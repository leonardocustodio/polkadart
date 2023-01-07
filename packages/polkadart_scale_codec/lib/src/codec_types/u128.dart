part of codec_types;

///
/// encode/decode unsigned 128 bit integer
class U128 extends Codec<BigInt> {
  ///
  /// constructor
  U128({Registry? registry}) : super(registry: registry ?? Registry());

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
    final BigInt low = super.createTypeCodec('U64', data: data).decode();
    final BigInt high = super.createTypeCodec('U64', data: data).decode();
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
  String encode(BigInt value) {
    if (value.toInt() >= 0 &&
        value <= BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16)) {
      final low = super.createTypeCodec('U64');
      final high = super.createTypeCodec('U64');
      return low.encode(value & BigInt.parse('ffffffffffffffff', radix: 16)) +
          high.encode(value >> 64);
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffff"), but found: $value');
  }
}
