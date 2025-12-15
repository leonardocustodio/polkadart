part of primitives;

class I64Codec with Codec<BigInt> {
  const I64Codec._();

  static const I64Codec codec = I64Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    if (value < BigInt.parse('-9223372036854775808') ||
        value > BigInt.parse('9223372036854775807')) {
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

  @override
  bool isSizeZero() {
    // I64 always encodes to 8 bytes
    return false;
  }
}

class I64SequenceCodec with Codec<List<BigInt>> {
  const I64SequenceCodec._();

  static const I64SequenceCodec codec = I64SequenceCodec._();

  @override
  List<BigInt> decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = List<BigInt>.filled(length, BigInt.zero);
    for (var i = 0; i < length; i++) {
      list[i] = I64Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<BigInt> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      I64Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<BigInt> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length * 8;
  }

  @override
  bool isSizeZero() {
    // I64Sequence always has a length prefix (compact-encoded)
    return false;
  }
}

class I64ArrayCodec with Codec<List<BigInt>> {
  final int length;
  const I64ArrayCodec(this.length);

  @override
  List<BigInt> decode(Input input) {
    final list = List<BigInt>.filled(length, BigInt.zero);
    for (var i = 0; i < length; i++) {
      list[i] = I64Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<BigInt> value, Output output) {
    if (value.length != length) {
      throw Exception(
        'I64ArrayCodec: invalid length, expect $length found ${value.length}',
      );
    }
    for (final val in value) {
      I64Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<BigInt> value) {
    return length * 8;
  }

  @override
  bool isSizeZero() {
    // I64Array is size zero only if length is 0
    return length == 0;
  }
}
