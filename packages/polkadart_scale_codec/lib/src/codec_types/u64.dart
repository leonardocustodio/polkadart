part of codec_types;

///
/// encode/decode unsigned 64 bit integer
class U64 extends Codec<BigInt> {
  ///
  /// constructor
  U64._() : super(registry: Registry());

  ///
  /// Decode a unsigned 64 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64', input: Input('0x0000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64', input: Input('0xffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 18446744073709551615
  /// ```
  @override
  BigInt decode() {
    return decodeFromInput(input);
  }

  ///
  /// [static] Decode a unsigned 64 bit integer from the input
  ///
  /// Example:
  /// ```dart
  /// final value = U64.decodeFromInput(Input('0x0000000000000000'));
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U64.decodeFromInput(Input('0xffffffffffffffff'));
  /// print(value); // 18446744073709551615
  /// ```
  static BigInt decodeFromInput(Input input) {
    final low = U32.decodeFromInput(input);
    final high = U32.decodeFromInput(input);
    return BigInt.from(low) + (BigInt.from(high) << 32);
  }

  ///
  /// Encodes a unsigned 64 bit integer
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64');
  /// final value = codec.encode(BigInt.from(0));
  /// print(value); // 0000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64');
  /// final value = codec.encode(BigInt.parse('18446744073709551615'));
  /// print(value); // ffffffffffffffff
  /// ```
  @override
  void encode(Encoder encoder, BigInt value) {
    encodeToEncoder(encoder, value);
  }

  ///
  /// [static] Encodes a unsigned 64 bit integer
  ///
  /// Example:
  /// ```dart
  /// final value = U64.encodeToEncoder(BigInt.from(0));
  /// print(value); // 0000000000000000
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final value = U64.encodeToEncoder(BigInt.parse('18446744073709551615'));
  /// print(value); // ffffffffffffffff
  /// ```
  static void encodeToEncoder(Encoder encoder, BigInt value) {
    if (value < BigInt.zero || value > BigInt.parse('18446744073709551615')) {
      throw UnexpectedCaseException(
          'Expected value between 0 and BigInt.parse("18446744073709551615"), but found: $value');
    }

    U32.encodeToEncoder(encoder, (value & BigInt.from(0xffffffff)).toInt());
    U32.encodeToEncoder(encoder, (value >> 32).toInt());
  }
}
