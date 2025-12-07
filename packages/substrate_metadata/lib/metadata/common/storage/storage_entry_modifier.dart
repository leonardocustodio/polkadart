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

  @override
  bool isSizeZero() => false; // Always encodes 1 byte
}
