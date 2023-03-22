part of core;

typedef ProxyLoader = Codec Function();

class Registry {
  final Map<String, Codec> codecs = <String, Codec>{};

  final Map<String, ProxyLoader> _proxyLoaders = <String, ProxyLoader>{};
  final Map<String, ProxyCodec> _proxies = <String, ProxyCodec>{};

  Registry();

  Registry.from(Map<String, Codec> codecs) {
    this.codecs.addAll(codecs);
  }

  ProxyCodec _createProxy(
      Map<String, dynamic> metadata, String key, dynamic value) {
    if (_proxies[key] != null) {
      return _proxies[key]!;
    }

    final proxyCodec = ProxyCodec();

    _proxyLoaders[key] = () {
      proxyCodec.codec = _parseCodec(metadata, key, value, <String>{}, false);
      return proxyCodec.codec;
    };

    _proxies[key] = proxyCodec;

    return proxyCodec;
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
    if (codecs[codecName] != null &&
        codec.hashCode != codecs[codecName].hashCode) {
      final alreadyStoredCodec = codecs[codecName];
      throw Exception(
          'Codec already exists for key: $codecName, new_codec: $codec ,already_stored_codec: $alreadyStoredCodec');
    }
    codecs[codecName] ??= codec;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    return codecs[codecName];
  }

  Codec parseSpecificCodec(Map<String, dynamic> metadata, String selectedKey) {
    late Codec? codec = getCodec(selectedKey);
    if (codec != null) {
      return codec;
    }
    final value = metadata[selectedKey];

    codec = _parseCodec(
        metadata, selectedKey, value ?? selectedKey, <String>{}, true);

    _callProxyLoaders();
    if (getCodec(selectedKey) == null) {
      addCodec(selectedKey, codec);
    }
    return codec;
  }

  ///
  /// Parses metadata and adds it to registry
  void registerCustomCodec(Map<String, dynamic> metadata) {
    for (final mapEntry in metadata.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;

      if (getCodec(key) != null) {
        continue;
      }

      final codec = _parseCodec(metadata, key, value, <String>{}, true);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
    _callProxyLoaders();
  }

  void _callProxyLoaders() {
    for (final loader in _proxyLoaders.values) {
      loader();
    }
    _proxyLoaders.clear();
  }

  Codec _parseCodec(Map<String, dynamic> metadata, String key, dynamic value,
      Set<String> visitedKeys, bool allowSettingCodec) {
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
        if (allowSettingCodec) {
          addCodec(key, codec);
        }
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
              return _parseCompact(
                  metadata, key, match, visitedKeys, allowSettingCodec);
            case 'Option':
              return _parseOption(
                  metadata, key, match, visitedKeys, allowSettingCodec);
            case 'BTreeSet':
            case 'Vec':
              return _parseSequence(
                  metadata, key, match, visitedKeys, allowSettingCodec);
            case 'HashMap':
            case 'BTreeMap':
              return _parseBTreeMap(
                  metadata, key, value, visitedKeys, allowSettingCodec);
            case 'Result':
              return _parseResult(
                  metadata, key, value, visitedKeys, allowSettingCodec);
            case 'BitVec':
              return _parseBitSequence(metadata, key, value, allowSettingCodec);
            case 'DoNotConstruct':
              return NullCodec.codec;
          }

          return _parseCodec(
              metadata, value, metadata[value], visitedKeys, allowSettingCodec);
        }
      }

      //
      // Tuple
      if (value.startsWith('(') && value.endsWith(')')) {
        return _parseTuple(
            metadata, key, value, visitedKeys, allowSettingCodec);
      }

      //
      // Fixed array
      if (value.startsWith('[') && value.endsWith(']')) {
        return _parseArray(
            metadata, key, value, visitedKeys, allowSettingCodec);
      }

      if (metadata[value] != null) {
        final codec = _parseCodec(
            metadata, value, metadata[value], visitedKeys, allowSettingCodec);
        if (allowSettingCodec) {
          addCodec(key, codec);
        }
        return codec;
      }

      throw Exception('Type not found for `$value`');
    } else if (value is Map) {
      //
      // enum
      if (value['_enum'] != null) {
        return _parseEnum(
            metadata,
            key,
            value.map((k, v) => MapEntry(k.toString(), v)),
            visitedKeys,
            allowSettingCodec);
      }
      //
      // set
      if (value['_set'] != null) {
        return _parseSet(
            key, value['_set'] as Map<String, int>, allowSettingCodec);
      }
      //
      // composite
      return _parseComposite(
        metadata,
        key,
        value.map((k, v) => MapEntry(k.toString(), v)),
        visitedKeys,
        allowSettingCodec,
      );
    }
    if (value == null) {
      throw Exception('Type not found for `$value`');
    }
    return _parseCodec(
        metadata, key, metadata[value], visitedKeys, allowSettingCodec);
  }

  ///
  ///
  /// Parses a Tuple and then returns the codec
  ///
  /// Tuple is a list of types
  Codec _parseTuple(Map<String, dynamic> metadata, String key, String value,
      Set<String> visitedKeys, bool allowSettingCodec) {
    // (U64, (U128, Str))
    // U64,

    final List<String> types = parseTupleRegExp(value);

    final codecs = <String, Codec>{};

    for (final type in types) {
      if (codecs[type] != null) {
        continue;
      }
      final Codec subType = getCodec(type) ??
          _parseCodec(metadata, type, metadata[type] ?? type, visitedKeys,
              allowSettingCodec);
      codecs[type] = subType;
    }

    final TupleCodec codec = TupleCodec(
        types.map((String type) => codecs[type]!).toList(growable: false));
    if (allowSettingCodec) {
      addCodec(value, codec);
      addCodec(key, codec);
    }
    return codec;
  }

  ///
  ///
  /// Parses a Compact and then returns the codec
  ///
  /// Compact's subType can be any of the following:
  /// (U8, U16, U32, U64, U128, U256)
  Codec _parseCompact(Map<String, dynamic> metadata, String key,
      RegExpMatch match, Set<String> visitedKeys, bool allowSettingCodec) {
    final match2 = match[2].toString();

    final Codec subType = getCodec(match2) ??
        _parseCodec(metadata, match2, metadata[match2] ?? match2, visitedKeys,
            allowSettingCodec);

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

    if (allowSettingCodec) {
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseOption(Map<String, dynamic> metadata, String key,
      RegExpMatch match, Set<String> visitedKeys, bool allowSettingCodec) {
    final match2 = match[2].toString();

    final Codec subType = getCodec(match2) ??
        _parseCodec(metadata, match2, metadata[match2] ?? match2, visitedKeys,
            allowSettingCodec);

    final NestedOptionCodec codec = NestedOptionCodec(subType);

    if (allowSettingCodec) {
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseSequence(Map<String, dynamic> metadata, String key,
      RegExpMatch match, Set<String> visitedKeys, bool allowSettingCodec) {
    final match2 = match[2].toString();

    final Codec subType = getCodec(match2) ??
        _parseCodec(metadata, match2, metadata[match2] ?? match2, visitedKeys,
            allowSettingCodec);

    final SequenceCodec codec = SequenceCodec(subType);

    if (allowSettingCodec) {
      addCodec(key, codec);
    }
    return codec;
  }

  BitSequenceCodec _parseBitSequence(Map<String, dynamic> metadata, String key,
      String value, bool allowSettingCodec) {
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
    } else {
      throw Exception('BitVec order type not supported for order: $orderType.');
    }

    final BitSequenceCodec codec = BitSequenceCodec(
      store,
      order,
    );

    if (allowSettingCodec) {
      addCodec(value, codec);
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseResult(Map<String, dynamic> metadata, String key, String value,
      Set<String> visitedKeys, bool allowSettingCodec) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'Result type should have two types, Result<Ok, Error>. Like: Result<u8, bool>');

    final match2 = match![2]!.trim();

    final okCodec = getCodec(match2) ??
        _parseCodec(metadata, match2, metadata[match2] ?? match2, visitedKeys,
            allowSettingCodec);

    final match3 = match[3]!.trim();

    final errCodec = getCodec(match3) ??
        _parseCodec(metadata, match3, metadata[match3] ?? match3, visitedKeys,
            allowSettingCodec);

    final ComplexEnumCodec codec = ComplexEnumCodec.sparse({
      0: MapEntry('Ok', okCodec),
      1: MapEntry('Err', errCodec),
    });

    if (allowSettingCodec) {
      addCodec(value, codec);
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseBTreeMap(Map<String, dynamic> metadata, String key, String value,
      Set<String> visitedKeys, bool allowSettingCodec) {
    final match = getResultMatch(value);

    assertion(match != null && match.groupCount >= 3,
        'BTreeMap type should have two types, BTreeMap<KeyCodec, ValueCodec>. Like: BTreeMap<KeyCodec, ValueCodec>');

    final match2 = match![2]!.trim();

    final keyCodec = getCodec(match2) ??
        _parseCodec(metadata, match2, metadata[match2] ?? match2, visitedKeys,
            allowSettingCodec);

    final match3 = match[3]!.trim();

    final valueCodec = getCodec(match3) ??
        _parseCodec(metadata, match3, metadata[match3] ?? match3, visitedKeys,
            allowSettingCodec);

    final BTreeMapCodec codec = BTreeMapCodec(
      keyCodec: keyCodec,
      valueCodec: valueCodec,
    );

    if (allowSettingCodec) {
      addCodec(value, codec);
      addCodec(key, codec);
    }
    return codec;
  }

  SetCodec _parseSet(
      String key, Map<String, int> value, bool allowSettingCodec) {
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
    if (allowSettingCodec) {
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseComposite(
    Map<String, dynamic> metadata,
    String key,
    Map<String, dynamic> value,
    Set<String> visitedKeys,
    bool allowSettingCodec,
  ) {
    if (visitedKeys.contains(key)) {
      return _createProxy(metadata, key, value);
    }

    visitedKeys.add(key);

    final codecMap = <String, Codec>{};

    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final val = mapEntry.value;
      late Codec subCodec;
      if (val is String) {
        subCodec = getCodec(val) ??
            _parseCodec(metadata, val, metadata[val] ?? val, visitedKeys,
                allowSettingCodec);
      } else {
        subCodec = getCodec(key) ??
            _parseCodec(metadata, key, val, visitedKeys, allowSettingCodec);
      }
      codecMap[key] = subCodec;
    }

    final codec = CompositeCodec(codecMap);
    visitedKeys.remove(key);

    if (allowSettingCodec) {
      addCodec(key, codec);
    }

    return codec;
  }

  Codec _parseArray(Map<String, dynamic> metadata, String key, String value,
      Set<String> visitedKeys, bool allowSettingCodec) {
    final match = getArrayMatch(value);

    assertion(
        match != null, 'Expected fixed array: [Type; length] but got $value');
    assertion(match!.groupCount == 2,
        'Expected fixed array: [Type; length] but got $value');

    final match1 = match[1].toString();

    final subType = getCodec(match1) ??
        _parseCodec(metadata, match1, metadata[match1] ?? match1, visitedKeys,
            allowSettingCodec);

    //
    // Get the length of the fixed array
    final int? length = int.tryParse(match[2].toString());

    assertion(length != null, 'Expected length to be an integer');
    assertion(length! >= 0, 'Expected length to be greater than or equal to 0');
    assertion(length <= 256, 'Expected length to be less than or equal to 256');

    //
    // Get the Codec based on the subType
    final ArrayCodec codec = ArrayCodec(subType, length);

    if (allowSettingCodec) {
      addCodec(value, codec);
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseEnum(Map<String, dynamic> metadata, String key,
      Map<String, dynamic> value, Set<String> visited, bool allowSettingCodec) {
    late Codec codec;
    if (value['_enum'] is Map<String, int>) {
      //
      // Indexed Enum
      codec = _parseIndexedEnum(value['_enum'] as Map<String, int>);
    } else if (value['_enum'] is Map<String, dynamic>) {
      //
      // Complex Enum
      codec = _parseComplexEnum(metadata, key, value, visited);
    } else if (value['_enum'] is Map<int, MapEntry<String, dynamic>>) {
      //
      // Complex Enum
      codec = _parseComplexEnum(metadata, key, value, visited);
    } else if (value['_enum'] is List<String?>) {
      //
      // Simplified Enum
      codec = _parseSimplifiedEnum(value['_enum'] as List<String?>);
    } else {
      throw EnumException(
          'EnumException: Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }

    if (allowSettingCodec) {
      addCodec(key, codec);
    }
    return codec;
  }

  Codec _parseComplexEnum(Map<String, dynamic> metadata, String key,
      Map<String, dynamic> value, Set<String> visitedKeys) {
    if (visitedKeys.contains(key)) {
      return _createProxy(metadata, key, value);
    }
    visitedKeys.add(key);
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

    final cache = <String, Codec>{};

    for (final map in entries.entries) {
      final entry = map.value;
      late Codec codec;
      if (entry.value is String) {
        if (cache[entry.value] != null) {
          codec = cache[entry.value]!;
        } else {
          //
          // get the codec for this variant of the enum
          codec = getCodec(entry.value) ??
              _parseCodec(
                  metadata, entry.value, entry.value, visitedKeys, false);
          cache[entry.value] = codec;
        }
      } else {
        final tempKey = '$key:${entry.key}';
        if (cache[entry.key] != null) {
          codec = cache[entry.key]!;
        } else {
          codec = getCodec(tempKey) ??
              _parseComposite(
                  metadata, tempKey, entry.value, visitedKeys, false);
          cache[entry.key] = codec;
        }
      }
      //
      // Assign the codec to the enum
      codecMap[map.key] = MapEntry(entry.key, codec);
    }
    final codec = ComplexEnumCodec.sparse(codecMap);
    visitedKeys.remove(key);
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
    if (type.isEmpty || type == '()') {
      return 'Null';
    }
    type = type.replaceAll('T::', '');
    type = type.replaceAll('VecDeque<', 'Vec<');
    type = type.replaceAll('<T>', '');
    type = type.replaceAll('<T, I>', '');
    type = type.replaceAll('&\'static[u8]', 'Bytes');
    type = type.replaceAll('<Lookup as StaticLookup>::Source', 'Address');

    type = type.trim();
    if (type.isEmpty) {
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
        throw Exception('Type DoNotConstruct found.');
      case 'null':
        return NullCodec.codec;
      default:
        return null;
    }
  }
}
