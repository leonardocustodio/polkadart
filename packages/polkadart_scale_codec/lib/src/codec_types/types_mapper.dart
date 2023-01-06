part of codec_types;

class CodecMapper {
  static Codec? getCodec(String codecTypeName, Registry registry) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec(registry: registry);
    }
    return null;
  }
}
