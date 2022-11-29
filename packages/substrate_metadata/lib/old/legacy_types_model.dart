/// Legacy Types used to hold the types for metadata version older than v14.
class LegacyTypes {
  Map<String, dynamic>? types;
  Map<String, Map<String, String>>? typesAlias;
  Map<String, String>? signedExtensions;

  LegacyTypes({this.types, this.typesAlias, this.signedExtensions});

  static LegacyTypes fromJson(Map<String, dynamic> map) {
    return LegacyTypes(
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);
  }
}

/// `LegacyTypesWithSpecVersionRange` holds (min and max) spec-version.
class LegacyTypesWithSpecVersionRange extends LegacyTypes {
  /// minmax ~ ( min and max -> range of Spec-Version )
  final List<int?> minmax;

  LegacyTypesWithSpecVersionRange(
      {required this.minmax,
      super.types,
      super.typesAlias,
      super.signedExtensions});

  static LegacyTypesWithSpecVersionRange fromJson(Map<String, dynamic> map) {
    return LegacyTypesWithSpecVersionRange(
        minmax: (map['minmax'] as List).cast<int?>(),
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);
  }
}

/// `Legacy Types Bundle` holds optional array of (min and max) spec-version with `Legacy Types`
class LegacyTypesBundle extends LegacyTypes {
  List<LegacyTypesWithSpecVersionRange>? versions;

  LegacyTypesBundle(
      {this.versions, super.types, super.typesAlias, super.signedExtensions});

  static LegacyTypesBundle fromJson(Map<String, dynamic> map) {
    var obj = LegacyTypesBundle(
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);

    if (map['versions'] != null) {
      obj.versions = (map['versions'] as List)
          .map((value) => LegacyTypesWithSpecVersionRange.fromJson(value))
          .toList();
    }

    return obj;
  }
}
