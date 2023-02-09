part of primitives;

class BytesCodec with Codec<Uint8List> {
  const BytesCodec._();

  static final BytesCodec instance = BytesCodec._();

  @override
  Uint8List decode(Input input) {
    final length = CompactCodec.instance.decode(input);
    return input.readBytes(length);
  }

  @override
  void encodeTo(Uint8List value, Output output) {
    CompactCodec.instance.encodeTo(value.length, output);
    output.write(value);
  }
}
