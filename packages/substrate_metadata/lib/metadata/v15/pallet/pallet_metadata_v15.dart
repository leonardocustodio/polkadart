part of metadata;

/// Metadata about a single pallet (module) in MetadataV15
///
/// V15 adds documentation field to pallet metadata.
class PalletMetadataV15 {
  /// Name of the pallet
  final String name;

  /// Optional storage metadata for this pallet
  final PalletStorageMetadataV15? storage;

  /// Optional calls (dispatchable functions) metadata
  final PalletCallMetadataV15? calls;

  /// Optional events metadata
  final PalletEventMetadataV15? event;

  /// List of constants defined in this pallet
  final List<PalletConstantMetadataV15> constants;

  /// Optional error metadata
  final PalletErrorMetadataV15? error;

  /// Unique index of this pallet in the runtime
  final int index;

  /// Documentation for this pallet (new in V15)
  final List<String> docs;

  const PalletMetadataV15({
    required this.name,
    this.storage,
    this.calls,
    this.event,
    required this.constants,
    this.error,
    required this.index,
    this.docs = const [],
  });

  /// Codec instance for PalletMetadataV15
  static const $PalletMetadataV15 codec = $PalletMetadataV15._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'storage': storage?.toJson(),
        'calls': calls?.toJson(),
        'event': event?.toJson(),
        'constants': constants.map((c) => c.toJson()).toList(),
        'error': error?.toJson(),
        'index': index,
        'docs': docs,
      };
}

/// Codec for PalletMetadataV15
class $PalletMetadataV15 with Codec<PalletMetadataV15> {
  const $PalletMetadataV15._();

  @override
  PalletMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final storage = OptionCodec(PalletStorageMetadataV15.codec).decode(input);
    final calls = OptionCodec(PalletCallMetadataV15.codec).decode(input);
    final event = OptionCodec(PalletEventMetadataV15.codec).decode(input);
    final constants = SequenceCodec(PalletConstantMetadataV15.codec).decode(input);
    final error = OptionCodec(PalletErrorMetadataV15.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input); // New in V15

    return PalletMetadataV15(
      name: name,
      storage: storage,
      calls: calls,
      event: event,
      constants: constants,
      error: error,
      index: index,
      docs: docs,
    );
  }

  @override
  void encodeTo(PalletMetadataV15 value, Output output) {
    StrCodec.codec.encodeTo(value.name, output);
    OptionCodec(PalletStorageMetadataV15.codec).encodeTo(value.storage, output);
    OptionCodec(PalletCallMetadataV15.codec).encodeTo(value.calls, output);
    OptionCodec(PalletEventMetadataV15.codec).encodeTo(value.event, output);
    SequenceCodec(PalletConstantMetadataV15.codec).encodeTo(value.constants, output);
    OptionCodec(PalletErrorMetadataV15.codec).encodeTo(value.error, output);
    U8Codec.codec.encodeTo(value.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output); // New in V15
  }

  @override
  int sizeHint(PalletMetadataV15 value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += OptionCodec(PalletStorageMetadataV15.codec).sizeHint(value.storage);
    size += OptionCodec(PalletCallMetadataV15.codec).sizeHint(value.calls);
    size += OptionCodec(PalletEventMetadataV15.codec).sizeHint(value.event);
    size += SequenceCodec(PalletConstantMetadataV15.codec).sizeHint(value.constants);
    size += OptionCodec(PalletErrorMetadataV15.codec).sizeHint(value.error);
    size += U8Codec.codec.sizeHint(value.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs); // New in V15
    return size;
  }
}
