part of scale_info;

/// A type definition with optional metadata.
class TypeMetadata {
  final int id;

  /// The unique path to the type. Can be empty for built-in types
  final List<String> path;

  /// The generic type parameters of the type in use. Empty for non generic types
  final List<TypeParameter> params;

  /// The actual type definition
  final TypeDef typeDef;

  /// Documentation
  final List<String> docs;

  /// Create a [`Type`].
  const TypeMetadata(
      {required this.id,
      required this.path,
      required this.params,
      required this.typeDef,
      required this.docs});

  factory TypeMetadata.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    json = json['type'] as Map<String, dynamic>;
    final path = (json['path'] as List).cast<String>();
    final docs = (json['docs'] as List).cast<String>();

    final params = List<TypeParameter>.empty(growable: true);
    if (json.containsKey('params')) {
      for (final param in json['params'] as List) {
        params.add(TypeParameter(
          name: param['name'] as String,
          type: parseOption(param['type']),
        ));
      }
    }

    return TypeMetadata(
      id: id,
      path: path,
      params: params,
      typeDef: TypeDef.fromJson(json['def'] as Map<String, dynamic>),
      docs: docs,
    );
  }

  @override
  String toString() {
    return 'Type {\n  id: $id,\n  path: $path, \n  params: $params, \n  typeDef: $typeDef, \n  docs: $docs\n}';
  }

  Set<int> typeDependencies() {
    return typeDef.typeDependencies();
  }
}
