part of codec_types;

class CodecMapper {
  static Codec getCodec(String codecTypeName) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec._();
      case 'u8':
        return U8._();
      case 'u16':
        return U16._();
      case 'u32':
        return U32._();
      case 'u64':
        return U64._();
      case 'u128':
        return U128._();
      case 'u256':
        return U256._();
      case 'i8':
        return I8._();
      case 'i16':
        return I16._();
      case 'i32':
        return I32._();
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
