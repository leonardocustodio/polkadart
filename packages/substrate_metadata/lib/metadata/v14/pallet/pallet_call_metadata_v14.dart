part of metadata;

/// Metadata about callable functions in a pallet (MetadataV14)
///
/// References an enum type in the type registry that contains all
/// dispatchable functions (calls) available in this pallet.
class PalletCallMetadataV14 {
  /// Type ID referencing the enum of all calls in this pallet
  ///
  /// Points to a TypeDefVariantType in the PortableRegistry where each
  /// variant represents a callable function with its parameters.
  final int type;
  const PalletCallMetadataV14({required this.type});

  /// Codec instance for PalletCallMetadataV14
  static const $PalletCallMetadataV14 codec = $PalletCallMetadataV14._();

  Map<String, int> toJson() => {'type': type};
}

/// Codec for PalletCallMetadataV14
class $PalletCallMetadataV14 with Codec<PalletCallMetadataV14> {
  const $PalletCallMetadataV14._();

  @override
  PalletCallMetadataV14 decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return PalletCallMetadataV14(type: type);
  }

  @override
  void encodeTo(PalletCallMetadataV14 value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PalletCallMetadataV14 value) {
    return CompactCodec.codec.sizeHint(value.type);
  }
}
