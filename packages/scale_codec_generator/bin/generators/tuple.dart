import 'package:code_builder/code_builder.dart' show Expression, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:path/path.dart' as p;
import './base.dart' show Generator, GeneratedOutput, LazyLoader;
import '../class_builder.dart' show createTupleClass, createTupleCodec;

class TupleGenerator extends Generator {
  String filePath;
  List<Generator> generators;

  TupleGenerator({required this.filePath, required this.generators});

  TupleGenerator._lazy({required this.filePath}) : generators = [];

  factory TupleGenerator.lazy(
      {required LazyLoader loader,
      required String filePath,
      required List<int> codecs}) {
    final generator = TupleGenerator._lazy(filePath: filePath);
    loader.addLoader((Map<int, Generator> register) {
      for (final codec in codecs) {
        generator.generators.add(register[codec]!);
      }
    });
    return generator;
  }

  @override
  TypeReference codec([String? from]) {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}Codec'
      ..url = from == null ? filePath : p.relative(filePath, from: from)
      ..types.addAll(generators.map((e) => e.primitive(from))));
  }

  @override
  TypeReference primitive([String? from]) {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}'
      ..url = from == null ? filePath : p.relative(filePath, from: from)
      ..types.addAll(generators.map((e) => e.primitive(from))));
  }

  @override
  Expression codecInstance([String? from]) {
    return codec(from)
        .constInstance(generators.map((type) => type.codecInstance(from)));
  }

  @override
  Expression valueFrom(Input input, [String? from]) {
    // return primitive().newInstance([]);
    return primitive(from).newInstance(
        generators.map((type) => type.valueFrom(input, from)).toList());
  }

  @override
  GeneratedOutput? generated() {
    final tupleClass = createTupleClass(generators.length);
    final tupleCodec = createTupleCodec(generators.length);
    return GeneratedOutput(
        classes: [tupleClass, tupleCodec], enums: [], typedefs: []);
  }
}
