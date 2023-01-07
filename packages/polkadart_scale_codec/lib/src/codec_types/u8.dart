part of codec_types;

///
/// U8 to encode/decode unsigned 8 bit integer
class U8 extends Codec<int> {
  ///
  /// constructor
  U8({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 8 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0x00'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0xff'));
  /// final value = codec.decode();
  /// print(value); // 255
  /// ```
  @override
  int decode() {
    return bytesToLittleEndianInt(data.bytes(1).toList());
  }

  ///
  /// Encodes a unsigned 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8');
  /// final value = codec.encode(0);
  /// print(value); // 00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8');
  /// final value = codec.encode(255);
  /// print(value); // ff
  /// ```
  @override
  String encode(int value) {
    if (value >= 0 && value <= 255) {
      return encodeHex(<int>[value]);
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and 255, but found: $value');
  }
}
