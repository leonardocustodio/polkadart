part of models;

class VersionDescription extends SpecVersion {
  final ChainInfo chainInfo;

  VersionDescription({
    required this.chainInfo,
    required super.metadata,
    required super.specName,
    required super.specVersion,
    required super.blockNumber,
    required super.blockHash,
  });
}
