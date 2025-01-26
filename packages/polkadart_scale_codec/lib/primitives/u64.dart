part of primitives;

class U64Codec with Codec<BigInt> {
  const U64Codec._();

  static const U64Codec codec = U64Codec._();

  @override
  void encodeTo(BigInt value, Output output) {
    U32Codec.codec
      ..encodeTo(value.toUnsigned(32).toInt(), output)
      ..encodeTo((value >> 32).toUnsigned(32).toInt(), output);
  }

  @override
  BigInt decode(Input input) {
    final low = U32Codec.codec.decode(input);
    final high = U32Codec.codec.decode(input);
    return BigInt.from(low) | (BigInt.from(high) << 32);
  }

  @override
  int sizeHint(BigInt value) {
    return 8;
  }
}

class U64SequenceCodec with Codec<List<BigInt>> {
  const U64SequenceCodec._();

  static const U64SequenceCodec codec = U64SequenceCodec._();

  @override
  List<BigInt> decode(Input input) {
    final length = CompactCodec.codec.decode(input);
    final list = List<BigInt>.filled(length, BigInt.zero);
    for (var i = 0; i < length; i++) {
      list[i] = U64Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<BigInt> value, Output output) {
    CompactCodec.codec.encodeTo(value.length, output);
    for (final val in value) {
      U64Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<BigInt> value) {
    return CompactCodec.codec.sizeHint(value.length) + value.length * 8;
  }
}

class U64ArrayCodec with Codec<List<BigInt>> {
  final int length;
  const U64ArrayCodec(this.length);

  @override
  List<BigInt> decode(Input input) {
    final list = List<BigInt>.filled(length, BigInt.zero);
    for (var i = 0; i < length; i++) {
      list[i] = U64Codec.codec.decode(input);
    }
    return list;
  }

  @override
  void encodeTo(List<BigInt> value, Output output) {
    if (value.length != length) {
      throw Exception(
          'U64ArrayCodec: invalid length, expect $length found ${value.length}');
    }
    for (final val in value) {
      U64Codec.codec.encodeTo(val, output);
    }
  }

  @override
  int sizeHint(List<BigInt> value) {
    return length * 8;
  }
}
