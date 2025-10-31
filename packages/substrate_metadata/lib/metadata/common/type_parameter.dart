part of metadata;

/// Type parameter for generic types
///
/// Represents a generic parameter like T in Option<T>.
class TypeParameter {
  /// Name of the parameter (e.g., "T", "Balance")
  final String name;

  /// Optional concrete type for this parameter
  ///
  /// If present, indicates the concrete type used for this parameter.
  /// If null, the parameter is still generic.
  final int? type;

  const TypeParameter({required this.name, this.type});

  /// Codec instance for TypeParameter
  static const $TypeParameter codec = $TypeParameter._();

  Map<String, dynamic> toJson() => {'name': name, 'type': type};
}

/// Codec for TypeParameter
class $TypeParameter with Codec<TypeParameter> {
  const $TypeParameter._();

  @override
  TypeParameter decode(Input input) {
    // Decode parameter name
    final name = StrCodec.codec.decode(input);

    // Decode optional type ID
    final type = OptionCodec(CompactCodec.codec).decode(input);

    return TypeParameter(name: name, type: type);
  }

  @override
  void encodeTo(TypeParameter value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    OptionCodec(CompactCodec.codec).encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeParameter value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += OptionCodec(CompactCodec.codec).sizeHint(value.type);
    return size;
  }

  @override
  bool isSizeZero() => StrCodec.codec.isSizeZero() && OptionCodec(CompactCodec.codec).isSizeZero();
}
