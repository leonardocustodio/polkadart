part of primitives;

class RuntimeMetadata {
  final int version;
  final Map<String, dynamic> metadata;
  final ChainInfo chainInfo;

  RuntimeMetadata(
      {required this.version, required this.metadata, required this.chainInfo});

  factory RuntimeMetadata.fromHex(String hex) {
    final decodedMetadata = MetadataDecoder.instance.decode(hex);
    return RuntimeMetadata(
      version: decodedMetadata.version,
      metadata: decodedMetadata.metadata,
      chainInfo: ChainInfo.fromMetadata(decodedMetadata),
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'metadata': metadata.toJson(),
      };
}
