part of metadata;

/// Metadata about events in a pallet (MetadataV14)
///
/// References an enum type in the type registry that contains all
/// events that can be emitted by this pallet.
class PalletEventMetadataV14 {
  /// Type ID referencing the enum of all events in this pallet
  ///
  /// Points to a TypeDefVariantType in the PortableRegistry where each
  /// variant represents an event with its data fields.
  final int type;
  const PalletEventMetadataV14({required this.type});

  /// Codec instance for PalletEventMetadataV14
  static const $PalletEventMetadataV14 codec = $PalletEventMetadataV14._();

  Map<String, int> toJson() => {'type': type};
}

/// Codec for PalletEventMetadataV14
class $PalletEventMetadataV14 with Codec<PalletEventMetadataV14> {
  const $PalletEventMetadataV14._();

  @override
  PalletEventMetadataV14 decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return PalletEventMetadataV14(type: type);
  }

  @override
  void encodeTo(PalletEventMetadataV14 value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PalletEventMetadataV14 value) {
    return CompactCodec.codec.sizeHint(value.type);
  }
}
