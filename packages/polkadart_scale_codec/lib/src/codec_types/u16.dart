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
  /// final codec = Codec<int>().createTypeCodec('U16', data: Source('0x0000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16', data: Source('0xffff'));
  /// final value = codec.decode();
  /// print(value); // 65535
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
    if (value < 0 || value > 65535) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 65535, but found: $value');
    }

    return encodeHex(<int>[value & 0xff, value >>> 8]);
  }
}
