part of codec_types;

///
/// encode/decode signed 64 bit integer
class I64 extends Codec<BigInt> {
  ///
  /// constructor
  I64._() : super(registry: Registry());

  ///
  /// [static] Create a properties-copied instance of I64
  @override
  I64 copyWith(Codec codec) {
    return copyProperties(codec, I64._()) as I64;
  }

  ///
  /// Decode a signed 64 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I64');
  /// final value = codec.decode(Input('0x0000000000000080'));
  /// print(value); // -9223372036854775808
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I64');
  /// final value = codec.decode(Input('0xffffffffffffff7f'));
  /// print(value); // 9223372036854775807
  /// ```
  @override
  BigInt decode(Input input) {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a signed 64 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = I64.decodeFromInput(Input('0x0000000000000080'));
  /// print(value); // -9223372036854775808
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = I64.decodeFromInput(Input('0xffffffffffffff7f'));
  /// print(value); // 9223372036854775807
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U32.decodeFromInput(input);
    final high = I32.decodeFromInput(input);
    return BigInt.from(low) + (BigInt.from(high) << 32);
  }

  ///
  /// Encodes a signed 64 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I64');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.from(-9223372036854775808));
  /// print(encoder.toHex()); // 0000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().fetchTypeCodec('I64');
  /// final encoder = HexEncoder();
  /// codec.encode(encoder, BigInt.from(9223372036854775807));
  /// print(encoder.toHex()); // ffffffffffffff7f
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a signed 64 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I64.encodeToEncoder(encoder, BigInt.from(-9223372036854775808));
  /// print(encoder.toHex()); // 0000000000000080
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// I64.encodeToEncoder(encoder, BigInt.from(9223372036854775807));
  /// print(encoder.toHex()); // ffffffffffffff7f
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.from(-9223372036854775808) ||
        value > BigInt.from(9223372036854775807)) {
      throw UnexpectedCaseException(
          'Expected value between BigInt.from(-9223372036854775808) and BigInt.from(9223372036854775807), but found: $value');
    }

    final base = BigInt.parse('18446744073709551616');
    final val = (value + base) % base;
    U64.encodeToEncoder(encoder, val);
  }
}
