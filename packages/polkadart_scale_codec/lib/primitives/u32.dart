part of primitives;

class U32Codec with Codec<int> {
  const U32Codec._();

  static const U32Codec codec = U32Codec._();

  @override
  void encodeTo(int value, Output output) {
    assertion(value >= 0 && value <= 0xFFFFFFFF);
    output
      ..pushByte(value.toUnsigned(8))
      ..pushByte((value >> 8).toUnsigned(8))
      ..pushByte((value >> 16).toUnsigned(8))
      ..pushByte((value >> 24).toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read() |
        (input.read() << 8) |
        (input.read() << 16) |
        (input.read() << 24);
  }

  @override
  int sizeHint(int value) {
    return 4;
  }
}

class U32SequenceCodec with Codec<Uint32List> {
  const U32SequenceCodec._();

  static const U32SequenceCodec codec = U32SequenceCodec._();

  @override
  Uint32List decode(Input input) {
    final length = CompactCodec.codec.decode(input).toInt();
    final list = Uint32List(length);
    for (var i = 0; i < length; i++) {
      list[i] = U32Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Uint32List list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      U32Codec.codec.encodeTo(value, output);
    }
  }

  @override
  int sizeHint(Uint32List list) {
    return CompactCodec.codec.sizeHint(list.length) + list.lengthInBytes;
  }
}

class U32ArrayCodec with Codec<Uint32List> {
  final int length;
  const U32ArrayCodec(this.length);

  @override
  Uint32List decode(Input input) {
    final list = Uint32List(length);
    for (var i = 0; i < length; i++) {
      list[i] = U32Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Uint32List list, Output output) {
    if (list.length != length) {
      throw Exception(
          "U32ArrayCodec: invalid length, expect $length found ${list.length}");
    }
    for (var i = 0; i < length; i++) {
      U32Codec.codec.encodeTo(list[i], output);
    }
  }

  @override
  int sizeHint(Uint32List list) {
    return length * 4;
  }
}
