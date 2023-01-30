part of core;

class Registry {
  final Map<String, Codec> _codecs = <String, Codec>{};

  ///
  /// Get the registry length
  int get length => _codecs.length;

  ///
  /// Get the registry keys
  Iterable<String> get keys => _codecs.keys;

  ///
  /// Add a codec to the registry
  void addCodec(String codecName, Codec codec) {
    _codecs[codecName.toLowerCase()] = codec;
  }

  ///
  /// Get a codec from the registry
  Codec? getCodec(String codecName) {
    return _codecs[codecName.toLowerCase()];
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

      final codec = _processCodec(customJson, key, value);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
  }

  Codec _processCodec(
      Map<String, dynamic> customJson, String key, dynamic value) {
    /// Check if the codec is already in the registry
    final Codec? codec = getCodec(key);
    if (codec != null) {
      return codec;
    }

    /// Check if the value is a string
    if (value is String) {
      /// Check if the value is present in the registry
      final Codec? codec = getCodec(value);
      if (codec != null) {
        /// Add the codec to the registry for the key and then return the codec
        addCodec(key, codec);
        return codec;
      }
      // Complex type
      if (value.endsWith('>')) {
        final RegExpMatch? match = getVecMatch(value);

        /// For knowing why we're checking for groupCount == 2 and accessing [1] and [2] index
        ///
        /// Check documentation on utils/regexp.dart -> getVecMatch(value);
        if (match != null && match.groupCount == 2) {
          final match1 = match[1].toString();
          final match2 = match[2].toString();
          switch (match1) {
            case 'Result':
              return _processResult(customJson, key, value);
            case 'BTreeMap':
              return _processBTreeMap(customJson, key, value);
            case 'Vec':
            case 'Option':
            case 'Compact':
              final codec = getCodec(match1)!;//.freshInstance();
              codec.registry = this;

              codec.subType = getCodec(match2);

              // If the subType is null, then it is a custom type or a complex type
              codec.subType ??= _processCodec(
                  customJson, match2, customJson[match2] ?? match2);

              codec.typeString = value;
              addCodec(key, codec);
              return codec;
          }
          return _processCodec(customJson, value, customJson[value]);
        }
      }

      //
      // Tuple
      if (value.startsWith('(') && value.endsWith(')')) {
        final Tuples codec = getCodec('Tuples')!.freshInstance() as Tuples;
        codec.typeString = value;
        codec.buildMapping();
        for (var element in codec.tupleTypes) {
          var subCodecs = getCodec(element);
          subCodecs ??= _processCodec(
              customJson, element, customJson[element] ?? element);
          codec.registry.addCodec(element, subCodecs);
        }
        addCodec(key, codec);
        return codec;
      }
      //
      // Fixed array
      if (value.startsWith('[') && value.endsWith(']')) {
        _processFixedVec(customJson, key, value);
      }
      throw UnexpectedCaseException('Type not found for $value');
    } else if (value is Map) {
      //
      // enum
      if (value['_enum'] != null) {
        return _processEnum(customJson, key, value as Map<String, dynamic>);
      }
      //
      // set
      if (value['_set'] != null) {
        return _processSet(key, value as Map<String, dynamic>);
      }
      //
      // struct
      if (value['_struct'] != null) {
        return _processStruct(
            customJson, key, value['_struct'] as Map<String, String>);
      }
    }
    return _processCodec(customJson, value, customJson[value]);
  }

  Struct _processStruct(
      Map<String, dynamic> customJson, String key, Map<String, String> value) {
    final Struct codec = getCodec('Struct')!.freshInstance() as Struct;
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;
      var subCodec = getCodec(value);
      subCodec ??= _processCodec(customJson, value, customJson[value] ?? value);
      codec.typeStruct[key] = subCodec;
    }
    addCodec(key, codec);
    return codec;
  }

  FixedVec _processFixedVec(
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

    subType ??= _processCodec(cusomJson, match1, cusomJson[match1] ?? match1);

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

  Enum _processEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    final Enum codec = getCodec('Enum')!.freshInstance() as Enum;
    if (value['_enum'] is Map<String, dynamic>) {
      codec.typeStruct =
          _processStruct(customJson, key, value['_enum']).typeStruct;
    } else if (value['_enum'] is List<String>) {
      codec.valueList = value['_enum'];
    } else {
      throw UnexpectedCaseException(
          'Expected enum to be a map or a list, but found ${value['_enum'].runtimeType}');
    }
    addCodec(key, codec);
    return codec;
  }

  Result _processResult(
      Map<String, dynamic> customJson, String key, String value) {
    final Result codec = getCodec('Result')!.freshInstance() as Result;
    final match = getResultMatch(value);

    assertionCheck(match != null && match.groupCount >= 3,
        'Result type should have two types, Result<Ok, Error>. Like: Result<u8, bool>');

    codec.typeString = key;

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    codec.typeStruct = {
      'Ok': getCodec(match2) ??
          _processCodec(customJson, match2, customJson[match2] ?? match2),
      'Err': getCodec(match3) ??
          _processCodec(customJson, match3, customJson[match3] ?? match3),
    };
    addCodec(key, codec);
    return codec;
  }

  BTreeMap _processBTreeMap(
      Map<String, dynamic> customJson, String key, String value) {
    final BTreeMap codec = getCodec('BTreeMap')!.freshInstance() as BTreeMap;
    final match = getResultMatch(value);

    assertionCheck(match != null && match.groupCount >= 3,
        'BTreeMap type should have two types, Like: BTreeMap<u8, bool>');

    codec.typeString = key;

    final match2 = match![2]!.trim();
    final match3 = match[3]!.trim();

    codec.typeStruct = {
      'key': getCodec(match2) ??
          _processCodec(customJson, match2, customJson[match2] ?? match2),
      'value': getCodec(match3) ??
          _processCodec(customJson, match3, customJson[match3] ?? match3),
    };
    addCodec(key, codec);
    return codec;
  }

  Codec _processSet(String key, Map<String, dynamic> value) {
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
  }
}
