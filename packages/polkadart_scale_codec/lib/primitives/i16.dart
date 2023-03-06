part of primitives;

class I16Codec with Codec<int> {
  const I16Codec._();

  static final I16Codec codec = I16Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -0x8000 || value > 0x7FFF) {
      throw OutOfBoundsException();
    }
    U16Codec.codec.encodeTo(value.toUnsigned(16), output);
  }

  @override
  int decode(Input input) {
    return U16Codec.codec.decode(input).toSigned(16);
  }

  @override
  int sizeHint(int value) {
    return 2;
  }
}

class I16SequenceCodec with Codec<Int16List> {
  const I16SequenceCodec._();

  static const I16SequenceCodec codec = I16SequenceCodec._();

  @override
  Int16List decode(Input input) {
    final length = CompactCodec.codec.decode(input).toInt();
    final list = Int16List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I16Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Int16List list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      I16Codec.codec.encodeTo(value, output);
    }
  }

  @override
  int sizeHint(Int16List list) {
    return CompactCodec.codec.sizeHint(list.length) + list.lengthInBytes;
  }
}

class I16ArrayCodec with Codec<Int16List> {
  final int length;
  const I16ArrayCodec(this.length);

  @override
  Int16List decode(Input input) {
    final list = Int16List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I16Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Int16List list, Output output) {
    if (list.length != length) {
      throw Exception(
          'I16ArrayCodec: invalid length, expect $length found ${list.length}');
    }
    for (var i = 0; i < length; i++) {
      I16Codec.codec.encodeTo(list[i], output);
    }
  }

  @override
  int sizeHint(Int16List list) {
    return length * 2;
  }
}
