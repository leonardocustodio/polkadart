part of metadata;

class PalletMetadata {
  /// Name of the pallet
  ///
  /// This is the identifier used in the runtime (e.g., "System", "Balances").
  final String name;

  /// Optional storage metadata for this pallet
  ///
  /// Contains information about all storage items defined in this pallet.
  /// Null if the pallet has no storage.
  final PalletStorageMetadata? storage;

  /// Optional calls (dispatchable functions) metadata
  ///
  /// References an enum type containing all callable functions in this pallet.
  /// Null if the pallet has no callable functions.
  final PalletCallMetadata? calls;

  /// Optional events metadata
  ///
  /// References an enum type containing all events that can be emitted by this pallet.
  /// Null if the pallet emits no events.
  final PalletEventMetadata? event;

  /// List of constants defined in this pallet
  ///
  /// Constants are compile-time values configured in the runtime.
  final List<PalletConstantMetadata> constants;

  /// Optional error metadata
  ///
  /// References an enum type containing all possible errors from this pallet.
  /// Null if the pallet defines no errors.
  final PalletErrorMetadata? error;

  /// Unique index of this pallet in the runtime
  ///
  /// Used as a discriminant when encoding calls, events, and errors.
  final int index;

  const PalletMetadata({
    required this.name,
    this.storage,
    this.calls,
    this.event,
    required this.constants,
    this.error,
    required this.index,
  });

  /// Codec instance for PalletMetadata
  static const $PalletMetadata codec = $PalletMetadata._();

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

/// Codec for PalletMetadataV15
class $PalletMetadata with Codec<PalletMetadata> {
  const $PalletMetadata._();

  @override
  PalletMetadata decode(Input input) {
    // Decode pallet name
    final name = StrCodec.codec.decode(input);

    // Decode optional storage
    final storage = OptionCodec(PalletStorageMetadata.codec).decode(input);

    // Decode optional calls
    final calls = OptionCodec(PalletCallMetadata.codec).decode(input);

    // Decode optional event
    final event = OptionCodec(PalletEventMetadata.codec).decode(input);

    // Decode constants
    final constants = SequenceCodec(PalletConstantMetadata.codec).decode(input);

    // Decode optional error
    final error = OptionCodec(PalletErrorMetadata.codec).decode(input);

    // Decode pallet index
    final index = U8Codec.codec.decode(input);

    return PalletMetadata(
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
  void encodeTo(PalletMetadata value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    OptionCodec(PalletStorageMetadata.codec).encodeTo(value.storage, output);
    OptionCodec(PalletCallMetadata.codec).encodeTo(value.calls, output);
    OptionCodec(PalletEventMetadata.codec).encodeTo(value.event, output);
    SequenceCodec(PalletConstantMetadata.codec).encodeTo(value.constants, output);
    OptionCodec(PalletErrorMetadata.codec).encodeTo(value.error, output);
    U8Codec.codec.encodeTo(value.index, output);
  }

  @override
  int sizeHint(PalletMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += OptionCodec(PalletStorageMetadata.codec).sizeHint(value.storage);
    size += OptionCodec(PalletCallMetadata.codec).sizeHint(value.calls);
    size += OptionCodec(PalletEventMetadata.codec).sizeHint(value.event);
    size += SequenceCodec(PalletConstantMetadata.codec).sizeHint(value.constants);
    size += OptionCodec(PalletErrorMetadata.codec).sizeHint(value.error);
    size += U8Codec.codec.sizeHint(value.index);
    return size;
  }

  @override
  bool isSizeZero() {
    return StrCodec.codec.isSizeZero() &&
        OptionCodec(PalletStorageMetadata.codec).isSizeZero() &&
        OptionCodec(PalletCallMetadata.codec).isSizeZero() &&
        OptionCodec(PalletEventMetadata.codec).isSizeZero() &&
        SequenceCodec(PalletConstantMetadata.codec).isSizeZero() &&
        OptionCodec(PalletErrorMetadata.codec).isSizeZero() &&
        U8Codec.codec.isSizeZero();
  }
}
