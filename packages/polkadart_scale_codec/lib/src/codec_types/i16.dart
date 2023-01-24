part of codec_types;

///
/// I16 to encode/decode signed 16 bit integer
class I16 extends Codec<int> {
  ///
  /// constructor
  I16._() : super(registry: Registry());

  ///
  /// [static] Create a new instance of I16
  @override
  I16 copyWith(Codec codec) {
    return copyProperties(codec, I16._()) as I16;
  }

  ///
  /// Decode a signed 16 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16', input: Input('0x0080'));
  /// final value = codec.decode();
  /// print(value); // -32768
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16', input: Input('0xff7f'));
  /// final value = codec.decode();
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
  /// final value = I16.decodeFromInput(input: Input('0x0080'));
  /// print(value); // -32768
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I16.decodeFromInput(input: Input('0xff7f'));
  /// print(value); // 32767
  /// ```
  static int decodeFromInput(Input input) {
    final value = bytesToLittleEndianInt(input.bytes(2).toList());
    return (value | (value & (1 << 15)) * 0x1fffe).toSigned(16);
  }

  ///
  /// Encodes a signed 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16');
  /// final value = codec.encode(-32768);
  /// print(value); // 0080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<int>().createTypeCodec('I16');
  /// final value = codec.encode(32767);
  /// print(value); // ff7f
  /// ```
  @override
  void encode(Encoder encoder, int value) {
    encodeTo(encoder, value);
  }

  ///
  /// [static] Encodes a signed 16 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = I16.encodeToBytes(encoder, -32768);
  /// print(encoder.toHex()); // 0080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = I16.encodeToBytes(encoder, 32767);
  /// print(encoder.toHex()); // ff7f
  /// ```
  static void encodeTo(Encoder encoder, int value) {
    if (value < -32768 || value > 32767) {
      throw UnexpectedCaseException(
          'Expected value between -32768 and 32767, but found: $value');
    }

    final base = (value + 65536) % 65536;
    encoder.writeBytes(<int>[base & 0xff, base >>> 8]);
  }
}
