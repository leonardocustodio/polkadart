part of primitives;

class I64Codec with Codec<BigInt> {
  const I64Codec._();

  static const I64Codec codec = I64Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    if (value < BigInt.from(-9223372036854775808) ||
        value > BigInt.from(9223372036854775807)) {
      throw OutOfBoundsException();
    }
    U64Codec.codec.encodeTo(value.toUnsigned(64), output);
  }

  @override
  BigInt decode(Input input) {
    return U64Codec.codec.decode(input).toSigned(64);
  }

  @override
  int sizeHint(BigInt value) {
    return 8;
  }
}

class I64SequenceCodec with Codec<Int64List> {
  const I64SequenceCodec._();

  static const I64SequenceCodec codec = I64SequenceCodec._();

  @override
  Int64List decode(Input input) {
    final length = CompactCodec.codec.decode(input).toInt();
    final list = Int64List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I64Codec.codec.decode(input).toInt();
    }
    return list;
  }

  @override
  void encodeTo(Int64List list, Output output) {
    CompactCodec.codec.encodeTo(list.length, output);
    for (int value in list) {
      I64Codec.codec.encodeTo(BigInt.from(value), output);
    }
  }

  @override
  int sizeHint(Int64List list) {
    return CompactCodec.codec.sizeHint(list.length) + list.lengthInBytes;
  }
}

class I64ArrayCodec with Codec<Int64List> {
  final int length;
  const I64ArrayCodec(this.length);

  @override
  Int64List decode(Input input) {
    final list = Int64List(length);
    for (var i = 0; i < length; i++) {
      list[i] = I64Codec.codec.decode(input).toInt();
    }
    return list;
  }

  @override
  void encodeTo(Int64List list, Output output) {
    if (list.length != length) {
      throw Exception(
          'I64ArrayCodec: invalid length, expect $length found ${list.length}');
    }
    for (var i = 0; i < length; i++) {
      I64Codec.codec.encodeTo(BigInt.from(list[i]), output);
    }
  }

  @override
  int sizeHint(Int64List list) {
    return length * 8;
  }
}
