part of metadata;

/// Metadata of the extrinsic used by the runtime.
class ExtrinsicMetadata {
  /// Extrinsic version.
  final int version;

  /// The type of the address.
  final int addressType;

  /// The type of the call.
  final int callType;

  /// The type of the signature.
  final int signatureType;

  /// The type of the extra.
  final int extraType;

  /// The signed extensions in the order they appear in the extrinsic.
  final List<SignedExtensionMetadata> signedExtensions;

  const ExtrinsicMetadata({
    required this.version,
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
    required this.signedExtensions,
  });

  Map<String, dynamic> toJson() => {
        'version': version,
        'address_type': addressType,
        'call_type': callType,
        'signature_type': signatureType,
        'extra_type': extraType,
        'signed_extensions': signedExtensions.map((e) => e.toJson()).toList(),
      };
}

/// Metadata of an extrinsic signed extension.
class SignedExtensionMetadata {
  /// The unique signed extension identifier, which may be different from the type name.
  final String identifier;

  /// The type of the signed extension, with the data to be included in the extrinsic.
  final int type;

  /// The type of the additional signed data, with the data to be included in the signed payload
  final int additionalSigned;

  static const $SignedExtensionMetadataCodec codec = $SignedExtensionMetadataCodec._();

  SignedExtensionMetadata({
    required this.identifier,
    required this.type,
    required this.additionalSigned,
  });

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'ty': type,
        'additional_signed': additionalSigned,
      };
}

class $SignedExtensionMetadataCodec with Codec<SignedExtensionMetadata> {
  const $SignedExtensionMetadataCodec._();

  @override
  SignedExtensionMetadata decode(Input input) {
    final identifier = StrCodec.codec.decode(input);
    final type = CompactCodec.codec.decode(input);
    final additionalSigned = CompactCodec.codec.decode(input);
    return SignedExtensionMetadata(
      identifier: identifier,
      type: type,
      additionalSigned: additionalSigned,
    );
  }

  @override
  void encodeTo(SignedExtensionMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.identifier, output);
    CompactCodec.codec.encodeTo(metadata.type, output);
    CompactCodec.codec.encodeTo(metadata.additionalSigned, output);
  }

  @override
  int sizeHint(SignedExtensionMetadata value) {
    int size = StrCodec.codec.sizeHint(value.identifier);
    size += CompactCodec.codec.sizeHint(value.type);
    size += CompactCodec.codec.sizeHint(value.additionalSigned);
    return size;
  }

  @override
  bool isSizeZero() {
    return StrCodec.codec.isSizeZero() && CompactCodec.codec.isSizeZero();
  }
}
