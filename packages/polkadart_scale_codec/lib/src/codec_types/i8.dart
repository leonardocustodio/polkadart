part of codec_types;

///
/// I8 to encode/decode signed 8 bit integer
class I8 extends Codec<int> {
  ///
  /// constructor
  I8({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a signed 8 bit integer from the source
  ///
  ///
  @override
  int decode() {
    final byte = data.byte();
    return (byte | (byte & 0x80) * 0x1fffffe).toSigned(16);
  }

  ///
  /// Encodes a signed 8 bit integer
  @override
  String encode(int value) {
    if (value < -128 || value > 127) {
      throw UnexpectedCaseException(
          'I8: value $value is not in range of -128 to 127');
    }

    return encodeHex(<int>[(value + 256) % 256]);
  }
}
