// Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.
// This code is part of hashlib 1.12.0
// https://pub.dev/packages/hashlib

import 'dart:typed_data';

import 'block_hash.dart';

/// This implementation is derived from
/// https://github.com/easyaspi314/xxhash-clean/blob/master/xxhash64-ref.c
class XXHash64Sink extends BlockHashSink {
  final int seed;

  @override
  final int hashLength = 8;

  static const int prime64_1 = 0x9E3779B185EBCA87;
  static const int prime64_2 = 0xC2B2AE3D27D4EB4F;
  static const int prime64_3 = 0x165667B19E3779F9;
  static const int prime64_4 = 0x85EBCA77C2B2AE63;
  static const int prime64_5 = 0x27D4EB2F165667C5;

  int _acc1 = 0;
  int _acc2 = 0;
  int _acc3 = 0;
  int _acc4 = 0;

  late final Uint64List qbuffer = buffer.buffer.asUint64List();

  XXHash64Sink(this.seed) : super(32) {
    reset();
  }

  @override
  void reset() {
    super.reset();
    _acc1 = seed + prime64_1 + prime64_2;
    _acc2 = seed + prime64_2;
    _acc3 = seed + 0;
    _acc4 = seed - prime64_1;
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
    if (pos == blockLength) {
      $update();
      pos = 0;
    }
  }

  @pragma('vm:prefer-inline')
  static int _rotl(int x, int n) => (x << n) | (x >>> (64 - n));

  @pragma('vm:prefer-inline')
  static int _accumulate(int x, int y) => _rotl((x + y * prime64_2), 31) * prime64_1;

  @override
  void $update([List<int>? block, int offset = 0, bool last = false]) {
    _acc1 = _accumulate(_acc1, qbuffer[0]);
    _acc2 = _accumulate(_acc2, qbuffer[1]);
    _acc3 = _accumulate(_acc3, qbuffer[2]);
    _acc4 = _accumulate(_acc4, qbuffer[3]);
  }

  @pragma('vm:prefer-inline')
  static int _merge(int h, int a) => (h ^ _accumulate(0, a)) * prime64_1 + prime64_4;

  @override
  Uint8List $finalize() {
    int i, t;
    int hash;

    if (messageLength < 32) {
      hash = seed + prime64_5;
    } else {
      // accumulate
      hash = _rotl(_acc1, 1);
      hash += _rotl(_acc2, 7);
      hash += _rotl(_acc3, 12);
      hash += _rotl(_acc4, 18);

      // merge round
      hash = _merge(hash, _acc1);
      hash = _merge(hash, _acc2);
      hash = _merge(hash, _acc3);
      hash = _merge(hash, _acc4);
    }

    hash += messageLength;

    // process the remaining data
    for (i = t = 0; t + 8 <= pos; ++i, t += 8) {
      hash ^= _accumulate(0, qbuffer[i]);
      hash = _rotl(hash, 27);
      hash *= prime64_1;
      hash += prime64_4;
    }
    for (i <<= 1; t + 4 <= pos; ++i, t += 4) {
      hash ^= sbuffer[i] * prime64_1;
      hash = _rotl(hash, 23);
      hash *= prime64_2;
      hash += prime64_3;
    }
    for (; t < pos; t++) {
      hash ^= buffer[t] * prime64_5;
      hash = _rotl(hash, 11);
      hash *= prime64_1;
    }

    // avalanche
    hash ^= hash >>> 33;
    hash *= prime64_2;
    hash ^= hash >>> 29;
    hash *= prime64_3;
    hash ^= hash >>> 32;

    return Uint8List.fromList([
      hash >>> 56,
      hash >>> 48,
      hash >>> 40,
      hash >>> 32,
      hash >>> 24,
      hash >>> 16,
      hash >>> 8,
      hash,
    ]);
  }
}
