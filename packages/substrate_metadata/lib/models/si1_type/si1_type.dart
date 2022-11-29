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
            .toList(),
        def: Si1TypeDef.fromJson(map['def']),
        docs: (map['docs'] as List).cast<String>(),
      );
}

class Si1TypeParameter {
  final String name;
  final int? type;

  const Si1TypeParameter({required this.name, this.type});

  /// Creates Class Object from `Json`
  static Si1TypeParameter fromJson(Map<String, dynamic> map) =>
      Si1TypeParameter(name: map['name'], type: map['type'].value);
}

class Si1TypeDef {
  final String kind;
  const Si1TypeDef({required this.kind});

  /// Creates Class Object from `Json`
  static Si1TypeDef fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Composite':
        return Si1TypeDef_Composite.fromJson(map['Composite']);
      case 'Variant':
        return Si1TypeDef_Variant.fromJson(map['Variant']);
      case 'Sequence':
        return Si1TypeDef_Sequence.fromJson(map['Sequence']);
      case 'Array':
        return Si1TypeDef_Array.fromJson(map['Array']);
      case 'Tuple':
        return Si1TypeDef_Tuple.fromJson(map['Tuple']);
      case 'Primitive':
        return Si1TypeDef_Primitive.fromKey(map['Primitive']);
      case 'Compact':
        return Si1TypeDef_Compact.fromJson(map['Compact']);
      case 'BitSequence':
        return Si1TypeDef_BitSequence.fromJson(map['BitSequence']);
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class Si1TypeDef_Composite extends Si1TypeDef {
  final Si1TypeDefComposite value;
  const Si1TypeDef_Composite({required this.value}) : super(kind: 'Composite');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Composite fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Composite(value: Si1TypeDefComposite.fromJson(map));
}

class Si1TypeDef_Variant extends Si1TypeDef {
  final Si1TypeDefVariant value;
  const Si1TypeDef_Variant({required this.value}) : super(kind: 'Variant');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Variant fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Variant(value: Si1TypeDefVariant.fromJson(map));
}

class Si1TypeDef_Sequence extends Si1TypeDef {
  final Si1TypeDefSequence value;
  const Si1TypeDef_Sequence({required this.value}) : super(kind: 'Sequence');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Sequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Sequence(value: Si1TypeDefSequence.fromJson(map));
}

class Si1TypeDef_Array extends Si1TypeDef {
  final Si1TypeDefArray value;
  const Si1TypeDef_Array({required this.value}) : super(kind: 'Array');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Array fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_Array(value: Si1TypeDefArray.fromJson(map));
}

class Si1TypeDef_Tuple extends Si1TypeDef {
  final List<int> value;
  const Si1TypeDef_Tuple({required this.value}) : super(kind: 'Tuple');

  /// Creates Class Object from `Json`
  static Si1TypeDef_Tuple fromJson(List list) =>
      Si1TypeDef_Tuple(value: list.cast<int>());
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
}

class Si1TypeDef_BitSequence extends Si1TypeDef {
  final Si1TypeDefBitSequence value;
  const Si1TypeDef_BitSequence({required this.value})
      : super(kind: 'BitSequence');

  /// Creates Class Object from `Json`
  static Si1TypeDef_BitSequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDef_BitSequence(value: Si1TypeDefBitSequence.fromJson(map));
}

class Si1TypeDefComposite {
  final List<Si1Field> fields;
  const Si1TypeDefComposite({required this.fields});

  /// Creates Class Object from `Json`
  static Si1TypeDefComposite fromJson(Map<String, dynamic> map) =>
      Si1TypeDefComposite(
        fields: (map['fields'] as List)
            .map((value) => Si1Field.fromJson(value))
            .toList(),
      );
}

class Si1TypeDefVariant {
  final List<Si1Variant> variants;
  const Si1TypeDefVariant({required this.variants});

  /// Creates Class Object from `Json`
  static Si1TypeDefVariant fromJson(Map<String, dynamic> map) =>
      Si1TypeDefVariant(
        variants: (map['variants'] as List)
            .map((value) => Si1Variant.fromJson(value))
            .toList(),
      );
}

class Si1TypeDefSequence {
  final int type;
  const Si1TypeDefSequence({required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefSequence fromJson(Map<String, dynamic> map) =>
      Si1TypeDefSequence(type: map['type']);
}

class Si1TypeDefArray {
  final int len;
  final int type;
  const Si1TypeDefArray({required this.len, required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefArray fromJson(Map<String, dynamic> map) =>
      Si1TypeDefArray(len: map['len'], type: map['type']);
}

class Si1TypeDefCompact {
  final int type;
  const Si1TypeDefCompact({required this.type});

  /// Creates Class Object from `Json`
  static Si1TypeDefCompact fromJson(Map<String, dynamic> map) =>
      Si1TypeDefCompact(type: map['type']);
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
}

class Si1Field extends scale_codec.Field {
  final String? typeName;
  Si1Field(
      {super.name, required super.type, this.typeName, required super.docs});

  /// Creates Class Object from `Json`
  static Si1Field fromJson(Map<String, dynamic> map) => Si1Field(
        name: map['name'].value,
        type: map['type'],
        typeName: map['typeName'].value,
        docs: (map['docs'] as List).cast<String>(),
      );
}

class Si1Variant extends scale_codec.Variant {
  Si1Variant(
      {required super.name,
      required super.fields,
      required super.index,
      required super.docs});

  /// Creates Class Object from `Json`
  static Si1Variant fromJson(Map<String, dynamic> map) => Si1Variant(
      name: map['name'],
      fields: (map['fields'] as List)
          .map((value) => Si1Field.fromJson(value))
          .toList(),
      index: map['index'],
      docs: (map['docs'] as List).cast<String>());
}
