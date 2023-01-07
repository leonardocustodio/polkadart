part of codec_types;

///
/// I32 to encode/decode signed 32 bit integer
class I32 extends Codec<int> {
  ///
  /// constructor
  I32({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a signed 32 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32', data: Source('0x00000080'));
  /// final value = codec.decode();
  /// print(value); // -2147483648
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32', data: Source('0xffffff7f'));
  /// final value = codec.decode();
  /// print(value); // 2147483647
  /// ```
  @override
  int decode() {
    return data.byte() +
        data.byte() * (pow(2, 8) as int) +
        data.byte() * (pow(2, 16) as int) +
        (data.byte() << 24).toSigned(32);
  }

  ///
  /// Encodes a signed 32 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32');
  /// final value = codec.encode(-2147483648);
  /// print(value); // 00000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32');
  /// final value = codec.encode(2147483647);
  /// print(value); // ffffff7f
  /// ```
  @override
  String encode(int value) {
    if (value < -2147483648 || value > 2147483647) {
      throw UnexpectedCaseException(
          'I16: value $value is not in range of -2147483648 to 2147483647');
    }

    final newValue = (value + 4294967296) % 4294967296;
    return createTypeCodec('U32').encode(newValue);
  }
}
