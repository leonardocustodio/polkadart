part of extrinsic_builder;

/// Information about an encoded extrinsic
class EncodedExtrinsicInfo {
  final int totalSize;
  final int lengthPrefixSize;
  final int versionByteSize;
  final int addressSize;
  final int signatureSize;
  final int extensionSize;
  final int callDataSize;
  final Uint8List hash;
  final SignatureType signatureType;
  final bool isSigned;

  const EncodedExtrinsicInfo({
    required this.totalSize,
    required this.lengthPrefixSize,
    required this.versionByteSize,
    required this.addressSize,
    required this.signatureSize,
    required this.extensionSize,
    required this.callDataSize,
    required this.hash,
    required this.signatureType,
    required this.isSigned,
  });

  /// Get the hash as hex string
  String get hashHex => '0x${hash.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';

  /// Get a summary of the extrinsic structure
  Map<String, dynamic> summary() {
    return {
      'totalSize': '$totalSize bytes',
      'breakdown': {
        'lengthPrefix': '$lengthPrefixSize bytes',
        'versionByte': '$versionByteSize byte',
        'address': '$addressSize bytes',
        'signature': '$signatureSize bytes ($signatureType)',
        'extensions': '$extensionSize bytes',
        'callData': '$callDataSize bytes',
      },
      'hash': hashHex,
      'isSigned': isSigned,
    };
  }
}
