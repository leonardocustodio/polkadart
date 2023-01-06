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
  @override
  BigInt decode() {
    final low = createTypeCodec('U32').decode();
    final high = createTypeCodec('U32').decode();
    return BigInt.from(low) + (BigInt.from(high) << 32);
  }

  ///
  /// Encodes a unsigned 64 bit integer
  @override
  String encode(BigInt value) {
    if (value >= 0 && value <= 4294967295) {
      return encodeHex(littleEndianIntToBytes(value, 4));
    }
    throw UnexpectedCaseException(
        'Expected value between 0 and 4294967295, but found: $value');
  }
}
