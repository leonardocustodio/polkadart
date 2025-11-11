part of primitives;

class BoolCodec with Codec<bool> {
  const BoolCodec._();

  static const BoolCodec codec = BoolCodec._();

  @override
  void encodeTo(bool value, Output output) {
    return output.pushByte(value ? 1 : 0);
  }

  @override
  bool decode(Input input) {
    return input.read() > 0;
  }

  @override
  int sizeHint(bool value) {
    return 1;
  }

  @override
  bool isSizeZero() {
    // Bool always encodes to 1 byte (0 or 1)
    return false;
  }
}
