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

  TypeDefBuilder._lazy(super.filePath, this.name, this.docs);

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
    return TypeReference((b) => b
      ..symbol = '${name}Codec'
      ..url = p.relative(filePath, from: from));
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([]);
  }

  @override
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
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
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    return generator.jsonType(isCircular, context);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return generator.instanceToJson(from, obj);
  }

  @override
  GeneratedOutput build() {
    final typeDef = createTypeDef();
    final typeDefCodec = createTypeDefCodec();
    return GeneratedOutput(
        classes: [typeDefCodec], enums: [], typedefs: [typeDef]);
  }

  TypeDef createTypeDef() => TypeDef((b) => b
    ..name = name
    ..definition = generator.primitive(p.dirname(filePath))
    ..docs.addAll(sanitizeDocs(docs)));

  Class createTypeDefCodec() => Class((classBuilder) {
        final className = refer(name);
        final dirname = p.dirname(filePath);

        classBuilder
          ..name = '${name}Codec'
          ..constructors.add(Constructor((b) => b..constant = true))
          ..mixins.add(refs.codec(ref: className))
          ..methods.add(Method((b) => b
            ..name = 'decode'
            ..returns = className
            ..annotations.add(refer('override'))
            ..requiredParameters.add(Parameter((b) => b
              ..type = refs.input
              ..name = 'input'))
            ..body = generator.decode(dirname).returned.statement))
          ..methods.add(Method.returnsVoid((b) => b
            ..name = 'encodeTo'
            ..annotations.add(refer('override'))
            ..requiredParameters.addAll([
              Parameter((b) => b
                ..type = className
                ..name = 'value'),
              Parameter((b) => b
                ..type = refs.output
                ..name = 'output'),
            ])
            ..body = generator.encode(dirname, refer('value')).statement))
          ..methods.add(Method((b) => b
            ..name = 'sizeHint'
            ..returns = refs.int
            ..annotations.add(refer('override'))
            ..requiredParameters.add(
              Parameter((b) => b
                ..type = className
                ..name = 'value'),
            )
            ..body = generator
                .codecInstance(dirname)
                .property('sizeHint')
                .call([refer('value')])
                .returned
                .statement));
      });
}
