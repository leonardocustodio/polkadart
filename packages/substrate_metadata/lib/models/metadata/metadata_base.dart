part of models;

class Metadata {
  final int version;
  final dynamic value;
  const Metadata({required this.version, required this.value});

  /// Creates Metadata Object from the version info
  static Metadata fromVersion(Map<String, dynamic> json, int version) {
    switch (version) {
      case 9:
        return Metadata_V9.fromJson(json);
      case 10:
        return Metadata_V10.fromJson(json);
      case 11:
        return Metadata_V11.fromJson(json);
      case 12:
        return Metadata_V12.fromJson(json);
      case 13:
        return Metadata_V13.fromJson(json);
      case 14:
        return Metadata_V14.fromJson(json);
      default:
        throw Exception('Unknown Metadata version: $version');
    }
  }

  /// Creates Map from Class Object
  static Map<String, dynamic> toJson(Metadata metadata) {
    switch (metadata.version) {
      case 9:
        return (metadata as Metadata_V9).toJson();
      case 10:
        return (metadata as Metadata_V10).toJson();
      case 11:
        return (metadata as Metadata_V11).toJson();
      case 12:
        return (metadata as Metadata_V12).toJson();
      case 13:
        return (metadata as Metadata_V13).toJson();
      case 14:
        return (metadata as Metadata_V14).toJson();
      default:
        throw Exception('Unknown Metadata version: ${metadata.version}}');
    }
  }
}
