// ignore_for_file: camel_case_types, overridden_fields

part of models;

class StorageEntryModifierV9 {
  final String kind;
  const StorageEntryModifierV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryModifierV9 fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Optional':
        return StorageEntryModifierV9_Optional();
      case 'Default':
        return StorageEntryModifierV9_Default();
      case 'Requried':
        return StorageEntryModifierV9_Required();
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class StorageEntryModifierV9_Optional extends StorageEntryModifierV9 {
  const StorageEntryModifierV9_Optional() : super(kind: 'Optional');
}

class StorageEntryModifierV9_Default extends StorageEntryModifierV9 {
  const StorageEntryModifierV9_Default() : super(kind: 'Default');
}

class StorageEntryModifierV9_Required extends StorageEntryModifierV9 {
  const StorageEntryModifierV9_Required() : super(kind: 'Requried');
}

class StorageEntryTypeV14 {
  final String kind;
  final int value;
  const StorageEntryTypeV14({required this.kind, required this.value});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV14 fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Plain':
        return StorageEntryTypeV14_Plain(value: map['Plain']);
      case 'Map':
        return StorageEntryTypeV14_Map.fromJson(map['Map']);
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class StorageEntryTypeV14_Plain extends StorageEntryTypeV14 {
  @override
  final int value;
  const StorageEntryTypeV14_Plain({required this.value})
      : super(kind: 'Plain', value: value);
}

class StorageEntryTypeV14_Map extends StorageEntryTypeV14 {
  final List<StorageHasherV11> hashers;
  final int key;
  @override
  final int value;
  const StorageEntryTypeV14_Map(
      {required this.hashers, required this.key, required this.value})
      : super(kind: 'Map', value: value);

  /// Creates Class Object from `Json`
  static StorageEntryTypeV14_Map fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV14_Map(
        key: map['key'],
        hashers: (map['hashers'] as List)
            .map((value) => StorageHasherV11.fromJson(value))
            .toList(),
        value: map['value'],
      );
}
