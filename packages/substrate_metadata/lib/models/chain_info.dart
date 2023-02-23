part of models;

class ChainInfo {
  final Registry registry;
  final ScaleCodec scaleCodec;

  const ChainInfo({
    required this.registry,
    required this.scaleCodec,
  });

  static int _versionConverter(String version) {
    return int.parse(version.substring(1));
  }

  static bool isPreV14(Metadata metadata) {
    final String version = metadata.kind;
    final int versionNumber = _versionConverter(version);
    if (versionNumber < 14) {
      return true;
    }
    if (versionNumber == 14) {
      return false;
    }
    throw UnsupportedMetadataException(
        'Unsupported metadata version: ${metadata.kind}');
  }
}
