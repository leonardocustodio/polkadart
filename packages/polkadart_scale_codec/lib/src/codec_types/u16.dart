part of codec_types;

///
/// U16 to encode/decode unsigned 16 bit integer
class U16 extends Uint<int> {
  ///
  /// constructor
  U16._() : super._();

  ///
  /// [static] returns a new instance of U16
  @override
  U16 freshInstance() => U16._();

  ///
  /// Decode a unsigned 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U16');
  /// final value = codec.decode(DefaultInput.fromHex('0x0000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U16');
  /// final value = codec.decode(DefaultInput.fromHex('0xffff'));
  /// print(value); // 65535
  /// ```
  @override
  int decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// Decode a unsigned 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U16.decodeFromInput(DefaultInput.fromHex('0x0000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U16.decodeFromInput(DefaultInput.fromHex('0xffff'));
  /// print(value); // 65535
  /// ```
  static int decodeFromInput(Input input) {
    return input.byte() + (input.byte() << 8);
  }

  ///
  /// Encodes a unsigned 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U16');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 0);
  /// print(encoder.toHex()); // 0000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U16');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 65535);
  /// print(encoder.toHex()); // ffff
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U16.encodeToEncoder(encoder, 0);
  /// print(encoder.toHex()); // 0x0000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// U16.encodeToEncoder(encoder, 65535);
  /// print(encoder.toHex()); // 0xffff
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < 0 || value > 65535) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 65535, but found: $value');
    }

    encoder.writeBytes(<int>[value & 0xff, value >>> 8]);
  }
}
