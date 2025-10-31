part of metadata;

/// Metadata about a pallet constant
///
/// Constants are compile-time values configured in the runtime.
/// They cannot be changed without a runtime upgrade.
class PalletConstantMetadata {
  /// Name of the constant
  final String name;

  /// Type ID of the constant
  ///
  /// References a type in the PortableRegistry.
  final int type;

  /// Value of the constant (SCALE encoded)
  ///
  /// The value is already SCALE-encoded and can be decoded using
  /// the type information from the registry.
  final List<int> value;

  /// Documentation for this constant
  ///
  /// Contains the documentation comments from the source code.
  final List<String> docs;

  const PalletConstantMetadata({
    required this.name,
    required this.type,
    required this.value,
    this.docs = const [],
  });

  /// Codec instance for PalletConstantMetadata
  static const $PalletConstantMetadata codec = $PalletConstantMetadata._();

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'value': value,
        'docs': docs,
      };
}

/// Codec for PalletConstantMetadata
class $PalletConstantMetadata with Codec<PalletConstantMetadata> {
  const $PalletConstantMetadata._();

  @override
  PalletConstantMetadata decode(Input input) {
    // Decode constant name
    final name = StrCodec.codec.decode(input);

    // Decode type ID
    final type = CompactCodec.codec.decode(input);

    // Decode SCALE-encoded value
    final value = U8SequenceCodec.codec.decode(input);

    // Decode documentation
    final docs = SequenceCodec(StrCodec.codec).decode(input);

    return PalletConstantMetadata(
      name: name,
      type: type,
      value: value,
      docs: docs,
    );
  }

  @override
  void encodeTo(PalletConstantMetadata value, Output output) {
    // Encode constant name
    StrCodec.codec.encodeTo(value.name, output);

    // Encode type ID
    CompactCodec.codec.encodeTo(value.type, output);

    // Encode SCALE-encoded value
    U8SequenceCodec.codec.encodeTo(value.value, output);

    // Encode documentation
    SequenceCodec(StrCodec.codec).encodeTo(value.docs, output);
  }

  @override
  int sizeHint(PalletConstantMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.name);
    size += CompactCodec.codec.sizeHint(value.type);
    size += U8SequenceCodec.codec.sizeHint(value.value);
    size += SequenceCodec(StrCodec.codec).sizeHint(value.docs);
    return size;
  }

  @override
  bool isSizeZero() {
    return StrCodec.codec.isSizeZero() &&
        CompactCodec.codec.isSizeZero() &&
        U8SequenceCodec.codec.isSizeZero() &&
        SequenceCodec(StrCodec.codec).isSizeZero();
  }
}
