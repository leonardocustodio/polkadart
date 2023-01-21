part of codec_types;

///
/// encode/decode unsigned 128 bit integer
class U128 extends Codec<BigInt> {
  ///
  /// constructor
  U128._() : super(registry: Registry());

  ///
  /// Decode a unsigned 128 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128', input: Input('0x00000000000000000000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128', input: Input('0xffffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 340282366920938463463374607431768211455
  /// ```
  @override
  BigInt decode() {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 128 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U128.decodeFromInput(Input('0x00000000000000000000000000000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U128.decodeFromInput(Input('0xffffffffffffffffffffffffffffffff'));
  /// print(value); // 340282366920938463463374607431768211455
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U64.decodeFromInput(input);
    final high = U64.decodeFromInput(input);
    return low + (high << 64);
  }

  ///
  /// Encodes a unsigned 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128');
  /// final value = codec.encode(BigInt.from(0));
  /// print(value); // 00000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128');
  /// final value = codec.encode(BigInt.parse('340282366920938463463374607431768211455'));
  /// print(value); // ffffffffffffffffffffffffffffffff
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 128 bit integer
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = U128.encodeToEncoder(encoder, BigInt.from(0));
  /// print(value); // 00000000000000000000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final encoder = HexEncoder();
  /// final value = U128.encodeToEncoder(encoder, BigInt.parse('340282366920938463463374607431768211455'));
  /// print(value); // ffffffffffffffffffffffffffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.zero ||
        value > BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16)) {
      throw UnexpectedCaseException(
          'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffff"), but found: $value');
    }

    U64.encodeToEncoder(
        encoder, value & BigInt.parse('ffffffffffffffff', radix: 16));
    U64.encodeToEncoder(encoder, value >> 64);
  }
}
