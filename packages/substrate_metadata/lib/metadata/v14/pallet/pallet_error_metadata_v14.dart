part of metadata;

/// Metadata about errors in a pallet (MetadataV14)
///
/// References an enum type in the type registry that contains all
/// possible errors that can be returned by this pallet.
class PalletErrorMetadataV14 {
  /// Type ID referencing the enum of all errors in this pallet
  ///
  /// Points to a TypeDefVariantType in the PortableRegistry where each
  /// variant represents a possible error condition.
  final int type;

  const PalletErrorMetadataV14({required this.type});

  /// Codec instance for PalletErrorMetadataV14
  static const $PalletErrorMetadataV14 codec = $PalletErrorMetadataV14._();

  Map<String, dynamic> toJson() => {'type': type};
}

/// Codec for PalletErrorMetadataV14
class $PalletErrorMetadataV14 with Codec<PalletErrorMetadataV14> {
  const $PalletErrorMetadataV14._();

  @override
  PalletErrorMetadataV14 decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return PalletErrorMetadataV14(type: type);
  }

  @override
  void encodeTo(PalletErrorMetadataV14 value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PalletErrorMetadataV14 value) {
    return CompactCodec.codec.sizeHint(value.type);
  }
}
