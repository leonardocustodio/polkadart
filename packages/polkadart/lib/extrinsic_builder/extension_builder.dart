part of extrinsic_builder;

/// Builder for managing signed extension values and additional signed data
///
/// This class handles the construction and management of extension values
/// following the exact structure used in Substrate chains.
class ExtensionBuilder {
  final ChainInfo chainInfo;

  // Extension values (goes in the extrinsic)
  final Map<String, dynamic> extensions = <String, dynamic>{};

  // Additional signed data (included in signing payload but not in extrinsic)
  final Map<String, dynamic> additionalSigned = <String, dynamic>{};

  // Track what user has explicitly set
  final Set<String> _userOverrides = <String>{};

  // Internal state for smart defaults
  int? _specVersion;
  int? _transactionVersion;
  Uint8List? _genesisHash;
  Uint8List? _blockHash;
  int? _blockNumber;
  int? _nonce;
  BigInt _tip = BigInt.zero;
  int _eraPeriod = 64; // Default to mortal with 64 blocks
  dynamic _assetId;
  int _metadataHashMode = 0; // 0 = disabled, 1 = enabled
  Uint8List? _metadataHash;

  ExtensionBuilder(this.chainInfo);

  /// Set values that were auto-fetched from the chain
  void setAutoFetchedValues({
    required Set<String> userOverrides,
    int? specVersion,
    int? transactionVersion,
    Uint8List? genesisHash,
    Uint8List? blockHash,
    int? blockNumber,
    int? nonce,
  }) {
    // Only set if user hasn't overridden
    if (!userOverrides.contains('runtime')) {
      _specVersion = specVersion;
      _transactionVersion = transactionVersion;
    }

    if (!userOverrides.contains('genesis')) {
      _genesisHash = genesisHash;
    }

    if (!userOverrides.contains('block')) {
      _blockHash = blockHash;
      _blockNumber = blockNumber;
    }

    if (!userOverrides.contains('nonce') && nonce != null) {
      _nonce = nonce;
    }

    // Apply to actual extensions
    _applyStoredValues();
  }

  /// Set all standard extensions at once (for offline mode)
  void setStandardExtensions({
    required int specVersion,
    required int transactionVersion,
    required Uint8List genesisHash,
    required Uint8List blockHash,
    required int blockNumber,
    required int nonce,
    BigInt? tip,
    int eraPeriod = 64,
    dynamic assetId,
    bool enableMetadataHash = false,
    Uint8List? metadataHash,
  }) {
    _specVersion = specVersion;
    _transactionVersion = transactionVersion;
    _genesisHash = genesisHash;
    _blockHash = blockHash;
    _blockNumber = blockNumber;
    _nonce = nonce;
    _tip = tip ?? BigInt.zero;
    _eraPeriod = eraPeriod;
    _assetId = assetId;
    _metadataHashMode = enableMetadataHash ? 1 : 0;
    _metadataHash = metadataHash;

    _applyStoredValues();
  }

  /// Apply stored values to the actual extension maps
  void _applyStoredValues() {
    // Clear existing to avoid stale values
    extensions.clear();
    additionalSigned.clear();

    // Go through each extension in metadata
    for (final SignedExtensionMetadata ext in chainInfo.registry.signedExtensions) {
      final String identifier = ext.identifier;

      // Check if we should skip this extension entirely
      if (_shouldSkipExtension(ext)) continue;

      switch (identifier) {
        case 'CheckNonZeroSender':
          // Zero-sized, no value or additional needed
          break;

        case 'CheckSpecVersion':
          // Only additional signed
          if (_specVersion != null) {
            additionalSigned[identifier] = _specVersion;
          }
          break;

        case 'CheckTxVersion':
          // Only additional signed
          if (_transactionVersion != null) {
            additionalSigned[identifier] = _transactionVersion;
          }
          break;

        case 'CheckGenesis':
          // Only additional signed
          if (_genesisHash != null) {
            additionalSigned[identifier] = _genesisHash;
          }
          break;

        case 'CheckEra':
        case 'CheckMortality':
          // Both value and additional signed
          // Note: Era is a special type that uses custom encoding, not standard SCALE enum
          // We store the pre-encoded bytes here, and the extrinsic encoder will write them directly
          if (_eraPeriod == 0) {
            // Immortal era - single 0x00 byte
            extensions[identifier] = Era.codec.encodeToBytes(0, 0);
            if (_genesisHash != null) {
              additionalSigned[identifier] = _genesisHash;
            }
          } else if (_blockNumber != null && _blockHash != null) {
            // Mortal era - 2 bytes using Era's special encoding
            extensions[identifier] = Era.codec.encodeMortal(_blockNumber!, _eraPeriod);
            additionalSigned[identifier] = _blockHash;
          }
          break;

        case 'CheckNonce':
          // Simple value
          if (_nonce != null) {
            extensions[identifier] = _nonce;
          }
          break;

        case 'CheckWeight':
          // Usually not included for signed transactions
          // Would need specific weight values if required
          break;

        case 'ChargeTransactionPayment':
          // Simple tip value
          extensions[identifier] = _tip;
          break;

        case 'ChargeAssetTxPayment':
          // Complex structure with tip and optional asset
          extensions[identifier] = <String, dynamic>{
            'tip': _tip,
            'asset_id': _assetId == null ? MapEntry('None', null) : MapEntry('Some', _assetId),
          };
          break;

        case 'CheckMetadataHash':
          // Mode-based structure
          if (_metadataHashMode == 0) {
            // Disabled
            extensions[identifier] = <String, dynamic>{'mode': MapEntry('Disabled', 0)};
            additionalSigned[identifier] = null; /* MapEntry('None', 0); */
          } else if (_metadataHashMode == 1 && _metadataHash != null) {
            // Enabled with hash
            extensions[identifier] = <String, dynamic>{'mode': MapEntry('Enabled', 1)};
            // Additional signed uses Option encoding
            additionalSigned[identifier] = _metadataHash;
            //MapEntry('Some', [0x01, ..._metadataHash!]);
          }
          break;

        default:
        // Unknown extension - log warning but continue
      }
    }
  }

  // ===== Manual setter methods =====

  /// Set the nonce value
  ExtensionBuilder nonce(int nonce) {
    _userOverrides.add('nonce');
    _nonce = nonce;

    // Apply immediately if extension exists
    if (_hasExtension('CheckNonce')) {
      extensions['CheckNonce'] = nonce;
    }

    return this;
  }

  /// Set the tip amount
  ExtensionBuilder tip(BigInt tip) {
    _userOverrides.add('tip');
    _tip = tip;

    // Update the relevant payment extension
    if (_hasExtension('ChargeAssetTxPayment')) {
      extensions['ChargeAssetTxPayment'] = <String, dynamic>{
        'tip': tip,
        'asset_id': _assetId == null ? MapEntry('None', null) : MapEntry('Some', _assetId),
      };
    } else if (_hasExtension('ChargeTransactionPayment')) {
      extensions['ChargeTransactionPayment'] = tip;
    }

    return this;
  }

  /// Set mortal era
  ExtensionBuilder era({
    required final int period,
    final int? blockNumber,
    final Uint8List? blockHash,
  }) {
    _userOverrides.add('era');
    _eraPeriod = period;

    if (blockNumber != null) {
      _blockNumber = blockNumber;
    }
    if (blockHash != null) {
      _blockHash = blockHash;
    }

    _applyEra();
    return this;
  }

  /// Make the transaction immortal
  ExtensionBuilder immortal() {
    _userOverrides.add('era');
    _eraPeriod = 0;

    _applyEra();
    return this;
  }

  /// Set runtime spec version
  ExtensionBuilder specVersion(int version) {
    _userOverrides.add('runtime');
    _specVersion = version;

    if (_hasExtension('CheckSpecVersion')) {
      additionalSigned['CheckSpecVersion'] = version;
    }

    return this;
  }

  /// Set transaction version
  ExtensionBuilder transactionVersion(int version) {
    _userOverrides.add('runtime');
    _transactionVersion = version;

    if (_hasExtension('CheckTxVersion')) {
      additionalSigned['CheckTxVersion'] = version;
    }

    return this;
  }

  /// Set genesis hash
  ExtensionBuilder genesisHash(Uint8List hash) {
    _userOverrides.add('genesis');
    _genesisHash = hash;

    if (_hasExtension('CheckGenesis')) {
      additionalSigned['CheckGenesis'] = hash;
    }

    // Update immortal era if applicable
    if (_eraPeriod == 0) {
      _applyEra();
    }

    return this;
  }

  /// Set current block hash
  ExtensionBuilder blockHash(Uint8List hash) {
    _userOverrides.add('block');
    _blockHash = hash;

    // Update mortal era if applicable
    if (_eraPeriod > 0) {
      _applyEra();
    }

    return this;
  }

  /// Set asset for payment (for chains with asset payment)
  ExtensionBuilder assetId(dynamic assetId) {
    _userOverrides.add('asset');
    _assetId = assetId;

    if (_hasExtension('ChargeAssetTxPayment')) {
      extensions['ChargeAssetTxPayment'] = <String, dynamic>{
        'tip': _tip,
        'asset_id': assetId == null ? MapEntry('None', null) : MapEntry('Some', assetId),
      };
    }

    return this;
  }

  /// Enable or disable metadata hash
  ExtensionBuilder metadataHash({bool enabled = true, Uint8List? hash}) {
    _userOverrides.add('metadataHash');
    _metadataHashMode = enabled ? 1 : 0;
    _metadataHash = hash;

    if (_hasExtension('CheckMetadataHash')) {
      if (enabled && hash != null) {
        extensions['CheckMetadataHash'] = <String, dynamic>{'mode': MapEntry('Enabled', 1)};
        additionalSigned['CheckMetadataHash'] = MapEntry('Some', [0x01, ...hash]);
      } else {
        extensions['CheckMetadataHash'] = <String, dynamic>{'mode': MapEntry('Disabled', 0)};
        additionalSigned['CheckMetadataHash'] = MapEntry('None', 0);
      }
    }

    return this;
  }

  /// Set a custom extension value
  ExtensionBuilder customExtension(String identifier, dynamic value, {dynamic additional}) {
    _userOverrides.add('custom_$identifier');

    if (value != null) {
      extensions[identifier] = value;
    }
    if (additional != null) {
      additionalSigned[identifier] = additional;
    }

    return this;
  }

  // ===== Helper methods =====

  /// Apply era settings to extensions
  void _applyEra() {
    String? extName;
    if (_hasExtension('CheckMortality')) {
      extName = 'CheckMortality';
    } else if (_hasExtension('CheckEra')) {
      extName = 'CheckEra';
    }

    if (extName == null) return;

    // Era is a special type that uses custom encoding, not standard SCALE enum
    if (_eraPeriod == 0) {
      // Immortal - single 0x00 byte
      extensions[extName] = Era.codec.encodeToBytes(0, 0);
      if (_genesisHash != null) {
        additionalSigned[extName] = _genesisHash;
      }
    } else if (_blockNumber != null && _blockHash != null) {
      // Mortal - 2 bytes using Era's special encoding
      extensions[extName] = Era.codec.encodeMortal(_blockNumber!, _eraPeriod);
      additionalSigned[extName] = _blockHash;
    }
  }

  /// Check if an extension should be skipped entirely
  bool _shouldSkipExtension(SignedExtensionMetadata ext) {
    final valueCodec = chainInfo.registry.codecFor(ext.type);
    final additionalCodec = chainInfo.registry.codecFor(ext.additionalSigned);

    // Skip if both value and additional are zero-sized
    return (valueCodec is NullCodec || valueCodec.isSizeZero()) &&
        (additionalCodec is NullCodec || additionalCodec.isSizeZero());
  }

  /// Check if chain has a specific extension
  bool _hasExtension(String identifier) {
    return chainInfo.registry.signedExtensions.any((ext) => ext.identifier == identifier);
  }

  /// Validate that all required extensions have values
  void validate() {
    final missing = <String>[];

    for (final ext in chainInfo.registry.signedExtensions) {
      final valueCodec = chainInfo.registry.codecFor(ext.type);
      final additionalCodec = chainInfo.registry.codecFor(ext.additionalSigned);

      // Skip completely zero-sized extensions
      if (_shouldSkipExtension(ext)) {
        continue;
      }

      // Check extension value
      if (!(valueCodec is NullCodec || valueCodec.isSizeZero())) {
        if (!extensions.containsKey(ext.identifier)) {
          missing.add('${ext.identifier} (value)');
        }
      }

      // Check additional signed
      if (!(additionalCodec is NullCodec || additionalCodec.isSizeZero())) {
        if (!additionalSigned.containsKey(ext.identifier)) {
          missing.add('${ext.identifier} (additional)');
        }
      }
    }

    if (missing.isNotEmpty) {
      throw ExtensionValidationError(
        'Missing required extensions: ${missing.join(', ')}\n'
        'Tip: Use ExtrinsicBuilder.auto() for automatic fetching, '
        'or provide missing values manually.',
      );
    }
  }

  /// Get a summary of configured extensions
  Map<String, dynamic> summary() {
    return {
      'extensions': extensions.keys.toList(),
      'additionalSigned': additionalSigned.keys.toList(),
      'userOverrides': _userOverrides.toList(),
      'era': _eraPeriod == 0 ? 'immortal' : 'mortal($_eraPeriod blocks)',
      'nonce': _nonce,
      'tip': _tip.toString(),
    };
  }
}

/// Error thrown when extension validation fails
class ExtensionValidationError implements Exception {
  final String message;

  ExtensionValidationError(this.message);

  @override
  String toString() => 'ExtensionValidationError: $message';
}
