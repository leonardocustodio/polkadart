/// Legacy Types used to hold the types for metadata version older than v14.
class LegacyTypes {
  final Map<String, dynamic> types;
  Map<String, Map<String, String>>? typesAlias;
  Map<String, String>? signedExtensions;

  LegacyTypes({required this.types, this.typesAlias, this.signedExtensions});

  static LegacyTypes fromJson(Map<String, dynamic> map) {
    return LegacyTypes(
      types: map['types'] ?? <String, dynamic>{},
      typesAlias: map['typesAlias'] ?? <String, Map<String, String>>{},
      signedExtensions: map['signedExtensions'] ?? <String, String>{},
    );
  }
}

/// `LegacyTypesWithSpecVersionRange` holds (min and max) spec-version.
class LegacyTypesWithSpecVersionRange extends LegacyTypes {
  /// minmax ~ ( min and max -> range of Spec-Version )
  final List<int?> minmax;

  LegacyTypesWithSpecVersionRange(
      {required this.minmax,
      required super.types,
      super.typesAlias,
      super.signedExtensions});

  static LegacyTypesWithSpecVersionRange fromJson(Map<String, dynamic> map) {
    return LegacyTypesWithSpecVersionRange(
        minmax: (map['minmax'] as List).cast<int?>(),
        types: (map['types'] as Map).cast<String, dynamic>(),
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);
  }
}

/// `Legacy Types Bundle` holds optional array of (min and max) spec-version with `Legacy Types`
class LegacyTypesBundle extends LegacyTypes {
  final List<LegacyTypesWithSpecVersionRange>? versions;

  LegacyTypesBundle(
      {this.versions,
      required super.types,
      super.typesAlias,
      super.signedExtensions});

  static LegacyTypesBundle fromJson(Map<String, dynamic> map) {
    return LegacyTypesBundle(
      types: map['types'],
      typesAlias: map['typesAlias'],
      signedExtensions: map['signedExtensions'],
      versions: (map['versions'] as List?)
          ?.map((value) => LegacyTypesWithSpecVersionRange.fromJson(value))
          .toList(growable: false),
    );
  }
}
