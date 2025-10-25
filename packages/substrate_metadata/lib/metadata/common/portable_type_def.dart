part of metadata;

/// Definition of a type's structure
///
/// Contains the complete information about a type including its path,
/// generic parameters, actual definition, and documentation.
class PortableTypeDef {
  /// Type path as a list of segments (e.g., ['pallet_balances', 'AccountData'])
  ///
  /// Represents the fully qualified path of the type in the source code.
  /// Stored as a list to preserve exact structure without parsing issues.
  final List<String> path;

  /// Type parameters (for generic types)
  ///
  /// For example, Option<TypeParameter> would have one parameter "T".
  final List<TypeParameter> params;

  /// The actual type definition variant
  ///
  /// This determines whether the type is a composite, variant, sequence, etc.
  final TypeDef typeDef;

  /// Documentation for this type
  final List<String> docs;

  const PortableTypeDef({
    required this.path,
    required this.params,
    required this.typeDef,
    this.docs = const [],
  });

  /// Codec instance for PortableTypeDef
  static const $PortableTypeDef codec = $PortableTypeDef._();

  Set<int> typeDependencies() {
    return typeDef.typeDependencies();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (path.isNotEmpty) {
      json['path'] = path;
    }
    if (params.isNotEmpty) {
      json['params'] = params.map((final TypeParameter param) => param.toJson()).toList();
    }
    json['def'] = typeDef.toJson();
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }

  /// Helper to get path as joined string with '::'
  String? get pathString => path.isEmpty ? null : path.join('::');
}

/// Codec for TypeDef
///
/// Handles encoding and decoding of type definitions.
/// Path is stored as a sequence of strings to preserve exact structure.
class $PortableTypeDef with Codec<PortableTypeDef> {
  const $PortableTypeDef._();

  @override
  PortableTypeDef decode(Input input) {
    // Decode path as sequence of strings (not joined with ::)
    final path = SequenceCodec(StrCodec.codec).decode(input);

    // Decode type parameters
    final params = SequenceCodec(TypeParameter.codec).decode(input);

    // Decode type definition variant
    final typeDef = TypeDef.codec.decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return PortableTypeDef(
      path: path,
      params: params,
      typeDef: typeDef,
      docs: docs,
    );
  }

  @override
  void encodeTo(PortableTypeDef value, Output output) {
    SequenceCodec(StrCodec.codec).encodeTo(value.path, output);
    SequenceCodec(TypeParameter.codec).encodeTo(value.params, output);
    TypeDef.codec.encodeTo(value.typeDef, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(PortableTypeDef value) {
    var size = 0;
    size += SequenceCodec(StrCodec.codec).sizeHint(value.path);
    size += SequenceCodec(TypeParameter.codec).sizeHint(value.params);
    size += TypeDef.codec.sizeHint(value.typeDef);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }
}
