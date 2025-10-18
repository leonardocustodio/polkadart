part of metadata;

/// Metadata about a single pallet (module) in MetadataV14
///
/// A pallet is a logical unit of functionality in a Substrate runtime.
/// Examples include System, Balances, Timestamp, Staking, etc.
class PalletMetadataV14 {
  /// Name of the pallet
  ///
  /// This is the identifier used in the runtime (e.g., "System", "Balances").
  final String name;

  /// Optional storage metadata for this pallet
  ///
  /// Contains information about all storage items defined in this pallet.
  /// Null if the pallet has no storage.
  final PalletStorageMetadataV14? storage;

  /// Optional calls (dispatchable functions) metadata
  ///
  /// References an enum type containing all callable functions in this pallet.
  /// Null if the pallet has no callable functions.
  final PalletCallMetadataV14? calls;

  /// Optional events metadata
  ///
  /// References an enum type containing all events that can be emitted by this pallet.
  /// Null if the pallet emits no events.
  final PalletEventMetadataV14? event;

  /// List of constants defined in this pallet
  ///
  /// Constants are compile-time values configured in the runtime.
  final List<PalletConstantMetadataV14> constants;

  /// Optional error metadata
  ///
  /// References an enum type containing all possible errors from this pallet.
  /// Null if the pallet defines no errors.
  final PalletErrorMetadataV14? error;

  /// Unique index of this pallet in the runtime
  ///
  /// Used as a discriminant when encoding calls, events, and errors.
  final int index;

  const PalletMetadataV14({
    required this.name,
    this.storage,
    this.calls,
    this.event,
    required this.constants,
    this.error,
    required this.index,
  });

  /// Codec instance for PalletMetadataV14
  static const $PalletMetadataV14 codec = $PalletMetadataV14._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'storage': storage?.toJson(),
        'calls': calls?.toJson(),
        'event': event?.toJson(),
        'constants': constants.map((c) => c.toJson()).toList(),
        'error': error?.toJson(),
        'index': index,
      };
}

/// Codec for PalletMetadataV14
///
/// Handles encoding and decoding of pallet metadata.
class $PalletMetadataV14 with Codec<PalletMetadataV14> {
  const $PalletMetadataV14._();

  @override
  PalletMetadataV14 decode(Input input) {
    // Decode pallet name
    final name = StrCodec.codec.decode(input);

    // Decode optional storage
    final storage = OptionCodec(PalletStorageMetadataV14.codec).decode(input);

    // Decode optional calls
    final calls = OptionCodec(PalletCallMetadataV14.codec).decode(input);

    // Decode optional event
    final event = OptionCodec(PalletEventMetadataV14.codec).decode(input);

    // Decode constants
    final constants = SequenceCodec(PalletConstantMetadataV14.codec).decode(input);

    // Decode optional error
    final error = OptionCodec(PalletErrorMetadataV14.codec).decode(input);

    // Decode pallet index
    final index = U8Codec.codec.decode(input);

    return PalletMetadataV14(
      name: name,
      storage: storage,
      calls: calls,
      event: event,
      constants: constants,
      error: error,
      index: index,
    );
  }

  @override
  void encodeTo(PalletMetadataV14 value, Output output) {
    // Encode pallet name
    StrCodec.codec.encodeTo(value.name, output);

    // Encode optional storage
    OptionCodec(PalletStorageMetadataV14.codec).encodeTo(value.storage, output);

    // Encode optional calls
    OptionCodec(PalletCallMetadataV14.codec).encodeTo(value.calls, output);

    // Encode optional event
    OptionCodec(PalletEventMetadataV14.codec).encodeTo(value.event, output);

    // Encode constants
    SequenceCodec(PalletConstantMetadataV14.codec).encodeTo(value.constants, output);

    // Encode optional error
    OptionCodec(PalletErrorMetadataV14.codec).encodeTo(value.error, output);

    // Encode pallet index
    U8Codec.codec.encodeTo(value.index, output);
  }

  @override
  int sizeHint(PalletMetadataV14 value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += OptionCodec(PalletStorageMetadataV14.codec).sizeHint(value.storage);
    size += OptionCodec(PalletCallMetadataV14.codec).sizeHint(value.calls);
    size += OptionCodec(PalletEventMetadataV14.codec).sizeHint(value.event);
    size += SequenceCodec(PalletConstantMetadataV14.codec).sizeHint(value.constants);
    size += OptionCodec(PalletErrorMetadataV14.codec).sizeHint(value.error);
    size += U8Codec.codec.sizeHint(value.index);
    return size;
  }
}
