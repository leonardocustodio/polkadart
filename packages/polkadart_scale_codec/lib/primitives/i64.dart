part of primitives;

class I64Codec with Codec<BigInt> {
  const I64Codec._();

  static final I64Codec instance = I64Codec._();

  @override
  void encodeTo(BigInt element, Output output) {
    assert(
        element >= BigInt.from(-0x80000000) &&
            element <= BigInt.from(0x7FFFFFFF),
        'Out of bounds');
    U64Codec.instance.encodeTo(element.toUnsigned(64), output);
  }

  @override
  BigInt decode(Input input) {
    return U64Codec.instance.decode(input).toSigned(64);
  }

  @override
  int sizeHint(BigInt element) {
    return 8;
  }
}
