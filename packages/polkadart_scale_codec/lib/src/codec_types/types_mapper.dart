part of codec_types;

class CodecMapper {
  static Codec? getCodec(String codecTypeName, Registry registry) {
    switch (codecTypeName) {
      case 'Bool':
        return BoolCodec(registry);
    }
    return null;
  }
}
