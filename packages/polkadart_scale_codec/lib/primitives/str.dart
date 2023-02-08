part of primitives;

// UT16 -> UTF-8
class StrCodec<A> with Codec<String> {
  const StrCodec._();

  static final StrCodec instance = StrCodec._();

  @override
  void encodeTo(String value, Output output) {
    final list = value.codeUnits;
    CompactCodec.instance.encodeTo(list.length, output);
    for (final charCode in list) {
      U8Codec.instance.encodeTo(charCode, output);
    }
  }

  @override
  String decode(Input input) {
    final size = CompactCodec.instance.decode(input).toInt();
    final elements = input.readBytes(size).toList();
    return String.fromCharCodes(elements);
  }

  @override
  int sizeHint(String value) {
    var size = CompactCodec.instance.sizeHint(value.length);
    size += value.codeUnits.length;
    return size;
  }
}
