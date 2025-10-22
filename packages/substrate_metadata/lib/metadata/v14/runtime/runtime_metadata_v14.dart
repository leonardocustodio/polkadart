part of metadata;

/// Main metadata container for a Substrate runtime (Version 14)
///
/// This is the root structure that contains all metadata information about
/// a Substrate blockchain runtime, including type registry, pallets, and extrinsic format.
class RuntimeMetadataV14 extends RuntimeMetadata {
  /// List of all registered types
  ///
  /// Each type has a unique ID (its index in this list) and a complete
  /// definition including its structure and documentation.
  final List<PortableType> types;

  /// List of all pallets (modules) in the runtime
  ///
  /// Each pallet represents a logical unit of functionality in the blockchain,
  /// such as Balances, System, or Staking.
  final List<PalletMetadataV14> pallets;

  /// Metadata about the extrinsic format used by the runtime
  ///
  /// Describes how transactions (extrinsics) are structured and what
  /// signed extensions are applied.
  final ExtrinsicMetadataV14 extrinsic;

  /// Type ID of the Runtime type itself
  ///
  /// This references a type in the [types] registry that describes
  /// the overall runtime structure.
  final int type;

  const RuntimeMetadataV14({
    required this.types,
    required this.pallets,
    required this.extrinsic,
    required this.type,
  });

  /// Codec instance for RuntimeMetadataV14
  static const $RuntimeMetadataV14 codec = $RuntimeMetadataV14._();

  @override
  int get version => 14;

  @override
  PortableType typeById(int id) {
    return types.firstWhere((type) => type.id == id);
  }

  @override
  Map<String, dynamic> toJson() => {
        'types': types.map((final PortableType value) => value.toJson()).toList(growable: false),
        'pallets': pallets.map((pallet) => pallet.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
        'type': type,
      };
}

/// Codec for RuntimeMetadataV14
///
/// Handles encoding and decoding of the main MetadataV14 structure.
/// This is the root codec that orchestrates decoding of all metadata components.
class $RuntimeMetadataV14 with Codec<RuntimeMetadataV14> {
  const $RuntimeMetadataV14._();

  @override
  RuntimeMetadataV14 decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);

    // Decode all pallets
    final pallets = SequenceCodec(PalletMetadataV14.codec).decode(input);

    // Decode extrinsic metadata
    final extrinsic = ExtrinsicMetadataV14.codec.decode(input, types: types);

    // Decode runtime type ID
    final type = CompactCodec.codec.decode(input);

    return RuntimeMetadataV14(
      types: types,
      pallets: pallets,
      extrinsic: extrinsic,
      type: type,
    );
  }

  @override
  void encodeTo(RuntimeMetadataV14 metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);

    // Encode all pallets
    SequenceCodec(PalletMetadataV14.codec).encodeTo(metadata.pallets, output);

    // Encode extrinsic metadata
    ExtrinsicMetadataV14.codec.encodeTo(metadata.extrinsic, output);

    // Encode runtime type ID
    CompactCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(RuntimeMetadataV14 value) {
    var size = 0;
    size += SequenceCodec(PortableType.codec).sizeHint(value.types);
    size += SequenceCodec(PalletMetadataV14.codec).sizeHint(value.pallets);
    size += ExtrinsicMetadataV14.codec.sizeHint(value.extrinsic);
    size += CompactCodec.codec.sizeHint(value.type);
    return size;
  }
}
