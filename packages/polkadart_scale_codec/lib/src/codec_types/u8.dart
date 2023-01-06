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
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0x01'));
  /// final value = codec.decode();
  /// print(value); // 1
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8', data: Source('0x00'));
  /// final value = codec.decode();
  /// print(value); // 0
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
  /// final value = codec.encode(1);
  /// print(value); // 01
  /// ```
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
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U8');
  /// final value = codec.encode(256);
  /// print(value); // 00
  /// ```
  @override
  String encode(int value) {
    if (value >= 0 && value <= 255) {
      return encodeHex(littleEndianIntToBytes(value, 1));
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and 255, but found: $value');
  }
}
