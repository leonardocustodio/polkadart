part of metadata;

/// Metadata about extrinsics (transactions) in MetadataV15
///
/// V15 introduces "transaction extensions" which replace "signed extensions".
/// This is a more general concept that allows extensions to modify both
/// signed and unsigned extrinsics.
class ExtrinsicMetadataV15 {
  /// Version of the extrinsic format
  ///
  /// Typically 4 or 5 for modern Substrate chains.
  final int version;

  /// Type ID of the address type
  ///
  /// New in V15: Explicitly specifies the address type used in extrinsics.
  final int addressType;

  /// Type ID of the call type
  ///
  /// New in V15: Explicitly specifies the call enum type.
  final int callType;

  /// Type ID of the signature type
  ///
  /// New in V15: Explicitly specifies the signature type.
  final int signatureType;

  /// Type ID of the extra data type
  ///
  /// New in V15: Type of the extra data in extrinsics.
  final int extraType;

  /// List of transaction extensions
  ///
  /// Renamed from "signed extensions" in V14.
  /// Transaction extensions can modify both signed and unsigned extrinsics.
  final List<TransactionExtensionMetadataV15> transactionExtensions;

  const ExtrinsicMetadataV15({
    required this.version,
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
    required this.transactionExtensions,
  });

  /// Codec instance for ExtrinsicMetadataV15
  static const $ExtrinsicMetadataV15 codec = $ExtrinsicMetadataV15._();

  Map<String, dynamic> toJson() => {
        'version': version,
        'addressType': addressType,
        'callType': callType,
        'signatureType': signatureType,
        'extraType': extraType,
        'transactionExtensions': transactionExtensions.map((te) => te.toJson()).toList(),
      };
}

/// Codec for ExtrinsicMetadataV15
class $ExtrinsicMetadataV15 with Codec<ExtrinsicMetadataV15> {
  const $ExtrinsicMetadataV15._();

  @override
  ExtrinsicMetadataV15 decode(Input input) {
    final version = U8Codec.codec.decode(input);
    final addressType = CompactCodec.codec.decode(input);
    final callType = CompactCodec.codec.decode(input);
    final signatureType = CompactCodec.codec.decode(input);
    final extraType = CompactCodec.codec.decode(input);
    final transactionExtensions =
        SequenceCodec(TransactionExtensionMetadataV15.codec).decode(input);

    return ExtrinsicMetadataV15(
      version: version,
      addressType: addressType,
      callType: callType,
      signatureType: signatureType,
      extraType: extraType,
      transactionExtensions: transactionExtensions,
    );
  }

  @override
  void encodeTo(ExtrinsicMetadataV15 value, Output output) {
    U8Codec.codec.encodeTo(value.version, output);
    CompactCodec.codec.encodeTo(value.addressType, output);
    CompactCodec.codec.encodeTo(value.callType, output);
    CompactCodec.codec.encodeTo(value.signatureType, output);
    CompactCodec.codec.encodeTo(value.extraType, output);
    SequenceCodec(TransactionExtensionMetadataV15.codec)
        .encodeTo(value.transactionExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV15 value) {
    var size = 0;
    size += U8Codec.codec.sizeHint(value.version);
    size += CompactCodec.codec.sizeHint(value.addressType);
    size += CompactCodec.codec.sizeHint(value.callType);
    size += CompactCodec.codec.sizeHint(value.signatureType);
    size += CompactCodec.codec.sizeHint(value.extraType);
    size +=
        SequenceCodec(TransactionExtensionMetadataV15.codec).sizeHint(value.transactionExtensions);
    return size;
  }
}

/// Metadata about a transaction extension (V15)
///
/// Transaction extensions are the V15 evolution of "signed extensions".
/// They can modify both signed and unsigned extrinsics.
class TransactionExtensionMetadataV15 {
  /// Unique identifier for this extension
  final String identifier;

  /// Type ID of the extension's data type
  final int typeId;

  /// Type ID of the additional signed data
  final int additionalSignedTypeId;

  const TransactionExtensionMetadataV15({
    required this.identifier,
    required this.typeId,
    required this.additionalSignedTypeId,
  });

  /// Codec instance for TransactionExtensionMetadataV15
  static const $TransactionExtensionMetadataV15 codec = $TransactionExtensionMetadataV15._();

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'typeId': typeId,
        'additionalSignedTypeId': additionalSignedTypeId,
      };
}

/// Codec for TransactionExtensionMetadataV15
class $TransactionExtensionMetadataV15 with Codec<TransactionExtensionMetadataV15> {
  const $TransactionExtensionMetadataV15._();

  @override
  TransactionExtensionMetadataV15 decode(Input input) {
    final identifier = StrCodec.codec.decode(input);
    final typeId = CompactCodec.codec.decode(input);
    final additionalSignedTypeId = CompactCodec.codec.decode(input);

    return TransactionExtensionMetadataV15(
      identifier: identifier,
      typeId: typeId,
      additionalSignedTypeId: additionalSignedTypeId,
    );
  }

  @override
  void encodeTo(TransactionExtensionMetadataV15 value, Output output) {
    StrCodec.codec.encodeTo(value.identifier, output);
    CompactCodec.codec.encodeTo(value.typeId, output);
    CompactCodec.codec.encodeTo(value.additionalSignedTypeId, output);
  }

  @override
  int sizeHint(TransactionExtensionMetadataV15 value) {
    return StrCodec.codec.sizeHint(value.identifier) +
        CompactCodec.codec.sizeHint(value.typeId) +
        CompactCodec.codec.sizeHint(value.additionalSignedTypeId);
  }
}
