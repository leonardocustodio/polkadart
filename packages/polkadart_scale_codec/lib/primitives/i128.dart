part of primitives;

class I128Codec with Codec<BigInt> {
  const I128Codec._();

  static final I128Codec instance = I128Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    if (value < BigInt.parse('-170141183460469231731687303715884105728') ||
        value > BigInt.parse('170141183460469231731687303715884105727')) {
      throw OutOfBoundsException();
    }
    U128Codec.instance.encodeTo(value.toUnsigned(128), output);
  }

  @override
  BigInt decode(Input input) {
    return U128Codec.instance.decode(input).toSigned(128);
  }

  @override
  int sizeHint(BigInt value) {
    return 16;
  }
}