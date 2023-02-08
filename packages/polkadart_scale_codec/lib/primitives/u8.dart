part of primitives;

class U8Codec with Codec<int> {
  const U8Codec._();

  static final U8Codec instance = U8Codec._();

  @override
  void encodeTo(int value, Output output) {
    assertion(value >= 0 && value <= 0xFF);
    return output.pushByte(value.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read();
  }

  @override
  int sizeHint(int value) {
    return 1;
  }
}
