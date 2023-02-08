part of primitives;

class CompactBigIntCodec with Codec<BigInt> {
  const CompactBigIntCodec._();

  static final CompactBigIntCodec instance = CompactBigIntCodec._();

  @override
  void encodeTo(BigInt element, Output output) {
    if (element < BigInt.from(64)) {
      output.pushByte(element.toInt() << 2);
    } else if (element < BigInt.from(16384)) {
      output
        ..pushByte((element.toInt() & 0x3F) << 2 | 1)
        ..pushByte((element.toInt() >> 6).toUnsigned(8));
    } else if (element < BigInt.from(1073741824)) {
      output
        ..pushByte((element.toInt() & 0x3F) << 2 | 2)
        ..pushByte((element.toInt() >> 6).toUnsigned(8))
        ..pushByte((element.toInt() >> 14).toUnsigned(8))
        ..pushByte((element.toInt() >> 22).toUnsigned(8));
    } else {
      assert(element.bitLength >= 30,
          'Previously checked anyting less than 2^30; qed');
      final bytesNeeded = (element.bitLength + 7) >> 3;
      output.pushByte(((bytesNeeded - 4) << 2).toUnsigned(8) | 3);
      for (var i = 0; i < bytesNeeded; i++) {
        output.pushByte(element.toUnsigned(8).toInt());
        element >>= 8;
      }
      assert(element == BigInt.zero, 'Value is not fully consumed; qed');
    }
  }

  @override
  BigInt decode(Input input) {
    var prefix = input.read();
    switch (prefix % 4) {
      case 0:
        {
          return BigInt.from(prefix >> 2);
        }
      case 1:
        {
          prefix >>= 2;
          prefix |= input.read() << 6;
          assert(prefix > 0x3f && prefix <= 0x3fff, 'Out of range');
          return BigInt.from(prefix);
        }
      case 2:
        {
          prefix >>= 2;
          prefix |=
              (input.read() << 6) | (input.read() << 14) | (input.read() << 22);
          assert(prefix > 0x3fff && prefix <= 0x3fffffff, 'Out of range');
          return BigInt.from(prefix);
        }
      default:
        {
          final bytesNeeded = (prefix >> 2) + 4;
          var value = BigInt.zero;
          for (var i = 0; i < bytesNeeded; i++) {
            value |= BigInt.from(input.read()) << (8 * i);
          }
          assert(value > BigInt.from(0x3fffffff), 'Out of range');
          return value;
        }
    }
  }

  @override
  int sizeHint(BigInt element) {
    if (element <= BigInt.from(0x3F)) {
      return 1;
    } else if (element <= BigInt.from(0x3FFF)) {
      return 2;
    } else if (element <= BigInt.from(0x3FFFFFFF)) {
      return 4;
    } else {
      return ((element.bitLength + 7) >> 3) + 1;
    }
  }
}

class CompactCodec with Codec<int> {
  const CompactCodec._();

  static CompactCodec instance = CompactCodec._();

  @override
  void encodeTo(int element, Output output) {
    if (element < 64) {
      output.pushByte(element.toInt() << 2);
    } else if (element < 16384) {
      output
        ..pushByte((element.toInt() & 0x3F) << 2 | 1)
        ..pushByte((element.toInt() >> 6).toUnsigned(8));
    } else if (element < 1073741824) {
      output
        ..pushByte((element.toInt() & 0x3F) << 2 | 2)
        ..pushByte((element.toInt() >> 6).toUnsigned(8))
        ..pushByte((element.toInt() >> 14).toUnsigned(8))
        ..pushByte((element.toInt() >> 22).toUnsigned(8));
    } else {
      assert(element.bitLength >= 30,
          'Previously checked anyting less than 2^30; qed');
      final bytesNeeded = (element.bitLength + 7) >> 3;
      output.pushByte(((bytesNeeded - 4) << 2).toUnsigned(8) | 3);
      for (var i = 0; i < bytesNeeded; i++) {
        output.pushByte(element.toUnsigned(8).toInt());
        element >>= 8;
      }
      assert(element == 0, 'Value is not fully consumed; qed');
    }
  }

  @override
  int decode(Input input) {
    var prefix = input.read();
    switch (prefix % 4) {
      case 0:
        {
          return prefix >> 2;
        }
      case 1:
        {
          prefix >>= 2;
          prefix |= input.read() << 6;
          assert(prefix > 0x3f && prefix <= 0x3fff, 'Out of range');
          return prefix;
        }
      case 2:
        {
          prefix >>= 2;
          prefix |=
              (input.read() << 6) | (input.read() << 14) | (input.read() << 22);
          assert(prefix > 0x3fff && prefix <= 0x3fffffff, 'Out of range');
          return prefix;
        }
      default:
        {
          final bytesNeeded = (prefix >> 2) + 4;
          var value = 0;
          for (var i = 0; i < bytesNeeded; i++) {
            value |= input.read() << (8 * i);
          }
          assert(value > 0x3fffffff, 'Out of range');
          return value;
        }
    }
  }

  @override
  int sizeHint(int element) {
    if (element <= 0x3F) {
      return 1;
    } else if (element <= 0x3FFF) {
      return 2;
    } else if (element <= 0x3FFFFFFF) {
      return 4;
    } else {
      return ((element.bitLength + 7) >> 3) + 1;
    }
  }
}
