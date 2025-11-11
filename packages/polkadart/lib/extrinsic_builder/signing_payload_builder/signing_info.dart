part of extrinsic_builder;

/// Information about what will be signed
class SigningInfo {
  final int callDataSize;
  final int extensionCount;
  final int additionalSignedCount;
  final int rawPayloadSize;
  final bool willBeHashed;
  final Map<String, dynamic> extensions;
  final Map<String, dynamic> additionalSigned;

  const SigningInfo({
    required this.callDataSize,
    required this.extensionCount,
    required this.additionalSignedCount,
    required this.rawPayloadSize,
    required this.willBeHashed,
    required this.extensions,
    required this.additionalSigned,
  });

  /// Get a human-readable summary
  Map<String, dynamic> summary() {
    return {
      'callDataSize': '$callDataSize bytes',
      'extensionCount': extensionCount,
      'additionalSignedCount': additionalSignedCount,
      'rawPayloadSize': '$rawPayloadSize bytes',
      'willBeHashed': willBeHashed ? 'Yes (> 256 bytes)' : 'No',
      'finalPayloadSize': willBeHashed ? '32 bytes (hash)' : '$rawPayloadSize bytes',
      'extensions': extensions.keys.toList(),
      'additionalSigned': additionalSigned.keys.toList(),
    };
  }
}
