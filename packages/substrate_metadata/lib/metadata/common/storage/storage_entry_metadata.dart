part of metadata;

/// Metadata about a single storage entry in Metadata
///
/// Storage entries represent persistent data stored on-chain.
class StorageEntryMetadata {
  /// Name of the storage entry
  final String name;

  /// Modifier indicating optionality
  final StorageEntryModifier modifier;

  /// Type of the storage entry (Plain, Map, etc.)
  final StorageEntryType type;

  /// Default value (SCALE encoded)
  final List<int> defaultValue;

  /// Documentation for this storage entry
  final List<String> docs;

  const StorageEntryMetadata({
    required this.name,
    required this.modifier,
    required this.type,
    required this.defaultValue,
    this.docs = const [],
  });

  /// Codec instance for StorageEntryMetadata
  static const $StorageEntryMetadata codec = $StorageEntryMetadata._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'modifier': modifier.toString(),
        'type': type.toJson(),
        'default': defaultValue,
        'docs': docs,
      };
}

/// Codec for StorageEntryMetadata
class $StorageEntryMetadata with Codec<StorageEntryMetadata> {
  const $StorageEntryMetadata._();

  @override
  StorageEntryMetadata decode(Input input) {
    // Decode entry name
    final name = StrCodec.codec.decode(input);

    // Decode modifier
    final modifier = StorageEntryModifier.codec.decode(input);

    // Decode storage entry type
    final type = StorageEntryType.codec.decode(input);

    // Decode default value
    final defaultValue = U8SequenceCodec.codec.decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return StorageEntryMetadata(
      name: name,
      modifier: modifier,
      type: type,
      defaultValue: defaultValue,
      docs: docs,
    );
  }

  @override
  void encodeTo(StorageEntryMetadata value, Output output) {
    // Encode entry name
    StrCodec.codec.encodeTo(value.name, output);

    // Encode modifier
    StorageEntryModifier.codec.encodeTo(value.modifier, output);

    // Encode storage entry type
    StorageEntryType.codec.encodeTo(value.type, output);

    // Encode default value
    U8SequenceCodec.codec.encodeTo(value.defaultValue, output);

    // Encode documentation
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(StorageEntryMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += StorageEntryModifier.codec.sizeHint(value.modifier);
    size += StorageEntryType.codec.sizeHint(value.type);
    size += U8SequenceCodec.codec.sizeHint(value.defaultValue);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }

  @override
  bool isSizeZero() {
    return StrCodec.codec.isSizeZero() &&
        StorageEntryModifier.codec.isSizeZero() &&
        StorageEntryType.codec.isSizeZero() &&
        U8SequenceCodec.codec.isSizeZero() &&
        SequenceCodec(StrCodec.codec).isSizeZero();
  }
}
