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
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
