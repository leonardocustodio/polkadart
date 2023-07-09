part of descriptors;

class TupleBuilder extends TypeBuilder {
  final int _id;
  List<TypeDescriptor> generators;

  TupleBuilder(
      {required int id, required String filePath, required this.generators})
      : _id = id,
        super(filePath);

  TupleBuilder._lazy({required int id, required String filePath})
      : generators = [],
        _id = id,
        super(filePath);

  factory TupleBuilder.lazy(
      {required int id,
      required LazyLoader loader,
      required String filePath,
      required List<int> codecs}) {
    final generator = TupleBuilder._lazy(id: id, filePath: filePath);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      for (final codec in codecs) {
        generator.generators.add(register[codec]!);
      }
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference codec(BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}Codec'
      ..url = p.relative(filePath, from: from)
      ..types.addAll(generators.map((e) => e.primitive(from))));
  }

  @override
  TypeReference primitive(BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}'
      ..url = p.relative(filePath, from: from)
      ..types.addAll(generators.map((e) => e.primitive(from))));
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from)
        .constInstance(generators.map((type) => type.codecInstance(from)));
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final values = <Expression>[
      for (final generator in generators)
        generator.valueFrom(from, input, constant: constant)
    ];

    if (values.every((value) => value.isConst)) {
      return primitive(from).constInstance(values);
    }
    return primitive(from).newInstance(values);
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (generators.isEmpty) {
      return refs.dynamic.type as TypeReference;
    }

    if (isCircular) {
      return refs.list(ref: refs.dynamic);
    }
    // Check if all fields are of the same type, otherwise use dynamic
    final type = findCommonType(
        generators.map((generator) => context.jsonTypeFrom(generator)));
    return refs.list(ref: type);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return literalList([
      for (int i = 0; i < generators.length; i++)
        generators[i].instanceToJson(from, obj.property('value$i'))
    ]);
  }

  @override
  GeneratedOutput build() {
    final tupleClass = classbuilder.createTupleClass(generators.length);
    final tupleCodec = classbuilder.createTupleCodec(generators.length);
    return GeneratedOutput(
        classes: [tupleClass, tupleCodec], enums: [], typedefs: []);
  }
}
