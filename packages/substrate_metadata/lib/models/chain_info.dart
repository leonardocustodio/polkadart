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

  static ChainInfo fromMetadata(DecodedMetadata metadata,
      [LegacyTypes? legacyTypes]) {
    if (metadata.isPreV14) {
      assertion(legacyTypes != null,
          'Legacy types are required for metadata versions below 14');
      return LegacyParser(metadata, legacyTypes!).getChainInfo();
    }
    return V14Parser(metadata).getChainInfo();
  }
}
