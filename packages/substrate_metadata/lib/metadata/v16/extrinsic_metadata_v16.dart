part of metadata;

/// Metadata of the extrinsic used by the runtime (Version 16)
///
/// V16 changes:
/// - Support for multiple extrinsic versions
/// - Renamed signed extensions to transaction extensions
/// - Removed separate call type (using outer enum type)
class ExtrinsicMetadataV16 extends ExtrinsicMetadata {
  /// List of supported extrinsic versions
  final List<int> versions;

  /// Transaction extensions (previously signed extensions)
  final List<TransactionExtensionMetadata> transactionExtensions;

  const ExtrinsicMetadataV16({
    required this.versions,
    required super.addressType,
    required super.signatureType,
    required super.extraType,
    required this.transactionExtensions,
  }) : super(
          // TODO: Fix it.
          version: 0,
          callType: 0, // Using outer enum call type
          signedExtensions: const [], // Replaced by transactionExtensions
        );

  /// Codec instance for ExtrinsicMetadataV16
  static const $ExtrinsicMetadataV16 codec = $ExtrinsicMetadataV16._();

  @override
  Map<String, dynamic> toJson() => {
        'versions': versions,
        'addressType': addressType,
        'signatureType': signatureType,
        'extraType': extraType,
        'transactionExtensions': transactionExtensions.map((e) => e.toJson()).toList(),
      };
}

/// Codec for ExtrinsicMetadataV16
class $ExtrinsicMetadataV16 with Codec<ExtrinsicMetadataV16> {
  const $ExtrinsicMetadataV16._();

  @override
  ExtrinsicMetadataV16 decode(Input input) {
    // Decode versions array
    final versions = SequenceCodec(U8Codec.codec).decode(input);

    // Decode type IDs
    final addressType = CompactCodec.codec.decode(input);
    final signatureType = CompactCodec.codec.decode(input);
    final extraType = CompactCodec.codec.decode(input);

    // Decode transaction extensions
    final transactionExtensions = SequenceCodec(TransactionExtensionMetadata.codec).decode(input);

    return ExtrinsicMetadataV16(
      versions: versions,
      addressType: addressType,
      signatureType: signatureType,
      extraType: extraType,
      transactionExtensions: transactionExtensions,
    );
  }

  @override
  void encodeTo(ExtrinsicMetadataV16 value, Output output) {
    SequenceCodec(U8Codec.codec).encodeTo(value.versions, output);
    CompactCodec.codec.encodeTo(value.addressType, output);
    CompactCodec.codec.encodeTo(value.signatureType, output);
    CompactCodec.codec.encodeTo(value.extraType, output);
    SequenceCodec(TransactionExtensionMetadata.codec).encodeTo(value.transactionExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV16 value) {
    var size = 0;
    size += SequenceCodec(U8Codec.codec).sizeHint(value.versions);
    size += CompactCodec.codec.sizeHint(value.addressType);
    size += CompactCodec.codec.sizeHint(value.signatureType);
    size += CompactCodec.codec.sizeHint(value.extraType);
    size += SequenceCodec(TransactionExtensionMetadata.codec).sizeHint(value.transactionExtensions);
    return size;
  }
}

/// Metadata of a transaction extension (renamed from signed extension in V16)
class TransactionExtensionMetadata {
  /// The unique identifier
  final String identifier;

  /// The type included in the extrinsic
  final int type;

  /// Additional signed data type
  final int additionalSigned;

  /// Extension version
  final int version;

  const TransactionExtensionMetadata({
    required this.identifier,
    required this.type,
    required this.additionalSigned,
    this.version = 0,
  });

  static const $TransactionExtensionMetadata codec = $TransactionExtensionMetadata._();

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'type': type,
        'additionalSigned': additionalSigned,
        'version': version,
      };
}

class $TransactionExtensionMetadata with Codec<TransactionExtensionMetadata> {
  const $TransactionExtensionMetadata._();

  @override
  TransactionExtensionMetadata decode(Input input) {
    final identifier = StrCodec.codec.decode(input);
    final type = CompactCodec.codec.decode(input);
    final additionalSigned = CompactCodec.codec.decode(input);
    final version = U8Codec.codec.decode(input);

    return TransactionExtensionMetadata(
      identifier: identifier,
      type: type,
      additionalSigned: additionalSigned,
      version: version,
    );
  }

  @override
  void encodeTo(TransactionExtensionMetadata value, Output output) {
    StrCodec.codec.encodeTo(value.identifier, output);
    CompactCodec.codec.encodeTo(value.type, output);
    CompactCodec.codec.encodeTo(value.additionalSigned, output);
    U8Codec.codec.encodeTo(value.version, output);
  }

  @override
  int sizeHint(TransactionExtensionMetadata value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.identifier);
    size += CompactCodec.codec.sizeHint(value.type);
    size += CompactCodec.codec.sizeHint(value.additionalSigned);
    size += U8Codec.codec.sizeHint(value.version);
    return size;
  }
}