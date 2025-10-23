part of metadata;

/// Main metadata container for a Substrate runtime (Version 16)
///
/// V16:
/// - Associated types from Config traits
/// - Deprecation information
/// - Support for multiple extrinsic versions
/// - Pallet view functions
class RuntimeMetadataV16 extends RuntimeMetadata {
  /// List of all registered types
  final List<PortableType> types;

  /// List of all pallets (modules) in the runtime
  final List<PalletMetadataV16> pallets;

  /// Metadata about the extrinsic format
  final ExtrinsicMetadataV16 extrinsic;

  /// Type ID of the Runtime type itself
  final int type;

  /// List of runtime APIs
  final List<RuntimeApiMetadataV16> apis;

  /// Outer enum type IDs
  final OuterEnumsV16 outerEnums;

  const RuntimeMetadataV16({
    required this.types,
    required this.pallets,
    required this.extrinsic,
    required this.type,
    required this.apis,
    required this.outerEnums,
  });

  /// Codec instance for RuntimeMetadataV16
  static const $RuntimeMetadataV16 codec = $RuntimeMetadataV16._();

  @override
  int get version => 16;

  @override
  PortableType typeById(int id) {
    return types.firstWhere((type) => type.id == id);
  }

  @override
  Map<String, dynamic> toJson() => {
        'types': types.map((final PortableType value) => value.toJson()).toList(growable: false),
        'pallets': pallets.map((p) => p.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
        'type': type,
        'apis': apis.map((a) => a.toJson()).toList(),
        'outerEnums': {
          'callType': outerEnums.callType,
          'eventType': outerEnums.eventType,
          'errorType': outerEnums.errorType,
        },
      };
}

/// Codec for RuntimeMetadataV16
class $RuntimeMetadataV16 with Codec<RuntimeMetadataV16> {
  const $RuntimeMetadataV16._();

  @override
  RuntimeMetadataV16 decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);
    final pallets = SequenceCodec(PalletMetadataV16.codec).decode(input);
    final extrinsic = ExtrinsicMetadataV16.codec.decode(input);
    final type = CompactCodec.codec.decode(input);
    final apis = SequenceCodec(RuntimeApiMetadataV16.codec).decode(input);
    final outerEnums = OuterEnumsV16.codec.decode(input);

    return RuntimeMetadataV16(
      types: types,
      pallets: pallets,
      extrinsic: extrinsic,
      type: type,
      apis: apis,
      outerEnums: outerEnums,
    );
  }

  @override
  void encodeTo(RuntimeMetadataV16 metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);
    SequenceCodec(PalletMetadataV16.codec).encodeTo(metadata.pallets, output);
    ExtrinsicMetadataV16.codec.encodeTo(metadata.extrinsic, output);
    CompactCodec.codec.encodeTo(metadata.type, output);
    SequenceCodec(RuntimeApiMetadataV16.codec).encodeTo(metadata.apis, output);
    OuterEnumsV16.codec.encodeTo(metadata.outerEnums, output);
  }

  @override
  int sizeHint(RuntimeMetadataV16 value) {
    var size = 0;
    size += SequenceCodec(PortableType.codec).sizeHint(value.types);
    size += SequenceCodec(PalletMetadataV16.codec).sizeHint(value.pallets);
    size += ExtrinsicMetadataV16.codec.sizeHint(value.extrinsic);
    size += CompactCodec.codec.sizeHint(value.type);
    size += SequenceCodec(RuntimeApiMetadataV16.codec).sizeHint(value.apis);
    size += OuterEnumsV16.codec.sizeHint(value.outerEnums);
    return size;
  }
}

typedef OuterEnumsV16 = OuterEnumsV15;
