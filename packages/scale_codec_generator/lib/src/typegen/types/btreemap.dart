part of generators;

class BTreeMapGenerator extends Generator {
  final int _id;
  late Generator key;
  late Generator value;

  BTreeMapGenerator({
    required int id,
    required this.key,
    required this.value,
  }) : _id = id;

  BTreeMapGenerator._lazy(int id) : _id = id;

  factory BTreeMapGenerator.lazy(
      {required int id,
      required LazyLoader loader,
      required int key,
      required int value}) {
    final generator = BTreeMapGenerator._lazy(id);
    loader.addLoader((Map<int, Generator> register) {
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
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final size = CompactCodec.codec.decode(input);
    final Map<Expression, Expression> map = {
      for (var i = 0; i < size; i++)
        key.valueFrom(from, input, constant: constant):
            value.valueFrom(from, input, constant: constant)
    };
    if (map.values.every((value) => value.isConst) &&
        map.keys.every((key) => key.isConst)) {
      return literalConstMap(map, key.primitive(from), value.primitive(from));
    }
    return literalMap(map, key.primitive(from), value.primitive(from));
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    if (visited.contains(this)) {
      return refs.map(refs.dynamic, refs.dynamic);
    }
    visited.add(this);
    final type = Generator.cacheOrCreate(
        from,
        visited,
        () => refs.map(
            key.jsonType(from, visited), value.jsonType(from, visited)));
    visited.remove(this);
    return type;
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
