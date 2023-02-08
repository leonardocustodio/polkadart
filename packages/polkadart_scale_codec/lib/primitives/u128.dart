part of primitives;

class U128Codec with Codec<BigInt> {
  const U128Codec._();

  static final U128Codec instance = U128Codec._();

  @override
  void encodeTo(BigInt element, Output output) {
    U64Codec.instance
      ..encodeTo(element.toUnsigned(64), output)
      ..encodeTo((element >> 64).toUnsigned(64), output);
  }

  @override
  BigInt decode(Input input) {
    final low = U64Codec.instance.decode(input);
    final high = U64Codec.instance.decode(input);
    return low | (high << 64);
  }

  @override
  int sizeHint(BigInt element) {
    return 16;
  }
}
