import 'package:code_builder/code_builder.dart' show Class, Expression, TypeReference;
import 'package:scale_codec/scale_codec.dart' show Input;
import 'package:recase/recase.dart' show ReCase;
import '../class_builder.dart' show createVariantBaseClass, createVariantValuesClass, createVariantCodec, createVariantClass, createSimpleVariantEnum, createSimpleVariantCodec;
import './base.dart' show Generator, GeneratedOutput, Field;


class Variant {
  int index;
  String name;
  List<Field> fields;

  Variant({ required this.index, required this.name, required this.fields });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is Variant &&
        runtimeType == other.runtimeType &&
        fields.length == other.fields.length) {
      for (var i = 0; i < fields.length; i++) {
        if (fields[i] != other.fields[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}

class VariantGenerator extends Generator {
  String filePath;
  String name;
  List<Variant> variants;

  VariantGenerator({ required this.filePath, required this.name, required this.variants });

  @override
  TypeReference codec() {
    return TypeReference((b) => b
      ..symbol = name
      ..url = filePath
    );
  }

  @override
  TypeReference primitive() {
    return TypeReference((b) => b
      ..symbol = name
      ..url = filePath
    );
  }

  @override
  Expression valueFrom(Input input) {
    final index = input.read();
    final variant = variants.firstWhere((variant) => variant.index == index);

    if (variants.isNotEmpty && variants.every((variant) => variant.fields.isEmpty)) {
      return primitive().property(ReCase(variant.name).camelCase);
    }

    return primitive()
      .property('values')
      .property(ReCase(variant.name).camelCase)
      .call([], {
        for (final field in variant.fields) field.name: field.codec.valueFrom(input)
      });
  }

  @override
  GeneratedOutput? generated() {
    if (variants.isNotEmpty && variants.every((variant) => variant.fields.isEmpty)) {
      final simpleEnum = createSimpleVariantEnum(name, '_\$${name}Codec', variants);
      final simpleCodec = createSimpleVariantCodec('_\$${name}Codec', name, variants);
      return GeneratedOutput(classes: [simpleCodec], enums: [simpleEnum], typedefs: []);
    }

    final baseClass = createVariantBaseClass(name, '_\$${name}Codec', variants);
    final valuesClass = createVariantValuesClass('_$name', variants);
    final codecClass = createVariantCodec('_\$${name}Codec', name, variants);

    List<Class> classes = variants.fold(
      <Class>[baseClass, valuesClass, codecClass],
      (classes, variant) {
        classes.add(createVariantClass(name, '_\$${name}Codec', variant));
        return classes;
      }
    );
    return GeneratedOutput(classes: classes, enums: [], typedefs: []);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is VariantGenerator &&
        variants.length == other.variants.length) {
      for (int i = 0; i < variants.length; i++) {
        if (variants[i] != other.variants[i]) {
          return false;
        }
      }
      return true;
    }
    return false;
  }
}
