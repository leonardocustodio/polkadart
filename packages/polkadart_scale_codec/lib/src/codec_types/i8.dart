part of codec_types;

///
/// I8 to encode/decode signed 8 bit integer
class I8 extends Codec<int> {
  ///
  /// constructor
  I8._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of I8
  @override
  I8 copyWith(Codec codec) {
    return copyProperties(codec, I8._()) as I8;
  }

  ///
  /// Decode a signed 8 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8');
  /// final value = codec.decode(Input('0x80'));
  /// print(value); // -128
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8');
  /// final value = codec.decode(Input('0x7f'));
  /// print(value); // 127
  /// ```
  @override
  int decode(Input input) {
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
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, -128);
  /// print(encoder.toHex()); // 80
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I8');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 127);
  /// print(encoder.toHex()); // 7f
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I8.encodeToEncoder(encoder, -128);
  /// print(encoder.toHex()); // 80
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I8.encodeToEncoder(encoder, 127);
  /// print(encoder.toHex()); // 7f
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < -128 || value > 127) {
      throw UnexpectedCaseException(
          'Expected value between -128 and 127, but found: $value');
    }

    encoder.write((value + 256) % 256);
  }
}
