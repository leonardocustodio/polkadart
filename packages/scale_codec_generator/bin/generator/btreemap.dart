import 'package:code_builder/code_builder.dart'
    show
        Expression,
        TypeReference,
        Method,
        Parameter,
        literalMap,
        literalConstMap,
        refer;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, CompactCodec;
import '../constants.dart' as constants;
import './base.dart' show BasePath, Generator, LazyLoader;

class BTreeMapGenerator extends Generator {
  late Generator key;
  late Generator value;

  BTreeMapGenerator({
    required this.key,
    required this.value,
  });

  BTreeMapGenerator._lazy();

  factory BTreeMapGenerator.lazy(
      {required LazyLoader loader, required int key, required int value}) {
    final generator = BTreeMapGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.key = register[key]!;
      generator.value = register[value]!;
    });
    return generator;
  }

  @override
  TypeReference primitive(BasePath from) {
    return constants.map(key.primitive(from), value.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.bTreeMapCodec(key.primitive(from), value.primitive(from));
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
      return constants.map(constants.dynamic, constants.dynamic);
    }
    visited.add(this);
    final type = Generator.cacheOrCreate(
        from,
        visited,
        () => constants.map(
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
        ..body = constants.mapEntry.newInstance([
          key.instanceToJson(from, refer('key')),
          value.instanceToJson(from, refer('value')),
        ]).code).closure
    ]);
  }
}
