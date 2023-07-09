part of descriptors;

class Variant extends TypeDescriptor {
  int index;
  String name;
  String orignalName;
  List<Field> fields;
  List<String> docs;
  late VariantBuilder generator;

  Variant({
    required this.index,
    required this.name,
    required this.orignalName,
    required this.fields,
    required this.docs,
  }) {
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].originalName == null) {
        fields[i].sanitizedName = 'value$i';
      }
    }
  }

  @override
  int id() => generator.id() | ((index + 1) << 24);

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (fields.isEmpty) {
      return refs.map(refs.string, refs.dynamic);
    }

    if (isCircular) {
      if (fields.length == 1) {
        return refs.map(refs.string, refs.dynamic);
      } else if (fields.every((field) => field.originalName == null)) {
        return refs.map(refs.string, refs.list(ref: refs.dynamic));
      }
      return refs.map(refs.string, refs.map(refs.string, refs.dynamic));
    }

    if (fields.length == 1 && fields.first.originalName == null) {
      return refs.map(refs.string, context.jsonTypeFrom(fields.first.codec));
    }

    // Check if all fields are of the same type, otherwise use dynamic
    final type = findCommonType(
        fields.map((field) => context.jsonTypeFrom(field.codec)));

    // If all fields are unnamed, returns Map<String, List<T>>
    if (fields.every((field) => field.originalName == null)) {
      return refs.map(refs.string, refs.list(ref: type));
    }

    // If fields are named, returns Map<String, Map<String, T>>
    return refs.map(refs.string, refs.map(refs.string, type));
  }

  Expression toJson(BasePath from) {
    if (fields.isEmpty) {
      return literalMap({orignalName: literalNull});
    }
    if (fields.length == 1 && fields.first.originalName == null) {
      return literalMap({
        orignalName: fields.first.codec
            .instanceToJson(from, refer(fields.first.sanitizedName))
      });
    }
    if (fields.every((field) => field.originalName == null)) {
      return literalMap({
        orignalName: literalList(fields.map((field) =>
            field.codec.instanceToJson(from, refer(field.sanitizedName))))
      });
    }
    return literalMap({
      orignalName: literalMap({
        for (final field in fields)
          ReCase(field.originalOrSanitizedName()).camelCase:
              field.codec.instanceToJson(from, refer(field.sanitizedName))
      })
    });
  }

  @override
  TypeReference codec(BasePath from) {
    throw UnimplementedError();
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    throw UnimplementedError();
  }

  @override
  TypeReference primitive(BasePath from) {
    return TypeReference((b) => b
      ..symbol = name
      ..url = p.relative(generator.filePath, from: from));
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    throw UnimplementedError();
  }
}

class VariantBuilder extends TypeBuilder {
  final int _id;
  String name;
  String orginalName;
  List<Variant> variants;
  List<String> docs;

  VariantBuilder(
      {required int id,
      required String filePath,
      required this.name,
      required this.orginalName,
      required this.variants,
      required this.docs})
      : _id = id,
        super(filePath) {
    for (final variant in variants) {
      variant.generator = this;
    }
  }

  @override
  int id() => _id;

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
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final index = input.read();
    final variant = variants.firstWhere((variant) => variant.index == index);

    if (variants.isNotEmpty &&
        variants.every((variant) => variant.fields.isEmpty)) {
      return primitive(from).property(ReCase(variant.name).camelCase);
    }

    final variantType = variant.primitive(from);
    final values = <String, Expression>{
      for (final field in variant.fields)
        field.sanitizedName: field.codec.valueFrom(from, input)
    };
    if (values.values.every((value) => value.isConst)) {
      return variantType.constInstance([], values);
    }
    return variantType.newInstance([], values);
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    // For Simple Variants json type is String
    if (variants.isNotEmpty &&
        variants.every((variant) => variant.fields.isEmpty)) {
      return refs.string.type as TypeReference;
    }

    if (isCircular) {
      return refs.map(refs.string, refs.dynamic);
    }

    // Check if all variants are of the same type, otherwise use Map<String, dynamic>
    final complexJsonType = findCommonType(
        variants.map((variant) => context.jsonTypeFrom(variant)));
    if (complexJsonType.symbol != 'Map') {
      throw Exception('$name: Invalid complex variant type: $complexJsonType');
    }
    return complexJsonType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }

  @override
  GeneratedOutput build() {
    // Simple Variants
    if (variants.isNotEmpty &&
        variants.every((variant) => variant.fields.isEmpty)) {
      final simpleEnum = classbuilder.createSimpleVariantEnum(this);
      final simpleCodec = classbuilder.createSimpleVariantCodec(this);
      return GeneratedOutput(
          classes: [simpleCodec], enums: [simpleEnum], typedefs: []);
    }

    // Complex Variants
    final dirname = p.dirname(filePath);
    final builderContext = TypeBuilderContext(from: dirname);
    final variantsJsonType = variants
        .map((variant) => builderContext.jsonTypeFrom(variant))
        .toList();
    final baseClassJsonType = findCommonType(variantsJsonType);
    final baseClass =
        classbuilder.createVariantBaseClass(this, baseClassJsonType);
    final valuesClass = classbuilder.createVariantValuesClass(this);
    final codecClass = classbuilder.createVariantCodec(this);
    final classes = [baseClass, valuesClass, codecClass];
    for (int i = 0; i < variants.length; i++) {
      classes.add(classbuilder.createVariantClass(
          filePath, name, variants[i], variantsJsonType[i]));
    }
    return GeneratedOutput(classes: classes, enums: [], typedefs: []);
  }
}
