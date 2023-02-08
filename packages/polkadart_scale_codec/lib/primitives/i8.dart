part of primitives;

class I8Codec with Codec<int> {
  const I8Codec._();

  static final I8Codec instance = I8Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -128 || value > 0x7F) {
      throw OutOfBoundsException();
    }
    output.pushByte(value.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read().toSigned(8);
  }

  @override
  int sizeHint(int value) {
    return 1;
  }
}
