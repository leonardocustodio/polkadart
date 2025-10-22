part of metadata;

/// Storage hashers for map keys
///
/// Different hashing algorithms provide different security and performance tradeoffs.
enum StorageHasher {
  /// Blake2 128-bit hash
  blake2_128,

  /// Blake2 256-bit hash
  blake2_256,

  /// Blake2 128-bit hash concatenated with the key
  ///
  /// This allows reverse lookups and enumeration.
  blake2_128Concat,

  /// Two-X (XX) 128-bit hash
  twox128,

  /// Two-X (XX) 256-bit hash
  twox256,

  /// Two-X (XX) 64-bit hash concatenated with the key
  ///
  /// This allows reverse lookups and enumeration.
  twox64Concat,

  /// Identity "hasher" (no hashing, key used directly)
  ///
  /// Only safe when the key space is trusted (e.g., pallet index).
  identity;

  static const $StorageHasher codec = $StorageHasher._();
}

class $StorageHasher with Codec<StorageHasher> {
  const $StorageHasher._();

  @override
  StorageHasher decode(Input input) {
    final index = input.read();
    if (index < 0 || index >= StorageHasher.values.length) {
      throw Exception('Unknown StorageHasher variant index $index');
    }
    return StorageHasher.values[index];
  }

  @override
  void encodeTo(StorageHasher storageHasher, Output output) {
    output.pushByte(storageHasher.index);
  }

  @override
  int sizeHint(StorageHasher value) => 1;
}
