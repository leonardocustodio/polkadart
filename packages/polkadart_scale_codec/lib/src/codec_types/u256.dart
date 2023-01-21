part of codec_types;

///
/// encode/decode unsigned 256 bit integer
class U256 extends Codec<BigInt> {
  ///
  /// constructor
  U256._() : super(registry: Registry());

  ///
  /// Decode a unsigned 256 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256', input: Input('0x0000000000000000000000000000000000000000000000000000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256', input: Input('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 115792089237316195423570985008687907853269984665640564039457584007913129639935
  /// ```
  @override
  BigInt decode() {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 256 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U256.decodeFromInput(Input('0x0000000000000000000000000000000000000000000000000000000000000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U256.decodeFromInput(Input('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  /// print(value); // 115792089237316195423570985008687907853269984665640564039457584007913129639935
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U128.decodeFromInput(input);
    final high = U128.decodeFromInput(input);
    return low + (high << 128);
  }

  ///
  /// Encodes a unsigned 256 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256');
  /// final value = codec.encode(BigInt.from(0));
  /// print(value); // 0000000000000000000000000000000000000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256');
  /// final value = codec.encode(BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'));
  /// print(value); // ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 256 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = U256.encodeToEncoder(encoder, BigInt.from(0));
  /// print(value); // 0000000000000000000000000000000000000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = U256.encodeToEncoder(encoder, BigInt.parse('115792089237316195423570985008687907853269984665640564039457584007913129639935'));
  /// print(value); // ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.zero ||
        value >
            BigInt.parse(
                'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
                radix: 16)) {
      throw UnexpectedCaseException(
          'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), but found: $value');
    }

    U128.encodeToEncoder(encoder,
        value & BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16));
    U128.encodeToEncoder(encoder, value >> 128);
  }
}
