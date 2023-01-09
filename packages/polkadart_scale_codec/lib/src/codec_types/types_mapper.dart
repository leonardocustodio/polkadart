part of codec_types;

class CodecMapper {
  static Codec getCodec(String codecTypeName) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec();
      case 'u8':
        return U8();
      case 'u16':
        return U16();
      case 'u32':
        return U32();
      case 'u64':
        return U64();
      case 'u128':
        return U128();
      case 'u256':
        return U256();
      case 'i8':
        return I8();
      case 'i16':
        return I16();
      case 'i32':
        return I32();
      case 'i64':
        return I64();
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
