part of models;

/// Storage Entry Metadata [V9]
class StorageEntryMetadataV9 {
  final String name;
  final StorageEntryModifierV9 modifier;
  final StorageEntryTypeV9 type;
  final Uint8List fallback;
  final List<String> docs;

  const StorageEntryMetadataV9(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.fallback,
      required this.docs});

  /// Creates Class Object from `Json`
  static StorageEntryMetadataV9 fromJson(Map<String, dynamic> map) =>
      StorageEntryMetadataV9(
        name: map['name'],
        modifier: StorageEntryModifierV9.fromKey(map['modifier']),
        type: StorageEntryTypeV9.fromJson(map['type']),
        fallback: Uint8List.fromList(map['fallback'] as List<int>),
        docs: (map['docs'] as List).cast<String>(),
      );
}

/// Storage Entry Metadata [V10]
class StorageEntryMetadataV10 {
  final String name;
  final StorageEntryModifierV9 modifier;
  final StorageEntryTypeV10 type;
  final Uint8List fallback;
  final List<String> docs;

  const StorageEntryMetadataV10(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.fallback,
      required this.docs});

  /// Creates Class Object from `Json`
  static StorageEntryMetadataV10 fromJson(Map<String, dynamic> map) =>
      StorageEntryMetadataV10(
        name: map['name'],
        modifier: StorageEntryModifierV9.fromKey(map['modifier']),
        type: StorageEntryTypeV10.fromJson(map['type']),
        fallback: Uint8List.fromList(map['fallback'] as List<int>),
        docs: (map['docs'] as List).cast<String>(),
      );
}

/// Storage Entry Metadata [V11]
class StorageEntryMetadataV11 {
  final String name;
  final StorageEntryModifierV9 modifier;
  final StorageEntryTypeV11 type;
  final Uint8List fallback;
  final List<String> docs;

  const StorageEntryMetadataV11(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.fallback,
      required this.docs});

  /// Creates Class Object from `Json`
  static StorageEntryMetadataV11 fromJson(Map<String, dynamic> map) =>
      StorageEntryMetadataV11(
        name: map['name'],
        modifier: StorageEntryModifierV9.fromKey(map['modifier']),
        type: StorageEntryTypeV11.fromJson(map['type']),
        fallback: Uint8List.fromList((map['fallback'] as List).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );
}

/// Storage Entry Metadata [V13]
class StorageEntryMetadataV13 {
  final String name;
  final StorageEntryModifierV9 modifier;
  final StorageEntryTypeV13 type;
  final Uint8List fallback;
  final List<String> docs;

  const StorageEntryMetadataV13(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.fallback,
      required this.docs});

  /// Creates Class Object from `Json`
  static StorageEntryMetadataV13 fromJson(Map<String, dynamic> map) =>
      StorageEntryMetadataV13(
        name: map['name'],
        modifier: StorageEntryModifierV9.fromKey(map['modifier']),
        type: StorageEntryTypeV13.fromJson(map['type']),
        fallback: Uint8List.fromList((map['fallback'] as List).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );
}

class StorageEntryMetadataV14 {
  final String name;
  final StorageEntryModifierV9 modifier;
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
  static StorageEntryMetadataV14 fromJson(Map<String, dynamic> map) =>
      StorageEntryMetadataV14(
        name: map['name'],
        modifier: StorageEntryModifierV9.fromKey(map['modifier']),
        type: StorageEntryTypeV14.fromJson(map['type']),
        fallback: Uint8List.fromList((map['fallback'] as List).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );
}
