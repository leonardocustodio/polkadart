part of codec_types;

///
/// encode/decode unsigned 32 bit integer
class U32 extends Uint<int> {
  ///
  /// constructor
  U32._() : super._();

  ///
  /// [static] returns a new instance of U32
  @override
  U32 freshInstance() => U32._();

  ///
  /// Decode a unsigned 32 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U32');
  /// final value = codec.decode(DefaultInput.fromHex('0x00000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U32');
  /// final value = codec.decode(DefaultInput.fromHex('0xffffffff'));
  /// print(value); // 4294967295
  /// ```
  @override
  int decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 32 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U32.decodeFromInput(DefaultInput.fromHex('0x00000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U32.decodeFromInput(DefaultInput.fromHex('0xffffffff'));
  /// print(value); // 4294967295
  /// ```
  static int decodeFromInput(Input input) {
    return input.byte() +
        (input.byte() << 8) +
        (input.byte() << 16) +
        (input.byte() << 24);
  }

  ///
  /// Encodes a unsigned 32 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U32');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 0);
  /// print(encoder.toHex()); // 00000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('U32');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 4294967295);
  /// print(encoder.toHex()); // ffffffff
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 32 bit integer
  ///
  /// Example:
  /// ```dart
  /// final value = U32.encodeToEncoder(0);
  /// print(value); // 00000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U32.encodeToEncoder(4294967295);
  /// print(value); // ffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < 0 || value > 4294967295) {
      throw UnexpectedCaseException(
          'Expected value between 0 and 4294967295, but found: $value');
    }

    encoder.writeBytes(<int>[
      value & 0xff,
      (value >>> 8) & 0xff,
      (value >>> 16) & 0xff,
      value >>> 24
    ]);
  }
}
