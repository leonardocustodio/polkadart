part of codec_types;

///
/// encode/decode unsigned 32 bit integer
class U32 extends Codec<int> {
  ///
  /// constructor
  U32._() : super(registry: Registry());

  ///
  /// Decode a unsigned 32 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32', input: Input('0x00000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U32', input: Input('0xffffffff'));
  /// final value = codec.decode();
  /// print(value); // 4294967295
  /// ```
  @override
  int decode() {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 32 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U32.decodeFromInput(Input('0x00000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U32.decodeFromInput(Input('0xffffffff'));
  /// print(value); // 4294967295
  /// ```
  static int decodeFromInput(Input input) {
    return bytesToLittleEndianInt(input.bytes(4).toList());
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