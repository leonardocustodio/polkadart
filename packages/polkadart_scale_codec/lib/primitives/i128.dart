part of primitives;

class I128Codec with Codec<BigInt> {
  const I128Codec._();

  static final I128Codec instance = I128Codec._();

  @override
  void encodeTo(BigInt element, Output output) {
    U128Codec.instance.encodeTo(element.toUnsigned(128), output);
  }

  @override
  BigInt decode(Input input) {
    return U128Codec.instance.decode(input).toSigned(128);
  }

  @override
  int sizeHint(BigInt element) {
    return 16;
  }
}
