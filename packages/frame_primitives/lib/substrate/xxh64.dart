part of substrate_core;

enum Endian { little, big }

class XXH64 {
  // 0b1001111000110111011110011011000110000101111010111100101010000111
  static final prime1 = BigInt.parse('11400714785074694791');

  // 0b1100001010110010101011100011110100100111110101001110101101001111
  static final prime2 = BigInt.parse('14029467366897019727');

  // 0b0001011001010110011001111011000110011110001101110111100111111001
  static final prime3 = BigInt.parse('1609587929392839161');

  // 0b1000010111101011110010100111011111000010101100101010111001100011
  static final prime4 = BigInt.parse('9650029242287828579');

  // 0b0010011111010100111010110010111100010110010101100110011111000101
  static final prime5 = BigInt.parse('2870177450012600261');

  static BigInt defaultSeed = BigInt.from(0x1234567890);

  static BigInt digest({required List<int> data, BigInt? seed, Endian? endian}) {
    endian ??= XXH64.endian;

    seed ??= defaultSeed;

    List<int> array = data;

    final len = array.length;

    BigInt h;
    int index = 0;

    if (len >= 32) {
      final limit = len - 32;
      var v1 = ((seed + prime1).toUnsigned(64) + prime2).toUnsigned(64);
      var v2 = (seed + prime2).toUnsigned(64);
      var v3 = seed + BigInt.zero;
      var v4 = (seed - prime1).toUnsigned(64);

      while (index <= limit) {
        v1 = round(
            acc: v1,
            input: convertIntArrayToBigInt(array: array, index: index));
        index += 8;

        v2 = round(
            acc: v2,
            input: convertIntArrayToBigInt(array: array, index: index));
        index += 8;

        v3 = round(
            acc: v3,
            input: convertIntArrayToBigInt(array: array, index: index));
        index += 8;

        v4 = round(
            acc: v4,
            input: convertIntArrayToBigInt(array: array, index: index));
        index += 8;
      }
      h = rotl(x: v1, r: 1) +
          rotl(x: v2, r: 7) +
          rotl(x: v3, r: 12) +
          rotl(x: v4, r: 18);

      h = mergeRound(acc: h, val: v1);
      h = mergeRound(acc: h, val: v2);
      h = mergeRound(acc: h, val: v3);
      h = mergeRound(acc: h, val: v4);
    } else {
      h = (seed + prime5).toUnsigned(64);
    }

    h = (h + BigInt.from(len)).toUnsigned(64);

    final array2 = List<int>.from(array);
    h = finalize(h: h, array: array2, len: len, endian: endian);
    return h;
  }

  static BigInt convertIntArrayToBigInt({
    required List<int> array,
    required int index,
    Endian? endian,
  }) {
    endian ??= XXH64.endian;

    BigInt block = BigInt.zero;

    final size = array.length - index;

    for (int i = 0; i < size; i++) {
      block |= BigInt.from(array[index + i] << (i * 8)).toUnsigned(64);
    }
    if (endian == Endian.little) {
      return block;
    }

    // for Big Endian
    block = swap(block);
    return block;
  }

  static final Endian endian =
      (ByteData.view(Uint16List.fromList([1]).buffer)).getInt8(0) == 1
          ? Endian.little
          : Endian.big;

  static swap(BigInt x) {
    BigInt res = BigInt.zero;
    BigInt mask = BigInt.from(255);
    int bit = 0;

    final int size = (x.bitLength / 8).ceil();

    bit = (size - 1) * 8;

    for (int i = 0; i < size / 2; i++) {
      res |= (x & mask) << bit;
      mask = mask << 8;
      bit -= 16;
    }

    bit = 8;
    for (int i = 0; i < size / 2; i++) {
      res |= (x & mask) >> bit;
      mask = mask << 8;
      bit += 16;
    }

    return res;
  }

  static BigInt round({required BigInt acc, required BigInt input}) {
    var acc2 = acc;
    acc2 += (input * prime2).toUnsigned(64);
    acc2 = acc2.toUnsigned(64);

    acc2 = rotl(x: acc2, r: 31);
    acc2 *= prime1;
    acc2 = acc2.toUnsigned(64);
    return acc2;
  }

  static BigInt rotl({required BigInt x, required int r}) {
    final result = (x << r) | (x >> (64 - r));
    return result.toUnsigned(64);
  }

  static BigInt mergeRound({required BigInt acc, required BigInt val}) {
    var val2 = round(acc: BigInt.zero, input: val);
    var acc2 = acc ^ val2;
    acc2 = ((acc2 * prime1).toUnsigned(64) + prime4).toUnsigned(64);
    return acc2;
  }

  static BigInt avalanche(BigInt h) {
    var h2 = h;
    h2 ^= h2 >> 33;
    h2 = (h2 * prime2).toUnsigned(64);
    h2 ^= h2 >> 29;
    h2 = (h2 * prime3).toUnsigned(64);
    h2 ^= h2 >> 32;
    return h2;
  }

  static BigInt finalize({
    required BigInt h,
    List<int>? array,
    required int len,
    required Endian endian,
  }) {
    var index = 0;
    var h2 = h;

    void process1() {
      h2 ^= (BigInt.from(array![index]) * prime5).toUnsigned(64);
      index += 1;
      h2 = (rotl(x: h2, r: 11) * prime1).toUnsigned(64);
    }

    void process4() {
      h2 ^=
          ((convertIntArrayToBigInt(array: array!, index: index, endian: endian)
                          .toUnsigned(32))
                      .toUnsigned(64) *
                  prime1)
              .toUnsigned(64);
      index += 4;
      h2 = ((rotl(x: h2, r: 23) * prime2).toUnsigned(64) + prime3)
          .toUnsigned(64);
    }

    void process8() {
      final k1 = round(
          acc: BigInt.zero,
          input: convertIntArrayToBigInt(
              array: array!, index: index, endian: endian));
      index += 8;
      h2 ^= k1;
      h2 = ((rotl(x: h2, r: 27) * prime1).toUnsigned(64) + prime4)
          .toUnsigned(64);
    }

    switch (len & 31) {
      case 24:
        process8();
        continue c16;
      c16:
      case 16:
        process8();
        continue c8;
      c8:
      case 8:
        process8();
        return avalanche(h2);

      case 28:
        process8();
        continue c20;
      c20:
      case 20:
        process8();
        continue c12;
      c12:
      case 12:
        process8();
        continue c4;
      c4:
      case 4:
        process4();
        return avalanche(h2);

      case 25:
        process8();
        continue c17;
      c17:
      case 17:
        process8();
        continue c9;
      c9:
      case 9:
        process8();
        process1();
        return avalanche(h2);

      case 29:
        process8();
        continue c21;
      c21:
      case 21:
        process8();
        continue c13;
      c13:
      case 13:
        process8();
        continue c5;
      c5:
      case 5:
        process4();
        process1();
        return avalanche(h2);

      case 26:
        process8();
        continue c18;
      c18:
      case 18:
        process8();
        continue c10;
      c10:
      case 10:
        process8();
        process1();
        process1();
        return avalanche(h2);

      case 30:
        process8();
        continue c22;
      c22:
      case 22:
        process8();
        continue c14;
      c14:
      case 14:
        process8();
        continue c6;
      c6:
      case 6:
        process4();
        process1();
        process1();
        return avalanche(h2);

      case 27:
        process8();
        continue c19;
      c19:
      case 19:
        process8();
        continue c11;
      c11:
      case 11:
        process8();
        process1();
        process1();
        process1();
        return avalanche(h2);

      case 31:
        process8();
        continue c23;
      c23:
      case 23:
        process8();
        continue c15;
      c15:
      case 15:
        process8();
        continue c7;

      c7:
      case 7:
        process4();
        continue c3;

      c3:
      case 3:
        process1();
        continue c2;

      c2:
      case 2:
        process1();
        continue c1;

      c1:
      case 1:
        process1();
        continue c0;

      c0:
      case 0:
        return avalanche(h2);

      default:
        break;
    }

    return BigInt.zero;
  }
}
