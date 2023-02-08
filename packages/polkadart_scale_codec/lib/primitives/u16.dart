part of primitives;

class U16Codec with Codec<int> {
  const U16Codec._();

  static final U16Codec instance = U16Codec._();

  @override
  void encodeTo(int value, Output output) {
    output
      ..pushByte(value.toUnsigned(8))
      ..pushByte((value >> 8).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() | (input.read() << 8);
  }

  @override
  int sizeHint(int value) {
    return 2;
  }
}
