part of primitives;

class U64Codec with Codec<BigInt> {
  const U64Codec._();

  static final U64Codec instance = U64Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    U32Codec.instance
      ..encodeTo(value.toUnsigned(32).toInt(), output)
      ..encodeTo((value >> 32).toUnsigned(32).toInt(), output);
  }

  @override
  BigInt decode(Input input) {
    final low = U32Codec.instance.decode(input);
    final high = U32Codec.instance.decode(input);
    return BigInt.from(low) | (BigInt.from(high) << 32);
  }

  @override
  int sizeHint(BigInt value) {
    return 8;
  }
}
