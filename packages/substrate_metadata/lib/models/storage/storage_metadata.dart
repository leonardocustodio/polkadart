part of models;

class StorageMetadataV9 {
  final String prefix;
  final List<StorageEntryMetadataV9> items;

  const StorageMetadataV9({required this.prefix, required this.items});

  /// Creates Class Object from `Json`
  static StorageMetadataV9 fromJson(Map<String, dynamic> map) =>
      StorageMetadataV9(
          prefix: map['prefix'],
          items: (map['items'] as List)
              .map((val) => StorageEntryMetadataV9.fromJson(val))
              .toList());
}

class StorageMetadataV10 {
  final String prefix;
  final List<StorageEntryMetadataV10> items;
  const StorageMetadataV10({required this.prefix, required this.items});

  /// Creates Class Object from `Json`
  static StorageMetadataV10 fromJson(Map<String, dynamic> map) =>
      StorageMetadataV10(
          prefix: map['prefix'],
          items: (map['items'] as List)
              .map((val) => StorageEntryMetadataV10.fromJson(val))
              .toList());
}

class StorageMetadataV11 {
  final String prefix;
  final List<StorageEntryMetadataV11> items;
  const StorageMetadataV11({required this.prefix, required this.items});

  /// Creates Class Object from `Json`
  static StorageMetadataV11 fromJson(Map<String, dynamic> map) =>
      StorageMetadataV11(
          prefix: map['prefix'],
          items: (map['items'] as List)
              .map((val) => StorageEntryMetadataV11.fromJson(val))
              .toList());
}

class StorageMetadataV13 {
  final String prefix;
  final List<StorageEntryMetadataV13> items;

  const StorageMetadataV13({required this.prefix, required this.items});

  /// Creates Class Object from `Json`
  static StorageMetadataV13 fromJson(Map<String, dynamic> map) =>
      StorageMetadataV13(
          prefix: map['prefix'],
          items: (map['items'] as List)
              .map((val) => StorageEntryMetadataV13.fromJson(val))
              .toList());
}
