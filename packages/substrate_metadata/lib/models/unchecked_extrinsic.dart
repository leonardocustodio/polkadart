part of models;

/// Represents an unchecked extrinsic (transaction) in the runtime
class UncheckedExtrinsic {
  /// Extrinsic version
  final int version;

  /// Optional signature (present for signed extrinsics)
  final ExtrinsicSignature? signature;

  /// The actual call being made
  final RuntimeCall call;

  const UncheckedExtrinsic({
    required this.version,
    this.signature,
    required this.call,
  });

  /// Whether this is a signed extrinsic
  bool get isSigned => signature != null;

  Map<String, dynamic> toJson() => {
        'version': version,
        'isSigned': isSigned,
        'signature': signature?.toJson(),
        'call': call.toJson(),
      };
}
