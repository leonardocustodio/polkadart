part of core;

class Registry {
  final Map<String, Codec> codecs = <String, Codec>{};

  Registry();

  final Map<int, String> hashCodes = <int, String>{};

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
  void addCodec(String codecName, Codec codec, [bool overwrite = false]) {
    if (overwrite) {
      codecs[codecName] = codec;
      return;
    }
    if (codecs[codecName] != null) {
      final storedCodec = codecs[codecName];
      if (storedCodec.runtimeType != codec.runtimeType &&
          storedCodec.hashCode != codec.hashCode) {
        throw Exception(
            'Tried overriting: $codecName: Stored: ${storedCodec.runtimeType}, New:${codec.runtimeType}');
      }
    }
    codecs[codecName] ??= codec;
    hashCodes[codecs[codecName].hashCode] = codecName;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    return codecs[codecName];
  }

  final Map<String, dynamic> _postVariantFieldsProcessor = <String, dynamic>{};

  Codec parseSpecificCodec(
      Map<String, dynamic> customJson, String selectedKey) {
    final value = customJson[selectedKey];
    late Codec codec;
    if (value == null) {
      // can be u8 or a Vec<u8> which don't need to have a definition
      codec = parseCodec(customJson, selectedKey, selectedKey);
    } else if (value is String) {
      codec = parseCodec(customJson, selectedKey, value);
    } else {
      codec = parseCodec(customJson, selectedKey, value);
    }
    _parsePostVariantFields(customJson);
    addCodec(selectedKey, codec);
    return codec;
  }

  ///
  /// Parses customJson and adds it to registry
  void registerCustomCodec(Map<String, dynamic> customJson) {
    for (final mapEntry in customJson.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      if (getCodec(key) != null) {
        continue;
      }

      final codec = parseCodec(customJson, key, value);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
    _parsePostVariantFields(customJson);
  }

  void _parsePostVariantFields(Map<String, dynamic> customJson) {
    for (final mapEntry in _postVariantFieldsProcessor.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      if (getCodec(key) != null) {
        continue;
      }

      final codec = parseCodec(customJson, key, value);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
  }

  Codec parseCodec(Map<String, dynamic> customJson, String key, dynamic value) {
    if (value == 'Null') {
      return NullCodec.codec;
    }

    key = renameType(key);
    //
    // Check if the codec is already in the registry
    Codec? codec = getCodec(key);

    //
    // If the codec is not in the registry then check for simple types
    codec ??= getSimpleCodecs(key);
    if (codec != null) {
      return codec;
    }

    //
    //Check if the value is a string
    if (value is String) {
      value = renameType(value);
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
              return _parseCompact(customJson, match);
            case 'Option':
              return _parseOption(customJson, match);
            case 'BTreeSet':
            case 'Vec':
              return _parseSequence(customJson, match);
            case 'HashMap':
            case 'BTreeMap':
              return _parseBTreeMap(customJson, value);
            case 'Result':
              return _parseResult(customJson, value);
            case 'BitVec':
              return _parseBitSequence(customJson, value);
            case 'DoNotConstruct':
              return NullCodec.codec;
          }
          return parseCodec(customJson, value, customJson[value]);
        }
      }

      //
      // Tuple
      if (value.startsWith('(') && value.endsWith(')')) {
        return _parseTuple(customJson, value);
      }

      //
      // Fixed array
      if (value.startsWith('[') && value.endsWith(']')) {
        return _parseArray(customJson, value);
      }

      if (customJson[value] != null) {
        return parseCodec(customJson, value, customJson[value]);
      }

      throw Exception('Type not found for `$value`');
    } else if (value is Map) {
      //
      // enum
      if (value['_enum'] != null) {
        return _parseEnum(
            customJson, value.map((k, v) => MapEntry(k.toString(), v)));
      }
      //
      // set
      if (value['_set'] != null) {
        return _parseSet(value['_set'] as Map<String, int>);
      }
      //
      // composite
      return _parseComposite(
          customJson, value.map((k, v) => MapEntry(k.toString(), v)));
    }
    if (value == null) {
      print('${value.runtimeType}');
      print('key: $key, value: $value, customJson: ${customJson[value]}');
      throw Exception('Type not found for `$value`');
    }
    return parseCodec(customJson, key, customJson[value]);
  }

  TupleCodec _parseTuple(Map<String, dynamic> customJson, String value) {
    // (U64, (U128, Str))
    // U64,
    final List<String> types = parseTupleRegExp(value);

    final codecs = <Codec>[];

    for (var type in types) {
      final Codec subType =
          parseCodec(customJson, type, customJson[type] ?? type);
      codecs.add(subType);
    }

    final TupleCodec codec = TupleCodec(codecs);
    return codec;
  }

  Codec _parseCompact(Map<String, dynamic> customJson, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        parseCodec(customJson, match2, customJson[match2] ?? match2);
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

    return codec;
  }

  NestedOptionCodec _parseOption(
      Map<String, dynamic> customJson, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        parseCodec(customJson, match2, customJson[match2] ?? match2);

    final NestedOptionCodec codec = NestedOptionCodec(subType);

    return codec;
  }

  SequenceCodec _parseSequence(
      Map<String, dynamic> customJson, RegExpMatch match) {
    final match2 = match[2].toString();

    final Codec subType =
        parseCodec(customJson, match2, customJson[match2] ?? match2);

    final SequenceCodec codec = SequenceCodec(subType);

    return codec;
  }

  BitSequenceCodec _parseBitSequence(
      Map<String, dynamic> customJson, String value) {
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

    return codec;
  }

  ComplexEnumCodec _parseResult(Map<String, dynamic> customJson, String value) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'Result type should have two types, Result<Ok, Error>. Like: Result<u8, bool>');

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    final okCodec = getCodec(match2) ??
        parseCodec(customJson, match2, customJson[match2] ?? match2);

    final errCodec = getCodec(match3) ??
        parseCodec(customJson, match3, customJson[match3] ?? match3);

    final ComplexEnumCodec codec = ComplexEnumCodec.sparse({
      0: MapEntry('Ok', okCodec),
      1: MapEntry('Err', errCodec),
    });

    return codec;
  }

  BTreeMapCodec _parseBTreeMap(Map<String, dynamic> customJson, String value) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'BTreeMap type should have two types, BTreeMap<KeyCodec, ValueCodec>. Like: BTreeMap<KeyCodec, ValueCodec>');

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    final keyCodec = getCodec(match2) ??
        parseCodec(customJson, match2, customJson[match2] ?? match2);

    final valueCodec = getCodec(match3) ??
        parseCodec(customJson, match3, customJson[match3] ?? match3);

    final BTreeMapCodec codec = BTreeMapCodec(
      keyCodec: keyCodec,
      valueCodec: valueCodec,
    );

    return codec;
  }

  SetCodec _parseSet(Map<String, int> value) {
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

    return codec;
  }

  CompositeCodec _parseComposite(
      Map<String, dynamic> customJson, Map<String, dynamic> value) {
    final codecMap = <String, Codec>{};
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final val = mapEntry.value;
      late Codec subCodec;
      if (val is String) {
        try {
          subCodec = getCodec(val) ??
              parseCodec(customJson, val, customJson[val] ?? val);
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
        subCodec = parseCodec(customJson, key, val);
      }
      codecMap[key] = subCodec;
    }
    final codec = CompositeCodec(codecMap);
    return codec;
  }

  ArrayCodec _parseArray(Map<String, dynamic> cusomJson, String value) {
    final match = getArrayMatch(value);

    assertion(
        match != null, 'Expected fixed array: [Type; length] but got $value');

    assertion(match!.groupCount == 2,
        'Expected fixed array: [Type; length] but got $value');

    final match1 = match[1].toString();

    // Get the subType
    late Codec? subType;

    subType = getCodec(match1);

    subType ??= parseCodec(cusomJson, match1, cusomJson[match1] ?? match1);

    //
    // Get the length of the fixed array
    final int? length = int.tryParse(match[2].toString());

    assertion(length != null, 'Expected length to be an integer');

    assertion(length! >= 0, 'Expected length to be greater than or equal to 0');

    assertion(length <= 256, 'Expected length to be less than or equal to 256');

    //
    // Get the Codec based on the subType
    final ArrayCodec codec = ArrayCodec(subType, length);

    return codec;
  }

  Codec _parseEnum(
      Map<String, dynamic> customJson, Map<String, dynamic> value) {
    if (value['_enum'] is Map<String, int>) {
      //
      // Indexed Enum
      return _parseIndexedEnum(value['_enum'] as Map<String, int>);
    } else if (value['_enum'] is Map<String, dynamic>) {
      //
      // Complex Enum
      return _parseComplexEnum(customJson, value);
    } else if (value['_enum'] is Map<int, MapEntry<String, dynamic>>) {
      //
      // Complex Enum
      return _parseComplexEnum(customJson, value);
    } else if (value['_enum'] is List<String?>) {
      //
      // Simplified Enum
      return _parseSimplifiedEnum(value['_enum'] as List<String?>);
    } else {
      throw EnumException(
          'EnumException: Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }
  }

  Codec _parseComplexEnum(
      Map<String, dynamic> customJson, Map<String, dynamic> value) {
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
              entry.key, parseCodec(customJson, entry.value, entry.value));
        } else {
          codecMap[map.key] =
              MapEntry(entry.key, _parseComposite(customJson, entry.value));
        }
      }
      final codec = ComplexEnumCodec.sparse(codecMap);

      return codec;
    } catch (e) {
      // If the enum is too complex and is calling itself back again and again then,
      // we fallback to a dynamic enum
      if (e is! StackOverflowError) {
        rethrow;
      }
      return _parseDynamicEnum(customJson, value);
    }
  }

  DynamicEnumCodec _parseDynamicEnum(
      Map<String, dynamic> customJson, Map<String, dynamic> value) {
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

    return codec;
  }

  SimpleEnumCodec _parseSimplifiedEnum(List<String?> values) {
    final codec = SimpleEnumCodec.fromList(values);

    return codec;
  }

  SimpleEnumCodec _parseIndexedEnum(Map<String, int> indexedEnumValues) {
    if (indexedEnumValues.isEmpty) {
      return _parseSimplifiedEnum(<String>[]); // empty enum
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

    return _parseSimplifiedEnum(enumValues);
  }

  String renameType(String type) {
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
