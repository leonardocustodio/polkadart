// Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.
// This code is part of hashlib 1.12.0
// https://pub.dev/packages/hashlib

import 'dart:typed_data';

import 'block_hash.dart';

/// This implementation is derived from
/// https://github.com/easyaspi314/xxhash-clean/blob/master/xxhash64-ref.c
/// and
/// https://github.com/polkadot-js/common/blob/20d3af56ec0dd375bf21faa7f3de3b70b847c58b/packages/util-crypto/src/xxhash/xxhash64.ts

class XXHash64Sink extends BlockHashSink {
  final int seed;

  @override
  final int hashLength = 8;

  static final _u_64 = BigInt.parse('0xffffffffffffffff');
  static final prime64_1 = BigInt.parse('0x9E3779B185EBCA87');
  static final prime64_2 = BigInt.parse('0xC2B2AE3D27D4EB4F');
  static final prime64_3 = BigInt.parse('0x165667B19E3779F9');
  static final prime64_4 = BigInt.parse('0x85EBCA77C2B2AE63');
  static final prime64_5 = BigInt.parse('0x27D4EB2F165667C5');

  late BigInt _acc1;
  late BigInt _acc2;
  late BigInt _acc3;
  late BigInt _acc4;

  XXHash64Sink(this.seed) : super(32) {
    reset();
  }

  @override
  void reset() {
    super.reset();
    final s = BigInt.from(seed);
    _acc1 = (s + prime64_1 + prime64_2) & _u_64;
    _acc2 = (s + prime64_2) & _u_64;
    _acc3 = (s + BigInt.zero) & _u_64;
    _acc4 = (s - prime64_1) & _u_64;
  }

  @override
  void $process(List<int> chunk, int start, int end) {
    messageLength += end - start;
    for (; start < end; start++, pos++) {
      if (pos == blockLength) {
        $update();
        pos = 0;
      }
      buffer[pos] = chunk[start];
    }
  }

  @override
  void $update([List<int>? block, int offset = 0, bool last = false]) {
    // Process the 32-byte block (4 * 64 bits)
    final v1 = _from64(buffer, 0);
    final v2 = _from64(buffer, 8);
    final v3 = _from64(buffer, 16);
    final v4 = _from64(buffer, 24);

    _acc1 = _accumulate(_acc1, v1);
    _acc2 = _accumulate(_acc2, v2);
    _acc3 = _accumulate(_acc3, v3);
    _acc4 = _accumulate(_acc4, v4);
  }

  @override
  Uint8List $finalize() {
    var hash = BigInt.zero;
    final length = BigInt.from(messageLength);

    if (messageLength < 32) {
      hash = (BigInt.from(seed) + prime64_5) & _u_64;
    } else {
      hash = (_rotl(_acc1, 1) + _rotl(_acc2, 7) + _rotl(_acc3, 12) + _rotl(_acc4, 18)) & _u_64;

      hash = _merge(hash, _acc1);
      hash = _merge(hash, _acc2);
      hash = _merge(hash, _acc3);
      hash = _merge(hash, _acc4);
    }

    hash = (hash + length) & _u_64;

    int t = 0;

    // Process remaining 64 bits
    while (t + 8 <= pos) {
      final v = _from64(buffer, t);
      hash = (hash ^ _accumulate(BigInt.zero, v)) & _u_64;
      hash = _rotl(hash, 27);
      hash = ((hash * prime64_1) + prime64_4) & _u_64;
      t += 8;
    }

    // Process remaining 32 bits
    while (t + 4 <= pos) {
      final v = _from32(buffer, t);
      hash = (hash ^ ((v * prime64_1) & _u_64)) & _u_64;
      hash = _rotl(hash, 23);
      hash = ((hash * prime64_2) + prime64_3) & _u_64;
      t += 4;
    }

    // Process remaining bytes
    while (t < pos) {
      final v = BigInt.from(buffer[t++]);
      hash = (hash ^ ((v * prime64_5) & _u_64)) & _u_64;
      hash = _rotl(hash, 11);
      hash = (hash * prime64_1) & _u_64;
    }

    hash = (hash ^ (hash >> 33)) & _u_64;
    hash = (hash * prime64_2) & _u_64;
    hash = (hash ^ (hash >> 29)) & _u_64;
    hash = (hash * prime64_3) & _u_64;
    hash = (hash ^ (hash >> 32)) & _u_64;

    // Convert to Uint8List (big-endian)
    final result = Uint8List(8);
    var h = hash;
    for (int i = 7; i >= 0; i--) {
      result[i] = (h & BigInt.from(0xff)).toInt();
      h = h >> 8;
    }
    return result;
  }

  static BigInt _rotl(BigInt x, int n) {
    final shiftedLeft = (x << n) & _u_64;
    final shiftedRight = x >> (64 - n);
    return (shiftedLeft | shiftedRight) & _u_64;
  }

  static BigInt _accumulate(BigInt x, BigInt y) {
    final mul = (y * prime64_2) & _u_64;
    final add = (x + mul) & _u_64;
    final rot = _rotl(add, 31);
    return (rot * prime64_1) & _u_64;
  }

  static BigInt _merge(BigInt h, BigInt a) {
    final merged = (h ^ _accumulate(BigInt.zero, a)) & _u_64;
    return ((merged * prime64_1) + prime64_4) & _u_64;
  }

  static BigInt _from64(Uint8List u8a, int offset) {
    BigInt val = BigInt.zero;
    for (int i = 7; i >= 0; i--) {
      val = (val << 8) + BigInt.from(u8a[offset + i]);
    }
    return val & _u_64;
  }

  static BigInt _from32(Uint8List u8a, int offset) {
    BigInt val = BigInt.zero;
    for (int i = 3; i >= 0; i--) {
      val = (val << 8) + BigInt.from(u8a[offset + i]);
    }
    return val & _u_64;
  }
}
