part of primitives;

class I16Codec with Codec<int> {
  const I16Codec._();

  static final I16Codec instance = I16Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -0x8000 || value > 0x7FFF) {
      throw OutOfBoundsException();
    }
    U16Codec.instance.encodeTo(value.toUnsigned(16), output);
  }

  @override
  int decode(Input input) {
    return U16Codec.instance.decode(input).toSigned(16);
  }

  @override
  int sizeHint(int value) {
    return 2;
  }
}
