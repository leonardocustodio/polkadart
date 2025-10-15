part of models;

class ChainInfo {
  final int version;
  final ScaleCodec scaleCodec;
  final Map<String, Map<String, Constant>> constants;

  ChainInfo({
    required this.version,
    required this.scaleCodec,
    required this.constants,
  });

  static ChainInfo fromMetadata(DecodedMetadata metadata) {
    if (metadata.version < 14) {
      throw UnsupportedError(
        'Metadata version ${metadata.version} is not supported. '
        'Only v14 and v15 are supported. '
        'Use substrate_metadata v1.x for legacy version support.'
      );
    }
    return V14Parser(metadata).getChainInfo();
  }
}
