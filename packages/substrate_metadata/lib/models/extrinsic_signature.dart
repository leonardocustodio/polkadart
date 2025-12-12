part of models;

/// Signature information for a signed extrinsic
class ExtrinsicSignature {
  /// The address of the signer
  final dynamic address;

  /// The signature
  final dynamic signature;

  /// Extra data (signed extensions like nonce, tip, etc.)
  final Map<String, dynamic> extra;

  const ExtrinsicSignature({required this.address, required this.signature, required this.extra});

  Map<String, dynamic> toJson() => {'address': address, 'signature': signature, 'extra': extra};
}
