part of models;

class ExtrinsicMetadataV11 {
  final int version;
  final List<String> signedExtensions;
  const ExtrinsicMetadataV11(
      {required this.version, required this.signedExtensions});

  /// Creates Class Object from `Json`
  static ExtrinsicMetadataV11 fromJson(Map<String, dynamic> map) =>
      ExtrinsicMetadataV11(
        version: map['version'],
        signedExtensions: (map['signedExtensions'] as List).cast<String>(),
      );
}

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
