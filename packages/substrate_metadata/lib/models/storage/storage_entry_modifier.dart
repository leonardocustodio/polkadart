// ignore_for_file: camel_case_types, overridden_fields

part of models;

class StorageEntryTypeV14 {
  final String kind;
  final int value;
  const StorageEntryTypeV14({required this.kind, required this.value});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV14 fromJson(MapEntry<String, dynamic> map) {
    switch (map.key) {
      case 'Plain':
        return StorageEntryTypeV14_Plain(value: map.value);
      case 'Map':
        return StorageEntryTypeV14_Map.fromJson(map.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${map.key}');
    }
  }

  /// Creates `Map` from Class Object
  MapEntry<String, dynamic> toJson() {
    switch (kind) {
      case 'Plain':
        return MapEntry(kind, value);
      case 'Map':
        return MapEntry(kind, (this as StorageEntryTypeV14_Map).toMap());
      default:
        throw UnexpectedTypeException('Unexpected type: $kind');
    }
  }
}

class StorageEntryTypeV14_Plain extends StorageEntryTypeV14 {
  const StorageEntryTypeV14_Plain({required super.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV14_Map extends StorageEntryTypeV14 {
  final List<StorageHasherV11> hashers;
  final int key;
  const StorageEntryTypeV14_Map({required this.hashers, required this.key, required super.value})
      : super(kind: 'Map');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV14_Map fromJson(Map<String, dynamic> map) => StorageEntryTypeV14_Map(
        key: map['key'],
        hashers: (map['hashers'] as List)
            .map((value) => StorageHasherV11.fromKey(value))
            .toList(growable: false),
        value: map['value'],
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toMap() => {
        'hashers': hashers.map((e) => e.toJson()).toList(growable: false),
        'key': key,
        'value': value,
      };
}
