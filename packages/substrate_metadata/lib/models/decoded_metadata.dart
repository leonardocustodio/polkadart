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
}
