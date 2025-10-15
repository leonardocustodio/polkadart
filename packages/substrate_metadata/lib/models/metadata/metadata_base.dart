part of models;

class Metadata {
  final int version;
  final dynamic value;
  const Metadata({required this.version, required this.value});

  /// Creates Metadata Object from the version info
  static Metadata fromVersion(Map<String, dynamic> json, int version) {
    switch (version) {
      case 14:
        return Metadata_V14.fromJson(json);
      default:
        throw Exception('Unsupported Metadata version: $version. Only V14 and above are supported.');
    }
  }

  /// Creates Map from Class Object
  static Map<String, dynamic> toJson(Metadata metadata) {
    switch (metadata.version) {
      case 14:
        return (metadata as Metadata_V14).toJson();
      default:
        throw Exception('Unsupported Metadata version: ${metadata.version}. Only V14 and above are supported.');
    }
  }
}
