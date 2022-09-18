part of models;

class Metadata {
  final String kind;
  final dynamic value;
  const Metadata({required this.kind, required this.value});

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
      default:
        return Metadata_V14.fromJson(json);
    }
  }
}
