part of primitives;

enum PrimitivesEnum {
  Str,
  Bool,
  I8,
  I16,
  I32,
  I64,
  I128,
  I256,
  U8,
  U16,
  U32,
  U64,
  U128,
  U256;

  static Codec fromString(final String name) {
    return switch (name) {
      'Str' => StrCodec.codec,
      'Bool' => BoolCodec.codec,
      // Signed
      'I8' => I8Codec.codec,
      'I16' => I16Codec.codec,
      'I32' => I32Codec.codec,
      'I64' => I64Codec.codec,
      'I128' => I128Codec.codec,
      'I256' => I256Codec.codec,
      // Unsigned
      'U8' => U8Codec.codec,
      'U16' => U16Codec.codec,
      'U32' => U32Codec.codec,
      'U64' => U64Codec.codec,
      'U128' => U128Codec.codec,
      'U256' => U256Codec.codec,
      _ => throw Exception('Not a primitive: $name')
    };
  }
}
