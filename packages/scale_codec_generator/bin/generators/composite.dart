import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show refer, TypeReference, Expression;
import 'package:path/path.dart' as p;
import '../class_builder.dart' show createCompositeCodec, createCompositeClass;
import './base.dart' show Generator, GeneratedOutput, Field;

class CompositeGenerator extends Generator {
  String filePath;
  String name;
  late List<Field> fields;
  List<String> docs;

  CompositeGenerator({
    required this.filePath,
    required this.name,
    required this.fields,
    required this.docs,
  });

  @override
  TypeReference codec([ String? from ]) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = from == null ? filePath : p.relative(filePath, from: from));
  }

  @override
  TypeReference primitive([ String? from ]) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = from == null ? filePath : p.relative(filePath, from: from));
  }

  @override
  Expression valueFrom(Input input, [ String? from ]) {
    return primitive(from).newInstance([], {
      for (final field in fields) field.name: field.codec.valueFrom(input, from),
    });
  }

  @override
  GeneratedOutput? generated() {
    final typeBuilder = createCompositeClass(this);
    final codecBuilder = createCompositeCodec(this);
    return GeneratedOutput(
        classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }
}
