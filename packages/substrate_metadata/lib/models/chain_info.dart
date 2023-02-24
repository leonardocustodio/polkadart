part of models;

class ChainInfo {
  final Registry registry;
  final ScaleCodec scaleCodec;

  const ChainInfo({
    required this.registry,
    required this.scaleCodec,
  });

  static bool isPreV14(Metadata metadata) {
    final int versionNumber = metadata.version;
    if (versionNumber < 14) {
      return true;
    }
    if (versionNumber == 14) {
      return false;
    }
    throw UnsupportedMetadataException(
        'Unsupported metadata version: ${metadata.version}');
  }
}
