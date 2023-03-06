import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show refer, TypeReference, Expression;
import '../class_builder.dart' show createCompositeCodec, createCompositeClass;
import './base.dart' show Generator, GeneratedOutput, Field;

class CompositeGenerator extends Generator {
  String filePath;
  String name;
  late List<Field> fields;

  CompositeGenerator(
      {required this.filePath, required this.name, required this.fields});

  @override
  TypeReference codec() {
    return TypeReference((b) => b
      ..symbol = name
      ..url = filePath);
  }

  @override
  TypeReference primitive() {
    return TypeReference((b) => b
      ..symbol = name
      ..url = filePath);
  }

  @override
  Expression valueFrom(Input input) {
    return primitive().newInstance([], {
      for (final field in fields) field.name: field.codec.valueFrom(input),
    });
  }

  @override
  GeneratedOutput? generated() {
    final codecName = '_\$${name}Codec';
    final typeBuilder = createCompositeClass(name, fields,
        staticCodec: codecName, implDecode: true);
    final codecBuilder = createCompositeCodec(codecName, refer(name), fields);
    return GeneratedOutput(
        classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is CompositeGenerator &&
        name == other.name &&
        fields.length == other.fields.length) {
      for (int i = 0; i < fields.length; i++) {
        if (fields[i] != other.fields[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
