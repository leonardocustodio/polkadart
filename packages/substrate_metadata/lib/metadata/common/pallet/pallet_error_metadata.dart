part of metadata;

/// Metadata about errors in a pallet
///
/// References an enum type in the type registry that contains all
/// possible errors that can be returned by this pallet.
class PalletErrorMetadata {
  /// Type ID referencing the enum of all errors in this pallet
  ///
  /// Points to a TypeDefVariant in the PortableRegistry where each
  /// variant represents a possible error condition.
  final int type;

  const PalletErrorMetadata({required this.type});

  /// Codec instance for PalletErrorMetadata
  static const $PalletErrorMetadata codec = $PalletErrorMetadata._();

  Map<String, dynamic> toJson() => {'type': type};
}

/// Codec for PalletErrorMetadata
class $PalletErrorMetadata with Codec<PalletErrorMetadata> {
  const $PalletErrorMetadata._();

  @override
  PalletErrorMetadata decode(Input input) {
    final type = CompactCodec.codec.decode(input);
    return PalletErrorMetadata(type: type);
  }

  @override
  void encodeTo(PalletErrorMetadata value, Output output) {
    CompactCodec.codec.encodeTo(value.type, output);
  }

  @override
  int sizeHint(PalletErrorMetadata value) {
    return CompactCodec.codec.sizeHint(value.type);
  }

  @override
  bool isSizeZero() => CompactCodec.codec.isSizeZero();
}
