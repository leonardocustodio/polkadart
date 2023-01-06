part of codec_types;

///
/// U16 to encode/decode unsigned 16 bit integer
class U16 extends Codec<int> {
  ///
  /// constructor
  U16({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 16 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16', data: Source('0x0001'));
  /// final value = codec.decode();
  /// print(value); // 1
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16', data: Source('0x0000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  @override
  int decode() {
    return bytesToLittleEndianInt(data.bytes(2).toList());
  }

  ///
  /// Encodes a unsigned 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16');
  /// final value = codec.encode(1);
  /// print(value); // 0001
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16');
  /// final value = codec.encode(0);
  /// print(value); // 0000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16');
  /// final value = codec.encode(65535);
  /// print(value); // ffff
  /// ```
  @override
  String encode(int value) {
    if (value >= 0 && value <= 65535) {
      return encodeHex(<int>[value & 0xff, value >>> 8]);
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and 65535, but found: $value');
  }
}
