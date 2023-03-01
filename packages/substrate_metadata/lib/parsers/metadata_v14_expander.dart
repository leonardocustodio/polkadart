part of parsers;

class MetadataV14Expander {
  final registeredSiType = <int, String>{};

  final registeredTypeNames = <String>[];

  final customCodecRegister = <String, dynamic>{};

  MetadataV14Expander(List<dynamic> types) {
    final id2Portable =
        types.map((e) => (e as Map<String, dynamic>).toJson()).toList();

    for (var item in id2Portable) {
      if (item['type']?['def']?['Primitive'] != null) {
        registeredSiType[item['id']] = item['type']['def']['Primitive'];
      }
    }
    for (var item in id2Portable) {
      final id = item['id'];
      final one = item['type'];
      if (item['type']?['def']?['Variant'] != null) {
        if (one['path'].length >= 2) {
          if (['Call', 'Event', 'Instruction'].contains(one['path'].last)) {
            registeredSiType[id] = 'Call';
            continue;
          }
          /* if (one['path'].last == 'Call' &&
              one['path'][one['path'].length - 2] == 'pallet') {
            registeredSiType[id] = 'Call';
            continue;
          } */
          /* if (one['path'].last == 'Instruction') {
            registeredSiType[id] = 'Call';
            continue;
          } */
        }
      }
    }
    for (var item in id2Portable) {
      if (item['type']['path'].length > 1 &&
          item['type']['path'][0] == 'primitive_types') {
        _fetchTypeName(item['id'], item, id2Portable);
      }
    }
    for (var item in id2Portable) {
      if (item['type']['path'].length > 1 &&
          item['type']['path'][0] == 'sp_core') {
        _fetchTypeName(item['id'], item, id2Portable);
      }
    }
    for (var item in id2Portable) {
      _fetchTypeName(item['id'], item, id2Portable);
    }
  }

  String _fetchTypeName(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (registeredSiType[id] != null) {
      return registeredSiType[id]!;
    }
    one = one['type'];
    if (one['def']?['Composite'] != null) {
      return _exploreComposite(id, one, id2Portable);
    }
    if (one['def']?['Array'] != null) {
      return _exploreArray(id, one, id2Portable);
    }
    if (one['def']?['Sequence'] != null) {
      return _exploreSequence(id, one, id2Portable);
    }
    if (one['def']?['Tuple'] != null) {
      return _exploreTuple(id, one, id2Portable);
    }
    if (one['def']?['Compact'] != null) {
      return _exploreCompact(id, one, id2Portable);
    }
    if (one['def']?['BitSequence'] != null) {
      registeredSiType[id] = 'BitVec<U8, Lsb>';
      return registeredSiType[id]!;
    }
    if (one['def']?['Variant'] != null) {
      final String variantType = one['path'][0];
      switch (variantType) {
        case 'Option':
          return _exploreOption(id, one, id2Portable);
        case 'Result':
          return _exploreResult(id, one, id2Portable);
      }
      /* if (one['path'].length >= 2) {
        if (['Call', 'Event'].contains(one['path'].last)) {
          registeredSiType[id] = 'Call';
          return registeredSiType[id]!;
        }
        if (one['path'].last == 'Call' &&
            one['path'][one['path'].length - 2] == 'pallet') {
          registeredSiType[id] = 'Call';
          return registeredSiType[id]!;
        }
        if (one['path'].last == 'Instruction') {
          registeredSiType[id] = 'Call';
          return registeredSiType[id]!;
        }
      } */
      return _exploreEnum(id, one, id2Portable);
    }
    registeredSiType[id] = 'Null';
    return 'Null';
  }

  String _genPathName(
    List<dynamic> path,
    int siTypeId,
    Map<String, dynamic> one,
    List<dynamic> id2Portable,
  ) {
    if (registeredSiType[siTypeId] != null) {
      return registeredSiType[siTypeId]!;
    }
    path = path.cast<String>();

    if (one.isNotEmpty && one['type']['def']?['Variant'] != null) {
      switch (one['type']['path'][0]) {
        case 'Option':
          return _exploreOption(siTypeId, one['type'], id2Portable);
        case 'Result':
          return _exploreResult(siTypeId, one['type'], id2Portable);
        default:
      }
    }

    String genName = path.join(':');
    if (registeredTypeNames.contains(genName)) {
      genName = '$genName@$siTypeId';
    }
    if (genName == '' && one.isNotEmpty) {
      // can't return empty path names
      if (one['type']['def']?['Sequence'] != null) {
        final sequenceSubTypeId = one['type']['def']?['Sequence']['type'];

        String? subType = _genPathName(
            id2Portable[sequenceSubTypeId]['type']['path'],
            sequenceSubTypeId,
            id2Portable[sequenceSubTypeId],
            id2Portable);

        if (subType == '') {
          subType = registeredSiType[sequenceSubTypeId] ??
              _fetchTypeName(sequenceSubTypeId, id2Portable[sequenceSubTypeId],
                  id2Portable);
        }
        registeredSiType[siTypeId] = 'Vec<$subType>';
        return 'Vec<$subType>';
      } else if (one['type']['def']?['Compact'] != null) {
        return _exploreCompact(siTypeId, one['type'], id2Portable);
      } else if (one['type']['def']?['Array'] != null) {
        return _exploreArray(siTypeId, one['type'], id2Portable);
      }
    }
    return genName;
  }

  String _exploreComposite(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (one['def']['Composite']['fields'].length == 0) {
      registeredSiType[id] = 'Null';
      return 'Null';
    }
    if (one['def']['Composite']['fields'].length == 1) {
      final int siType = one['def']['Composite']['fields'][0]['type'];
      final String subType = registeredSiType[siType] ??
          _fetchTypeName(siType, id2Portable[siType], id2Portable);
      final String typeString = _genPathName(one['path'], id, {}, []);
      registeredTypeNames.add(typeString);
      customCodecRegister[typeString] = subType;
      registeredSiType[id] = typeString;
      return subType;
    }
    final Map<String, String> tempStruct = <String, String>{};
    for (var field in one['def']['Composite']['fields']) {
      final subTypeName = registeredSiType[field['type']] ??
          _fetchTypeName(
              field['type'], id2Portable[field['type']], id2Portable);

      tempStruct[field['name'] ??
          field['typeName']?.toLowerCase() ??
          subTypeName.toLowerCase()] = subTypeName;
    }
    final String typeString = _genPathName(one['path'], id, {}, []);
    registeredTypeNames.add(typeString);
    customCodecRegister[typeString] = tempStruct;
    registeredSiType[id] = typeString;
    return typeString;
  }

  String _exploreArray(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Array']['type'];

    registeredSiType[id] =
        '[${registeredSiType[siType] ?? _fetchTypeName(siType, id2Portable[siType], id2Portable)}; ${one['def']['Array']['len']}]';

    customCodecRegister[registeredSiType[id]!] = registeredSiType[id];
    return registeredSiType[id]!;
  }

  String _exploreSequence(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Sequence']['type'];

    registeredSiType[id] =
        'Vec<${registeredSiType[siType] ?? _fetchTypeName(siType, id2Portable[siType], id2Portable)}>';
    customCodecRegister[registeredSiType[id]!] = registeredSiType[id];
    return registeredSiType[id]!;
  }

  String _exploreTuple(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (one['def']['Tuple'].length == 0) {
      registeredSiType[id] = 'Null';
      return 'Null';
    }
    final int tuple1 = one['def']['Tuple'][0];
    final int tuple2 = one['def']['Tuple'][1];
    final String tuple1Type = registeredSiType[tuple1] ??
        _fetchTypeName(tuple1, id2Portable[tuple1], id2Portable);
    final String tuple2Type = registeredSiType[tuple2] ??
        _fetchTypeName(tuple2, id2Portable[tuple2], id2Portable);
    // combine (a,b) Tuple
    registeredSiType[id] = '($tuple1Type, $tuple2Type)';
    return registeredSiType[id]!;
  }

  String _exploreCompact(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Compact']['type'];

    registeredSiType[id] =
        'Compact<${registeredSiType[siType] ?? _fetchTypeName(siType, id2Portable[siType], id2Portable)}>';

    customCodecRegister[registeredSiType[id]!] = registeredSiType[id];
    return registeredSiType[id]!;
  }

  String _exploreOption(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['params'][0]['type'];

    registeredSiType[id] =
        'Option<${registeredSiType[siType] ?? _fetchTypeName(siType, id2Portable[siType], id2Portable)}>';

    customCodecRegister[registeredSiType[id]!] = registeredSiType[id];
    return registeredSiType[id]!;
  }

  String _exploreResult(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int resultOk = one['params'][0]['type'];

    final int resultErr = one['params'][1]['type'];

    final String okType = registeredSiType[resultOk] ??
        _fetchTypeName(resultOk, id2Portable[resultOk], id2Portable);

    final String errType = registeredSiType[resultErr] ??
        _fetchTypeName(resultErr, id2Portable[resultErr], id2Portable);

    registeredSiType[id] = 'Result<$okType,$errType>';
    customCodecRegister[registeredSiType[id]!] = registeredSiType[id];
    return registeredSiType[id]!;
  }

  String _exploreEnum(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (registeredSiType[id] != null) {
      return registeredSiType[id]!;
    }

    final List<dynamic> variants = one['def']['Variant']['variants'];

    variants.sort((a, b) => a['index'] < b['index'] ? -1 : 1);

    final maxIndex = variants[variants.length - 1]['index'];

    final List<MapEntry<String, dynamic>?> variantNameMap =
        List<MapEntry<String, dynamic>?>.filled(maxIndex + 1, null);

    for (final Map<String, dynamic> variant in variants) {
      final int index = variant['index'];
      final String name = variant['name'];
      variantNameMap[index] = MapEntry(name, 'Null');

      switch (variant['fields'].length) {
        case 0:
          break;
        case 1:
          final int siType = variant['fields'][0]['type'];
          variantNameMap[index] = MapEntry(
              name,
              registeredSiType[siType] ??
                  _genPathName(id2Portable[siType]['type']['path'], siType,
                      id2Portable[siType], id2Portable));
          break;
        default:
          // field count> 1, enum one element is struct
          // If there is no name the fields are a tuple
          if (variant['fields'][0]['name'] == null) {
            String typeMapping = '';
            for (Map<String, dynamic> field in variant['fields']) {
              final int siType = field['type'];

              if (typeMapping != '') {
                typeMapping += ', ';
              }
              typeMapping += registeredSiType[siType] ??
                  _genPathName(id2Portable[siType]['type']['path'], siType,
                      id2Portable[siType], id2Portable);
            }
            variantNameMap[index] = MapEntry(name, '($typeMapping)');
            break;
          }

          final Map<String, String> typeMapping = {};
          for (Map<String, dynamic> field in variant['fields']) {
            final String valueName = field['name'];
            final int siType = field['type'];
            final subType = registeredSiType[siType] ??
                _genPathName(id2Portable[siType]['type']['path'], siType,
                    id2Portable[siType], id2Portable);
            typeMapping[valueName] = subType;
          }
          variantNameMap[index] = MapEntry(name, typeMapping);
          break;
      }
    }

    late dynamic result;

    if (variantNameMap.any(
        (MapEntry<String, dynamic>? e) => e != null && e.value != 'Null')) {
      // enum one element is composite or parameterized
      // Here some of the indexs can be null which denotes that the index is not used and
      // hence should throw error from the Enum Codec
      result = variantNameMap;
    } else {
      // enum all values are 'Null' and hence it is not a parameterized enum
      result =
          variantNameMap.map((MapEntry<String, dynamic>? e) => e?.key).toList();
    }

    final String typeString = _genPathName(one['path'], id, {}, []);

    registeredTypeNames.add(typeString);
    customCodecRegister[typeString] = {'_enum': result};

    registeredSiType[id] = typeString;
    return typeString;
  }
}
