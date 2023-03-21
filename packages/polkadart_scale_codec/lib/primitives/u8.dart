part of primitives;

class U8Codec with Codec<int> {
  const U8Codec._();

  static const U8Codec codec = U8Codec._();

  @override
  void encodeTo(int value, Output output) {
    assertion(value >= 0 && value <= 0xFF);
    return output.pushByte(value.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read();
  }

  @override
  int sizeHint(int value) {
    return 1;
  }
}

class U8SequenceCodec with Codec<List<int>> {
  const U8SequenceCodec._();

  static const U8SequenceCodec codec = U8SequenceCodec._();

  @override
  Uint8Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Uint8Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = U8Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      U8Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length;
  }
}

class U8ArrayCodec with Codec<List<int>> {
  final int length;
  const U8ArrayCodec(this.length);

  @override
  Uint8List decode(Input input) {
    final list = Uint8List(length);
    for (var i = 0; i < length; i++) {
      list[i] = U8Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> value, Output output) {
    if (value.length != length) {
      throw Exception(
          'U8ArrayCodec: invalid length, expect $length found ${value.length}');
    }
    for (final val in value) {
      U8Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return length;
  }
}
