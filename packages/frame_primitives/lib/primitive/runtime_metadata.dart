part of primitives;

class RuntimeMetadata {
  final int version;
  final Map<String, dynamic> metadata;

  RuntimeMetadata({required this.version, required this.metadata});

  factory RuntimeMetadata.fromHex(String hex) {
    final decodedMetadata = MetadataDecoder.instance.decode(hex);
    return RuntimeMetadata(
      version: decodedMetadata.version,
      metadata: decodedMetadata.metadata,
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'metadata': metadata.toJson(),
      };
}
