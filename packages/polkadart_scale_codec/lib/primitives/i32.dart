part of primitives;

class I32Codec with Codec<int> {
  const I32Codec._();

  static final I32Codec codec = I32Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -2147483648 || value > 2147483647) {
      throw OutOfBoundsException();
    }
    U32Codec.codec.encodeTo(value.toUnsigned(32), output);
  }

  @override
  int decode(Input input) {
    return U32Codec.codec.decode(input).toSigned(32);
  }

  @override
  int sizeHint(int value) {
    return 4;
  }
}
