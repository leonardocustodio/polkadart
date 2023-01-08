part of codec_types;

///
/// encode/decode unsigned 128 bit integer
class U128 extends Codec<BigInt> {
  final Source? source;

  ///
  /// constructor
  U128({Registry? registry, this.source})
      : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 128 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128', data: Source('0x00000000000000000000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U128', data: Source('0xffffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 340282366920938463463374607431768211455
  /// ```
  @override
  BigInt decode() {
    final u64Codec = U64(source: source ?? data);
    return u64Codec.decode() + (u64Codec.decode() << 64);
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
  String encode(BigInt value) {
    if (value < BigInt.zero ||
        value > BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16)) {
      throw UnexpectedCaseException(
          'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffff"), but found: $value');
    }

    final u64Codec = U64();
    return u64Codec
            .encode(value & BigInt.parse('ffffffffffffffff', radix: 16)) +
        u64Codec.encode(value >> 64);
  }
}
