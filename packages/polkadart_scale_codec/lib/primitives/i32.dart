part of primitives;

class I32Codec with Codec<int> {
  const I32Codec._();

  static final I32Codec instance = I32Codec._();

  @override
  void encodeTo(int element, Output output) {
    assert(element >= -0x80000000 && element <= 0x7FFFFFFF, 'Out of bounds');
    U32Codec.instance.encodeTo(element.toUnsigned(32), output);
  }

  @override
  int decode(Input input) {
    return U32Codec.instance.decode(input).toSigned(32);
  }

  @override
  int sizeHint(int element) {
    return 4;
  }
}
