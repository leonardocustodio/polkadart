part of codec_types;

///
/// encode/decode unsigned 256 bit integer
class U256 extends Codec<BigInt> {
  ///
  /// constructor
  U256({Registry? registry}) : super(registry: registry ?? Registry());

  ///
  /// Decode a unsigned 256 bit integer from the source
  /// 
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256', data: Source('0x0000000000000000000000000000000000000000000000000000000000000000'));
  /// final value = codec.decode();
  /// print(value); // 0
  /// 
  /// Example:
  /// ```dart
  /// final codec = Codec<BigInt>().createTypeCodec('U256', data: Source('0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'));
  /// final value = codec.decode();
  /// print(value); // 115792089237316195423570985008687907853269984665640564039457584007913129639935
  /// ```
  @override
  BigInt decode() {
    final BigInt low = super.createTypeCodec('U128', data: data).decode();
    final BigInt high = super.createTypeCodec('U128', data: data).decode();
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
  String encode(BigInt value) {
    if (value.toInt() >= 0 &&
        value <=
            BigInt.parse(
                'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
                radix: 16)) {
      final low = super.createTypeCodec('U128');
      final high = super.createTypeCodec('U128');
      return low.encode(value &
              BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16)) +
          high.encode(value >> 128);
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and BigInt.parse("ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), but found: $value');
  }
}
