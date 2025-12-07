part of metadata;

/// Metadata about a single pallet (module)
///
/// A pallet is a logical unit of functionality in a Substrate runtime.
/// Examples include System, Balances, Timestamp, Staking, etc.
class PalletMetadataV14 extends PalletMetadata {
  const PalletMetadataV14({
    required super.name,
    super.storage,
    super.calls,
    super.event,
    required super.constants,
    super.error,
    required super.index,
  });

  /// Codec instance for PalletMetadataV14
  static const $PalletMetadataV14 codec = $PalletMetadataV14._();
}

/// Codec for PalletMetadataV14
///
/// Handles encoding and decoding of pallet metadata.
class $PalletMetadataV14 with Codec<PalletMetadataV14> {
  const $PalletMetadataV14._();

  @override
  PalletMetadataV14 decode(Input input) {
    final palletMetadata = PalletMetadata.codec.decode(input);

    return PalletMetadataV14(
      name: palletMetadata.name,
      storage: palletMetadata.storage,
      calls: palletMetadata.calls,
      event: palletMetadata.event,
      constants: palletMetadata.constants,
      error: palletMetadata.error,
      index: palletMetadata.index,
    );
  }

  @override
  void encodeTo(PalletMetadataV14 value, Output output) {
    PalletMetadata.codec.encodeTo(value, output);
  }

  @override
  int sizeHint(PalletMetadataV14 value) {
    return PalletMetadata.codec.sizeHint(value);
  }

  @override
  bool isSizeZero() => PalletMetadata.codec.isSizeZero();
}
