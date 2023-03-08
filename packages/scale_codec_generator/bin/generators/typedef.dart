import 'package:code_builder/code_builder.dart'
    show Expression, Reference, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:path/path.dart' as p;
import './base.dart' show BasePath, Generator, GeneratedOutput, LazyLoader;
import '../class_builder.dart' show createTypeDef;

class TypeDefGenerator extends Generator {
  String filePath;
  String name;
  late Generator generator;
  List<String> docs;

  TypeDefGenerator({
    required this.filePath,
    required this.name,
    required this.generator,
    required this.docs,
  });

  TypeDefGenerator._lazy(this.filePath, this.name, this.docs);

  factory TypeDefGenerator.lazy({
    required LazyLoader loader,
    required int codec,
    required String filePath,
    required String name,
    required List<String> docs,
  }) {
    final generator = TypeDefGenerator._lazy(filePath, name, docs);
    loader.addLoader((Map<int, Generator> register) {
      generator.generator = register[codec]!;
    });
    return generator;
  }

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
  Expression valueFrom(BasePath from, Input input) {
    return generator.valueFrom(from, input);
  }

  @override
  Expression encode(String from, Expression obj,
      [Expression output = const Reference('output')]) {
    return generator.encode(from, obj, output);
  }

  @override
  Expression decode(String from, [Expression input = const Reference('input')]) {
    return generator.decode(from, input);
  }

  @override
  GeneratedOutput? generated() {
    final typeDef = createTypeDef(
        name: name, reference: generator.primitive(p.dirname(filePath)));
    return GeneratedOutput(classes: [], enums: [], typedefs: [typeDef]);
  }
}
