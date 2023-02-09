part of primitives;

class H256Codec with Codec<Uint8List> {
  const H256Codec._();

  static final H256Codec instance = H256Codec._();

  @override
  void encodeTo(Uint8List value, Output output) {
    if (value.length != 32) {
      throw Exception('Invalid H256 length: ${value.length}');
    }
    output.write(value);
  }

  @override
  Uint8List decode(Input input) {
    return input.readBytes(32);
  }
}
