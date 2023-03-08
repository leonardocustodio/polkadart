import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalList;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:path/path.dart' as p;
import './base.dart' show BasePath, Generator, GeneratedOutput, LazyLoader;
import '../utils.dart' as utils show findCommonType;
import '../class_builder.dart' show createTupleClass, createTupleCodec;
import '../constants.dart' as constants;

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
  Expression valueFrom(BasePath from, Input input) {
    return primitive(from).newInstance(
        generators.map((type) => type.valueFrom(from, input)).toList());
  }

  @override
  GeneratedOutput? generated() {
    final tupleClass = createTupleClass(generators.length);
    final tupleCodec = createTupleCodec(generators.length);
    return GeneratedOutput(
        classes: [tupleClass, tupleCodec], enums: [], typedefs: []);
  }

  @override
  TypeReference jsonType(BasePath from, [ Set<Generator> visited = const {}]) {
    if (generators.isEmpty) {
      return constants.dynamic.type as TypeReference;
    }

    if (visited.contains(this)) {
      return constants.list(ref: constants.dynamic);
    }
    visited.add(this);
    
    // Check if all fields are of the same type, otherwise use dynamic
    final type = utils.findCommonType(generators.map((generator) => generator.jsonType(from, visited)));
    final newType = constants.list(ref: type);
    visited.remove(this);
    return newType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return literalList([
      for (int i = 0; i < generators.length; i++)
        generators[i].instanceToJson(from, obj.property('value$i'))
    ], constants.dynamic);
  }
}
