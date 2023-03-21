part of primitives;

class I16Codec with Codec<int> {
  const I16Codec._();

  static const I16Codec codec = I16Codec._();

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

class I16SequenceCodec with Codec<List<int>> {
  const I16SequenceCodec._();

  static const I16SequenceCodec codec = I16SequenceCodec._();

  @override
  Int16Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Int16Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = I16Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      I16Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length * 2;
  }
}

class I16ArrayCodec with Codec<List<int>> {
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
  void encodeTo(List<int> value, Output output) {
    if (value.length != length) {
      throw Exception(
          'I16ArrayCodec: invalid length, expect $length found ${value.length}');
    }
    for (final val in value) {
      I16Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return length * 2;
  }
}
