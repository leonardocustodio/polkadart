part of metadata;

/// Modifier indicating whether a storage entry is optional
enum StorageEntryModifier {
  /// The storage entry returns an Option<T>, None if key not present
  optional,

  /// The storage entry returns T, using default value if key not present
  defaultModifier;

  static const $StorageEntryModifier codec = $StorageEntryModifier._();
}

class $StorageEntryModifier with Codec<StorageEntryModifier> {
  const $StorageEntryModifier._();

  @override
  StorageEntryModifier decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return StorageEntryModifier.optional;
      case 1:
        return StorageEntryModifier.defaultModifier;
      default:
        throw Exception('Unknown storage modifier variant index $index');
    }
  }

  @override
  void encodeTo(StorageEntryModifier value, Output output) {
    output.pushByte(value.index);
  }

  @override
  int sizeHint(StorageEntryModifier value) => 1;
}

/// Metadata about a single storage entry in MetadataV14
///
/// Storage entries represent persistent data stored on-chain.
class StorageEntryMetadataV14 {
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

  const StorageEntryMetadataV14({
    required this.name,
    required this.modifier,
    required this.type,
    required this.defaultValue,
    this.docs = const [],
  });

  /// Codec instance for StorageEntryMetadataV14
  static const $StorageEntryMetadataV14 codec = $StorageEntryMetadataV14._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'modifier': modifier.toString(),
        'type': type.toJson(),
        'default': defaultValue,
        'docs': docs,
      };
}

/// Codec for StorageEntryMetadataV14
class $StorageEntryMetadataV14 with Codec<StorageEntryMetadataV14> {
  const $StorageEntryMetadataV14._();

  @override
  StorageEntryMetadataV14 decode(Input input) {
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

    return StorageEntryMetadataV14(
      name: name,
      modifier: modifier,
      type: type,
      defaultValue: defaultValue,
      docs: docs,
    );
  }

  @override
  void encodeTo(StorageEntryMetadataV14 value, Output output) {
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
  int sizeHint(StorageEntryMetadataV14 value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += StorageEntryModifier.codec.sizeHint(value.modifier);
    size += StorageEntryType.codec.sizeHint(value.type);
    size += U8SequenceCodec.codec.sizeHint(value.defaultValue);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }
}
