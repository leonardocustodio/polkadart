part of metadata;

/// Main metadata container for a Substrate runtime (Version 15)
class RuntimeMetadataV15 extends RuntimeMetadata {
  /// List of all registered types
  ///
  /// Each type has a unique ID (its index in this list) and a complete
  /// definition including its structure and documentation.
  final List<PortableType> types;

  /// List of all pallets (modules) in the runtime
  ///
  /// Each pallet represents a logical unit of functionality in the blockchain.
  final List<PalletMetadataV15> pallets;

  /// Metadata about the extrinsic format used by the runtime
  ///
  /// Describes how transactions (extrinsics) are structured and what
  /// transaction extensions are applied.
  final ExtrinsicMetadataV15 extrinsic;

  /// Type ID of the Runtime type itself
  ///
  /// This references a type in the [types] registry that describes
  /// the overall runtime structure.
  final int type;

  /// List of runtime APIs exposed by the runtime
  ///
  /// New in V15: Provides metadata about available runtime APIs
  /// that can be called via the state_call RPC method.
  final List<RuntimeApiMetadataV15> apis;

  /// Outer enum type IDs
  ///
  /// New in V15: Direct references to the composite enums containing
  /// all calls, events, and errors from all pallets.
  final OuterEnumsV15 outerEnums;

  const RuntimeMetadataV15({
    required this.types,
    required this.pallets,
    required this.extrinsic,
    required this.type,
    required this.apis,
    required this.outerEnums,
  });

  /// Codec instance for RuntimeMetadataV15
  static const $RuntimeMetadataV15 codec = $RuntimeMetadataV15._();

  @override
  int get version => 14;

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

/// Codec for RuntimeMetadataV15
class $RuntimeMetadataV15 with Codec<RuntimeMetadataV15> {
  const $RuntimeMetadataV15._();

  @override
  RuntimeMetadataV15 decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);

    // Decode all pallets
    final pallets = SequenceCodec(PalletMetadataV15.codec).decode(input);

    // Decode extrinsic metadata
    final extrinsic = ExtrinsicMetadataV15.codec.decode(input);

    // Decode runtime type ID
    final type = CompactCodec.codec.decode(input);

    // Decode runtime APIs (new in V15)
    final apis = SequenceCodec(RuntimeApiMetadataV15.codec).decode(input);

    // Decode outer enums (new in V15)
    final outerEnums = OuterEnumsV15.codec.decode(input);

    return RuntimeMetadataV15(
      types: types,
      pallets: pallets,
      extrinsic: extrinsic,
      type: type,
      apis: apis,
      outerEnums: outerEnums,
    );
  }

  @override
  void encodeTo(RuntimeMetadataV15 metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);

    // Encode all pallets
    SequenceCodec(PalletMetadataV15.codec).encodeTo(metadata.pallets, output);

    // Encode extrinsic metadata
    ExtrinsicMetadataV15.codec.encodeTo(metadata.extrinsic, output);

    // Encode runtime type ID
    CompactCodec.codec.encodeTo(metadata.type, output);

    // Encode runtime APIs
    SequenceCodec(RuntimeApiMetadataV15.codec).encodeTo(metadata.apis, output);

    // Encode outer enums
    OuterEnumsV15.codec.encodeTo(metadata.outerEnums, output);
  }

  @override
  int sizeHint(RuntimeMetadataV15 value) {
    var size = 0;
    size += SequenceCodec(PortableType.codec).sizeHint(value.types);
    size += SequenceCodec(PalletMetadataV15.codec).sizeHint(value.pallets);
    size += ExtrinsicMetadataV15.codec.sizeHint(value.extrinsic);
    size += CompactCodec.codec.sizeHint(value.type);
    size += SequenceCodec(RuntimeApiMetadataV15.codec).sizeHint(value.apis);
    size += OuterEnumsV15.codec.sizeHint(value.outerEnums);
    return size;
  }
}

/// Outer enum type references (V15)
///
/// Contains type IDs for the composite enums that aggregate
/// all calls, events, and errors from all pallets.
class OuterEnumsV15 {
  /// Type ID of the RuntimeCall enum
  ///
  /// This enum contains all callable functions from all pallets.
  final int callType;

  /// Type ID of the RuntimeEvent enum
  ///
  /// This enum contains all events from all pallets.
  final int eventType;

  /// Type ID of the RuntimeError enum
  ///
  /// This enum contains all errors from all pallets.
  final int errorType;

  const OuterEnumsV15({
    required this.callType,
    required this.eventType,
    required this.errorType,
  });

  /// Codec instance for OuterEnumsV15
  static const $OuterEnumsV15 codec = $OuterEnumsV15._();

  Map<String, dynamic> toJson() => {
        'callType': callType,
        'eventType': eventType,
        'errorType': errorType,
      };
}

/// Codec for OuterEnumsV15
class $OuterEnumsV15 with Codec<OuterEnumsV15> {
  const $OuterEnumsV15._();

  @override
  OuterEnumsV15 decode(Input input) {
    final callType = CompactCodec.codec.decode(input);
    final eventType = CompactCodec.codec.decode(input);
    final errorType = CompactCodec.codec.decode(input);

    return OuterEnumsV15(
      callType: callType,
      eventType: eventType,
      errorType: errorType,
    );
  }

  @override
  void encodeTo(OuterEnumsV15 value, Output output) {
    CompactCodec.codec.encodeTo(value.callType, output);
    CompactCodec.codec.encodeTo(value.eventType, output);
    CompactCodec.codec.encodeTo(value.errorType, output);
  }

  @override
  int sizeHint(OuterEnumsV15 value) {
    return CompactCodec.codec.sizeHint(value.callType) +
        CompactCodec.codec.sizeHint(value.eventType) +
        CompactCodec.codec.sizeHint(value.errorType);
  }
}
