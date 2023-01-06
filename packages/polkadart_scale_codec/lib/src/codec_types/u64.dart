part of codec_types;

///
/// encode/decode unsigned 64 bit integer
class U64 extends Codec<BigInt> {
  ///
  /// constructor
  U64({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 64 bit integer from the source
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64', data: Source('0x0000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64', data: Source('0x0000000000000001'));
  /// final value = codec.decode();
  /// print(value); // 1
  /// ```
  @override
  BigInt decode() {
    final low = super.createTypeCodec('U32', data: data).decode();
    final high = super.createTypeCodec('U32', data: data).decode();
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
  /// final value = codec.encode(BigInt.from(1));
  /// print(value); // 0000000000000001
  /// ```
  ///
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U64');
  /// final value = codec.encode(BigInt.parse('18446744073709551615'));
  /// print(value); // ffffffffffffffff
  /// ```
  @override
  String encode(BigInt value) {
    if (value.toInt() >= 0 && value <= BigInt.parse('18446744073709551615')) {
      final low = super.createTypeCodec('U32');
      final high = super.createTypeCodec('U32');
      return low.encode((value & BigInt.from(0xffffffff)).toInt()) +
          high.encode((value >> 32).toInt());
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and BigInt.parse("18446744073709551615"), but found: $value');
  }
}
