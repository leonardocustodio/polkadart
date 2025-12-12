part of substrate_hashers;

abstract class Hasher {
  /// Length of the final hash in bytes.
  final int digestSize;

  const Hasher(this.digestSize);

  static const blake2b64 = Blake2bHasher(8);
  static const blake2b128 = Blake2bHasher(16);
  static const blake2b256 = Blake2bHasher(32);
  static const blake364 = Blake3Hasher(8);
  static const blake3128 = Blake3Hasher(16);
  static const blake3256 = Blake3Hasher(32);
  static const twoxx64 = TwoxxHasher(1);
  static const twoxx128 = TwoxxHasher(2);
  static const twoxx256 = TwoxxHasher(4);

  void hashTo({required Uint8List data, required Uint8List output});

  Uint8List hash(Uint8List data) {
    final output = Uint8List(digestSize);
    hashTo(data: data, output: output);
    return output;
  }

  Uint8List hashString(String str) {
    final data = Uint8List.fromList(utf8.encode(str));
    return hash(data);
  }
}

/// Blake3 hash
class Blake3Hasher extends Hasher {
  const Blake3Hasher(super.size);

  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    final digest = blake3(data, digestSize);
    output.setAll(0, digest);
  }
}

/// Blake2b hash
class Blake2bHasher extends Hasher {
  const Blake2bHasher(super.size);

  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    final blake2b = Blake2bDigest(digestSize: digestSize);
    blake2b.update(data, 0, data.length);
    blake2b.doFinal(output, 0);
  }
}

/// XX hash
class TwoxxHasher extends Hasher {
  // Digest size in blocks of 64bit
  final int blocks;

  const TwoxxHasher(this.blocks) : super(blocks * 8);

  @override
  void hashTo({required Uint8List data, required Uint8List output}) {
    for (int seed = 0; seed < blocks; seed++) {
      final hashedBytes = XXHash64(seed).convert(data).bytes.reversed.toList();

      for (var i = 0; i < 8; i++) {
        output[(seed * 8) + i] = hashedBytes[i];
      }
    }
  }
}
