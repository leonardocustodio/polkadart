part of primitives;

class I16Codec with Codec<int> {
  const I16Codec._();

  static final I16Codec instance = I16Codec._();

  @override
  void encodeTo(int element, Output output) {
    assert(element >= -0x8000 && element <= 0x7FFF);
    U16Codec.instance.encodeTo(element.toUnsigned(16), output);
  }

  @override
  int decode(Input input) {
    return U16Codec.instance.decode(input).toSigned(16);
  }

  @override
  int sizeHint(int element) {
    return 2;
  }
}
