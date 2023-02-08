part of primitives;

class I8Codec with Codec<int> {
  const I8Codec._();

  static final I8Codec instance = I8Codec._();

  @override
  void encodeTo(int element, Output output) {
    assert(element >= -128 && element <= 0x7F);
    output.pushByte(element.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read().toSigned(8);
  }

  @override
  int sizeHint(int element) {
    return 1;
  }
}
