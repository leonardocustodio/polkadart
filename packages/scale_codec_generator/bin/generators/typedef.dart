import 'package:code_builder/code_builder.dart'
    show Expression, Reference, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import './base.dart' show Generator, GeneratedOutput, LazyLoader;
import '../class_builder.dart' show createTypeDef;

class TypeDefGenerator extends Generator {
  String filePath;
  String name;
  late Generator generator;

  TypeDefGenerator(
      {required this.filePath, required this.name, required this.generator});

  TypeDefGenerator._lazy(this.filePath, this.name);

  factory TypeDefGenerator.lazy(
      {required LazyLoader loader,
      required int codec,
      required String filePath,
      required String name}) {
    final generator = TypeDefGenerator._lazy(filePath, name);
    loader.addLoader((Map<int, Generator> register) {
      generator.generator = register[codec]!;
    });
    return generator;
  }

  @override
  TypeReference primitive() {
    return TypeReference((b) => b
      ..symbol = name
      ..url = filePath);
  }

  @override
  TypeReference codec() {
    return generator.codec();
  }

  @override
  Expression codecInstance() {
    return generator.codecInstance();
  }

  @override
  Expression valueFrom(Input input) {
    return generator.valueFrom(input);
  }

  @override
  Expression encode(Expression obj,
      [Expression output = const Reference('output')]) {
    return generator.encode(obj, output);
  }

  @override
  Expression decode([Expression input = const Reference('input')]) {
    return generator.decode(input);
  }

  @override
  GeneratedOutput? generated() {
    final typeDef = createTypeDef(name: name, reference: generator.primitive());
    return GeneratedOutput(classes: [], enums: [], typedefs: [typeDef]);
  }
}
