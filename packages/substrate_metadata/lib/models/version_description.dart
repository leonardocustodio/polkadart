part of models;

class VersionDescription extends SpecVersion {
  const VersionDescription({
    required super.metadata,
    required super.specName,
    required super.specVersion,
    required super.blockNumber,
    required super.blockHash,
  });
}
