part of primitives;

class U16Codec with Codec<int> {
  const U16Codec._();

  static final U16Codec instance = U16Codec._();

  @override
  void encodeTo(int element, Output output) {
    output
      ..pushByte(element.toUnsigned(8))
      ..pushByte((element >> 8).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() | (input.read() << 8);
  }

  @override
  int sizeHint(int element) {
    return 2;
  }
}
