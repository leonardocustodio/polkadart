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

  ///
  /// Parses customJson and adds it to registry
  static void addCustomCodec(
      Registry registry, Map<String, dynamic> customJson) {
    for (final mapEntry in customJson.entries) {
      final key = mapEntry.key;
      var value = mapEntry.value;

      if (value is String) {
        final Codec? codec = registry.getCodec(value);
        if (codec != null) {
          registry.addCodec(key, codec);
          continue;
        }
        bool iterationSolve = false;
        while (true) {
          if (customJson[value] != null) {
            value = customJson[value];
            if (value is String) {
              final Codec? codec = registry.getCodec(value);
              if (codec != null) {
                registry.addCodec(key, codec);
                iterationSolve = true;
                break;
              } else {
                continue;
              }
            }
            addCustomCodec(registry, {key: value});
            iterationSolve = true;
          } else {
            iterationSolve = false;
          }
          break;
        }
        if (iterationSolve) {
          continue;
        }

        // Complex type
        if ((value as String).endsWith('>')) {
          final RegExpMatch? match = getVecMatch(value);

          /// For knowing why we're checking for groupCount == 2 and accessing [1] and [2] index
          ///
          /// Check documentation on utils/regexp.dart -> getVecMatch(value);
          if (match != null && match.groupCount == 2) {
            switch (match[1].toString()) {
              // vec array
              case 'Vec':
              // option
              case 'Option':
              // compact
              case 'Compact':
              // BTreeMap
              case 'BTreeMap':
                final codec = registry.getCodec(match[1].toString())!;
                codec.subType = match[2].toString();
                registry.addCodec(key, codec);
                break;
            }
            continue;
          }
        }

        //
        // Tuple
        if (value.startsWith('(') && value.endsWith(')')) {
          final Codec codec = registry.getCodec('Tuples')!;
          codec.typeString = value;
          codec.buildMapping();
          registry.addCodec(key, codec);
          continue;
        }
        //
        // Fixed array
        if (value.startsWith('[') && value.endsWith(']')) {
          _initFixedArray(registry, key, value);
        }
      } else if (value is Map) {
        //
        // enum
        if (value['_enum'] != null) {
          _initEnum(registry, key, value as Map<String, dynamic>);
          continue;
        }
        //
        // set
        if (value['_set'] != null) {
          _initSet(registry, key, value as Map<String, dynamic>);
          continue;
        }
        //
        // struct
        final Codec codec = registry.getCodec('Struct')!;
        codec.typeStruct = value as List;
        registry.addCodec(key, codec);
      }
    }
  }

  static void _initFixedArray(Registry registry, String key, String value) {
    final slicedList = value.substring(1, value.length - 2).split(';');
    if (slicedList.length == 2) {
      final String subType = slicedList[0].trim();
      final Codec codec = subType.toLowerCase() == 'u8'
          ? registry.getCodec('VecU8Fixed')!
          : registry.getCodec('FixedArray')!;
      codec.subType = subType;
      codec.fixedLength = int.parse(slicedList[1]);
      registry.addCodec(key, codec);
    }
  }

  static void _initEnum(
      Registry registry, String key, Map<String, dynamic> value) {
    final Codec codec = registry.getCodec('Enum')!;
    if (value['_enum'] is Map<String, dynamic>) {
      codec.typeStruct = value['_enum'];
    } else {
      codec.valueList = value['_enum'];
    }
    registry.addCodec(key, codec);
  }

  static void _initSet(
      Registry registry, String key, Map<String, dynamic> value) {
    final Codec codec = registry.getCodec('Set')!;
    if (value['_bitLength'] != null) {
      codec.bitLength = int.parse(value['_bitLength']);
    } else {
      codec.bitLength = 16;
    }
    (value['_set'] as Map).remove('_bitLength');
    codec.valueList = (value['_set'] as Map).keys.toList();
    registry.addCodec(key, codec);
  }
}
