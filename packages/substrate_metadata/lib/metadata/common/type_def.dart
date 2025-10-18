part of metadata;

/// Definition of a type's structure
///
/// Contains the complete information about a type including its path,
/// generic parameters, actual definition, and documentation.
class TypeDef {
  /// Type path as a list of segments (e.g., ['pallet_balances', 'AccountData'])
  ///
  /// Represents the fully qualified path of the type in the source code.
  /// Stored as a list to preserve exact structure without parsing issues.
  final List<String> path;

  /// Type parameters (for generic types)
  ///
  /// For example, Option<T> would have one parameter "T".
  final List<TypeParameter> params;

  /// The actual type definition variant
  ///
  /// This determines whether the type is a composite, variant, sequence, etc.
  final TypeDefVariant def;

  /// Documentation for this type
  final List<String> docs;

  const TypeDef({
    required this.path,
    required this.params,
    required this.def,
    this.docs = const [],
  });

  /// Codec instance for TypeDef
  static const $TypeDef codec = $TypeDef._();

  Set<int> typeDependencies() {
    return def.typeDependencies();
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (path.isNotEmpty) {
      json['path'] = path;
    }
    if (params.isNotEmpty) {
      json['params'] = params.map((final TypeParameter param) => param.toJson()).toList();
    }
    json['def'] = def.toJson();
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
class $TypeDef with Codec<TypeDef> {
  const $TypeDef._();

  @override
  TypeDef decode(Input input) {
    // Decode path as sequence of strings (not joined with ::)
    final path = SequenceCodec(StrCodec.codec).decode(input);

    // Decode type parameters
    final params = SequenceCodec(TypeParameter.codec).decode(input);

    // Decode type definition variant
    final def = TypeDefVariant.codec.decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return TypeDef(
      path: path,
      params: params,
      def: def,
      docs: docs,
    );
  }

  @override
  void encodeTo(TypeDef value, Output output) {
    SequenceCodec(StrCodec.codec).encodeTo(value.path, output);
    SequenceCodec(TypeParameter.codec).encodeTo(value.params, output);
    TypeDefVariant.codec.encodeTo(value.def, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(TypeDef value) {
    var size = 0;
    size += SequenceCodec(StrCodec.codec).sizeHint(value.path);
    size += SequenceCodec(TypeParameter.codec).sizeHint(value.params);
    size += TypeDefVariant.codec.sizeHint(value.def);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }
}
