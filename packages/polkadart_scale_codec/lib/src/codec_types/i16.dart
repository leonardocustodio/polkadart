part of codec_types;

///
/// I16 to encode/decode signed 16 bit integer
class I16 extends Codec<int> {
  ///
  /// constructor
  I16({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a signed 16 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16', data: Source('0x0080'));
  /// final value = codec.decode();
  /// print(value); // -32768
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16', data: Source('0xff7f'));
  /// final value = codec.decode();
  /// print(value); // 32767
  /// ```
  @override
  int decode() {
    final value = bytesToLittleEndianInt(data.bytes(2).toList());
    final result = (value | (value & (1 << 15)) * 0x1fffe).toSigned(16);

    return result;
  }

  ///
  /// Encodes a signed 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16');
  /// final value = codec.encode(-32768);
  /// print(value); // 0080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16');
  /// final value = codec.encode(32767);
  /// print(value); // ff7f
  /// ```
  @override
  String encode(int value) {
    if (value < -32768 || value > 32767) {
      throw UnexpectedCaseException(
          'I8: value $value is not in range of -32768 to 32767');
    }

    final base = (value + 65536) % 65536;
    return encodeHex(<int>[base & 0xff, base >>> 8]);
  }
}
