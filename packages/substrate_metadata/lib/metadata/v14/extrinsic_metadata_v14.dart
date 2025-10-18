part of metadata;

/// Metadata about extrinsics (transactions) in MetadataV14
///
/// Describes the structure and format of extrinsics (transactions)
/// including what signed extensions are applied.
class ExtrinsicMetadataV14 {
  /// Type ID of the extrinsic type
  ///
  /// References the complete extrinsic structure in the type registry.
  final int type;

  /// Version of the extrinsic format
  ///
  /// Typically 4 for modern Substrate chains.
  final int version;

  /// List of signed extensions applied to extrinsics
  ///
  /// Signed extensions add additional data and validation to transactions,
  /// such as nonce checks, mortality, and tip payments.
  /// The order matters as they are applied in sequence.
  final List<SignedExtensionMetadataV14> signedExtensions;

  const ExtrinsicMetadataV14({
    required this.type,
    required this.version,
    required this.signedExtensions,
  });

  /// Codec instance for ExtrinsicMetadataV14
  static const $ExtrinsicMetadataV14 codec = $ExtrinsicMetadataV14._();

  Map<String, dynamic> toJson() => {
        'type': type,
        'version': version,
        'signed_extensions': signedExtensions.map((e) => e.toJson()).toList(),
      };
}

/// Codec for ExtrinsicMetadataV14
class $ExtrinsicMetadataV14 with Codec<ExtrinsicMetadataV14> {
  const $ExtrinsicMetadataV14._();

  @override
  ExtrinsicMetadataV14 decode(Input input) {
    final type = CompactCodec.codec.decode(input);

    // Decode extrinsic version
    final version = U8Codec.codec.decode(input);

    // Decode signed extensions
    final signedExtensions = SequenceCodec(SignedExtensionMetadataV14.codec).decode(input);

    return ExtrinsicMetadataV14(
      type: type,
      version: version,
      signedExtensions: signedExtensions,
    );
  }

  @override
  void encodeTo(ExtrinsicMetadataV14 value, Output output) {
    // Encode extrinsic type ID
    CompactCodec.codec.encodeTo(value.type, output);

    // Encode extrinsic version
    U8Codec.codec.encodeTo(value.version, output);

    // Encode signed extensions
    SequenceCodec(SignedExtensionMetadataV14.codec).encodeTo(value.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV14 value) {
    var size = 0;
    size += CompactCodec.codec.sizeHint(value.type);
    size += U8Codec.codec.sizeHint(value.version);
    size += SequenceCodec(SignedExtensionMetadataV14.codec).sizeHint(value.signedExtensions);
    return size;
  }
}
