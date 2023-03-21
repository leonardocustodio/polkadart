part of primitives;

class I8Codec with Codec<int> {
  const I8Codec._();

  static const I8Codec codec = I8Codec._();

  @override
  void encodeTo(int value, Output output) {
    if (value < -128 || value > 0x7F) {
      throw OutOfBoundsException();
    }
    output.pushByte(value.toUnsigned(8));
  }

  @override
  int decode(Input input) {
    return input.read().toSigned(8);
  }

  @override
  int sizeHint(int value) {
    return 1;
  }
}

class I8SequenceCodec with Codec<List<int>> {
  const I8SequenceCodec._();

  static const I8SequenceCodec codec = I8SequenceCodec._();

  @override
  Int8Buffer decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = Int8Buffer(length);
    for (var i = 0; i < length; i++) {
      list[i] = I8Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<int> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      I8Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<int> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length;
  }
}

class I8ArrayCodec with Codec<Int8List> {
  final int length;
  const I8ArrayCodec(this.length);

  @override
  Int8List decode(Input input) {
    final list = Int8List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I8Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(Int8List value, Output output) {
    if (value.length != length) {
      throw Exception(
          'I8ArrayCodec: invalid length, expect $length found ${value.length}');
    }
    for (final val in value) {
      I8Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(Int8List value) {
    return length;
  }
}
