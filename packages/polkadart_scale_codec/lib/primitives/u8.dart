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

class U8SequenceCodec with Codec<Uint8List> {
  const U8SequenceCodec._();

  static const U8SequenceCodec codec = U8SequenceCodec._();

  @override
  Uint8List decode(Input input) {
    final length = CompactCodec.codec.decode(input).toInt();
    final list = Uint8List(length);
    for (var i = 0; i < length; i++) {
      list[i] = U8Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Uint8List list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      U8Codec.codec.encodeTo(value, output);
    }
  }

  @override
  int sizeHint(Uint8List list) {
    return CompactCodec.codec.sizeHint(list.length) + list.lengthInBytes;
  }
}

class U8ArrayCodec with Codec<Uint8List> {
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
  void encodeTo(Uint8List list, Output output) {
    if (list.length != length) {
      throw Exception(
          'U8ArrayCodec: invalid length, expect $length found ${list.length}');
    }
    for (var i = 0; i < length; i++) {
      U8Codec.codec.encodeTo(list[i], output);
    }
  }

  @override
  int sizeHint(Uint8List list) {
    return length;
  }
}
