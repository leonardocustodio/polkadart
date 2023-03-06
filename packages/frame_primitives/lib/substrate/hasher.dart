part of substrate_core;

abstract class Hasher {
  /// Length of the final hash in bytes.
  final int digestSize;

  const Hasher(this.digestSize);

  static const blake2b128 = Blake2bHasher(16);
  static const blake2b256 = Blake2bHasher(32);
  static const twoxx64 = Twoxx64Hasher();
  static const twoxx128 = Twoxx128Hasher();

  void hashTo({
    required Uint8List data,
    required Uint8List output,
  });

  Uint8List hash(Uint8List data) {
    final output = Uint8List(digestSize);
    hashTo(data: data, output: output);
    return output;
  }
}

class Blake2bHasher extends Hasher {
  const Blake2bHasher(super.size);

  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    final blake2b = Blake2b(digestSize * 8);
    blake2b.update(data, 0, data.length);
    blake2b.digest(output, 0);
  }
}

class Twoxx64Hasher extends Hasher {
  final BigInt? seed;

  const Twoxx64Hasher(): seed = null, super(8);
  const Twoxx64Hasher.withSeed(this.seed): super(8);

  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    final seed = this.seed ?? BigInt.zero;
    BigInt hash = XXH64.digest(data: data, seed: seed, endian: Endian.little);
    for (var i = 0; i < 8; i++) {
      output[i] = hash.toUnsigned(8).toInt();
      hash >>= 8;
    }
  }
}

class Twoxx128Hasher extends Hasher {
  const Twoxx128Hasher(): super(16);
  
  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    Twoxx64Hasher.withSeed(BigInt.zero).hashTo(data: data, output: output.buffer.asUint8List(output.offsetInBytes, 8));
    Twoxx64Hasher.withSeed(BigInt.one).hashTo(data: data, output: output.buffer.asUint8List(output.offsetInBytes + 8, 8));
  }
}
