part of primitives;

class U32Codec with Codec<int> {
  const U32Codec._();

  static final U32Codec instance = U32Codec._();

  @override
  void encodeTo(int element, Output output) {
    assert(element >= 0 && element <= 0xFFFFFFFF);
    output
      ..pushByte(element.toUnsigned(8))
      ..pushByte((element >> 8).toUnsigned(8))
      ..pushByte((element >> 16).toUnsigned(8))
      ..pushByte((element >> 24).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() |
        (input.read() << 8) |
        (input.read() << 16) |
        (input.read() << 24);
  }

  @override
  int sizeHint(int element) {
    return 4;
  }
}
