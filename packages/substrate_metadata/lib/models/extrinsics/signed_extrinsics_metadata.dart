part of models;

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
