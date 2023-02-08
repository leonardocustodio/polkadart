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

  ///
  /// Parses customJson and adds it to registry
  void registerCustomCodec(Map<String, dynamic> customJson) {
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

  Codec _parseCodec(
      Map<String, dynamic> customJson, String key, dynamic value) {
    //
    // Check if the codec is already in the registry
    final Codec? codec = getCodec(key);
    if (codec != null) {
      return codec;
    }

    //
    //Check if the value is a string
    if (value is String) {
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
            case 'Vec':
              return _parseSequence(customJson, key, match);
          }
          return _parseCodec(customJson, value, customJson[value]);
        }
      }

      //
      // Tuple
      /*  if (value.startsWith('(') && value.endsWith(')')) {
        final Tuples codec = getCodec('Tuples')!.newInstance() as Tuples;
        codec.typeString = value;
        codec.buildMapping();
        for (var element in codec.tupleTypes) {
          var subCodecs = getCodec(element);
          subCodecs ??=
              _parseCodec(customJson, element, customJson[element] ?? element);
          codec.registry.addCodec(element, subCodecs);
        }
        addCodec(key, codec);
        return codec;
      } */
      //
      // Fixed array
      /*  if (value.startsWith('[') && value.endsWith(']')) {
        _parseFixedVec(customJson, key, value);
      } */
      throw Exception('Type not found for $value');
    } else if (value is Map) {
      //
      // enum
      /*  if (value['_enum'] != null) {
        return _parseEnum(customJson, key, value as Map<String, dynamic>);
      } */
      //
      // set
      /*  if (value['_set'] != null) {
        return _parseSet(key, value as Map<String, dynamic>);
      } */
      //
      // struct
      /* if (value['_struct'] != null) {
        return _parseStruct(
            customJson, key, value['_struct'] as Map<String, String>);
      } */
    }
    return _parseCodec(customJson, value, customJson[value]);
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

  /* Struct _parseStruct(
      Map<String, dynamic> customJson, String key, Map<String, String> value) {
    final Struct codec = getCodec('Struct')!.newInstance() as Struct;
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;
      var subCodec = getCodec(value);
      subCodec ??= _parseCodec(customJson, value, customJson[value] ?? value);
      codec.typeStruct[key] = subCodec;
    }
    addCodec(key, codec);
    return codec;
  } */

  /* FixedVec _parseFixedVec(
      Map<String, dynamic> cusomJson, String key, String value) {
    final match = getFixedVecMatch(value);

    assertionCheck(
        match != null, 'Expected fixed array: [Type; length] but got $value');

    assertionCheck(match!.groupCount == 2,
        'Expected fixed array: [Type; length] but got $value');

    // For knowing why we're checking for groupCount == 2 and accessing [1] and [2] index
    // Check documentation on utils/regexp.dart -> getFixedArrayMatch(value);
    final match1 = match[1].toString();

    // Get the subType
    late Codec? subType;

    subType = getCodec(match1);

    subType ??= _parseCodec(cusomJson, match1, cusomJson[match1] ?? match1);

    //
    // Get the Codec based on the subType
    final FixedVec codec = getCodec('FixedVec')! as FixedVec;

    //
    // Get the subType
    codec.subType = subType;

    //
    // Get the length of the fixed array
    final int? length = int.tryParse(match[2].toString());

    assertionCheck(length != null, 'Expected length to be an integer');

    assertionCheck(
        length! >= 0, 'Expected length to be greater than or equal to 0');

    assertionCheck(
        length <= 255, 'Expected length to be less than or equal to 256');

    codec.fixedLength = length;
    addCodec(key, codec);
    return codec;
  }

  Enum _parseEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    final Enum codec = getCodec('Enum')!.newInstance() as Enum;
    if (value['_enum'] is Map<String, dynamic>) {
      codec.typeStruct =
          _parseStruct(customJson, key, value['_enum']).typeStruct;
    } else if (value['_enum'] is List<String>) {
      codec.valueList = value['_enum'];
    } else {
      throw UnexpectedCaseException(
          'Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }
    addCodec(key, codec);
    return codec;
  }

  Result _parseResult(
      Map<String, dynamic> customJson, String key, String value) {
    final Result codec = getCodec('Result')!.newInstance() as Result;
    final match = getResultMatch(value);

    assertionCheck(match != null && match.groupCount >= 3,
        'Result type should have two types, Result<Ok, Error>. Like: Result<u8, bool>');

    codec.typeString = key;

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    codec.typeStruct = {
      'Ok': getCodec(match2) ??
          _parseCodec(customJson, match2, customJson[match2] ?? match2),
      'Err': getCodec(match3) ??
          _parseCodec(customJson, match3, customJson[match3] ?? match3),
    };
    addCodec(key, codec);
    return codec;
  }

  BTreeMap _parseBTreeMap(
      Map<String, dynamic> customJson, String key, String value) {
    final BTreeMap codec = getCodec('BTreeMap')!.newInstance() as BTreeMap;
    final match = getResultMatch(value);

    assertionCheck(match != null && match.groupCount >= 3,
        'BTreeMap type should have two types, Like: BTreeMap<u8, bool>');

    codec.typeString = key;

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    codec.typeStruct = {
      'key': getCodec(match2) ??
          _parseCodec(customJson, match2, customJson[match2] ?? match2),
      'value': getCodec(match3) ??
          _parseCodec(customJson, match3, customJson[match3] ?? match3),
    };
    addCodec(key, codec);
    return codec;
  }

  Codec _parseSet(String key, Map<String, dynamic> value) {
    final Codec codec = getCodec('Set')!;
    if (value['_bitLength'] != null) {
      codec.bitLength = int.parse(value['_bitLength']);
    } else {
      codec.bitLength = 16;
    }
    (value['_set'] as Map).remove('_bitLength');
    codec.valueList = (value['_set'] as Map).keys.cast<String>().toList();
    addCodec(key, codec);
    return codec;
  } */

  ///
  /// match and return the types which are simple and not parametrized
  Codec? getSimpleCodecs(String primitiveName) {
    switch (primitiveName.toString()) {
      case 'bool':
        return BoolCodec.instance;
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
      default:
        return null;
    }
  }
}
