part of metadata;

/// Metadata about a single pallet (module) in MetadataV16
/// 
/// V16 adds:
/// - Associated types from Config traits
/// - Deprecation information
class PalletMetadataV16 extends PalletMetadataV15 {
  /// Associated types from the Config trait
  final List<PalletAssociatedTypeMetadata> associatedTypes;

  /// Deprecation information for this pallet
  final DeprecationInfo? deprecationInfo;

  const PalletMetadataV16({
    required super.name,
    super.storage,
    super.calls,
    super.event,
    required super.constants,
    super.error,
    required super.index,
    super.docs = const <String>[],
    this.associatedTypes = const <PalletAssociatedTypeMetadata>[],
    this.deprecationInfo,
  });

  /// Codec instance for PalletMetadataV16
  static const $PalletMetadataV16 codec = $PalletMetadataV16._();

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        'associatedTypes': associatedTypes.map((t) => t.toJson()).toList(),
        if (deprecationInfo != null) 'deprecationInfo': deprecationInfo!.toJson(),
      };
}

/// Codec for PalletMetadataV16
class $PalletMetadataV16 with Codec<PalletMetadataV16> {
  const $PalletMetadataV16._();

  @override
  PalletMetadataV16 decode(Input input) {
    // Decode V15 fields first
    final palletMetadata = PalletMetadataV15.codec.decode(input);
    
    // Decode V16 additions
    final associatedTypes = SequenceCodec(PalletAssociatedTypeMetadata.codec).decode(input);
    final hasDeprecation = BoolCodec.codec.decode(input);
    final deprecationInfo = hasDeprecation ? DeprecationInfo.codec.decode(input) : null;

    return PalletMetadataV16(
      name: palletMetadata.name,
      storage: palletMetadata.storage,
      calls: palletMetadata.calls,
      event: palletMetadata.event,
      constants: palletMetadata.constants,
      error: palletMetadata.error,
      index: palletMetadata.index,
      docs: palletMetadata.docs,
      associatedTypes: associatedTypes,
      deprecationInfo: deprecationInfo,
    );
  }

  @override
  void encodeTo(PalletMetadataV16 value, Output output) {
    // Encode V15 fields
    PalletMetadataV15.codec.encodeTo(value, output);
    
    // Encode V16 additions
    SequenceCodec(PalletAssociatedTypeMetadata.codec).encodeTo(value.associatedTypes, output);
    BoolCodec.codec.encodeTo(value.deprecationInfo != null, output);
    if (value.deprecationInfo != null) {
      DeprecationInfo.codec.encodeTo(value.deprecationInfo!, output);
    }
  }

  @override
  int sizeHint(PalletMetadataV16 value) {
    var size = 0;
    size += PalletMetadataV15.codec.sizeHint(value);
    size += SequenceCodec(PalletAssociatedTypeMetadata.codec).sizeHint(value.associatedTypes);
    size += BoolCodec.codec.sizeHint(value.deprecationInfo != null);
    if (value.deprecationInfo != null) {
      size += DeprecationInfo.codec.sizeHint(value.deprecationInfo!);
    }
    return size;
  }
}