part of primitives;

class U32Codec with Codec<int> {
  const U32Codec._();

  static final U32Codec codec = U32Codec._();

  @override
  void encodeTo(int value, Output output) {
    assertion(value >= 0 && value <= 0xFFFFFFFF);
    output
      ..pushByte(value.toUnsigned(8))
      ..pushByte((value >> 8).toUnsigned(8))
      ..pushByte((value >> 16).toUnsigned(8))
      ..pushByte((value >> 24).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() |
        (input.read() << 8) |
        (input.read() << 16) |
        (input.read() << 24);
  }

  @override
  int sizeHint(int value) {
    return 4;
  }
}
