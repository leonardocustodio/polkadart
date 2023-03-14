part of primitives;

class U16Codec with Codec<int> {
  const U16Codec._();

  static const U16Codec codec = U16Codec._();

  @override
  void encodeTo(int value, Output output) {
    output
      ..pushByte(value.toUnsigned(8))
      ..pushByte((value >> 8).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() | (input.read() << 8);
  }

  @override
  int sizeHint(int value) {
    return 2;
  }
}

class U16SequenceCodec with Codec<List<int>> {
  const U16SequenceCodec._();

  static const U16SequenceCodec codec = U16SequenceCodec._();

  @override
  Uint16Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Uint16Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = U16Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      U16Codec.codec.encodeTo(value, output);
    }
  }

  @override
  int sizeHint(List<int> list) {
    return CompactCodec.codec.sizeHint(list.length) + list.length * 2;
  }
}

class U16ArrayCodec with Codec<List<int>> {
  final int length;
  const U16ArrayCodec(this.length);

  @override
  Uint16List decode(Input input) {
    final list = Uint16List(length);
    for (var i = 0; i < length; i++) {
      list[i] = U16Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> list, Output output) {
    if (list.length != length) {
      throw Exception(
          'U16ArrayCodec: invalid length, expect $length found ${list.length}');
    }
    for (var i = 0; i < length; i++) {
      U16Codec.codec.encodeTo(list[i], output);
    }
  }

  @override
  int sizeHint(List<int> list) {
    return length * 2;
  }
}
