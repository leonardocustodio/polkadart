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

      final codec = processCodec(customJson, key, value);
      if (getCodec(key) == null) {
        addCodec(key, codec);
      }
    }
  }

  Codec processCodec(
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
            // vec array
            case 'Vec':
            case 'Option':
            case 'Compact':
              final codec = getCodec(match1)!.freshInstance();
              codec.registry = this;

              codec.subType = getCodec(match2);

              // If the subType is null, then it is a custom type or a complex type
              codec.subType ??= processCodec(
                  customJson, match2, customJson[match2] ?? match2);

              codec.typeString = value;
              addCodec(key, codec);
              return codec;
            // BTreeMap
            /*  case 'BTreeMap':
                final Codec codec = getCodec(match[1].toString())!;
                codec.subType = getCodec(match[2].toString());
                codec.typeString = value;
                addCodec(key, codec);
                break; */
          }
          return processCodec(customJson, value, customJson[value]);
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
          subCodecs ??=
              processCodec(customJson, element, customJson[element] ?? element);
          codec.registry.addCodec(element, subCodecs);
        }
        addCodec(key, codec);
        return codec;
      }
      //
      // Fixed array
      if (value.startsWith('[') && value.endsWith(']')) {
        _processFixedArray(key, value);
      }
      throw Exception('Type not found for $value');
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
    return processCodec(customJson, value, customJson[value]);
  }

  Codec _processStruct(
      Map<String, dynamic> customJson, String key, Map<String, String> value) {
    final Struct codec = getCodec('Struct')!.freshInstance() as Struct;
    for (final mapEntry in value.entries) {
      final key = mapEntry.key;
      final value = mapEntry.value;
      var subCodec = getCodec(value);
      subCodec ??= processCodec(customJson, value, customJson[value] ?? value);
      codec.typeStruct[key] = subCodec;
    }
    addCodec(key, codec);
    return codec;
  }

  Codec? _processFixedArray(String key, String value) {
    final slicedList = value.substring(1, value.length - 2).split(';');
    if (slicedList.length == 2) {
      final subType = getCodec(slicedList[0].trim());
      final codec =
          (subType is U8 ? getCodec('VecU8Fixed') : getCodec('FixedArray'))!;
      codec.subType = subType;
      codec.fixedLength = int.parse(slicedList[1]);
      addCodec(key, codec);
      return codec;
    }
    return null;
  }

  Codec _processEnum(
      Map<String, dynamic> customJson, String key, Map<String, dynamic> value) {
    final Codec codec = getCodec('Enum')!;
    if (value['_enum'] is Map<String, dynamic>) {
      codec.typeStruct =
          _processStruct(customJson, key, value['_enum']).typeStruct;
    } else {
      codec.valueList = value['_enum'];
    }
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
