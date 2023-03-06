part of primitives;

class I64Codec with Codec<BigInt> {
  const I64Codec._();

  static final I64Codec codec = I64Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    if (value < BigInt.from(-9223372036854775808) ||
        value > BigInt.from(9223372036854775807)) {
      throw OutOfBoundsException();
    }
    U64Codec.codec.encodeTo(value.toUnsigned(64), output);
  }

  @override
  BigInt decode(Input input) {
    return U64Codec.codec.decode(input).toSigned(64);
  }

  @override
  int sizeHint(BigInt value) {
    return 8;
  }
}
