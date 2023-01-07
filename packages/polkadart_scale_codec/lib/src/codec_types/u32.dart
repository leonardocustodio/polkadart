part of codec_types;

///
/// encode/decode unsigned 32 bit integer
class U32 extends Codec<int> {
  ///
  /// constructor
  U32({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 32 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32', data: Source('0x000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32', data: Source('0xffffffff'));
  /// final value = codec.decode();
  /// print(value); // 4294967295
  /// ```
  @override
  int decode() {
    return bytesToLittleEndianInt(data.bytes(4).toList());
  }

  ///
  /// Encodes a unsigned 32 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32');
  /// final value = codec.encode(0);
  /// print(value); // 00000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32');
  /// final value = codec.encode(4294967295);
  /// print(value); // ffffffff
  /// ```
  @override
  String encode(int value) {
    if (value < 0 || value > 4294967295) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 4294967295, but found: $value');
    }

    return encodeHex(<int>[
      value & 0xff,
      (value >>> 8) & 0xff,
      (value >>> 16) & 0xff,
      value >>> 24
    ]);
  }
}
