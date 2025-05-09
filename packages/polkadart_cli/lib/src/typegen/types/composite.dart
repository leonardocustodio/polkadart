part of descriptors;

class CompositeBuilder extends TypeBuilder {
  final int _id;
  String name;
  late List<Field> fields;
  List<String> docs;

  CompositeBuilder({
    required int id,
    required String filePath,
    required this.name,
    required this.fields,
    required this.docs,
  })  : _id = id,
        super(filePath) {
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].originalName == null) {
        fields[i].sanitizedName = 'value$i';
      }
    }
  }

  bool unnamedFields() {
    return fields.isNotEmpty && fields.every((field) => field.originalName == null);
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
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (fields.isEmpty) {
      return literalNull.asLiteralValue(isConstant: true);
    }

    final args = CallArguments.fromFields(
        fields, (field) => field.codec.valueFrom(from, input, constant: constant));

    if (constant && args.every((value) => value.isConstant)) {
      return primitive(from)
          .constInstance(args.positional, args.named)
          .asLiteralValue(isConstant: true);
    }

    return primitive(from).newInstance(args.positional, args.named).asLiteralValue();
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (fields.isEmpty) {
      return refs.dynamic.type as TypeReference;
    }

    if (isCircular) {
      if (fields.length == 1 && fields.first.originalName == null) {
        return refs.dynamic.type as TypeReference;
      } else if (fields.every((field) => field.originalName == null)) {
        return refs.list(ref: refs.dynamic);
      }
      return refs.map(refs.string, refs.dynamic);
    }

    if (fields.length == 1 && fields.first.originalName == null) {
      return context.jsonTypeFrom(fields.first.codec);
    }

    // Check if all fields are of the same type, otherwise use dynamic
    final type = findCommonType(fields.map((field) => context.jsonTypeFrom(field.codec)));

    // If all field are unnamed, return a list
    if (fields.every((field) => field.originalName == null)) {
      return refs.list(ref: type);
    }

    // Otherwise return a map
    return refs.map(refs.string, type);
    // return refs.map(refs.string, refs.dynamic);
  }

  Expression toJson(BasePath from) {
    if (fields.isEmpty) {
      return literalNull;
    }
    if (fields.length == 1 && fields.first.originalName == null) {
      return fields.first.codec.instanceToJson(from, refer(fields.first.sanitizedName));
    }
    if (fields.every((field) => field.originalName == null)) {
      return literalList(
          fields.map((field) => field.codec.instanceToJson(from, refer(field.sanitizedName))));
    }
    return literalMap({
      for (final field in fields)
        ReCase(field.originalOrSanitizedName()).camelCase:
            field.codec.instanceToJson(from, refer(field.sanitizedName))
    });
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }

  @override
  GeneratedOutput build() {
    final typeBuilder = classbuilder.createCompositeClass(this);
    final codecBuilder = classbuilder.createCompositeCodec(this);
    return GeneratedOutput(classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }
}
