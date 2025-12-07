part of metadata;

/// Storage metadata for a pallet
///
/// Contains information about all storage items in a pallet.
class PalletStorageMetadata {
  /// Storage prefix used in the key generation
  ///
  /// This is typically the pallet name and is used to create unique
  /// storage keys that don't conflict between pallets.
  final String prefix;

  /// List of all storage entries in this pallet
  final List<StorageEntryMetadata> entries;

  const PalletStorageMetadata({
    required this.prefix,
    required this.entries,
  });

  /// Codec instance for PalletStorageMetadata
  static const $PalletStorageMetadata codec = $PalletStorageMetadata._();

  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'entries': entries.map((entry) => entry.toJson()).toList(),
      };
}

/// Codec for PalletStorageMetadata
class $PalletStorageMetadata with Codec<PalletStorageMetadata> {
  const $PalletStorageMetadata._();

  @override
  PalletStorageMetadata decode(Input input) {
    // Decode storage prefix
    final prefix = StrCodec.codec.decode(input);

    // Decode all storage entries
    final entries = SequenceCodec(StorageEntryMetadata.codec).decode(input);

    return PalletStorageMetadata(
      prefix: prefix,
      entries: entries,
    );
  }

  @override
  void encodeTo(PalletStorageMetadata value, Output output) {
    // Encode storage prefix
    StrCodec.codec.encodeTo(value.prefix, output);

    // Encode all storage entries
    SequenceCodec(StorageEntryMetadata.codec).encodeTo(value.entries, output);
  }

  @override
  int sizeHint(PalletStorageMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.prefix);
    size += SequenceCodec(StorageEntryMetadata.codec).sizeHint(value.entries);
    return size;
  }

  @override
  bool isSizeZero() =>
      StrCodec.codec.isSizeZero() && SequenceCodec(StorageEntryMetadata.codec).isSizeZero();
}
