part of codec_types;

class CodecMapper {
  static Codec? getCodec(String codecTypeName, Registry registry) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec(registry: registry);
      case 'u8':
        return U8(registry: registry);
      case 'u16':
        return U16(registry: registry);
      case 'u32':
        return U32(registry: registry);
      case 'u64':
        return U64(registry: registry);
    }
    return null;
  }
}
