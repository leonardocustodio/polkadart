part of models;

class ChainInfo {
  final int version;
  final ScaleCodec scaleCodec;

  ChainInfo({
    required this.version,
    required this.scaleCodec,
  });

  static ChainInfo fromMetadata(DecodedMetadata metadata,
      [LegacyTypes? legacyTypes]) {
    if (metadata.isPreV14) {
      assertion(legacyTypes != null,
          'Legacy types are required for metadata versions below 14');
      return LegacyParser.getChainInfo(metadata, legacyTypes!);
    }
    return V14Parser.getChainInfo(metadata);
  }
}
