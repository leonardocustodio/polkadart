part of metadata;

/// Metadata about a single pallet (module) in MetadataV15
///
/// V15 adds documentation field to pallet metadata.
class PalletMetadataV15 extends PalletMetadata {
  /// Documentation for this pallet (new in V15)
  final List<String> docs;

  const PalletMetadataV15({
    required super.name,
    super.storage,
    super.calls,
    super.event,
    required super.constants,
    super.error,
    required super.index,
    this.docs = const <String>[],
  });

  /// Codec instance for PalletMetadataV15
  static const $PalletMetadataV15 codec = $PalletMetadataV15._();

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'docs': docs,
      };
}

/// Codec for PalletMetadataV15
class $PalletMetadataV15 with Codec<PalletMetadataV15> {
  const $PalletMetadataV15._();

  @override
  PalletMetadataV15 decode(Input input) {
    final palletMetadata = PalletMetadata.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input); // New in V15

    return PalletMetadataV15(
      name: palletMetadata.name,
      storage: palletMetadata.storage,
      calls: palletMetadata.calls,
      event: palletMetadata.event,
      constants: palletMetadata.constants,
      error: palletMetadata.error,
      index: palletMetadata.index,
      docs: docs,
    );
  }

  @override
  void encodeTo(PalletMetadataV15 value, Output output) {
    PalletMetadata.codec.encodeTo(value, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output); // New in V15
  }

  @override
  int sizeHint(PalletMetadataV15 value) {
    var size = 0;
    size += PalletMetadata.codec.sizeHint(value);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs); // New in V15
    return size;
  }
}
