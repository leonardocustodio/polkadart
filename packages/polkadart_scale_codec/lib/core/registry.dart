part of core;

class Registry {
  final Map<String, Codec> codecs = <String, Codec>{};

  ///
  /// Get the registry length
  int get length => codecs.length;

  ///
  /// Get the registry keys
  Iterable<String> get keys => codecs.keys;

  ///
  /// Add a codec to the registry
  void addCodec(String codecName, Codec codec) {
    codecs[codecName] = codec;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    return codecs[codecName];
  }

  final Map<String, dynamic> _postVariantFieldsProcessor = <String, dynamic>{};

  ///
  /// Parses customJson and adds it to registry
  void registerCustomCodec(Map<String, dynamic> customJson,
      [String? selectedKey]) {
    if (selectedKey != null) {
      final codec =
          _parseCodec(customJson, selectedKey, customJson[selectedKey]);
      addCodec(selectedKey, codec);
    } else {
      for (final mapEntry in customJson.entries) {
        final key = mapEntry.key;
        final value = mapEntry.value;

        if (getCodec(key) != null) {
          continue;
        }

        final codec = _parseCodec(customJson, key, value);
        if (getCodec(key) == null) {
          addCodec(key, codec);
        }
      }
    }
    for (final mapEntry in _postVariantFieldsProcessor.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      if (getCodec(key) != null) {
        continue;
      }

      final codec = _parseCodec(customJson, key, value);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
  }

  Codec _parseCodec(
      Map<String, dynamic> customJson, String key, dynamic value) {
    if (value == null) {
      return NullCodec.instance;
    }

    key = key.trim();
    //
    // Check if the codec is already in the registry
    final Codec? codec = getCodec(key);
    if (codec != null) {
      return codec;
    }

    //
    //Check if the value is a string
    if (value is String) {
      value = value.trim();
      //
      // Check if the value is present in the registry
      Codec? codec = getCodec(value);

      //
      // If the codec is not in the registry then check for simple types
      codec ??= getSimpleCodecs(value);
      if (codec != null) {
        //
        // Add the codec to the registry for the key and then return the codec
        addCodec(key, codec);
        return codec;
      }
      //
      // Complex type
      if (value.endsWith('>')) {
        final RegExpMatch? match = getArrowMatch(value);

        // For knowing why we're checking for groupCount == 2 and accessing [1] and [2] index
        //
        // Check documentation on utils/regexp.dart -> getArrowMatch(value);
        if (match != null && match.groupCount == 2) {
          final typeName = match[1].toString();
          switch (typeName) {
            case 'Compact':
              return _parseCompact(customJson, key, match);
            case 'Option':
              return _parseOption(customJson, key, match);
            case 'Vec':
              return _parseSequence(customJson, key, match);
            case 'BTreeMap':
              return _parseBTreeMap(customJson, key, value);
            case 'Result':
              return _parseResult(customJson, key, value);
          }
          return _parseCodec(customJson, value, customJson[value]);
        }
      }

      //
      // Tuple
      if (value.startsWith('(') && value.endsWith(')')) {
        return _parseTuple(customJson, key, value);
      }

      //
      // Fixed array
      if (value.startsWith('[') && value.endsWith(']')) {
        return _parseArray(customJson, key, value);
      }

      if (customJson[value] != null) {
        return _parseCodec(customJson, value, customJson[value]);
      }

      throw Exception('Type not found for $value');
    } else if (value is Map<String, dynamic>) {
      //
      // enum
      if (value['_enum'] != null) {
        return _parseEnum(customJson, key, value);
      }
      //
      // struct
      return _parseStruct(customJson, key, value);
    }

    return _parseCodec(customJson, value, customJson[value]);
  }

  TupleCodec _parseTuple(
      Map<String, dynamic> customJson, String key, String value) {
    // (U64, (U128, Str))
    // U64,
    final List<String> types = parseTupleRegExp(value);

    final codecs = <Codec>[];

    for (var type in types) {
      final Codec subType =
          _parseCodec(customJson, type, customJson[type] ?? type);
      codecs.add(subType);
    }

    final TupleCodec codec = TupleCodec(codecs);
    addCodec(key, codec);

    return codec;
  }

  Codec _parseCompact(
      Map<String, dynamic> customJson, String key, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        _parseCodec(customJson, match2, customJson[match2] ?? match2);
    late Codec codec;

    if (subType is U8Codec || subType is U16Codec || subType is U32Codec) {
      codec = CompactCodec.instance;
    } else if (subType is U64Codec ||
        subType is U128Codec ||
        subType is U256Codec) {
      codec = CompactBigIntCodec.instance;
    } else {
      throw Exception('Compact type not supported for $subType');
    }

    addCodec(key, codec);

    return codec;
  }

  OptionCodec _parseOption(
      Map<String, dynamic> customJson, String key, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        _parseCodec(customJson, match2, customJson[match2] ?? match2);

    final OptionCodec codec = OptionCodec(subType);

    addCodec(key, codec);

    return codec;
  }

  SequenceCodec _parseSequence(
      Map<String, dynamic> customJson, String key, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        _parseCodec(customJson, match2, customJson[match2] ?? match2);

    final SequenceCodec codec = SequenceCodec(subType);

    addCodec(key, codec);

    return codec;
  }

  ResultCodec _parseResult(
      Map<String, dynamic> customJson, String key, String value) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'Result type should have two types, Result<Ok, Error>. Like: Result<u8, bool>');

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    final okCodec = getCodec(match2) ??
        _parseCodec(customJson, match2, customJson[match2] ?? match2);

    final errCodec = getCodec(match3) ??
        _parseCodec(customJson, match3, customJson[match3] ?? match3);

    final ResultCodec codec = ResultCodec(
      okCodec: okCodec,
      errCodec: errCodec,
    );
    addCodec(key, codec);
    return codec;
  }

  BTreeMapCodec _parseBTreeMap(
      Map<String, dynamic> customJson, String key, String value) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'BTreeMap type should have two types, BTreeMap<KeyCodec, ValueCodec>. Like: BTreeMap<KeyCodec, ValueCodec>');

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    final keyCodec = getCodec(match2) ??
        _parseCodec(customJson, match2, customJson[match2] ?? match2);

    final valueCodec = getCodec(match3) ??
        _parseCodec(customJson, match3, customJson[match3] ?? match3);

    final BTreeMapCodec codec = BTreeMapCodec(
      keyCodec: keyCodec,
      valueCodec: valueCodec,
    );
    addCodec(key, codec);
    return codec;
  }

  StructCodec _parseStruct(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    final codecMap = <String, Codec>{};
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      late Codec subCodec;
      if (value is String) {
        subCodec = getCodec(value) ??
            _parseCodec(customJson, value, customJson[value] ?? value);
      } else {
        subCodec = _parseCodec(customJson, key, value);
      }
      codecMap[key] = subCodec;
    }
    final codec = StructCodec(LinkedHashMap.from(codecMap));
    addCodec(key, codec);
    return codec;
  }

  ArrayCodec _parseArray(
      Map<String, dynamic> cusomJson, String key, String value) {
    final match = getArrayMatch(value);

    assertion(
        match != null, 'Expected fixed array: [Type; length] but got $value');

    assertion(match!.groupCount == 2,
        'Expected fixed array: [Type; length] but got $value');

    final match1 = match[1].toString();

    // Get the subType
    late Codec? subType;

    subType = getCodec(match1);

    subType ??= _parseCodec(cusomJson, match1, cusomJson[match1] ?? match1);

    //
    // Get the length of the fixed array
    final int? length = int.tryParse(match[2].toString());

    assertion(length != null, 'Expected length to be an integer');

    assertion(length! >= 0, 'Expected length to be greater than or equal to 0');

    assertion(length <= 255, 'Expected length to be less than or equal to 256');

    //
    // Get the Codec based on the subType
    final ArrayCodec codec = ArrayCodec(subType, length);

    addCodec(key, codec);
    return codec;
  }

  Codec _parseEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    late Codec codec;
    if (value['_enum'] is Map<String, dynamic>) {
      try {
        final codecMap = <String, Codec>{};
        for (var entry in (value['_enum'] as Map<String, dynamic>).entries) {
          if (entry.value is String) {
            codecMap[entry.key] =
                _parseCodec(customJson, entry.value, entry.value);
          } else {
            codecMap[entry.key] = _parseStruct(customJson, key, entry.value);
          }
        }
        codec = ComplexEnumCodec(codecMap);
      } catch (e) {
        // If the enum is too complex and is calling itself back again and again then, we fallback to a dynamic enum
        if (e is! StackOverflowError) {
          rethrow;
        }

        codec = DynamicEnumCodec(
          registry: this,
          map: value['_enum'],
        );
        for (final entry in (value['_enum'] as Map<String, dynamic>).entries) {
          _postVariantFieldsProcessor[entry.key] = entry.value;
        }
      }
    } else if (value['_enum'] is List<String>) {
      codec = SimpleEnumCodec(value['_enum']);
    } else {
      throw EnumException(
          'EnumException: Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }
    addCodec(key, codec);
    return codec;
  }

  ///
  /// match and return the types which are simple and not parametrized
  Codec? getSimpleCodecs(String simpleCodecs) {
    switch (simpleCodecs.toLowerCase()) {
      case 'bool':
        return BoolCodec.instance;
      case 'h160':
        return ArrayCodec(U8Codec.instance, 20);
      case 'h256':
        return H256Codec.instance;
      case 'bytes':
        return BytesCodec.instance;
      case 'u8':
        return U8Codec.instance;
      case 'u16':
        return U16Codec.instance;
      case 'u32':
        return U32Codec.instance;
      case 'u64':
        return U64Codec.instance;
      case 'u128':
        return U128Codec.instance;
      case 'string':
      case 'text':
      case 'str':
        return StrCodec.instance;
      case 'i8':
        return I8Codec.instance;
      case 'i16':
        return I16Codec.instance;
      case 'i32':
        return I32Codec.instance;
      case 'i64':
        return I64Codec.instance;
      case 'i128':
        return I128Codec.instance;
      case 'null':
        return NullCodec.instance;
      default:
        return null;
    }
  }
}
