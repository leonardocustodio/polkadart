part of codec_types;

///
/// U8 to encode/decode unsigned 8 bit integer
class U8 extends Uint<int> {
  ///
  /// constructor
  U8._() : super._();

  ///
  /// [static] returns a new instance of U8
  @override
  U8 freshInstance() => U8._();

  ///
  /// Decode a unsigned 8 bit integer from the Codec's input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U8');
  /// final value = codec.decode(DefaultInput.fromHex('0x00'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U8');
  /// final value = codec.decode(DefaultInput.fromHex('0xff'));
  /// print(value); // 255
  /// ```
  @override
  int decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// Decode a unsigned 8 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U8.decodeFromInput(DefaultInput.fromHex('0x00'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U8.decodeFromInput(DefaultInput.fromHex('0xff'));
  /// print(value); // 255
  /// ```
  static int decodeFromInput(Input input) {
    return input.byte();
  }

  ///
  /// Encodes a unsigned 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U8');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 0);
  /// print(encoder.toHex()); // 0x00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U8');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 255);
  /// print(encoder.toHex()); // 0xff
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 8 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U8.encodeToEncoder(encoder, 0);
  /// print(encoder.toHex()); // 0x00
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U8.encodeToEncoder(encoder, 255);
  /// print(encoder.toHex()); // 0xff
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < 0 || value > 255) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 255, but found: $value');
    }
    encoder.write(value);
  }
}
