part of core;

///
/// Converting above php code to dart code
class TypeRegistry {
  ///
  /// Basic Codec names
  static const _defaultCodecTypes = <String>['Bool'];

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
      final Codec codec = getCodecFromCodecName(codecType, registry);
      registry.addCodec(codecType, codec);
    }
    // interfaces runtime module types
    // _findInterfaces(registry);
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
  static Codec getCodecFromCodecName(String codecName, Registry registry) {
    Codec? codec = CodecMapper.getCodec(codecName, registry);

    if (codec != null) {
      return codec;
    }

    codecName = _convertCodecName(codecName);

    codec = CodecMapper.getCodec(codecName, registry);
    if (codec != null) {
      return codec;
    }

    throw UnexpectedCodecException('Unable to find codec for $codecName');
  }

  ///
  /// Convert codec name for basic types
  static String _convertCodecName(String codecName) {
    switch (codecName.toLowerCase()) {
      case 'bool':
      case 'string':
      case 'int':
      case 'null':
        return '${codecName}Codec';
      default:
        return codecName;
    }
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
        // iteration
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
        if (value[-1] == '>') {
          final match =
              RegExp(r'^([^<]*)<(.+)>$').allMatches(value as String).toList();

          if (match.length > 2) {
            switch (match[1].toString().toLowerCase()) {
              // vec array
              case 'vec':
              // option
              case 'option':
              // compact
              case 'compact':
              // BTreeMap
              case 'BTreeMap':
                final codec =
                    registry.getCodec(match[1].toString().toLowerCase())!;
                codec.subType = match[2].toString();
                registry.addCodec(key, codec);
                break;
            }
            continue;
          }
        }

        // Tuple
        if ((value as String).first == '(' && value.last == ')') {
          final Codec codec = registry.getCodec('tuples')!;
          codec.typeString = value;
          codec.buildMapping();
          registry.addCodec(key, codec);
          continue;
        }
        // Fixed array
        if (value.first == '[' && value.last == ']') {
          final slicedList = value.substring(1, value.length - 2).split(';');
          if (slicedList.length == 2) {
            final String subType = slicedList[0].trim();
            final codec = subType.toLowerCase() == 'u8'
                ? registry.getCodec('VecU8Fixed')!
                : registry.getCodec('FixedArray')!;
            codec.subType = subType;
            codec.fixedLength = int.parse(slicedList[1]);
            registry.addCodec(key, codec);
          }
        }
      } else if (value is Map) {
        // enum
        if (value['_enum'] != null) {
          final Codec codec = registry.getCodec('enum')!;
          if (isAssoc(value['_enum'])) {
            codec.typeStruct = value['_enum'];
          } else {
            codec.valueList = value['_enum'];
          }
          registry.addCodec(key, codec);
          continue;
        }
        // set
        if (value['_set'] != null) {
          final Codec codec = registry.getCodec('set')!;
          if (value['_bitLength'] != null) {
            codec.bitLength = int.parse(value['_bitLength']);
          } else {
            codec.bitLength = 16;
          }
          (value['_set'] as Map).remove('_bitLength');
          codec.valueList = (value['_set'] as Map).keys.toList();
          registry.addCodec(key, codec);
          continue;
        }
        // struct
        final Codec codec = registry.getCodec('struct')!;
        codec.typeStruct = value as List;
        registry.addCodec(key, codec);
      }
    }
  }
}

bool isAssoc(List list) {
  return list.asMap().keys.toList() !=
      List.generate(list.length, (index) => index);
}
