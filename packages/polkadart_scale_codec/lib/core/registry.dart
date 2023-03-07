part of core;

class Registry {
  final Map<String, Codec> codecs = <String, Codec>{};

  Registry();

  Registry.from(Map<String, Codec> codecs) {
    this.codecs.addAll(codecs);
  }

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
      return NullCodec.codec;
    }

    key = _renameType(key);
    //
    // Check if the codec is already in the registry
    final Codec? codec = getCodec(key);
    if (codec != null) {
      return codec;
    }

    //
    //Check if the value is a string
    if (value is String) {
      key = _renameType(key);
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
            case 'BitVec':
              return _parseBitSequence(customJson, key, value);
            case 'DoNotConstruct':
              return NullCodec.codec;
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

      throw Exception('Type not found for `$value`');
    } else if (value is Map<String, dynamic>) {
      //
      // enum
      if (value['_enum'] != null) {
        return _parseEnum(customJson, key, value);
      }
      //
      // set
      if (value['_set'] != null) {
        return _parseSet(key, value['_set'] as Map<String, int>);
      }
      //
      // composite
      return _parseComposite(customJson, key, value);
    }

    return _parseCodec(customJson, key, customJson[value]);
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
      codec = CompactCodec.codec;
    } else if (subType is U64Codec ||
        subType is U128Codec ||
        subType is U256Codec ||
        subType is NullCodec) {
      codec = CompactBigIntCodec.codec;
    } else {
      throw Exception('Compact type not supported for $subType');
    }

    addCodec(key, codec);

    return codec;
  }

  NestedOptionCodec _parseOption(
      Map<String, dynamic> customJson, String key, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        _parseCodec(customJson, match2, customJson[match2] ?? match2);

    final NestedOptionCodec codec = NestedOptionCodec(subType);

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

  BitSequenceCodec _parseBitSequence(
      Map<String, dynamic> customJson, String key, String value) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'BitVec type should have two types, BitVec<U8, LSB>. Like: BitVec<U8, MSB>');

    final storeType = match![2]!.trim();
    final orderType = match[3]!.trim();

    late BitStore store;
    late BitOrder order;

    switch (storeType) {
      case 'U8':
        store = BitStore.U8;
        break;
      case 'U16':
        store = BitStore.U16;
        break;
      case 'U32':
        store = BitStore.U32;
        break;
      case 'U64':
        store = BitStore.U64;
        break;
      default:
    }

    if (orderType.startsWith('Lsb')) {
      order = BitOrder.LSB;
    } else if (orderType.startsWith('Msb')) {
      order = BitOrder.MSB;
    }

    final BitSequenceCodec codec = BitSequenceCodec(
      store,
      order,
    );
    addCodec(key, codec);
    return codec;
  }

  ComplexEnumCodec _parseResult(
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

    final ComplexEnumCodec codec = ComplexEnumCodec.sparse({
      0: MapEntry('Ok', okCodec),
      1: MapEntry('Err', errCodec),
    });
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

  SetCodec _parseSet(String key, Map<String, int> value) {
    late int bitLength;
    if (value.containsKey('_bitLength')) {
      bitLength = value['_bitLength']!;
    } else {
      bitLength = 8;
    }
    assertion(bitLength % 8 == 0, 'Set bitLength should be multiple of 8.');
    assertion(bitLength > 0, 'Set bitLength should be greater than 0');

    final values = value.entries
        .where((element) => element.key != '_bitLength')
        .map((e) => e.key)
        .toList(growable: false);

    final codec = SetCodec(bitLength, values);
    addCodec(key, codec);
    return codec;
  }

  CompositeCodec _parseComposite(Map<String, dynamic> customJson,
      String mainKey, Map<String, dynamic> value) {
    final codecMap = <String, Codec>{};
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final val = mapEntry.value;
      late Codec subCodec;
      if (val is String) {
        try {
          subCodec = getCodec(val) ??
              _parseCodec(customJson, val, customJson[val] ?? val);
        } catch (e) {
          if (e is! StackOverflowError) {
            rethrow;
          }
          subCodec = ReferencedCodec(
            referencedType: val,
            registry: this,
          );
        }
      } else {
        subCodec = _parseCodec(customJson, key, val);
      }
      codecMap[key] = subCodec;
    }
    final codec = CompositeCodec(LinkedHashMap.from(codecMap));

    addCodec(mainKey, codec);
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

    assertion(length <= 256, 'Expected length to be less than or equal to 256');

    //
    // Get the Codec based on the subType
    final ArrayCodec codec = ArrayCodec(subType, length);

    addCodec(key, codec);
    return codec;
  }

  Codec _parseEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    if (value['_enum'] is Map<String, int>) {
      //
      // Indexed Enum
      return _parseIndexedEnum(key, value['_enum'] as Map<String, int>);
    } else if (value['_enum'] is Map<String, dynamic>) {
      //
      // Complex Enum
      return _parseComplexEnum(customJson, key, value);
    } else if (value['_enum'] is Map<int, MapEntry<String, dynamic>>) {
      //
      // Complex Enum
      return _parseComplexEnum(customJson, key, value);
    } else if (value['_enum'] is List<String?>) {
      //
      // Simplified Enum
      return _parseSimplifiedEnum(key, value['_enum'] as List<String?>);
    } else {
      throw EnumException(
          'EnumException: Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }
  }

  Codec _parseComplexEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    // enumValue
    final enumValue = value['_enum'];

    final Map<int, MapEntry<String, Codec>> codecMap =
        <int, MapEntry<String, Codec>>{};

    final Map<int, MapEntry<String, dynamic>> entries =
        <int, MapEntry<String, dynamic>>{};

    if (enumValue is Map<String, dynamic>) {
      //
      // convert enumValue to a list of MapEntry
      int index = 0;
      for (final entry in enumValue.entries) {
        entries[index] = MapEntry(entry.key, entry.value);
        index++;
      }
    } else if (enumValue is Map<int, MapEntry<String, dynamic>>) {
      //
      // convert enumValue to a list of MapEntry
      entries.addAll(enumValue);
    }
    try {
      for (final map in entries.entries) {
        final entry = map.value;
        if (entry.value is String) {
          codecMap[map.key] = MapEntry(
              entry.key, _parseCodec(customJson, entry.value, entry.value));
        } else {
          codecMap[map.key] = MapEntry(
              entry.key, _parseComposite(customJson, entry.key, entry.value));
        }
      }
      final codec = ComplexEnumCodec.sparse(codecMap);
      addCodec(key, codec);
      return codec;
    } catch (e) {
      // If the enum is too complex and is calling itself back again and again then,
      // we fallback to a dynamic enum
      if (e is! StackOverflowError) {
        rethrow;
      }
      return _parseDynamicEnum(customJson, key, value);
    }
  }

  DynamicEnumCodec _parseDynamicEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    final enumValue = value['_enum'];

    final Map<int, String> referenceTypeMap = <int, String>{};

    final Map<int, MapEntry<String, dynamic>> entries =
        <int, MapEntry<String, dynamic>>{};

    if (enumValue is Map<String, dynamic>) {
      //
      // convert enumValue to a list of MapEntry
      int index = 0;
      for (final entry in enumValue.entries) {
        entries[index] = MapEntry(entry.key, entry.value);
        index++;
      }
    } else if (enumValue is Map<int, MapEntry<String, dynamic>>) {
      //
      // convert enumValue to a list of MapEntry
      entries.addAll(enumValue);
    }
    for (final map in entries.entries) {
      final index = map.key;
      final entry = map.value;

      referenceTypeMap[index] = entry.key;
      _postVariantFieldsProcessor[entry.key] = entry.value;
    }
    final codec =
        DynamicEnumCodec.sparse(registry: this, map: referenceTypeMap);
    addCodec(key, codec);
    return codec;
  }

  SimpleEnumCodec _parseSimplifiedEnum(String key, List<String?> values) {
    final codec = SimpleEnumCodec.fromList(values);
    addCodec(key, codec);
    return codec;
  }

  SimpleEnumCodec _parseIndexedEnum(
      String key, Map<String, int> indexedEnumValues) {
    if (indexedEnumValues.isEmpty) {
      return _parseSimplifiedEnum(key, <String>[]); // empty enum
    }
    final maxIndex = indexedEnumValues.values
        .toList(growable: false)
        .reduce((int value, int element) => value > element ? value : element);
    //
    // make enum list of strings with null values
    final List<String?> enumValues = List.filled(maxIndex + 1, null);

    // filling at the available positions of the indexes
    for (final MapEntry<String, int> entry in indexedEnumValues.entries) {
      enumValues[entry.value] = entry.key;
    }

    return _parseSimplifiedEnum(key, enumValues);
  }

  String _renameType(String type) {
    type = type.trim();
    if (type == '()') {
      return 'Null';
    }
    type = type.replaceAll('T::', '');
    type = type.replaceAll('VecDeque<', 'Vec<');
    type = type.replaceAll('<T>', '');
    type = type.replaceAll('<T, I>', '');
    type = type.replaceAll('&\'static[u8]', 'Bytes');
    switch (type) {
      case '<Lookup as StaticLookup>::Source':
        return 'Address';
    }
    type = type.trim();
    if (type == '') {
      return 'Null';
    }
    return type;
  }

  ///
  /// match and return the types which are simple and not parametrized
  Codec? getSimpleCodecs(String simpleCodecs) {
    switch (simpleCodecs.toLowerCase()) {
      case 'bitvec':
        return BitSequenceCodec(BitStore.U8, BitOrder.LSB);
      case 'bool':
        return BoolCodec.codec;
      case 'u8':
        return U8Codec.codec;
      case 'u16':
        return U16Codec.codec;
      case 'u32':
        return U32Codec.codec;
      case 'u64':
        return U64Codec.codec;
      case 'u128':
        return U128Codec.codec;
      case 'u256':
        return U256Codec.codec;
      case 'string':
      case 'text':
      case 'str':
        return StrCodec.codec;
      case 'i8':
        return I8Codec.codec;
      case 'i16':
        return I16Codec.codec;
      case 'i32':
        return I32Codec.codec;
      case 'i64':
        return I64Codec.codec;
      case 'i128':
        return I128Codec.codec;
      case 'i256':
        return I256Codec.codec;
      case 'donotconstruct':
      case 'null':
        return NullCodec.codec;
      default:
        return null;
    }
  }
}
