part of codec_types;

///
/// I32 to encode/decode signed 32 bit integer
class I32 extends Codec<int> {
  ///
  /// constructor
  I32._() : super(registry: Registry());

  ///
  /// [static] Create a new instance of I32
  @override
  I32 copyWith(Codec codec) {
    return copyProperties(codec, I32._()) as I32;
  }

  ///
  /// Decode a signed 32 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32', input: Input('0x00000080'));
  /// final value = codec.decode();
  /// print(value); // -2147483648
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I32', input: Input('0xffffff7f'));
  /// final value = codec.decode();
  /// print(value); // 2147483647
  /// ```
  @override
  int decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 32 bit integer directly from the source
  ///
  /// Example:
  /// ```dart
  /// final value = I32.decodeFromInput(Input('0x00000080'));
  /// print(value); // -2147483648
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I32.decodeFromInput(Input('0xffffff7f'));
  /// print(value); // 2147483647
  /// ```
  static int decodeFromInput(Input input) {
    return U16.decodeFromInput(input) +
        input.byte() * (2 << 15) +
        (input.byte() << 24).toSigned(32);
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
  void encode(Encoder encoder, int value) {
    return encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 32 bit integer directly to the encoder
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I32.encodeTo(encoder, -2147483648);
  /// print(encoder.toHex()); // 00000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I32.encodeTo(encoder, 2147483647);
  /// print(encoder.toHex()); // ffffff7f
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < -2147483648 || value > 2147483647) {
      throw UnexpectedCaseException(
          'I16: value $value is not in range of -2147483648 to 2147483647');
    }

    final base = (value + 4294967296) % 4294967296;
    return U32.encodeToEncoder(encoder, base);
  }
}
