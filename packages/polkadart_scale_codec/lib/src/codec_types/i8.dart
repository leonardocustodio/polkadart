part of codec_types;

///
/// I8 to encode/decode signed 8 bit integer
class I8 extends Codec<int> {
  final Source? source;

  ///
  /// constructor
  I8({this.source}) : super(registry: Registry());

  ///
  /// Decode a signed 8 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8', data: Source('0x80'));
  /// final value = codec.decode();
  /// print(value); // -128
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8', data: Source('0x7f'));
  /// final value = codec.decode();
  /// print(value); // 127
  /// ```
  @override
  int decode() {
    final byte = (source ?? data).byte();
    return (byte | (byte & 0x80) * 0x1fffffe).toSigned(16);
  }

  ///
  /// Encodes a signed 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8');
  /// final value = codec.encode(-128);
  /// print(value); // 80
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8');
  /// final value = codec.encode(127);
  /// print(value); // 7f
  /// ```
  @override
  String encode(int value) {
    if (value < -128 || value > 127) {
      throw UnexpectedCaseException(
          'Expected value between -128 and 127, but found: $value');
    }

    return encodeHex([(value + 256) % 256]);
  }
}
