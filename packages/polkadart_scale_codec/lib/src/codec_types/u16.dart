part of codec_types;

///
/// U16 to encode/decode unsigned 16 bit integer
class U16 extends Codec<int> {
  ///
  /// constructor
  U16._() : super(registry: Registry());

  ///
  /// Decode a unsigned 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16', input: Input('0x0000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16', input: Input('0xffff'));
  /// final value = codec.decode();
  /// print(value); // 65535
  /// ```
  @override
  int decode() {
    return decodeFromInput(input);
  }

  ///
  /// Decode a unsigned 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U16.decodeFromInput(Input('0x0000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U16.decodeFromInput(Input('0xffff'));
  /// print(value); // 65535
  /// ```
  static int decodeFromInput(Input input) {
    return bytesToLittleEndianInt(input.bytes(2).toList());
  }

  ///
  /// Encodes a unsigned 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16');
  /// final value = codec.encode(0);
  /// print(value); // 0000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('U16');
  /// final value = codec.encode(65535);
  /// print(value); // ffff
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