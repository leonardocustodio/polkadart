part of metadata;

/// Array type (fixed-size)
///
/// Represents a [T; N] fixed-length array.
class TypeDefArray extends TypeDef {
  final int length;
  final int type;
  const TypeDefArray({required this.length, required this.type});

  static const $TypeDef codec = TypeDef.codec;

  @override
  Set<int> typeDependencies() {
    return {type};
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'len': length,
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
    return TypeDefArray(length: len, type: type);
  }

  @override
  void encodeTo(TypeDefArray value, Output output) {
    U32Codec.codec.encodeTo(value.length, output);
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(TypeDefArray value) {
    return CompactCodec.codec.sizeHint(value.length) + CompactCodec.codec.sizeHint(value.type);
  }
}
