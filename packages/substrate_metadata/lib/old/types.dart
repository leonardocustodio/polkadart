class OldTypes {
  Map<String, dynamic>? types;
  Map<String, Map<String, String>>? typesAlias;
  Map<String, String>? signedExtensions;

  OldTypes({this.types, this.typesAlias, this.signedExtensions});

  static OldTypes fromMap(Map<String, dynamic> map) {
    return OldTypes(
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);
  }
}

class OldTypesWithSpecVersionRange extends OldTypes {
  /// minmax ~ ( min and max -> range of Spec-Version )
  final List<int?> minmax;

  OldTypesWithSpecVersionRange(
      {required this.minmax,
      super.types,
      super.typesAlias,
      super.signedExtensions});

  static OldTypesWithSpecVersionRange fromMap(Map<String, dynamic> map) {
    return OldTypesWithSpecVersionRange(
        minmax: (map['minmax'] as List).cast<int?>(),
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);
  }
}

class OldTypesBundle extends OldTypes {
  List<OldTypesWithSpecVersionRange>? versions;

  OldTypesBundle(
      {this.versions, super.types, super.typesAlias, super.signedExtensions});

  static OldTypesBundle fromMap(Map<String, dynamic> map) {
    var obj = OldTypesBundle(
        types: map['types'],
        typesAlias: map['typesAlias'],
        signedExtensions: map['signedExtensions']);

    if (map['versions'] != null) {
      obj.versions = (map['versions'] as List)
          .map((value) => OldTypesWithSpecVersionRange.fromMap(value))
          .toList();
    }

    return obj;
  }
}
