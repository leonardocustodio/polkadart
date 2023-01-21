part of codec_types;

///
/// I8 to encode/decode signed 8 bit integer
class I8 extends Codec<int> {
  ///
  /// constructor
  I8._() : super(registry: Registry());

  ///
  /// Decode a signed 8 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8', input: Input('0x80'));
  /// final value = codec.decode();
  /// print(value); // -128
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8', input: Input('0x7f'));
  /// final value = codec.decode();
  /// print(value); // 127
  /// ```
  @override
  int decode() {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 8 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = I8.decode(input: Input('0x80'));
  /// print(value); // -128
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I8.decode(input: Input('0x7f'));
  /// print(value); // 127
  /// ```
  static int decodeFromInput(Input input) {
    final byte = input.byte();
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
  void encode(Encoder encoder, int value) {
    encodeTo(encoder, value);
  }

  ///
  /// [static] Encodes a signed 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = I8.encodeTo(encoder, -128);
  /// print(encoder.toHex()); // 80
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = I8.encodeTo(encoder, 127);
  /// print(encoder.toHex()); // 7f
  /// ```
  static void encodeTo(Encoder encoder, int value) {
    if (value < -128 || value > 127) {
      throw UnexpectedCaseException(
          'Expected value between -128 and 127, but found: $value');
    }

    encoder.write((value + 256) % 256);
  }
}
