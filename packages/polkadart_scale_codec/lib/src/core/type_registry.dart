part of core;

///
/// Converting above php code to dart code
class TypeRegistry {
  ///
  /// Basic Codec names
  static const _defaultCodecTypes = <String>[
    'Bool',
    'U8',
    'U16',
    'U32',
    'U64',
    'U128',
    'U256',
    'I8',
    'I16',
    'I32',
    'I64',
    'I128',
    'I256',
    'Compact',
    'Vec',
    'String',
    'Str',
    'Tuples',
    'Option',
    'Struct',
    'Result',
    'Enum',
    'H256',
    'BTreeMap',
    'FixedVec',
  ];

  ///
  /// Create a registry
  ///
  /// Example:
  /// ```dart
  /// final registry = TypeRegistry.createRegistry();
  /// ```
  static Registry createRegistry() {
    final registry = Registry();

    // register default codec
    for (final String codecType in _defaultCodecTypes) {
      final Codec codec = getCodecFromCodecName(codecType);
      registry.addCodec(codecType, codec);
    }
    return registry;
  }

  ///
  /// Get codec from codec name
  ///
  /// [codecName] is the name of the codec
  /// [registry] is the registry generated from TypeRegistry.createRegistry();
  ///
  /// Example:
  /// ```dart
  /// final registry = TypeRegistry.createRegistry();
  /// final codec = TypeRegistry.getCodecFromCodecName('Compact', registry);
  /// ```
  static Codec getCodecFromCodecName(String codecName) {
    return CodecMapper.getCodec(codecName);
  }
}
