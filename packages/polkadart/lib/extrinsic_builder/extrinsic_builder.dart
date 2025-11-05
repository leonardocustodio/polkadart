part of extrinsic_builder;

/// Main builder for constructing extrinsics
///
/// This is the primary API for creating and signing blockchain transactions.
/// It orchestrshow ChainDataFetcher, SystemApi, SigningBuilder, and ExtrinsicEncoder
/// to provide a clean, fluent interface for extrinsic construction.
class ExtrinsicBuilder {
  final ChainInfo chainInfo;
  final Uint8List callData;
  final Provider? provider; // Optional for auto-fetching
  final String? signerAddress; // For fetching nonce
  final ExtensionBuilder _extensionBuilder;

  // Track what user has explicitly set
  final Set<String> _userOverrides = {};

  ExtrinsicBuilder._({
    required this.chainInfo,
    required this.callData,
    this.provider,
    this.signerAddress,
  }) : _extensionBuilder = ExtensionBuilder(chainInfo);

  // ===== Factory Constructors =====

  /// Create builder with automatic chain data fetching
  ///
  /// This is the simplest way to build an extrinsic. It automatically:
  /// - Fetches chain metadata (if not provided)
  /// - Fetches genesis hash, latest block, runtime version
  /// - Fetches nonce (if signer address provided)
  ///
  /// Example:
  /// ```dart
  /// final extrinsic = await ExtrinsicBuilder.auto(
  ///   provider: provider,
  ///   callData: callBytes,
  ///   signerAddress: alice.address,
  /// ).signAndBuild(alice);
  /// ```
  static Future<ExtrinsicBuilder> auto({
    required Provider provider,
    required Uint8List callData,
    String? signerAddress,
    ChainInfo? chainInfo,
  }) async {
    // Fetch chain info if not provided
    chainInfo ??= await _fetchChainInfo(provider);

    final builder = ExtrinsicBuilder._(
      chainInfo: chainInfo,
      callData: callData,
      provider: provider,
      signerAddress: signerAddress,
    );

    // Pre-fetch standard values
    await builder._fetchStandardValues();

    return builder;
  }

  /// Create builder for offline signing
  ///
  /// Use this when you have all required values and don't need to fetch
  /// anything from the chain. Useful for air-gapped signing.
  ///
  /// Example:
  /// ```dart
  /// final extrinsic = ExtrinsicBuilder.offline(
  ///   chainInfo: chainInfo,
  ///   callData: callBytes,
  ///   specVersion: 1234,
  ///   transactionVersion: 5,
  ///   genesisHash: genesis,
  ///   blockHash: block,
  ///   blockNumber: 100000,
  ///   nonce: 5,
  /// ).signAndBuild(keypair);
  /// ```
  factory ExtrinsicBuilder.offline({
    required ChainInfo chainInfo,
    required Uint8List callData,
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
    final builder = ExtrinsicBuilder._(
      chainInfo: chainInfo,
      callData: callData,
      provider: null, // No provider for offline
    );

    // Set all values manually
    builder._extensionBuilder.setStandardExtensions(
      specVersion: specVersion,
      transactionVersion: transactionVersion,
      genesisHash: genesisHash,
      blockHash: blockHash,
      blockNumber: blockNumber,
      nonce: nonce,
      tip: tip ?? BigInt.zero,
      eraPeriod: eraPeriod,
      assetId: assetId,
      enableMetadataHash: enableMetadataHash,
      metadataHash: metadataHash,
    );

    return builder;
  }

  /// Create builder from a method call
  ///
  /// Convenience factory that encodes a pallet method call.
  ///
  /// Example:
  /// ```dart
  /// final extrinsic = await ExtrinsicBuilder.method(
  ///   provider: provider,
  ///   chainInfo: chainInfo,
  ///   pallet: 'Balances',
  ///   method: 'transfer_keep_alive',
  ///   args: {'dest': destAccount, 'value': amount},
  /// ).signAndBuild(keypair);
  /// ```
  static Future<ExtrinsicBuilder> method({
    required Provider provider,
    required ChainInfo chainInfo,
    required String pallet,
    required String method,
    required Map<String, dynamic> args,
    String? signerAddress,
  }) async {
    // Encode the method call
    final callData = _encodeMethodCall(chainInfo, pallet, method, args);

    return auto(
      provider: provider,
      chainInfo: chainInfo,
      callData: callData,
      signerAddress: signerAddress,
    );
  }

  // ===== Configuration Methods =====

  /// Set the nonce value
  ExtrinsicBuilder nonce(int nonce) {
    _userOverrides.add('nonce');
    _extensionBuilder.nonce(nonce);
    return this;
  }

  /// Set the tip amount
  ExtrinsicBuilder tip(BigInt tip) {
    _userOverrides.add('tip');
    _extensionBuilder.tip(tip);
    return this;
  }

  /// Set mortal era with period
  ExtrinsicBuilder era({required int period, Uint8List? blockHash}) {
    _userOverrides.add('era');
    _extensionBuilder.era(period: period, blockHash: blockHash);
    return this;
  }

  /// Make the transaction immortal
  ExtrinsicBuilder immortal() {
    _userOverrides.add('era');
    _extensionBuilder.immortal();
    return this;
  }

  /// Set spec version
  ExtrinsicBuilder specVersion(int version) {
    _userOverrides.add('runtime');
    _extensionBuilder.specVersion(version);
    return this;
  }

  /// Set transaction version
  ExtrinsicBuilder transactionVersion(int version) {
    _userOverrides.add('runtime');
    _extensionBuilder.transactionVersion(version);
    return this;
  }

  /// Set genesis hash
  ExtrinsicBuilder genesisHash(Uint8List hash) {
    _userOverrides.add('genesis');
    _extensionBuilder.genesisHash(hash);
    return this;
  }

  /// Set block hash for era
  ExtrinsicBuilder blockHash(Uint8List hash) {
    _userOverrides.add('block');
    _extensionBuilder.blockHash(hash);
    return this;
  }

  /// Set asset for payment (for chains with asset payment)
  ExtrinsicBuilder assetId(dynamic assetId) {
    _userOverrides.add('asset');
    _extensionBuilder.assetId(assetId);
    return this;
  }

  /// Enable metadata hash with optional hash value
  ExtrinsicBuilder metadataHash({bool enabled = true, Uint8List? hash}) {
    _userOverrides.add('metadataHash');
    _extensionBuilder.metadataHash(enabled: enabled, hash: hash);
    return this;
  }

  /// Set a custom extension
  ExtrinsicBuilder customExtension(String identifier, dynamic value, {dynamic additional}) {
    _userOverrides.add('custom_$identifier');
    _extensionBuilder.customExtension(identifier, value, additional: additional);
    return this;
  }

  // ===== Building and Signing =====

  /// Sign and build the extrinsic
  ///
  /// This is the main method that creates the final extrinsic.
  /// It will:
  /// 1. Fetch any missing values (like nonce if not set)
  /// 2. Validate all extensions are present
  /// 3. Create and sign the payload
  /// 4. Encode the final extrinsic
  ///
  /// Returns an EncodedExtrinsic ready for submission
  Future<EncodedExtrinsic> signAndBuild(KeyPair signer) async {
    // Fetch nonce if we have provider but didn't have address earlier
    if (provider != null && signerAddress == null && !_userOverrides.contains('nonce')) {
      try {
        final systemApi = SystemApi(provider!);
        final nonce = await systemApi.accountNextIndex(signer.address);
        _extensionBuilder.nonce(nonce);
      } catch (e) {
        throw BuilderError('Failed to fetch nonce for ${signer.address}: $e');
      }
    }

    // Create signing builder
    final signingBuilder = SigningBuilder(
      chainInfo: chainInfo,
      extensionBuilder: _extensionBuilder,
    );

    // Sign the extrinsic
    final signedData = signingBuilder.createSignedExtrinsic(
      callData: callData,
      signer: signer,
    );

    // Encode the extrinsic
    return EncodedExtrinsic.fromSignedData(chainInfo, signedData);
  }

  /// Sign, build, and submit the extrinsic
  ///
  /// Convenience method that combines signing and submission.
  /// Requires a provider to be set.
  Future<String> signBuildAndSubmit(KeyPair signer) async {
    if (provider == null) {
      throw BuilderError('Cannot submit without provider');
    }

    final extrinsic = await signAndBuild(signer);
    return extrinsic.submit(provider);
  }

  /// Build unsigned extrinsic (for inherents)
  EncodedExtrinsic buildUnsigned() {
    final encoder = ExtrinsicEncoder(chainInfo);
    final bytes = encoder.encodeUnsigned(callData);
    final hash = Hasher.blake2b256.hash(bytes);

    return EncodedExtrinsic(
      bytes: bytes,
      hash: hash,
      info: EncodedExtrinsicInfo(
        totalSize: bytes.length,
        lengthPrefixSize: _calculateCompactSize(bytes.length - 1), // Subtract version byte
        versionByteSize: 1,
        addressSize: 0,
        signatureSize: 0,
        extensionSize: 0,
        callDataSize: callData.length,
        hash: hash,
        signatureType: SignatureType.unknown,
        isSigned: false,
      ),
    );
  }

  /// Fetch chain info from provider
  static Future<ChainInfo> _fetchChainInfo(Provider provider) async {
    try {
      // This would typically fetch metadata and create ChainInfo
      // For now, return a placeholder
      throw UnimplementedError('ChainInfo.fromProvider not yet implemented');
    } catch (e) {
      throw BuilderError('Failed to fetch chain info: $e');
    }
  }

  /// Fetch standard values from the chain
  Future<void> _fetchStandardValues() async {
    if (provider == null) return;

    try {
      final fetcher = ChainDataFetcher(provider!);

      // Fetch all standard values in parallel
      final chainData = await fetcher.fetchStandardData(
        accountAddress: signerAddress,
        skipFlags: _userOverrides,
      );

      // Apply fetched values (only if not overridden)
      _extensionBuilder.setAutoFetchedValues(
        specVersion: chainData.specVersion,
        transactionVersion: chainData.transactionVersion,
        genesisHash: chainData.genesisHash,
        blockHash: chainData.blockHash,
        blockNumber: chainData.blockNumber,
        nonce: chainData.nonce,
        userOverrides: _userOverrides,
      );
    } catch (e) {
      throw BuilderError('Failed to fetch chain data: $e');
    }
  }

  /// Encode a method call
  static Uint8List _encodeMethodCall(
    ChainInfo chainInfo,
    String pallet,
    String method,
    Map<String, dynamic> args,
  ) {
    // This would use the RuntimeCallCodec to encode the call
    // For now, throw unimplemented
    throw UnimplementedError('Method call encoding not yet implemented. Use raw callData instead.');
  }

  /// Calculate compact encoding size
  static int _calculateCompactSize(int value) {
    if (value < 64) return 1;
    if (value < 16384) return 2;
    if (value < 1073741824) return 4;
    return 5; // For larger values
  }
}

/// Information about what will be built
class BuildInfo {
  final ChainInfo chainInfo;
  final int callDataSize;
  final Map<String, dynamic> extensions;
  final Map<String, dynamic> additionalSigned;
  final Set<String> userOverrides;
  final bool hasProvider;

  const BuildInfo({
    required this.chainInfo,
    required this.callDataSize,
    required this.extensions,
    required this.additionalSigned,
    required this.userOverrides,
    required this.hasProvider,
  });

  /// Get a summary of the build configuration
  Map<String, dynamic> summary() {
    return {
      'callDataSize': '$callDataSize bytes',
      'extensionCount': extensions.length,
      'additionalSignedCount': additionalSigned.length,
      'userOverrides': userOverrides.toList(),
      'hasProvider': hasProvider,
      'extensions': extensions.keys.toList(),
      'additionalSigned': additionalSigned.keys.toList(),
    };
  }
}

/// Error thrown by the builder
class BuilderError implements Exception {
  final String message;

  BuilderError(this.message);

  @override
  String toString() => 'BuilderError: $message';
}
