part of extrinsic_builder;

/// Result of encoding an extrinsic
class EncodedExtrinsic {
  /// The complete extrinsic bytes (with length prefix)
  final Uint8List bytes;

  /// The extrinsic hash
  final Uint8List hash;

  /// Information about the extrinsic
  final EncodedExtrinsicInfo info;

  const EncodedExtrinsic({
    required this.bytes,
    required this.hash,
    required this.info,
  });

  /// Get hex representation
  String toHex() => '0x${bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';

  /// Get hash as hex
  String get hashHex => '0x${hash.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}';

  /// Submit this extrinsic to a node
  Future<String> submit(dynamic provider) async {
    // This would be implemented to call author_submitExtrinsic RPC
    return await provider.send('author_submitExtrinsic', [toHex()]);
  }

  /// Create from SignedData
  static EncodedExtrinsic fromSignedData(ChainInfo chainInfo, SignedData signedData) {
    final encoder = ExtrinsicEncoder(chainInfo);
    final bytes = encoder.encode(signedData);
    final hash = Hasher.blake2b256.hash(bytes);
    final info = encoder.getExtrinsicInfo(signedData);

    return EncodedExtrinsic(
      bytes: bytes,
      hash: hash,
      info: info,
    );
  }
}
