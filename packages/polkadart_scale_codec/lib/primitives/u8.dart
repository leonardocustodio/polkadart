part of primitives;

class U8Codec with Codec<int> {
  const U8Codec._();

  static final U8Codec instance = U8Codec._();

  @override
  void encodeTo(int element, Output output) {
    assert(element >= 0 && element <= 0xFF);
    return output.pushByte(element.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read();
  }

  @override
  int sizeHint(int element) {
    return 1;
  }
}
