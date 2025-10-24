part of derived_codecs;

/// Codec for encoding and decoding Substrate runtime constants
///
/// This codec handles runtime constants which are fixed values defined in pallets.
/// Constants are stored in metadata with their SCALE-encoded values and can be
/// accessed and decoded at runtime.
///
/// Example:
/// ```dart
/// final registry = MetadataTypeRegistry(metadata);
/// final constantsCodec = ConstantsCodec(registry);
///
/// // Get a specific constant
/// final existentialDeposit = constantsCodec.getConstant('Balances', 'ExistentialDeposit');
/// print('Existential Deposit: $existentialDeposit');
///
/// // Get all constants for a pallet
/// final balancesConstants = constantsCodec.getPalletConstants('Balances');
/// for (final entry in balancesConstants.entries) {
///   print('${entry.key}: ${entry.value}');
/// }
/// ```
class ConstantsCodec {
  final MetadataTypeRegistry registry;

  /// Cache for decoded constants to avoid re-decoding
  final Map<String, Map<String, dynamic>> _decodedCache = {};

  ConstantsCodec(this.registry);

  /// Get a specific constant value from a pallet
  ///
  /// Returns the decoded constant value or null if not found.
  /// The value is cached after first decode for performance.
  dynamic getConstant(final String palletName, final String constantName) {
    if (_decodedCache.containsKey(palletName) &&
        _decodedCache[palletName]!.containsKey(constantName)) {
      return _decodedCache[palletName]![constantName];
    }

    // Find the pallet
    final pallet = registry.palletByName(palletName);
    if (pallet == null) {
      throw MetadataException('Pallet $palletName not found');
    }

    // Find the constant
    final constant = pallet.constants.firstWhere(
      (c) => c.name == constantName,
      orElse: () => throw MetadataException(
        'Constant $constantName not found in pallet $palletName',
      ),
    );

    final decodedValue = _decodeConstant(constant);

    _cacheConstant(palletName, constantName, decodedValue);

    return decodedValue;
  }

  /// Get all constants for a specific pallet
  ///
  /// Returns a map of constant name to decoded value
  Map<String, dynamic> getPalletConstants(String palletName) {
    // Check if we have all constants cached for this pallet
    if (_decodedCache.containsKey(palletName)) {
      final pallet = registry.palletByName(palletName);
      if (pallet != null && _decodedCache[palletName]!.length == pallet.constants.length) {
        return Map.from(_decodedCache[palletName]!);
      }
    }

    final pallet = registry.palletByName(palletName);
    if (pallet == null) {
      throw MetadataException('Pallet $palletName not found');
    }

    final constants = <String, dynamic>{};
    for (final constant in pallet.constants) {
      // Check cache first
      if (_decodedCache.containsKey(palletName) &&
          _decodedCache[palletName]!.containsKey(constant.name)) {
        constants[constant.name] = _decodedCache[palletName]![constant.name];
      } else {
        final decodedValue = _decodeConstant(constant);
        constants[constant.name] = decodedValue;
        _cacheConstant(palletName, constant.name, decodedValue);
      }
    }

    return constants;
  }

  /// Get all constants from all pallets
  ///
  /// Returns a nested map: pallet name -> constant name -> value
  Map<String, Map<String, dynamic>> getAllConstants() {
    final allConstants = <String, Map<String, dynamic>>{};

    for (final pallet in registry.prefixed.metadata.pallets) {
      if (pallet.constants.isNotEmpty) {
        allConstants[pallet.name] = getPalletConstants(pallet.name);
      }
    }

    return allConstants;
  }

  /// Get constant metadata information
  ///
  /// Returns information about a constant without decoding its value
  ConstantInfo? getConstantInfo(String palletName, String constantName) {
    final pallet = registry.palletByName(palletName);
    if (pallet == null) return null;

    final constant = pallet.constants.firstWhere(
      (c) => c.name == constantName,
      orElse: () => throw MetadataException(
        'Constant $constantName not found in pallet $palletName',
      ),
    );

    final type = registry.typeById(constant.type);

    return ConstantInfo(
      name: constant.name,
      type: type,
      typeId: constant.type,
      value: Uint8List.fromList(constant.value),
      docs: constant.docs,
      palletName: palletName,
    );
  }

  /// Decode a constant from its metadata
  dynamic _decodeConstant(PalletConstantMetadata constant) {
    try {
      final input = Input.fromBytes(constant.value);
      final codec = registry.codecFor(constant.type);
      return codec.decode(input);
    } catch (e) {
      throw MetadataException(
        'Failed to decode constant ${constant.name}: $e',
      );
    }
  }

  /// Cache a decoded constant value
  void _cacheConstant(String palletName, String constantName, dynamic value) {
    _decodedCache.putIfAbsent(palletName, () => {});
    _decodedCache[palletName]![constantName] = value;
  }

  /// Clear the cache
  void clearCache() {
    _decodedCache.clear();
  }

  /// Clear cache for a specific pallet
  void clearPalletCache(String palletName) {
    _decodedCache.remove(palletName);
  }
}
