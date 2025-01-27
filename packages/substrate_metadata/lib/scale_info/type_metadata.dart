part of scale_info;

/// A type definition with optional metadata.
class TypeMetadata {
  /// The unique path to the type. Can be empty for built-in types
  final List<String> path;

  /// The generic type parameters of the type in use. Empty for non generic types
  final List<TypeParameter> params;

  /// The actual type definition
  final TypeDef typeDef;

  /// Documentation
  final List<String> docs;

  static const $TypeMetadata codec = $TypeMetadata._();

  /// Create a [`Type`].
  const TypeMetadata(
      {required this.path,
      required this.params,
      required this.typeDef,
      required this.docs});

  @override
  String toString() {
    return 'Type {\n  path: $path, \n  params: $params, \n  typeDef: $typeDef, \n  docs: $docs\n}';
  }

  Set<int> typeDependencies() {
    return typeDef.typeDependencies();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (path.isNotEmpty) {
      json['path'] = path;
    }
    if (params.isNotEmpty) {
      json['params'] = params.map((e) => e.toJson()).toList();
    }
    json['def'] = typeDef.toJson();
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

class $TypeMetadata implements Codec<TypeMetadata> {
  const $TypeMetadata._();

  @override
  TypeMetadata decode(Input input) {
    final path = SequenceCodec(StrCodec.codec).decode(input);
    final params = SequenceCodec(TypeParameter.codec).decode(input);
    final typeDef = TypeDef.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return TypeMetadata(
      path: path,
      params: params,
      typeDef: typeDef,
      docs: docs,
    );
  }

  @override
  Uint8List encode(TypeMetadata value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeMetadata metadata, Output output) {
    SequenceCodec(StrCodec.codec).encodeTo(metadata.path, output);
    SequenceCodec(TypeParameter.codec).encodeTo(metadata.params, output);
    TypeDef.codec.encodeTo(metadata.typeDef, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(TypeMetadata metadata) {
    int size = SequenceCodec(StrCodec.codec).sizeHint(metadata.path);
    size += SequenceCodec(TypeParameter.codec).sizeHint(metadata.params);
    size += TypeDef.codec.sizeHint(metadata.typeDef);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}
