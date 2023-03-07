part of primitives;

class U256Codec with Codec<BigInt> {
  const U256Codec._();

  static const U256Codec codec = U256Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    U128Codec.codec
      ..encodeTo(
          (value & BigInt.parse('ffffffffffffffffffffffffffffffff', radix: 16))
              .toUnsigned(128),
          output)
      ..encodeTo((value >> 128).toUnsigned(128), output);
  }

  @override
  BigInt decode(Input input) {
    final low = U128Codec.codec.decode(input);
    final high = U128Codec.codec.decode(input);
    return low | (high << 128);
  }

  @override
  int sizeHint(BigInt value) {
    return 32;
  }
}
