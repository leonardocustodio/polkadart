part of descriptors;

class TypeDefBuilder extends TypeBuilder {
  String name;
  late TypeDescriptor generator;
  List<String> docs;

  TypeDefBuilder({
    required String filePath,
    required this.name,
    required this.generator,
    required this.docs,
  }) : super(filePath);

  TypeDefBuilder._lazy(String filePath, this.name, this.docs) : super(filePath);

  factory TypeDefBuilder.lazy({
    required int id,
    required LazyLoader loader,
    required int codec,
    required String filePath,
    required String name,
    required List<String> docs,
  }) {
    final generator = TypeDefBuilder._lazy(filePath, name, docs);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      generator.generator = register[codec]!;
    });
    return generator;
  }

  @override
  int id() => generator.id();

  @override
  TypeReference primitive(BasePath from) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = p.relative(filePath, from: from));
  }

  @override
  TypeReference codec(BasePath from) {
    return generator.codec(from);
  }

  @override
  Expression codecInstance(BasePath from) {
    return generator.codecInstance(from);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    return generator.valueFrom(from, input, constant: constant);
  }

  @override
  Expression encode(String from, Expression obj,
      [Expression output = const Reference('output')]) {
    return generator.encode(from, obj, output);
  }

  @override
  Expression decode(String from,
      [Expression input = const Reference('input')]) {
    return generator.decode(from, input);
  }

  @override
  TypeReference jsonType(BasePath from,
      [Set<TypeDescriptor> visited = const {}]) {
    if (visited.contains(this)) {
      return refs.dynamic.type as TypeReference;
    }
    visited.add(this);
    final newType = generator.jsonType(from, visited);
    visited.remove(this);
    return newType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return generator.instanceToJson(from, obj);
  }

  @override
  GeneratedOutput build() {
    final typeDef = classbuilder.createTypeDef(
        name: name, reference: generator.primitive(p.dirname(filePath)));
    return GeneratedOutput(classes: [], enums: [], typedefs: [typeDef]);
  }
}
