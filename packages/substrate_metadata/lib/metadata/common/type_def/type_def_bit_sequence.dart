part of metadata;

/// BitSequence type
///
/// Represents a bit sequence with specific storage and ordering.
class TypeDefBitSequence extends TypeDef {
  final int bitStoreType;
  final int bitOrderType;
  const TypeDefBitSequence({
    required this.bitStoreType,
    required this.bitOrderType,
  });

  static const $TypeDef codec = TypeDef.codec;

  @override
  Set<int> typeDependencies() {
    return {bitStoreType, bitOrderType};
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bitStoreType': bitStoreType,
      'bitOrderType': bitOrderType,
    };
  }
}

class $TypeDefBitSequence with Codec<TypeDefBitSequence> {
  const $TypeDefBitSequence._();

  @override
  TypeDefBitSequence decode(Input input) {
    final bitStoreType = CompactCodec.codec.decode(input);
    final bitOrderType = CompactCodec.codec.decode(input);
    return TypeDefBitSequence(
      bitStoreType: bitStoreType,
      bitOrderType: bitOrderType,
    );
  }

  @override
  void encodeTo(TypeDefBitSequence value, Output output) {
    CompactCodec.codec.encodeTo(value.bitStoreType, output);
    CompactCodec.codec.encodeTo(value.bitOrderType, output);
  }

  @override
  int sizeHint(TypeDefBitSequence value) {
    return CompactCodec.codec.sizeHint(value.bitStoreType) +
        CompactCodec.codec.sizeHint(value.bitOrderType);
  }
}
