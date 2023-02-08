part of primitives;

class BoolCodec with Codec<bool> {
  const BoolCodec._();

  static final BoolCodec instance = BoolCodec._();

  @override
  void encodeTo(bool element, Output output) {
    return output.pushByte(element ? 1 : 0);
  }

  @override
  bool decode(Input input) {
    return input.read() > 0;
  }

  @override
  int sizeHint(bool element) {
    return 1;
  }
}
