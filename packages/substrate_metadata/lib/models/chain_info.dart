part of models;

class ChainInfo {
  final ScaleCodec scaleCodec;

  const ChainInfo({
    required this.scaleCodec,
  });

  static ChainInfo fromMetadata(Map<String, dynamic> metadata) {
    final scaleCodec = ScaleCodec.fromMetadata(metadata);
    return ChainInfo(scaleCodec: scaleCodec);
  }

  static ChainInfo fromMetadataJson(Map<String, dynamic> metadata) {
    return ChainInfo(scaleCodec: scaleCodec);
  }

  static bool isPreV14(int versionNumber) {
    if (versionNumber < 14) {
      return true;
    }
    if (versionNumber == 14) {
      return false;
    }
    throw UnsupportedMetadataException(
        'Unsupported metadata version: $versionNumber');
  }
}
