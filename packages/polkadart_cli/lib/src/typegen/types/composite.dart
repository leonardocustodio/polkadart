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
    return fields.isNotEmpty &&
        fields.every((field) => field.originalName == null);
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
  TypeReference jsonType(BasePath from,
      [Set<TypeDescriptor> visited = const {}]) {
    if (fields.isEmpty) {
      return refs.dynamic.type as TypeReference;
    }

    if (visited.contains(this)) {
      if (fields.length == 1 && fields.first.originalName == null) {
        return refs.dynamic.type as TypeReference;
      } else if (fields.every((field) => field.originalName == null)) {
        return refs.list(ref: refs.dynamic);
      } else {
        return refs.map(refs.string, refs.dynamic);
      }
    }

    visited.add(this);
    final type = TypeDescriptor.cacheOrCreate(from, visited, () {
      if (fields.length == 1 && fields.first.originalName == null) {
        return fields.first.codec.jsonType(from, visited);
      }

      // Check if all fields are of the same type, otherwise use dynamic
      final type = findCommonType(
          fields.map((field) => field.codec.jsonType(from, visited)));

      // If all field are unnamed, return a list
      if (fields.every((field) => field.originalName == null)) {
        return refs.list(ref: type);
      }

      // Otherwise return a map
      return refs.map(refs.string, type);
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

  @override
  GeneratedOutput build() {
    final typeBuilder = classbuilder.createCompositeClass(this);
    final codecBuilder = classbuilder.createCompositeCodec(this);
    return GeneratedOutput(
        classes: [typeBuilder, codecBuilder], enums: [], typedefs: []);
  }
}
