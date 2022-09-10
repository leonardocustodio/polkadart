part of models;

class ExtrinsicMetadataV14 {
  final int? type;
  final int version;
  final List<SignedExtensionMetadataV14> signedExtensions;
  const ExtrinsicMetadataV14(
      {required this.type,
      required this.version,
      required this.signedExtensions});

  /// Creates Class Object from `Json`
  static ExtrinsicMetadataV14 fromJson(Map<String, dynamic> map) =>
      ExtrinsicMetadataV14(
          type: map['type'],
          version: map['version'],
          signedExtensions: (map['signedExtensions'] as List)
              .map((value) => SignedExtensionMetadataV14.fromJson(value))
              .toList());
}

class SignedExtensionMetadataV14 {
  final String identifier;
  final int? type;
  final int? additionalSigned;
  const SignedExtensionMetadataV14(
      {required this.identifier, this.type, this.additionalSigned});

  /// Creates Class Object from `Json`
  static SignedExtensionMetadataV14 fromJson(dynamic value) {
    if (value is String) {
      return SignedExtensionMetadataV14(identifier: value);
    } else {
      return SignedExtensionMetadataV14(
        identifier: value['identifier'],
        type: value['type'],
        additionalSigned: value['additionalSigned'],
      );
    }
  }
}
