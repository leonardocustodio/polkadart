part of codec_types;

class CodecMapper {
  static Codec getCodec(String codecTypeName) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec();
      case 'u8':
        return U8();
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
