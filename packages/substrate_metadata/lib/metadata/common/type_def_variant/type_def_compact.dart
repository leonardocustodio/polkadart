part of metadata;

/// Compact encoded type
///
/// Represents a type that uses compact/compressed encoding.
class TypeDefCompact extends TypeDefVariant {
  final int type;
  const TypeDefCompact({required this.type});

  static const $TypeDefVariant codec = TypeDefVariant.codec;

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, dynamic> toJson() {
    return {'type': type};
  }
}

class $TypeDefCompact with Codec<TypeDefCompact> {
  const $TypeDefCompact._();

  @override
  TypeDefCompact decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return TypeDefCompact(type: type);
  }

  @override
  void encodeTo(TypeDefCompact value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeDefCompact value) {
    return CompactCodec.codec.sizeHint(value.type);
  }
}
