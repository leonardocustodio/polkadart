part of models;

class ChainInfo {
  final int version;
  final Registry registry;
  final Map<String, dynamic> metadata;
  final ScaleCodec scaleCodec;

  ChainInfo({
    required this.version,
    required this.registry,
    required this.metadata,
  }) : scaleCodec = ScaleCodec(registry);

  static ChainInfo fromMetadata(DecodedMetadata metadata,
      [LegacyTypes? legacyTypes]) {
    if (metadata.isPreV14) {
      //assertion(legacyTypes != null, 'Legacy types are required for metadata versions below 14');
      return LegacyParser.getChainInfo(metadata);
    }
    return V14Parser.getChainInfo(metadata);
  }
}
