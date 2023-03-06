part of primitives;

class U128Codec with Codec<BigInt> {
  const U128Codec._();

  static const U128Codec codec = U128Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    U64Codec.codec
      ..encodeTo(value.toUnsigned(64), output)
      ..encodeTo((value >> 64).toUnsigned(64), output);
  }

  @override
  BigInt decode(Input input) {
    final low = U64Codec.codec.decode(input);
    final high = U64Codec.codec.decode(input);
    return low | (high << 64);
  }

  @override
  int sizeHint(BigInt value) {
    return 16;
  }
}
