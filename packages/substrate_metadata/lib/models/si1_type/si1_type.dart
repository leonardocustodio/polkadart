// ignore_for_file: camel_case_types

part of models;

class Si1Type {
  final List<String> path;
  final List<Si1TypeParameter> params;
  final Si1TypeDef def;
  final List<String> docs;

  const Si1Type(
      {required this.path,
      required this.params,
      required this.def,
      required this.docs});

  /// Creates Class Object from `Json`
  static Si1Type fromJson(Map<String, dynamic> map) => Si1Type(
        path: (map['path'] as List).cast<String>(),
        params: (map['params'] as List)
            .map((value) => Si1TypeParameter.fromJson(value))
            .toList(growable: false),
        def: Si1TypeDef.fromJson(map['def']),
        docs: (map['docs'] as List).cast<String>(),
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'path': path,
        'params': params
            .map((Si1TypeParameter value) => value.toJson())
            .toList(growable: false),
        'def': Si1TypeDef.toJson(def),
        'docs': docs,
      };
}

class Si1TypeParameter {
  final String name;
  final int? type;

  const Si1TypeParameter({required this.name, this.type});

  /// Creates Class Object from `Json`
  static Si1TypeParameter fromJson(Map<String, dynamic> map) =>
      Si1TypeParameter(name: map['name'], type: map['type'].value);

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type == null ? None : Option.some(type),
      };
}

class Si1TypeDef {
  final String kind;
  const Si1TypeDef({required this.kind});

  /// Creates Class Object from `Json`
  static Si1TypeDef fromJson(MapEntry<String, dynamic> map) {
    switch (map.key) {
      case 'Composite':
        return Si1TypeDef_Composite.fromJson(map.value);
      case 'Variant':
        return Si1TypeDef_Variant.fromJson(map.value);
      case 'Sequence':
        return Si1TypeDef_Sequence.fromJson(map.value);
      case 'Array':
        return Si1TypeDef_Array.fromJson(map.value);
      case 'Tuple':
        return Si1TypeDef_Tuple.fromJson(map.value);
      case 'Primitive':
        return Si1TypeDef_Primitive.fromKey(map.value);
      case 'Compact':
        return Si1TypeDef_Compact.fromJson(map.value);
      case 'BitSequence':
        return Si1TypeDef_BitSequence.fromJson(map.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${map.key}');
    }
  }

  /// Creates `Map` from Class Object
  static MapEntry<String, dynamic> toJson(Si1TypeDef value) {
    switch (value.kind) {
      case 'Composite':
        return MapEntry(
            value.kind, (value as Si1TypeDef_Composite).value.toJson());
      case 'Variant':
        return MapEntry(
            value.kind, (value as Si1TypeDef_Variant).value.toJson());
      case 'Sequence':
        return MapEntry(
            value.kind, (value as Si1TypeDef_Sequence).value.toJson());
      case 'Array':
        return MapEntry(value.kind, (value as Si1TypeDef_Array).value.toJson());
      case 'Tuple':
        return MapEntry(value.kind, (value as Si1TypeDef_Tuple).value);
      case 'Primitive':
        return MapEntry(value.kind, (value as Si1TypeDef_Primitive).value.kind);
      case 'Compact':
        return MapEntry(
            value.kind, (value as Si1TypeDef_Compact).value.toJson());
      case 'BitSequence':
        return MapEntry(
            value.kind, (value as Si1TypeDef_BitSequence).value.toJson());
      default:
        throw UnexpectedTypeException('Unexpected type: ${value.kind}');
    }
  }
}

class Si1TypeDef_Composite extends Si1TypeDef {
  final Si1TypeDefComposite value;
  const Si1TypeDef_Composite({required this.value}) : super(kind: 'Composite');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Composite fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Composite(value: Si1TypeDefComposite.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDef_Variant extends Si1TypeDef {
  final Si1TypeDefVariant value;
  const Si1TypeDef_Variant({required this.value}) : super(kind: 'Variant');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Variant fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Variant(value: Si1TypeDefVariant.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDef_Sequence extends Si1TypeDef {
  final Si1TypeDefSequence value;
  const Si1TypeDef_Sequence({required this.value}) : super(kind: 'Sequence');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Sequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Sequence(value: Si1TypeDefSequence.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDef_Array extends Si1TypeDef {
  final Si1TypeDefArray value;
  const Si1TypeDef_Array({required this.value}) : super(kind: 'Array');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Array fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Array(value: Si1TypeDefArray.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDef_Tuple extends Si1TypeDef {
  final List<int> value;
  const Si1TypeDef_Tuple({required this.value}) : super(kind: 'Tuple');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Tuple fromJson(List list) =>
      Si1TypeDef_Tuple(value: list.cast<int>());

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value,
      };
}

class Si1TypeDef_Primitive extends Si1TypeDef {
  final Si0TypeDefPrimitive value;
  const Si1TypeDef_Primitive({required this.value}) : super(kind: 'Primitive');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Primitive fromKey(String map) =>
      Si1TypeDef_Primitive(value: Si0TypeDefPrimitive.fromKey(map));
}

class Si1TypeDef_Compact extends Si1TypeDef {
  final Si1TypeDefCompact value;
  const Si1TypeDef_Compact({required this.value}) : super(kind: 'Compact');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Compact fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Compact(value: Si1TypeDefCompact.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDef_BitSequence extends Si1TypeDef {
  final Si1TypeDefBitSequence value;
  const Si1TypeDef_BitSequence({required this.value})
      : super(kind: 'BitSequence');

  /// Creates Class Object from `Json`
  static Si1TypeDef_BitSequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_BitSequence(value: Si1TypeDefBitSequence.fromJson(map));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        kind: value.toJson(),
      };
}

class Si1TypeDefComposite {
  final List<Si1Field> fields;
  const Si1TypeDefComposite({required this.fields});

  /// Creates Class Object from `Json`
  static Si1TypeDefComposite fromJson(Map<String, dynamic> map) =>
      Si1TypeDefComposite(
        fields: (map['fields'] as List)
            .map((value) => Si1Field.fromJson(value))
            .toList(growable: false),
      );

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'fields': fields.map((value) => value.toJson()).toList(growable: false),
      };
}

class Si1TypeDefVariant {
  final List<Si1Variant> variants;
  const Si1TypeDefVariant({required this.variants});

  /// Creates Class Object from `Json`
  static Si1TypeDefVariant fromJson(Map<String, dynamic> map) =>
      Si1TypeDefVariant(
        variants: (map['variants'] as List)
            .map((value) => Si1Variant.fromJson(value))
            .toList(growable: false),
      );

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'variants':
            variants.map((value) => value.toJson()).toList(growable: false),
      };
}

class Si1TypeDefSequence {
  final int type;
  const Si1TypeDefSequence({required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefSequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDefSequence(type: map['type']);

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}

class Si1TypeDefArray {
  final int len;
  final int type;
  const Si1TypeDefArray({required this.len, required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefArray fromJson(Map<String, dynamic> map) =>
      Si1TypeDefArray(len: map['len'], type: map['type']);

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'len': len,
        'type': type,
      };
}

class Si1TypeDefCompact {
  final int type;
  const Si1TypeDefCompact({required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefCompact fromJson(Map<String, dynamic> map) =>
      Si1TypeDefCompact(type: map['type']);

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'type': type,
      };
}

class Si1TypeDefBitSequence {
  final int bitStoreType;
  final int bitOrderType;
  const Si1TypeDefBitSequence(
      {required this.bitOrderType, required this.bitStoreType});

  /// Creates Class Object from `Json`
  static Si1TypeDefBitSequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDefBitSequence(
        bitStoreType: map['bitStoreType'],
        bitOrderType: map['bitOrderType'],
      );

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'bitStoreType': bitStoreType,
        'bitOrderType': bitOrderType,
      };
}

class Si1Field {
  final String? typeName;
  final String? name;
  final int type;
  final List<String> docs;
  Si1Field(
      {required this.name,
      required this.type,
      this.typeName,
      required this.docs});

  /// Creates Class Object from `Json`
  static Si1Field fromJson(Map<String, dynamic> map) => Si1Field(
        name: map['name'].value,
        type: map['type'],
        typeName: map['typeName'].value,
        docs: (map['docs'] as List).cast<String>(),
      );

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'name': name == null ? None : Option.some(name),
        'type': type,
        'typeName': typeName == null ? None : Option.some(typeName),
        'docs': docs,
      };
}

class Si1Variant {
  final String name;
  final List<Si1Field> fields;
  final int index;
  final List<String> docs;
  const Si1Variant(
      {required this.name,
      required this.fields,
      required this.index,
      required this.docs});

  /// Creates Class Object from `Json`
  static Si1Variant fromJson(Map<String, dynamic> map) => Si1Variant(
      name: map['name'],
      fields: (map['fields'] as List)
          .map((value) => Si1Field.fromJson(value))
          .toList(growable: false),
      index: map['index'],
      docs: (map['docs'] as List).cast<String>());

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'fields': fields.map((e) => e.toJson()).toList(growable: false),
        'index': index,
        'docs': docs,
      };
}
