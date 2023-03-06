import 'package:code_builder/code_builder.dart' show Expression, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
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
  TypeReference codec() {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}Codec'
      ..url = filePath
      ..types.addAll(generators.map((e) => e.primitive())));
  }

  @override
  TypeReference primitive() {
    return TypeReference((b) => b
      ..symbol = 'Tuple${generators.length}'
      ..url = filePath
      ..types.addAll(generators.map((e) => e.primitive())));
  }

  @override
  Expression codecInstance() {
    return codec()
        .constInstance(generators.map((type) => type.codecInstance()));
  }

  @override
  Expression valueFrom(Input input) {
    // return primitive().newInstance([]);
    return primitive()
        .newInstance(generators.map((type) => type.valueFrom(input)).toList());
  }

  @override
  GeneratedOutput? generated() {
    final tupleClass = createTupleClass(generators.length);
    final tupleCodec = createTupleCodec(generators.length);
    return GeneratedOutput(
        classes: [tupleClass, tupleCodec], enums: [], typedefs: []);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is TupleGenerator) {
      for (int i = 0; i < generators.length; i++) {
        if (generators[i] != other.generators[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }




}
