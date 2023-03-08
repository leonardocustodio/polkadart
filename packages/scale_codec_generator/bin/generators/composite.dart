import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show refer, TypeReference, Expression;
import 'package:path/path.dart' as p;
import '../class_builder.dart' show createCompositeCodec, createCompositeClass;
import './base.dart' show BasePath, Generator, GeneratedOutput, Field;

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
  TypeReference codec(BasePath from) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = p.relative(filePath, from: from));
  }

  @override
  TypeReference primitive(BasePath from) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = p.relative(filePath, from: from));
  }

  @override
  Expression valueFrom(BasePath from, Input input) {
    return primitive(from).newInstance([], {
      for (final field in fields)
        field.name: field.codec.valueFrom(from, input),
    });
  }

  @override
  GeneratedOutput? generated() {
    final typeBuilder = createCompositeClass(this);
    final codecBuilder = createCompositeCodec(this);
    return GeneratedOutput(
        classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
