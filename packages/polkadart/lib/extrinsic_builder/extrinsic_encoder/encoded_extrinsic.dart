part of extrinsic_builder;

/// Result of encoding an extrinsic
class EncodedExtrinsic extends Equatable {
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
  String toHex() => '0x${encodeHex(bytes)}';

  /// Get hash as hex
  String get hashHex => '0x${encodeHex(hash)}';

  /// Submit this extrinsic to a node
  Future<String> submit(final Provider provider) async {
    final authorApi = AuthorApi(provider);
    final result = await authorApi.submitExtrinsic(bytes);
    return '0x${encodeHex(result)}';
  }

  Future<StreamSubscription<ExtrinsicStatus>> submitAndWatch(
      final Provider provider, final ExtrinsicListener onStatusChange) async {
    final authorApi = AuthorApi(provider);
    return await authorApi.submitAndWatchExtrinsic(bytes, onStatusChange);
  }

  /// Create from SignedData
  static EncodedExtrinsic fromSignedData(final ChainInfo chainInfo, final SignedData signedData) {
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

  @override
  List<Object> get props => [bytes, hash, info];
}
