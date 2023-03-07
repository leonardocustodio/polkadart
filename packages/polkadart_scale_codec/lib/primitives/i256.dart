part of primitives;

class I256Codec with Codec<BigInt> {
  const I256Codec._();

  static const I256Codec codec = I256Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    if (value <
            BigInt.parse(
                '-57896044618658097711785492504343953926634992332820282019728792003956564819968') ||
        value >
            BigInt.parse(
                '57896044618658097711785492504343953926634992332820282019728792003956564819967')) {
      throw OutOfBoundsException();
    }
    U256Codec.codec.encodeTo(value.toUnsigned(256), output);
  }

  @override
  BigInt decode(Input input) {
    return U256Codec.codec.decode(input).toSigned(256);
  }

  @override
  int sizeHint(BigInt value) {
    return 32;
  }
}
