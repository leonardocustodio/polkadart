part of codec_types;

extension EnumExtensions<T extends core.Enum> on T {
  ///
  /// Encodes value of Enum to the [HexEncoder] / [ByteEncoder]
  void encodeTo(Encoder encoder) {
    encoder.write(index);
  }

  ///
  /// Encodes value of Enum and returns hex string
  String encode() {
    final encoder = HexEncoder()..write(index);
    return encoder.toHex();
  }
}
