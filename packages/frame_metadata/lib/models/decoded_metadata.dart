part of models;

class DecodedMetadata {
  final int version;
  final Map<String, dynamic> metadata;

  const DecodedMetadata({
    required this.version,
    required this.metadata,
  });

  ///
  /// Simplified metadata in json format where Option.some() and MapEntry are resolved into simpler types.
  ///
  /// Suitable to store in .json file.
  Map<String, dynamic> get json => <String, dynamic>{
        'version': version,
        'metadata': metadataJson,
      };

  ///
  /// Get the metadata json object.
  Map<String, dynamic> get metadataJson => metadata.toJson();

  ///
  /// Metadata Json object.
  Metadata get metadataObject => Metadata.fromVersion(metadata, version);

  ///
  /// Returns true if the metadata is for a pre v14 chain.
  bool get isPreV14 {
    if (version < 14) {
      return true;
    }
    if (version == 14) {
      return false;
    }
    throw UnsupportedMetadataException(
        'Unsupported metadata version: $version');
  }
}
