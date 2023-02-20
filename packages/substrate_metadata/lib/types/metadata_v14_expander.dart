part of metadata_types;

class MetadataV14Expander {
  final registeredSiType = <int, String>{};

  final registeredTypeNames = <String>[];

  final customCodecRegister = <String, dynamic>{};

  MetadataV14Expander(List<dynamic> id2Portable) {
    for (var item in id2Portable) {
      if (item['type']['def']?['Primitive'] != null) {
        registeredSiType[item['id']] = item['type']['def']['Primitive'];
      }
    }
    for (var item in id2Portable) {
      if (item['type']['path'].length > 1 &&
          item['type']['path'][0] == 'primitive_types') {
        registeredSiType[item['id']] =
            item['type']['path'][item['type']['path'].length - 1];
      }
    }
    for (var item in id2Portable) {
      if (item['type']['path'].length > 1 &&
          item['type']['path'][0] == 'sp_core') {
        _dealOnePortableType(item['id'], item, id2Portable);
      }
    }
    for (var item in id2Portable) {
      _dealOnePortableType(item['id'], item, id2Portable);
    }
  }

  String _dealOnePortableType(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (registeredSiType[id] != null) {
      return registeredSiType[id]!;
    }
    one = one['type'];
    if (one['def']?['Composite'] != null) {
      return _expandComposite(id, one, id2Portable);
    }
    if (one['def']?['Array'] != null) {
      return _expandArray(id, one, id2Portable);
    }
    if (one['def']?['Sequence'] != null) {
      return _expandSequence(id, one, id2Portable);
    }
    if (one['def']?['Tuple'] != null) {
      return _expandTuple(id, one, id2Portable);
    }
    if (one['def']?['Compact'] != null) {
      return _expandCompact(id, one, id2Portable);
    }
    if (one['def']?['BitSequence'] != null) {
      registeredSiType[id] = 'BitVec';
      return registeredSiType[id]!;
    }
    if (one['def']?['Variant'] != null) {
      final String variantType = one['path'][0];
      switch (variantType) {
        case 'Option':
          return _expandOption(id, one, id2Portable);
        case 'Result':
          return _expandResult(id, one, id2Portable);
      }
      if (one['path'].length >= 2) {
        switch (one['path'][one['path'].length - 1]) {
          case 'Instruction':
            registeredSiType[id] = 'Call';
            return 'Call';
          case 'Call':
            {
              if (one['path'][one['path'].length - 1] == 'Event' ||
                  one['path'][one['path'].length - 2] == 'pallet') {
                registeredSiType[id] = 'Call';
                return 'Call';
              }
            }
            break;
        }
      }
      return _expandEnum(id, one, id2Portable);
    }
    registeredSiType[id] = 'Null';
    return 'Null';
  }

  String _genPathName(List<dynamic> path, int siTypeId,
      Map<String, dynamic> one, List<dynamic> id2Portable) {
    path = path.cast<String>();

    if (one.isNotEmpty &&
        one['type']['def']?['Variant'] != null &&
        one['type']['path'][0] == 'Option') {
      return _expandOption(siTypeId, one['type'], id2Portable);
    }
    String genName = path.join(':');
    if (registeredTypeNames.contains(genName)) {
      genName = '$genName@$siTypeId';
    }
    return genName;
  }

  String _expandComposite(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (one['def']['Composite']['fields'].length == 0) {
      registeredSiType[id] = 'Null';
      return 'Null';
    }
    if (one['def']['Composite']['fields'].length == 1) {
      final int siType = one['def']['Composite']['fields'][0]['type'];
      final String subType = registeredSiType[siType] ??
          _dealOnePortableType(siType, id2Portable[siType], id2Portable);
      final String typeString = _genPathName(one['path'], id, {}, []);
      registeredTypeNames.add(typeString);
      customCodecRegister[typeString] = subType;
      registeredSiType[id] = typeString;
      return subType;
    }
    final Map<String, String> tempStruct = <String, String>{};
    for (var field in one['def']['Composite']['fields']) {
      tempStruct[field['name'] ?? field['typeName'].toLowerCase()] =
          registeredSiType[field['type']] ??
              _dealOnePortableType(
                  field['type'], id2Portable[field['type']], id2Portable);
    }
    final String typeString = _genPathName(one['path'], id, {}, []);
    registeredTypeNames.add(typeString);
    customCodecRegister[typeString] = tempStruct;
    registeredSiType[id] = typeString;
    return typeString;
  }

  String _expandArray(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Array']['type'];

    registeredSiType[id] =
        '[${registeredSiType[siType] ?? _dealOnePortableType(siType, id2Portable[siType], id2Portable)}; ${one['def']['Array']['len']}]';

    return registeredSiType[id]!;
  }

  String _expandSequence(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Sequence']['type'];

    registeredSiType[id] =
        'Vec<${registeredSiType[siType] ?? _dealOnePortableType(siType, id2Portable[siType], id2Portable)}>';

    return registeredSiType[id]!;
  }

  String _expandTuple(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    if (one['def']['Tuple'].length == 0) {
      registeredSiType[id] = 'Null';
      return 'Null';
    }
    final int tuple1 = one['def']['Tuple'][0];
    final int tuple2 = one['def']['Tuple'][1];
    final String tuple1Type = registeredSiType[tuple1] ??
        _dealOnePortableType(tuple1, id2Portable[tuple1], id2Portable);
    final String tuple2Type = registeredSiType[tuple2] ??
        _dealOnePortableType(tuple2, id2Portable[tuple2], id2Portable);
    // combine (a,b) Tuple
    registeredSiType[id] = '($tuple1Type, $tuple2Type)';
    return registeredSiType[id]!;
  }

  String _expandCompact(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['def']['Compact']['type'];

    registeredSiType[id] =
        'Compact<${registeredSiType[siType] ?? _dealOnePortableType(siType, id2Portable[siType], id2Portable)}>';

    return registeredSiType[id]!;
  }

  String _expandOption(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int siType = one['params'][0]['type'];

    registeredSiType[id] =
        'Option<${registeredSiType[siType] ?? _dealOnePortableType(siType, id2Portable[siType], id2Portable)}>';

    return registeredSiType[id]!;
  }

  String _expandResult(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final int resultOk = one['params'][0]['type'];

    final int resultErr = one['params'][1]['type'];

    final String okType = registeredSiType[resultOk] ??
        _dealOnePortableType(resultOk, id2Portable[resultOk], id2Portable);

    final String errType = registeredSiType[resultErr] ??
        _dealOnePortableType(resultErr, id2Portable[resultErr], id2Portable);

    registeredSiType[id] = 'Result<$okType,$errType>';
    return registeredSiType[id]!;
  }

  String _expandEnum(
      int id, Map<String, dynamic> one, List<dynamic> id2Portable) {
    final List<String> enumValueList = [];

    final List<dynamic> variants = one['def']['Variant']['variants'];
    variants.sort((a, b) => a['index'] < b['index'] ? -1 : 1);

    for (int index = 0; index < variants.length; index++) {
      final Map<String, dynamic> variant = variants[index];
      final String name = variant['name'];
      final int enumIndex = variant['index'];

      // fill empty element
      int interval = enumIndex;
      if (index > 0) {
        interval = enumIndex - (variants[index - 1]['index'] as int) - 1;
      }
      while (interval > 0) {
        enumValueList.add('empty$interval');
        interval--;
      }

      switch (variant['fields'].length) {
        case 0:
          enumValueList.add(name);
          break;
        case 1:
          final int siType = variant['fields'][0]['type'];
          enumValueList.add(registeredSiType[siType] ??
              _genPathName(
                  id2Portable[siType]['type']['path'], siType, {}, []));
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
                  _genPathName(
                      id2Portable[siType]['type']['path'], siType, {}, []);
            }
            enumValueList.add('($typeMapping)');
            break;
          }

          final Map<String, String> typeMapping = {};
          for (Map<String, dynamic> field in variant['fields']) {
            final String valueName = field['name'];
            final int siType = field['type'];
            typeMapping[valueName] = registeredSiType[siType] ??
                _genPathName(id2Portable[siType]['type']['path'], siType,
                    id2Portable[siType], id2Portable);
          }
          enumValueList.add(jsonEncode(typeMapping));
          break;
      }
    }

    final String typeString = _genPathName(one['path'], id, {}, []);

    registeredTypeNames.add(typeString);
    customCodecRegister[typeString] = {'_enum': enumValueList};

    /*  generator.registerCustomCodec(typeString, EnumType(enumValueList)); */

    registeredSiType[id] = typeString;
    return typeString;
  }
}
