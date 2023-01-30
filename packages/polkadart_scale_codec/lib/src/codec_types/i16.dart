part of codec_types;

///
/// I16 to encode/decode signed 16 bit integer
class I16 extends Codec<int> {
  ///
  /// constructor
  I16._() : super(registry: Registry());

  ///
  /// Decode a signed 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('I16');
  /// final value = codec.decode(DefaultInput.fromHex('0x0080'));
  /// print(value); // -32768
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('I16');
  /// final value = codec.decode(DefaultInput.fromHex('0xff7f'));
  /// print(value); // 32767
  /// ```
  @override
  int decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 16 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = I16.decodeFromInput(input: DefaultInput.fromHex('0x0080'));
  /// print(value); // -32768
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I16.decodeFromInput(input: DefaultInput.fromHex('0xff7f'));
  /// print(value); // 32767
  /// ```
  static int decodeFromInput(Input input) {
    final value = U16.decodeFromInput(input);
    return (value | (value & (1 << 15)) * 0x1fffe).toSigned(16);
  }

  ///
  /// Encodes a signed 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('I16');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, -32768);
  /// print(encoder.toHex()); // 0080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().fetchTypeCodec('I16');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, 32767);
  /// print(encoder.toHex()); // ff7f
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I16.encodeToEncoder(encoder, -32768);
  /// print(encoder.toHex()); // 0080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I16.encodeToEncoder(encoder, 32767);
  /// print(encoder.toHex()); // ff7f
  /// ```
  static void encodeToEncoder(Encoder encoder, int value) {
    if (value < -32768 || value > 32767) {
      throw UnexpectedCaseException(
          'Expected value between -32768 and 32767, but found: $value');
    }

    final base = (value + 65536) % 65536;
    encoder.writeBytes(<int>[base & 0xff, base >>> 8]);
  }
}
