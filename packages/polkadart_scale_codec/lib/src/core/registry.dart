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
  void addCustomCodec(Map<String, dynamic> customJson) {
    for (final mapEntry in customJson.entries) {
      final key = mapEntry.key;
      var value = mapEntry.value;

      if (value is String) {
        final Codec? codec = getCodec(value);
        if (codec != null) {
          addCodec(key, codec);
          continue;
        }
        bool iterationSolve = false;
        while (true) {
          if (customJson[value] != null) {
            value = customJson[value];
            if (value is String) {
              final Codec? codec = getCodec(value);
              if (codec != null) {
                addCodec(key, codec);
                iterationSolve = true;
                break;
              } else {
                continue;
              }
            }
            addCustomCodec({key: value});
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
                final codec = getCodec(match[1].toString())!.freshInstance();
                codec.subType = getCodec(match[2].toString());
                codec.typeString = value;
                addCodec(key, codec as Vec);
                break;
              // option
              case 'Option':
                final codec = getCodec(match[1].toString())!.freshInstance();
                codec.subType = getCodec(match[2].toString());
                codec.typeString = value;
                addCodec(key, codec as Option);
                break;
              // compact
              case 'Compact':
                final Codec codec =
                    getCodec(match[1].toString())!.freshInstance();
                codec.subType = getCodec(match[2].toString());
                codec.typeString = value;
                addCodec(key, codec as Compact);
                break;
              // BTreeMap
              /*  case 'BTreeMap':
                final Codec codec = getCodec(match[1].toString())!;
                codec.subType = getCodec(match[2].toString());
                codec.typeString = value;
                addCodec(key, codec);
                break; */
            }
            continue;
          }
        }

        //
        // Tuple
        if (value.startsWith('(') && value.endsWith(')')) {
          final Codec codec = getCodec('Tuples')!.freshInstance() as Tuples;
          codec.typeString = value;
          codec.buildMapping();
          addCodec(key, codec);
          continue;
        }
        //
        // Fixed array
        if (value.startsWith('[') && value.endsWith(']')) {
          _initFixedArray(key, value);
        }
      } else if (value is Map) {
        //
        // enum
        if (value['_enum'] != null) {
          _initEnum(key, value as Map<String, dynamic>);
          continue;
        }
        //
        // set
        if (value['_set'] != null) {
          _initSet(key, value as Map<String, dynamic>);
          continue;
        }
        //
        // struct
        final Codec codec = getCodec('Struct')!;
        codec.typeStruct = value as List;
        addCodec(key, codec);
      }
    }
  }

  void _initFixedArray(String key, String value) {
    final slicedList = value.substring(1, value.length - 2).split(';');
    if (slicedList.length == 2) {
      final subType = getCodec(slicedList[0].trim());
      final codec =
          subType is U8 ? getCodec('VecU8Fixed')! : getCodec('FixedArray')!;
      codec.subType = subType;
      codec.fixedLength = int.parse(slicedList[1]);
      addCodec(key, codec);
    }
  }

  void _initEnum(String key, Map<String, dynamic> value) {
    final Codec codec = getCodec('Enum')!;
    if (value['_enum'] is Map<String, dynamic>) {
      codec.typeStruct = value['_enum'];
    } else {
      codec.valueList = value['_enum'];
    }
    addCodec(key, codec);
  }

  void _initSet(String key, Map<String, dynamic> value) {
    final Codec codec = getCodec('Set')!;
    if (value['_bitLength'] != null) {
      codec.bitLength = int.parse(value['_bitLength']);
    } else {
      codec.bitLength = 16;
    }
    (value['_set'] as Map).remove('_bitLength');
    codec.valueList = (value['_set'] as Map).keys.toList();
    addCodec(key, codec);
  }
}
