part of derived_codecs;

/// Lazy loading constants codec with advanced control
///
/// This codec provides fine-grained control over when constants are loaded
/// and decoded, optimizing memory usage and initialization time.
class LazyConstantsCodec {
  final MetadataTypeRegistry registry;

  /// Cache for decoded constants
  final Map<String, Map<String, dynamic>> _decodedCache = <String, Map<String, dynamic>>{};

  /// Metadata cache (lightweight, always loaded)
  final Map<String, Map<String, ConstantInfo>> _metadataCache =
      <String, Map<String, ConstantInfo>>{};

  /// Track which pallets have been fully loaded
  final Set<String> _fullyLoadedPallets = <String>{};

  LazyConstantsCodec(this.registry);

  /// Get constant info without decoding the value
  /// This is very lightweight as it doesn't decode the actual constant value
  ConstantInfo? getConstantInfo(String palletName, String constantName) {
    // Load metadata for pallet if not cached
    if (!_metadataCache.containsKey(palletName)) {
      _loadPalletMetadata(palletName);
    }

    return _metadataCache[palletName]?[constantName];
  }

  /// Get a constant value (lazy decoded)
  dynamic getConstant(String palletName, String constantName) {
    // Check if already decoded
    if (_decodedCache[palletName]?.containsKey(constantName) == true) {
      return _decodedCache[palletName]![constantName];
    }

    // Get metadata
    final info = getConstantInfo(palletName, constantName);
    if (info == null) {
      throw MetadataException(
        'Constant $constantName not found in pallet $palletName',
      );
    }

    // Decode and cache
    final value = _decodeConstant(info);
    _cacheConstant(palletName, constantName, value);

    return value;
  }

  /// Preload specific constants (useful for critical path optimization)
  void preloadConstants(List<(String, String)> constants) {
    for (final (pallet, constant) in constants) {
      try {
        getConstant(pallet, constant);
      } catch (_) {}
    }
  }

  /// Preload all constants for a pallet
  void preloadPallet(String palletName) {
    if (_fullyLoadedPallets.contains(palletName)) return;

    final pallet = registry.palletByName(palletName);
    if (pallet == null) return;

    for (final constant in pallet.constants) {
      try {
        final value = _decodeConstantMetadata(constant);
        _cacheConstant(palletName, constant.name, value);
      } catch (_) {}
    }

    _fullyLoadedPallets.add(palletName);
  }

  /// Get loading statistics
  Map<String, int> getLoadingStats() {
    final totalPallets =
        registry.prefixed.metadata.pallets.where((p) => p.constants.isNotEmpty).length;

    int totalConstants = 0;
    int loadedConstants = 0;

    for (final pallet in registry.prefixed.metadata.pallets) {
      totalConstants += pallet.constants.length;
      loadedConstants += _decodedCache[pallet.name]?.length ?? 0;
    }

    return <String, int>{
      'totalPallets': totalPallets,
      'loadedPallets': _decodedCache.length,
      'fullyLoadedPallets': _fullyLoadedPallets.length,
      'totalConstants': totalConstants,
      'loadedConstants': loadedConstants,
      'metadataCachedPallets': _metadataCache.length,
    };
  }

  /// Clear cache with different levels
  void clearCache({bool onlyValues = false}) {
    _decodedCache.clear();
    _fullyLoadedPallets.clear();

    if (!onlyValues) {
      _metadataCache.clear();
    }
  }

  /// Check if a constant is loaded without triggering loading
  bool isConstantLoaded(String palletName, String constantName) {
    return _decodedCache[palletName]?.containsKey(constantName) == true;
  }

  /// Check if a pallet is fully loaded
  bool isPalletFullyLoaded(String palletName) {
    return _fullyLoadedPallets.contains(palletName);
  }

  void _loadPalletMetadata(String palletName) {
    final pallet = registry.palletByName(palletName);
    if (pallet == null) return;

    final metadata = <String, ConstantInfo>{};
    for (final constant in pallet.constants) {
      final type = registry.typeById(constant.type);
      metadata[constant.name] = ConstantInfo(
        name: constant.name,
        type: type,
        typeId: constant.type,
        value: Uint8List.fromList(constant.value),
        docs: constant.docs,
        palletName: palletName,
      );
    }

    _metadataCache[palletName] = metadata;
  }

  dynamic _decodeConstant(ConstantInfo info) {
    try {
      final input = Input.fromBytes(info.value);
      final codec = registry.codecFor(info.typeId);
      return codec.decode(input);
    } catch (e) {
      throw MetadataException(
        'Failed to decode constant ${info.name}: $e',
      );
    }
  }

  dynamic _decodeConstantMetadata(PalletConstantMetadata constant) {
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

  void _cacheConstant(String palletName, String constantName, dynamic value) {
    _decodedCache.putIfAbsent(palletName, () => {});
    _decodedCache[palletName]![constantName] = value;
  }
}
