part of metadata;

/// Array type (fixed-size)
///
/// Represents a [T; N] fixed-length array.
class TypeDefArray extends TypeDefVariant {
  final int len;
  final int type;

  const TypeDefArray({required this.len, required this.type});

  static const $TypeDefVariant codec = TypeDefVariant.codec;

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'len': len,
      'type': type,
    };
  }
}

class $TypeDefArray with Codec<TypeDefArray> {
  const $TypeDefArray._();

  @override
  TypeDefArray decode(Input input) {
    final len = U32Codec.codec.decode(input);
    final type = CompactCodec.codec.decode(input);
    return TypeDefArray(len: len, type: type);
  }

  @override
  void encodeTo(TypeDefArray value, Output output) {
    U32Codec.codec.encodeTo(value.len, output);
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeDefArray value) {
    return CompactCodec.codec.sizeHint(value.len) + CompactCodec.codec.sizeHint(value.type);
  }
}
