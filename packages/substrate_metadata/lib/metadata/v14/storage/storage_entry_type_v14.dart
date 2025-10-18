part of metadata;

/// Type of storage entry
///
/// Storage can be either a plain value or a map (single or double key).
sealed class StorageEntryType {
  const StorageEntryType();

  /// Codec instance for StorageEntryType
  static const $StorageEntryType codec = $StorageEntryType._();

  Map<String, dynamic> toJson();
}

/// Codec for StorageEntryType
///
/// Handles encoding and decoding of different storage entry types.
class $StorageEntryType with Codec<StorageEntryType> {
  const $StorageEntryType._();

  @override
  StorageEntryType decode(Input input) {
    final index = input.read();

    switch (index) {
      case 0: // Plain
        final valueType = CompactCodec.codec.decode(input);
        return StorageEntryTypePlain(valueType: valueType);

      case 1: // Map
        // Decode each hasher
        final hashers = SequenceCodec(StorageHasher.codec).decode(input);

        // Decode key type ID
        final keyType = CompactCodec.codec.decode(input);

        // Decode value type ID
        final valueType = CompactCodec.codec.decode(input);

        return StorageEntryTypeMap(
          hashers: hashers,
          keyType: keyType,
          valueType: valueType,
        );

      default:
        throw Exception('Unknown StorageEntryType index: $index');
    }
  }

  @override
  void encodeTo(StorageEntryType value, Output output) {
    switch (value) {
      case final StorageEntryTypePlain storageEntryTypePlain:
        output.pushByte(0);
        CompactCodec.codec.encodeTo(storageEntryTypePlain.valueType, output);

      case final StorageEntryTypeMap storageEntryTypeMap:
        output.pushByte(1);

        // Encode each hasher
        SequenceCodec(StorageHasher.codec).encodeTo(storageEntryTypeMap.hashers, output);

        // Encode key type ID
        CompactCodec.codec.encodeTo(storageEntryTypeMap.keyType, output);

        // Encode value type ID
        CompactCodec.codec.encodeTo(storageEntryTypeMap.valueType, output);
    }
  }

  @override
  int sizeHint(StorageEntryType value) {
    var size = 1; // For the type index

    switch (value) {
      case final StorageEntryTypePlain storageEntryTypePlain:
        size += CompactCodec.codec.sizeHint(storageEntryTypePlain.valueType);

      case final StorageEntryTypeMap storageEntryTypeMap:
        size += SequenceCodec(StorageHasher.codec).sizeHint(storageEntryTypeMap.hashers);
        size += CompactCodec.codec.sizeHint(storageEntryTypeMap.keyType);
        size += CompactCodec.codec.sizeHint(storageEntryTypeMap.valueType);
    }

    return size;
  }
}

/// Plain storage value (single value, no key)
class StorageEntryTypePlain extends StorageEntryType {
  /// Type ID of the stored value
  final int valueType;

  const StorageEntryTypePlain({required this.valueType});

  @override
  Map<String, dynamic> toJson() {
    return {'Plain': valueType};
  }
}

/// Map storage (key to value mapping)
///
/// Can be single-key map or multi-key map (using multiple hashers).
class StorageEntryTypeMap extends StorageEntryType {
  /// List of hashers used for the keys
  ///
  /// - Single hasher: standard Map
  /// - Multiple hashers: NMap (N-dimensional map)
  final List<StorageHasher> hashers;

  /// Type ID of the key
  ///
  /// For multiple keys, this is typically a tuple type.
  final int keyType;

  /// Type ID of the value
  final int valueType;

  const StorageEntryTypeMap({
    required this.hashers,
    required this.keyType,
    required this.valueType,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'Map': {
        'hashers': hashers.map((hasher) => hasher.toString()).toList(),
        'key': keyType,
        'value': valueType,
      }
    };
  }
}

/// Storage hashers for map keys
///
/// Different hashing algorithms provide different security and performance tradeoffs.
///
/// Used in: MetadataV14, MetadataV15
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
