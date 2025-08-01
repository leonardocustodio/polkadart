part of primitives;

class StrCodec with Codec<String> {
  const StrCodec._();

  static const StrCodec codec = StrCodec._();

  @override
  void encodeTo(String value, Output output) {
    final utf8str = Uint8List.fromList(utf8.encode(value));
    CompactCodec.codec.encodeTo(utf8str.length, output);
    output.write(utf8str);
  }

  @override
  String decode(Input input) {
    final size = CompactCodec.codec.decode(input);
    final bytes = input.readBytes(size);
    final decoded = utf8.decode(bytes);
    // Strip trailing null bytes that may exist in fixed-length string fields
    final nullIndex = decoded.indexOf('\x00');
    return nullIndex == -1 ? decoded : decoded.substring(0, nullIndex);
  }

  @override
  int sizeHint(String value) {
    final bytes = utf8.encode(value);
    var size = CompactCodec.codec.sizeHint(bytes.length);
    size += bytes.length;
    return size;
  }
}
