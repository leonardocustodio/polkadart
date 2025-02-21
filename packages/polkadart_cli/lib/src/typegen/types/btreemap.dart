part of descriptors;

class BTreeMapDescriptor extends TypeDescriptor {
  final int _id;
  late TypeDescriptor key;
  late TypeDescriptor value;

  BTreeMapDescriptor({
    required int id,
    required this.key,
    required this.value,
  }) : _id = id;

  BTreeMapDescriptor._lazy(int id) : _id = id;

  factory BTreeMapDescriptor.lazy(
      {required int id, required LazyLoader loader, required int key, required int value}) {
    final generator = BTreeMapDescriptor._lazy(id);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      generator.key = register[key]!;
      generator.value = register[value]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    return refs.map(key.primitive(from), value.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    return refs.bTreeMapCodec(key.primitive(from), value.primitive(from));
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([], {
      'keyCodec': key.codecInstance(from),
      'valueCodec': value.codecInstance(from),
    });
  }

  @override
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
    final size = CompactCodec.codec.decode(input);
    final Map<LiteralValue, LiteralValue> map = {
      for (var i = 0; i < size; i++)
        key.valueFrom(from, input, constant: constant):
            value.valueFrom(from, input, constant: constant)
    };
    if (constant &&
        map.values.every((value) => value.isConstant) &&
        map.keys.every((key) => key.isConstant)) {
      return literalConstMap(map, key.primitive(from), value.primitive(from))
          .asLiteralValue(isConstant: true);
    }
    return literalMap(map, key.primitive(from), value.primitive(from)).asLiteralValue();
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (isCircular) {
      return refs.map(refs.dynamic, refs.dynamic);
    }

    return refs.map(context.jsonTypeFrom(key), context.jsonTypeFrom(value));
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('map').call([
      Method.returnsVoid((b) => b
        ..requiredParameters.addAll([
          Parameter((b) => b..name = 'key'),
          Parameter((b) => b..name = 'value'),
        ])
        ..lambda = true
        ..body = refs.mapEntry.newInstance([
          key.instanceToJson(from, refer('key')),
          value.instanceToJson(from, refer('value')),
        ]).code).closure
    ]);
  }
}
