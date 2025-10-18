part of metadata;

/// Storage metadata for a pallet in MetadataV14
///
/// Contains information about all storage items in a pallet.
class PalletStorageMetadataV14 {
  /// Storage prefix used in the key generation
  ///
  /// This is typically the pallet name and is used to create unique
  /// storage keys that don't conflict between pallets.
  final String prefix;

  /// List of all storage entries in this pallet
  final List<StorageEntryMetadataV14> entries;

  const PalletStorageMetadataV14({
    required this.prefix,
    required this.entries,
  });

  /// Codec instance for PalletStorageMetadataV14
  static const $PalletStorageMetadataV14 codec = $PalletStorageMetadataV14._();

  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'entries': entries.map((entry) => entry.toJson()).toList(),
      };
}

/// Codec for PalletStorageMetadataV14
class $PalletStorageMetadataV14 with Codec<PalletStorageMetadataV14> {
  const $PalletStorageMetadataV14._();

  @override
  PalletStorageMetadataV14 decode(Input input) {
    // Decode storage prefix
    final prefix = StrCodec.codec.decode(input);

    // Decode all storage entries
    final entries = SequenceCodec(StorageEntryMetadataV14.codec).decode(input);

    return PalletStorageMetadataV14(
      prefix: prefix,
      entries: entries,
    );
  }

  @override
  void encodeTo(PalletStorageMetadataV14 value, Output output) {
    // Encode storage prefix
    StrCodec.codec.encodeTo(value.prefix, output);

    // Encode all storage entries
    SequenceCodec(StorageEntryMetadataV14.codec).encodeTo(value.entries, output);
  }

  @override
  int sizeHint(PalletStorageMetadataV14 value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.prefix);
    size += SequenceCodec(StorageEntryMetadataV14.codec).sizeHint(value.entries);
    return size;
  }
}
