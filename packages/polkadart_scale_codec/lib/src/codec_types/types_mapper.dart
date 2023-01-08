part of codec_types;

class CodecMapper {
  static Codec getCodec(String codecTypeName) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec();
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
