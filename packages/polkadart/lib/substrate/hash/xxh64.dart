// Copyright (c) 2023, Sudipto Chandra
// All rights reserved. Check LICENSE file for details.

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
  static int _accumulate(int x, int y) =>
      _rotl((x + y * prime64_2), 31) * prime64_1;

  @override
  void $update([List<int>? block, int offset = 0, bool last = false]) {
    _acc1 = _accumulate(_acc1, qbuffer[0]);
    _acc2 = _accumulate(_acc2, qbuffer[1]);
    _acc3 = _accumulate(_acc3, qbuffer[2]);
    _acc4 = _accumulate(_acc4, qbuffer[3]);
  }

  @pragma('vm:prefer-inline')
  static int _merge(int h, int a) =>
      (h ^ _accumulate(0, a)) * prime64_1 + prime64_4;

  @override
  Uint8List $finalize() {
    int i, t;
    int _hash;

    if (messageLength < 32) {
      _hash = seed + prime64_5;
    } else {
      // accumulate
      _hash = _rotl(_acc1, 1);
      _hash += _rotl(_acc2, 7);
      _hash += _rotl(_acc3, 12);
      _hash += _rotl(_acc4, 18);

      // merge round
      _hash = _merge(_hash, _acc1);
      _hash = _merge(_hash, _acc2);
      _hash = _merge(_hash, _acc3);
      _hash = _merge(_hash, _acc4);
    }

    _hash += messageLength;

    // process the remaining data
    for (i = t = 0; t + 8 <= pos; ++i, t += 8) {
      _hash ^= _accumulate(0, qbuffer[i]);
      _hash = _rotl(_hash, 27);
      _hash *= prime64_1;
      _hash += prime64_4;
    }
    for (i <<= 1; t + 4 <= pos; ++i, t += 4) {
      _hash ^= sbuffer[i] * prime64_1;
      _hash = _rotl(_hash, 23);
      _hash *= prime64_2;
      _hash += prime64_3;
    }
    for (; t < pos; t++) {
      _hash ^= buffer[t] * prime64_5;
      _hash = _rotl(_hash, 11);
      _hash *= prime64_1;
    }

    // avalanche
    _hash ^= _hash >>> 33;
    _hash *= prime64_2;
    _hash ^= _hash >>> 29;
    _hash *= prime64_3;
    _hash ^= _hash >>> 32;

    return Uint8List.fromList([
      _hash >>> 56,
      _hash >>> 48,
      _hash >>> 40,
      _hash >>> 32,
      _hash >>> 24,
      _hash >>> 16,
      _hash >>> 8,
      _hash,
    ]);
  }
}
