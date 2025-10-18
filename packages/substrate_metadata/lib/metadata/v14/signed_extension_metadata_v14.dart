part of metadata;

/// Metadata about a signed extension (MetadataV14)
///
/// Signed extensions modify extrinsic behavior by adding additional
/// data and validation logic to transactions.
class SignedExtensionMetadataV14 {
  /// Unique identifier for this extension
  ///
  /// This may differ from the type name and is used to identify
  /// the extension in the extrinsic format.
  /// Examples: "CheckNonce", "CheckMortality", "ChargeTransactionPayment"
  final String identifier;

  /// Type ID of the extension's data type
  ///
  /// References the type of data included in the extrinsic for this extension.
  /// For example, CheckNonce includes a Compact<Index> (nonce value).
  final int type;

  /// Type ID of the additional signed data
  ///
  /// Some extensions include data that is signed but not included
  /// in the extrinsic itself (e.g., genesis hash, spec version).
  /// This references the type of that additional data.
  final int additionalSignedType;

  const SignedExtensionMetadataV14({
    required this.identifier,
    required this.type,
    required this.additionalSignedType,
  });

  /// Codec instance for SignedExtensionMetadataV14
  static const $SignedExtensionMetadataV14 codec = $SignedExtensionMetadataV14._();

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'type': type,
        'additional_signed': additionalSignedType,
      };
}

/// Codec for SignedExtensionMetadataV14
class $SignedExtensionMetadataV14 with Codec<SignedExtensionMetadataV14> {
  const $SignedExtensionMetadataV14._();

  @override
  SignedExtensionMetadataV14 decode(Input input) {
    // Decode identifier
    final identifier = StrCodec.codec.decode(input);

    // Decode type ID
    final type = CompactCodec.codec.decode(input);

    // Decode additional signed type ID
    final additionalSignedType = CompactCodec.codec.decode(input);

    return SignedExtensionMetadataV14(
      identifier: identifier,
      type: type,
      additionalSignedType: additionalSignedType,
    );
  }

  @override
  void encodeTo(SignedExtensionMetadataV14 value, Output output) {
    // Encode identifier
    StrCodec.codec.encodeTo(value.identifier, output);

    // Encode type ID
    CompactCodec.codec.encodeTo(value.type, output);

    // Encode additional signed type ID
    CompactCodec.codec.encodeTo(value.additionalSignedType, output);
  }

  @override
  int sizeHint(SignedExtensionMetadataV14 value) {
    var size = 0;
    size += StrCodec.codec.sizeHint(value.identifier);
    size += CompactCodec.codec.sizeHint(value.type);
    size += CompactCodec.codec.sizeHint(value.additionalSignedType);
    return size;
  }
}
