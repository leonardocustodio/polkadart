part of models;

// This class is deprecated - V14+ uses StorageEntryMetadata from runtime.dart instead
// Kept for backwards compatibility with existing code

class StorageEntryMetadataV14 {
  final String name;
  final String modifier; // Changed from StorageEntryModifierV9 to String
  final StorageEntryTypeV14 type;
  final Uint8List fallback;
  final List<String> docs;

  const StorageEntryMetadataV14(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.fallback,
      required this.docs});

  /// Creates Class Object from `Json`
  static StorageEntryMetadataV14 fromJson(Map<String, dynamic> map) => StorageEntryMetadataV14(
        name: map['name'],
        modifier: map['modifier'] as String, // Direct string access
        type: StorageEntryTypeV14.fromJson(map['type']),
        fallback: Uint8List.fromList((map['fallback'] as List<dynamic>).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'name': name,
        'modifier': modifier,
        'type': type.toJson(),
        'fallback': fallback.toList(growable: false),
        'docs': docs,
      };
}
