import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/extensions/primitive_extensions.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

/// Type registry that works directly with Substrate metadata
///
/// Provides centralized type resolution and codec management for both V14 and V15 metadata.
/// Intelligently caches expensive operations while maintaining clean API design.
///
/// Example:
/// ```dart
/// // Create registry from metadata bytes
/// final prefixed = RuntimeMetadataPrefixed.codec.decode(input);
/// final registry = MetadataTypeRegistry(prefixed);
///
/// // Get codec for a type
/// final codec = registry.codecFor(42);
/// final value = codec.decode(input);
/// ```
class MetadataTypeRegistry {
  final RuntimeMetadataPrefixed prefixed;
  final PortableRegistry types;
  final int version;

  // Cache for generated codecs (expensive to create)
  final Map<int, Codec> _codecCache = {};

  // Cache for type path lookups (expensive string searches)
  final Map<String, int> _typePathCache = {};

  // Pre-built indices for fast pallet lookups
  late final Map<String, PalletMetadata> _palletsByName;
  late final Map<int, PalletMetadata> _palletsByIndex;

  // Proxy codecs for handling recursive types
  final Map<int, ProxyCodec> _proxyCodecs = {};

  // Track types currently being built (for recursion detection)
  final Set<int> _buildingTypes = {};

  /// Create a registry from prefixed metadata
  ///
  /// Automatically handles V14 and V15 metadata formats.
  /// Validates magic number and version compatibility.
  MetadataTypeRegistry(this.prefixed)
      : version = prefixed.metadata.version,
        types = _extractTypes(prefixed) {
    // Validate magic number
    if (!prefixed.isValidMagicNumber) {
      throw MetadataException(
        'Invalid metadata magic number: 0x${prefixed.magicNumber.toRadixString(16)}',
      );
    }

    // Check supported version
    if (version != 14 && version != 15) {
      throw MetadataException(
        'Unsupported metadata version: $version. Only V14 and V15 are supported.',
      );
    }

    _buildPalletIndices();
  }

  /// Extract PortableRegistry from versioned metadata
  static PortableRegistry _extractTypes(RuntimeMetadataPrefixed prefixed) {
    return switch (prefixed.metadata) {
      RuntimeMetadataV14(:final types) => PortableRegistry(types),
      RuntimeMetadataV15(:final types) => PortableRegistry(types),
      RuntimeMetadataV16(:final types) => PortableRegistry(types),
    };
  }

  /// Build pallet indices for O(1) lookups
  void _buildPalletIndices() {
    _palletsByName = {};
    _palletsByIndex = {};

    final pallets = switch (prefixed.metadata) {
      RuntimeMetadataV14(:final pallets) => pallets,
      RuntimeMetadataV15(:final pallets) => pallets,
      RuntimeMetadataV16(:final pallets) => pallets,
    };

    for (final pallet in pallets) {
      _palletsByName[pallet.name] = pallet;
      _palletsByIndex[pallet.index] = pallet;
    }
  }

  // ======================================================================
  // CORE TYPE RESOLUTION
  // ======================================================================

  /// Get codec for a type ID with intelligent caching
  ///
  /// This is the most important method - builds and caches codecs for any type.
  /// Handles recursive types using proxy pattern.
  Codec codecFor(int typeId) {
    // Check cache first
    if (_codecCache.containsKey(typeId)) {
      return _codecCache[typeId]!;
    }

    // Build codec and cache it
    final codec = _buildCodec(typeId);
    _codecCache[typeId] = codec;
    return codec;
  }

  /// Build a codec from type ID
  Codec _buildCodec(int typeId) {
    // Check for recursive type
    if (_buildingTypes.contains(typeId)) {
      // Return or create proxy for recursive type
      return _proxyCodecs.putIfAbsent(typeId, () => ProxyCodec());
    }

    _buildingTypes.add(typeId);
    try {
      final type = types.getType(typeId);
      if (type == null) {
        throw MetadataException('Type ID $typeId not found in registry');
      }

      final codec = _buildCodecFromTypeDef(type.type.typeDef, type);

      // Resolve proxy if it was created
      if (_proxyCodecs.containsKey(typeId)) {
        _proxyCodecs[typeId]!.codec = codec;
        return _proxyCodecs[typeId]!;
      }

      return codec;
    } finally {
      _buildingTypes.remove(typeId);
    }
  }

  /// Build codec from TypeDef
  Codec _buildCodecFromTypeDef(TypeDef typeDef, PortableType type) {
    switch (typeDef) {
      case TypeDefPrimitive(:final primitive):
        return _getPrimitiveCodec(primitive);

      case TypeDefComposite(:final fields):
        return _buildCompositeCodec(fields, type);

      case TypeDefVariant(:final variants):
        return _buildVariantCodec(variants);

      case TypeDefSequence(:final type):
        final elementCodec = codecFor(type);
        return SequenceCodec(elementCodec);

      case TypeDefArray(:final type, :final length):
        final elementCodec = codecFor(type);
        return ArrayCodec(elementCodec, length);

      case TypeDefTuple(:final fields):
        if (fields.isEmpty) {
          return NullCodec.codec;
        }
        final codecs = fields.map((id) => codecFor(id)).toList();
        return TupleCodec(codecs);

      case TypeDefCompact(:final type):
        return _buildCompactCodec(type);

      case TypeDefBitSequence(:final bitStoreType, :final bitOrderType):
        return _buildBitSequenceCodec(bitStoreType, bitOrderType);
    }
  }

  /// Get primitive codec
  Codec _getPrimitiveCodec(final Primitive primitive) {
    return primitive.primitiveCodec;
  }

  /// Build composite codec with special handling for common types
  Codec _buildCompositeCodec(List<Field> fields, PortableType type) {
    final path = type.type.pathString;

    // Handle Option<T>
    if (path == 'Option' && type.type.params.isNotEmpty) {
      final innerTypeId = type.type.params.first.type;
      if (innerTypeId != null) {
        final innerCodec = codecFor(innerTypeId);
        return OptionCodec(innerCodec);
      }
    }

    // Handle Result<T, E>
    if (path == 'Result' && type.type.params.length == 2) {
      final okTypeId = type.type.params[0].type;
      final errTypeId = type.type.params[1].type;
      if (okTypeId != null && errTypeId != null) {
        final okCodec = codecFor(okTypeId);
        final errCodec = codecFor(errTypeId);
        return ResultCodec(okCodec, errCodec);
      }
    }

    // If it's a single unnamed field, unwrap it
    if (fields.length == 1 && fields.first.name == null) {
      return codecFor(fields.first.type);
    }

    // Handle regular composite
    final fieldCodecs = <String, Codec>{};
    for (int i = 0; i < fields.length; i++) {
      final field = fields[i];
      final fieldName = field.name ?? 'field$i';
      fieldCodecs[fieldName] = codecFor(field.type);
    }

    return CompositeCodec(fieldCodecs);
  }

  /// Build variant codec (enum)
  Codec _buildVariantCodec(List<VariantDef> variants) {
    final variantMap = <int, MapEntry<String, Codec>>{};

    for (final variant in variants) {
      Codec variantCodec;

      if (variant.fields.isEmpty) {
        // No fields - unit variant
        variantCodec = NullCodec.codec;
      } else if (variant.fields.length == 1 && variant.fields.first.name == null) {
        // Single unnamed field - unwrap it
        variantCodec = codecFor(variant.fields.first.type);
      } else {
        // Multiple or named fields - use composite
        final fieldCodecs = <String, Codec>{};
        for (int i = 0; i < variant.fields.length; i++) {
          final field = variant.fields[i];
          final fieldName = field.name ?? 'field$i';
          fieldCodecs[fieldName] = codecFor(field.type);
        }
        variantCodec = CompositeCodec(fieldCodecs);
      }

      variantMap[variant.index] = MapEntry(variant.name, variantCodec);
    }

    return ComplexEnumCodec.sparse(variantMap);
  }

  /// Build compact codec based on underlying type
  Codec _buildCompactCodec(int typeId) {
    final type = types.getType(typeId);
    if (type == null) {
      throw MetadataException('Type ID $typeId not found for compact');
    }

    // Check if it's a primitive number type
    if (type.type.typeDef is TypeDefPrimitive) {
      final primitive = (type.type.typeDef as TypeDefPrimitive).primitive;
      switch (primitive) {
        case Primitive.U8:
        case Primitive.U16:
        case Primitive.U32:
          return CompactCodec.codec;
        case Primitive.U64:
        case Primitive.U128:
        case Primitive.U256:
          return CompactBigIntCodec.codec;
        default:
          throw MetadataException('Cannot create compact codec for $primitive');
      }
    }

    // For non-primitives, try to determine size
    // Default to BigInt compact for safety
    return CompactBigIntCodec.codec;
  }

  /// Build codec for bit sequence
  Codec _buildBitSequenceCodec(int bitStoreType, int bitOrderType) {
    // Resolve bit store type
    BitStore store = BitStore.U8; // Default
    final storeType = types.getType(bitStoreType);
    if (storeType != null) {
      final storePath = storeType.type.pathString;
      if (storePath != null) {
        if (storePath.contains('U8') || storePath.contains('u8')) {
          store = BitStore.U8;
        } else if (storePath.contains('U16') || storePath.contains('u16')) {
          store = BitStore.U16;
        } else if (storePath.contains('U32') || storePath.contains('u32')) {
          store = BitStore.U32;
        } else if (storePath.contains('U64') || storePath.contains('u64')) {
          store = BitStore.U64;
        }
      }
    }

    // Resolve bit order type
    BitOrder order = BitOrder.LSB; // Default (LSB is most common)
    final orderType = types.getType(bitOrderType);
    if (orderType != null) {
      final orderPath = orderType.type.pathString;
      if (orderPath != null) {
        if (orderPath.contains('Msb') || orderPath.contains('MSB')) {
          order = BitOrder.MSB;
        } else if (orderPath.contains('Lsb') || orderPath.contains('LSB')) {
          order = BitOrder.LSB;
        }
      }
    }

    return BitSequenceCodec(store, order);
  }

  /// Get type by ID
  PortableType typeById(int id) {
    final type = types.getType(id);
    if (type == null) {
      throw MetadataException('Type with ID $id not found');
    }
    return type;
  }

  /// Get type by path (expensive, cached)
  PortableType? typeByPath(String path) {
    // Check cache first
    if (_typePathCache.containsKey(path)) {
      return typeById(_typePathCache[path]!);
    }

    // Normalize path (remove leading ::)
    final normalizedPath = path.startsWith('::') ? path.substring(2) : path;

    // Search through all types
    for (final type in types.types) {
      if (type.type.pathString == normalizedPath) {
        _typePathCache[path] = type.id;
        return type;
      }
    }

    return null;
  }

  /// Get codec for a type path
  Codec? codecForPath(String path) {
    final type = typeByPath(path);
    return type != null ? codecFor(type.id) : null;
  }

  // ======================================================================
  // PALLET ACCESS
  // ======================================================================

  /// Get pallet by name (O(1) lookup)
  PalletMetadata? palletByName(String name) {
    return _palletsByName[name];
  }

  /// Get pallet by index (O(1) lookup)
  PalletMetadata? palletByIndex(int index) {
    return _palletsByIndex[index];
  }

  /// Get all pallets
  List<PalletMetadata> get pallets => _palletsByName.values.toList();

  /// Get the type ID for a pallet's calls
  int? getPalletCallType(String palletName) {
    return palletByName(palletName)?.calls?.type;
  }

  /// Get the type ID for a pallet's events
  int? getPalletEventType(String palletName) {
    return palletByName(palletName)?.event?.type;
  }

  /// Get the type ID for a pallet's errors
  int? getPalletErrorType(String palletName) {
    return palletByName(palletName)?.error?.type;
  }

  // ======================================================================
  // STORAGE ACCESS
  // ======================================================================

  /// Get storage metadata for a specific entry
  StorageEntryMetadata? getStorageMetadata(String palletName, String storageName) {
    final pallet = palletByName(palletName);
    if (pallet?.storage == null) return null;

    for (final entry in pallet!.storage!.entries) {
      if (entry.name == storageName) {
        return entry;
      }
    }
    return null;
  }

  /// Get the type ID for a storage value
  int? getStorageType(String palletName, String storageName) {
    final storage = getStorageMetadata(palletName, storageName);
    if (storage == null) return null;

    return switch (storage.type) {
      StorageEntryTypePlain(:final valueType) => valueType,
      StorageEntryTypeMap(:final valueType) => valueType,
    };
  }

  /// Get storage hashers for a storage entry
  List<StorageHasher>? getStorageHashers(String palletName, String storageName) {
    final storage = getStorageMetadata(palletName, storageName);
    if (storage == null) return null;

    return switch (storage.type) {
      StorageEntryTypePlain() => [],
      StorageEntryTypeMap(:final hashers) => hashers,
    };
  }

  // ======================================================================
  // VARIANT & COMPOSITE RESOLUTION
  // ======================================================================

  /// Get variant by name from an enum type
  VariantDef? getVariant(int typeId, String variantName) {
    final type = typeById(typeId);
    if (type.type.typeDef case TypeDefVariant(:final variants)) {
      for (final variant in variants) {
        if (variant.name == variantName) {
          return variant;
        }
      }
    }
    return null;
  }

  /// Get variant by index from an enum type
  VariantDef? getVariantByIndex(int typeId, int index) {
    final type = typeById(typeId);
    if (type.type.typeDef case TypeDefVariant(:final variants)) {
      for (final variant in variants) {
        if (variant.index == index) {
          return variant;
        }
      }
    }
    return null;
  }

  /// Get all fields for a composite type
  List<Field>? getFields(int typeId) {
    final type = typeById(typeId);
    if (type.type.typeDef case TypeDefComposite(:final fields)) {
      return fields;
    }
    return null;
  }

  // ======================================================================
  // CONSTANTS ACCESS
  // ======================================================================

  /// Get constant metadata
  PalletConstantMetadata? getConstantMetadata(String palletName, String constantName) {
    final pallet = palletByName(palletName);
    if (pallet == null) return null;

    for (final constant in pallet.constants) {
      if (constant.name == constantName) {
        return constant;
      }
    }
    return null;
  }

  /// Get decoded constant value directly
  dynamic getConstantValue(String palletName, String constantName) {
    final constant = getConstantMetadata(palletName, constantName);
    if (constant == null) return null;

    final codec = codecFor(constant.type);
    return codec.decode(Input.fromBytes(constant.value));
  }

  // ======================================================================
  // EXTRINSIC & COMMON TYPES
  // ======================================================================

  /// Get extrinsic metadata (version-agnostic)
  ExtrinsicMetadata get extrinsic {
    return switch (prefixed.metadata) {
      RuntimeMetadataV14(:final extrinsic) => extrinsic,
      RuntimeMetadataV15(:final extrinsic) => extrinsic,
      RuntimeMetadataV16(:final extrinsic) => extrinsic,
    };
  }

  /// AccountId type from extrinsic metadata
  int get accountIdType => extrinsic.addressType;

  /// Signature type from extrinsic metadata
  int get signatureType => extrinsic.signatureType;

  /// Runtime call type from extrinsic metadata
  int get callType => extrinsic.callType;

  /// Extra/Extension type from extrinsic metadata
  int get extraType => extrinsic.extraType;

  /// Get signed extensions
  List<SignedExtensionMetadata> get signedExtensions => extrinsic.signedExtensions;

  // ======================================================================
  // V15 SPECIFIC
  // ======================================================================

  /// Get outer enum types (V15 only)
  OuterEnums? get outerEnums {
    if (prefixed.metadata case RuntimeMetadataV15(:final outerEnums)) {
      return OuterEnums(
        callType: outerEnums.callType,
        eventType: outerEnums.eventType,
        errorType: outerEnums.errorType,
      );
    }
    return null;
  }

  /// Get runtime API metadata (V15 only)
  RuntimeApiMetadataV15? getRuntimeApi(String apiName) {
    if (prefixed.metadata case RuntimeMetadataV15(:final apis)) {
      for (final api in apis) {
        if (api.name == apiName) {
          return api;
        }
      }
    }
    return null;
  }

  // ======================================================================
  // UTILITY METHODS
  // ======================================================================

  /// Check if a type is an Option
  bool isOption(int typeId) {
    final type = typeById(typeId);
    return type.type.pathString == 'Option';
  }

  /// Check if a type is a Result
  bool isResult(int typeId) {
    final type = typeById(typeId);
    return type.type.pathString == 'Result';
  }

  /// Check if a type is a sequence (Vec)
  bool isSequence(int typeId) {
    final type = typeById(typeId);
    return type.type.typeDef is TypeDefSequence || type.type.pathString == 'Vec';
  }

  /// Clear all caches
  void clearCache() {
    _codecCache.clear();
    _typePathCache.clear();
    _proxyCodecs.clear();
    _buildingTypes.clear();
  }

  /// Get cache statistics for monitoring
  CacheStats get cacheStats => CacheStats(
        codecCacheSize: _codecCache.length,
        typePathCacheSize: _typePathCache.length,
        proxyCodecCount: _proxyCodecs.length,
      );
}

/// Outer enum types for V15 metadata
class OuterEnums {
  final int callType;
  final int eventType;
  final int errorType;

  const OuterEnums({
    required this.callType,
    required this.eventType,
    required this.errorType,
  });
}

/// Cache statistics for monitoring
class CacheStats {
  final int codecCacheSize;
  final int typePathCacheSize;
  final int proxyCodecCount;

  const CacheStats({
    required this.codecCacheSize,
    required this.typePathCacheSize,
    required this.proxyCodecCount,
  });

  int get totalCachedItems => codecCacheSize + typePathCacheSize;

  @override
  String toString() =>
      'CacheStats(codecs: $codecCacheSize, paths: $typePathCacheSize, proxies: $proxyCodecCount)';
}

/// Exception thrown by registry operations
class MetadataException implements Exception {
  final String message;

  const MetadataException(this.message);

  @override
  String toString() => 'MetadataException: $message';
}
