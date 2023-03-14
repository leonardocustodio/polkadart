part of generators;

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
  }) {
    for (int i = 0; i < fields.length; i++) {
      if (fields[i].originalName == null) {
        fields[i].sanitizedName = 'value$i';
      }
    }
  }

  bool unnamedFields() {
    return fields.isNotEmpty &&
        fields.every((field) => field.originalName == null);
  }

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
    if (fields.isEmpty) {
      return literalNull;
    }

    final Map<String, Expression> map = {
      for (final field in fields)
        field.sanitizedName:
            field.codec.valueFrom(from, input, constant: constant),
    };

    if (constant && map.values.every((value) => value.isConst)) {
      return primitive(from).constInstance([], map);
    }

    return primitive(from).newInstance([], map);
  }

  @override
  GeneratedOutput? generated() {
    final typeBuilder = classbuilder.createCompositeClass(this);
    final codecBuilder = classbuilder.createCompositeCodec(this);
    return GeneratedOutput(
        classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    if (fields.isEmpty) {
      return constants.dynamic.type as TypeReference;
    }

    if (visited.contains(this)) {
      if (fields.length == 1 && fields.first.originalName == null) {
        return constants.dynamic.type as TypeReference;
      } else if (fields.every((field) => field.originalName == null)) {
        return constants.list(ref: constants.dynamic);
      } else {
        return constants.map(constants.string, constants.dynamic);
      }
    }

    visited.add(this);
    final type = Generator.cacheOrCreate(from, visited, () {
      if (fields.length == 1 && fields.first.originalName == null) {
        return fields.first.codec.jsonType(from, visited);
      }

      // Check if all fields are of the same type, otherwise use dynamic
      final type = findCommonType(
          fields.map((field) => field.codec.jsonType(from, visited)));

      // If all field are unnamed, return a list
      if (fields.every((field) => field.originalName == null)) {
        return constants.list(ref: type);
      }

      // Otherwise return a map
      return constants.map(constants.string, type);
    });
    visited.remove(this);
    return type;
  }

  Expression toJson(BasePath from) {
    if (fields.isEmpty) {
      return literalNull;
    }
    if (fields.length == 1 && fields.first.originalName == null) {
      return fields.first.codec
          .instanceToJson(from, refer(fields.first.sanitizedName));
    }
    if (fields.every((field) => field.originalName == null)) {
      return literalList(fields.map((field) =>
          field.codec.instanceToJson(from, refer(field.sanitizedName))));
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
}
