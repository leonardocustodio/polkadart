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

class U32SequenceCodec with Codec<List<int>> {
  const U32SequenceCodec._();

  static const U32SequenceCodec codec = U32SequenceCodec._();

  @override
  Uint32Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Uint32Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = U32Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      U32Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length * 4;
  }
}

class U32ArrayCodec with Codec<List<int>> {
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
  void encodeTo(List<int> value, Output output) {
    if (value.length != length) {
      throw Exception(
          'U32ArrayCodec: invalid length, expect $length found ${value.length}');
    }
    for (final val in value) {
      U32Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return length * 4;
  }
}
