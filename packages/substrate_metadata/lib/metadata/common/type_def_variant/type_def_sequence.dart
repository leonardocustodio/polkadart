part of metadata;

/// Sequence type (vector/array-like with dynamic length)
///
/// Represents a Vec<T> or similar dynamic-length collection.
class TypeDefSequence extends TypeDefVariant {
  final int type;
  const TypeDefSequence({required this.type});

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

class $TypeDefSequence with Codec<TypeDefSequence> {
  const $TypeDefSequence._();

  @override
  TypeDefSequence decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return TypeDefSequence(type: type);
  }

  @override
  void encodeTo(TypeDefSequence value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeDefSequence value) {
    return CompactCodec.codec.sizeHint(value.type);
  }
}
