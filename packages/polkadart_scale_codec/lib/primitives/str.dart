part of primitives;

class StrCodec with Codec<String> {
  const StrCodec._();

  static const StrCodec instance = StrCodec._();

  @override
  void encodeTo(String value, Output output) {
    final utf8str = utf8.encode(value);
    CompactCodec.instance.encodeTo(utf8str.length, output);
    for (final charCode in utf8str) {
      U8Codec.codec.encodeTo(charCode, output);
    }
  }

  @override
  String decode(Input input) {
    final size = CompactCodec.instance.decode(input).toInt();
    final bytes = input.readBytes(size).toList();
    return utf8.decode(bytes);
  }

  @override
  int sizeHint(String value) {
    var size = CompactCodec.instance.sizeHint(value.length);
    size += utf8.encode(value).length;
    return size;
  }
}
