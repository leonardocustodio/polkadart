// ignore_for_file: camel_case_types

part of models;

/// Storage Entry Type [V9]
class StorageEntryTypeV9 {
  final String kind;
  const StorageEntryTypeV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV9 fromJson(MapEntry<String, dynamic> entry) {
    switch (entry.key) {
      case 'Plain':
        return StorageEntryTypeV9_Plain(value: entry.value);
      case 'Map':
        return StorageEntryTypeV9_Map.fromJson(entry.value);
      case 'DoubleMap':
        return StorageEntryTypeV9_DoubleMap.fromJson(entry.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${entry.key}');
    }
  }

  /// Creates `Map` from Class Object
  static MapEntry<String, dynamic> toJson(StorageEntryTypeV9 entryType) {
    switch (entryType.kind) {
      case 'Plain':
        return MapEntry('Plain', (entryType as StorageEntryTypeV9_Plain).value);
      case 'Map':
        return MapEntry('Map', (entryType as StorageEntryTypeV9_Map).toJson());
      case 'DoubleMap':
        return MapEntry(
            'DoubleMap', (entryType as StorageEntryTypeV9_DoubleMap).toJson());
      default:
        throw UnexpectedTypeException('Unexpected type: ${entryType.kind}');
    }
  }
}

class StorageEntryTypeV9_Plain extends StorageEntryTypeV9 {
  final String value;
  const StorageEntryTypeV9_Plain({required this.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV9_Map extends StorageEntryTypeV9 {
  final StorageHasherV9 hasher;
  final String key;
  final String value;
  final bool linked;
  const StorageEntryTypeV9_Map(
      {required this.hasher,
      required this.key,
      required this.value,
      required this.linked})
      : super(kind: 'Map');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV9_Map fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV9_Map(
        key: map['key'],
        hasher: StorageHasherV9.fromKey(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key': key,
        'value': value,
        'linked': linked,
      };
}

class StorageEntryTypeV9_DoubleMap extends StorageEntryTypeV9 {
  final StorageHasherV9 hasher;
  final String key1;
  final String key2;
  final String value;
  final StorageHasherV9 key2Hasher;
  const StorageEntryTypeV9_DoubleMap(
      {required this.hasher,
      required this.key1,
      required this.key2,
      required this.value,
      required this.key2Hasher})
      : super(kind: 'DoubleMap');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV9_DoubleMap fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV9_DoubleMap(
          hasher: StorageHasherV9.fromKey(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV9.fromKey(map['key2Hasher']));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key1': key1,
        'key2': key2,
        'value': value,
        'key2Hasher': key2Hasher.toJson(),
      };
}

/// Storage Entry Type [V10]
class StorageEntryTypeV10 {
  final String kind;
  const StorageEntryTypeV10({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV10 fromJson(MapEntry entry) {
    switch (entry.key) {
      case 'Plain':
        return StorageEntryTypeV10_Plain(value: entry.value);
      case 'Map':
        return StorageEntryTypeV10_Map.fromJson(entry.value);
      case 'DoubleMap':
        return StorageEntryTypeV10_DoubleMap.fromJson(entry.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${entry.key}');
    }
  }

  static MapEntry<String, dynamic> toJson(StorageEntryTypeV10 entryType) {
    switch (entryType.kind) {
      case 'Plain':
        return MapEntry(
            'Plain', (entryType as StorageEntryTypeV10_Plain).value);
      case 'Map':
        return MapEntry('Map', (entryType as StorageEntryTypeV10_Map).toJson());
      case 'DoubleMap':
        return MapEntry(
            'DoubleMap', (entryType as StorageEntryTypeV10_DoubleMap).toJson());
      default:
        throw UnexpectedTypeException('Unexpected type: ${entryType.kind}');
    }
  }
}

class StorageEntryTypeV10_Plain extends StorageEntryTypeV10 {
  final String value;
  const StorageEntryTypeV10_Plain({required this.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV10_Map extends StorageEntryTypeV10 {
  final StorageHasherV10 hasher;
  final String key;
  final String value;
  final bool linked;
  const StorageEntryTypeV10_Map(
      {required this.hasher,
      required this.key,
      required this.value,
      required this.linked})
      : super(kind: 'Map');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV10_Map fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV10_Map(
        key: map['key'],
        hasher: StorageHasherV10.fromKey(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key': key,
        'value': value,
        'linked': linked,
      };
}

class StorageEntryTypeV10_DoubleMap extends StorageEntryTypeV10 {
  final StorageHasherV10 hasher;
  final String key1;
  final String key2;
  final String value;
  final StorageHasherV10 key2Hasher;
  const StorageEntryTypeV10_DoubleMap(
      {required this.hasher,
      required this.key1,
      required this.key2,
      required this.value,
      required this.key2Hasher})
      : super(kind: 'DoubleMap');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV10_DoubleMap fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV10_DoubleMap(
          hasher: StorageHasherV10.fromKey(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV10.fromKey(map['key2Hasher']));

  /// Creates `Map` from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key1': key1,
        'key2': key2,
        'value': value,
        'key2Hasher': key2Hasher.toJson(),
      };
}

/// Storage Entry Type [V11]
class StorageEntryTypeV11 {
  final String kind;
  const StorageEntryTypeV11({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV11 fromJson(MapEntry map) {
    switch (map.key) {
      case 'Plain':
        return StorageEntryTypeV11_Plain(value: map.value);
      case 'Map':
        return StorageEntryTypeV11_Map.fromJson(map.value);
      case 'DoubleMap':
        return StorageEntryTypeV11_DoubleMap.fromJson(map.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${map.key}');
    }
  }

  /// Creates Map from Class Object
  static MapEntry<String, dynamic> toJson(StorageEntryTypeV11 entry) {
    switch (entry.kind) {
      case 'Plain':
        return MapEntry('Plain', (entry as StorageEntryTypeV11_Plain).value);
      case 'Map':
        return MapEntry('Map', (entry as StorageEntryTypeV11_Map).toJson());
      case 'DoubleMap':
        return MapEntry(
            'DoubleMap', (entry as StorageEntryTypeV11_DoubleMap).toJson());
      default:
        throw UnexpectedTypeException('Unexpected type: ${entry.kind}');
    }
  }
}

class StorageEntryTypeV11_Plain extends StorageEntryTypeV11 {
  final String value;
  const StorageEntryTypeV11_Plain({required this.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV11_Map extends StorageEntryTypeV11 {
  final StorageHasherV11 hasher;
  final String key;
  final String value;
  final bool linked;
  const StorageEntryTypeV11_Map(
      {required this.hasher,
      required this.key,
      required this.value,
      required this.linked})
      : super(kind: 'Map');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV11_Map fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV11_Map(
        key: map['key'],
        hasher: StorageHasherV11.fromKey(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key': key,
        'value': value,
        'linked': linked,
      };
}

class StorageEntryTypeV11_DoubleMap extends StorageEntryTypeV11 {
  final StorageHasherV11 hasher;
  final String key1;
  final String key2;
  final String value;
  final StorageHasherV11 key2Hasher;
  const StorageEntryTypeV11_DoubleMap(
      {required this.hasher,
      required this.key1,
      required this.key2,
      required this.value,
      required this.key2Hasher})
      : super(kind: 'DoubleMap');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV11_DoubleMap fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV11_DoubleMap(
          hasher: StorageHasherV11.fromKey(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV11.fromKey(map['key2Hasher']));

  /// Creates Map from Class Object
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key1': key1,
        'key2': key2,
        'value': value,
        'key2Hasher': key2Hasher.toJson(),
      };
}

/// Storage Entry Type [V13]
class StorageEntryTypeV13 {
  final String kind;
  const StorageEntryTypeV13({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV13 fromJson(MapEntry<String, dynamic> map) {
    switch (map.key) {
      case 'Plain':
        return StorageEntryTypeV13_Plain(value: map.value);
      case 'Map':
        return StorageEntryTypeV13_Map.fromJson(map.value);
      case 'DoubleMap':
        return StorageEntryTypeV13_DoubleMap.fromJson(map.value);
      case 'NMap':
        return StorageEntryTypeV13_NMap.fromJson(map.value);
      default:
        throw UnexpectedTypeException('Unexpected type: ${map.key}');
    }
  }

  /// Creates Map Object from `Json`
  static MapEntry<String, dynamic> toJson(StorageEntryTypeV13 entry) {
    switch (entry.kind) {
      case 'Plain':
        return MapEntry(entry.kind, (entry as StorageEntryTypeV13_Plain).value);
      case 'Map':
        return MapEntry(
            entry.kind, (entry as StorageEntryTypeV13_Map).toJson());
      case 'DoubleMap':
        return MapEntry(
            entry.kind, (entry as StorageEntryTypeV13_DoubleMap).toJson());
      case 'NMap':
        return MapEntry(
            entry.kind, (entry as StorageEntryTypeV13_NMap).toJson());
      default:
        throw UnexpectedTypeException('Unexpected type: ${entry.kind}');
    }
  }
}

class StorageEntryTypeV13_Plain extends StorageEntryTypeV13 {
  final String value;
  const StorageEntryTypeV13_Plain({required this.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV13_Map extends StorageEntryTypeV13 {
  final StorageHasherV11 hasher;
  final String key;
  final String value;
  final bool linked;
  const StorageEntryTypeV13_Map(
      {required this.hasher,
      required this.key,
      required this.value,
      required this.linked})
      : super(kind: 'Map');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV13_Map fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV13_Map(
        key: map['key'],
        hasher: StorageHasherV11.fromKey(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );

  /// Creates Map Object from `Json`
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key': key,
        'value': value,
        'linked': linked,
      };
}

class StorageEntryTypeV13_DoubleMap extends StorageEntryTypeV13 {
  final StorageHasherV11 hasher;
  final String key1;
  final String key2;
  final String value;
  final StorageHasherV11 key2Hasher;
  const StorageEntryTypeV13_DoubleMap(
      {required this.hasher,
      required this.key1,
      required this.key2,
      required this.value,
      required this.key2Hasher})
      : super(kind: 'DoubleMap');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV13_DoubleMap fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV13_DoubleMap(
          hasher: StorageHasherV11.fromKey(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV11.fromKey(map['key2Hasher']));

  /// Creates Map Object from `Json`
  Map<String, dynamic> toJson() => {
        'hasher': hasher.toJson(),
        'key1': key1,
        'key2': key2,
        'value': value,
        'key2Hasher': key2Hasher.toJson(),
      };
}

class StorageEntryTypeV13_NMap extends StorageEntryTypeV13 {
  final List<String> keyVec;
  final List<StorageHasherV11> hashers;
  final String value;
  const StorageEntryTypeV13_NMap({
    required this.keyVec,
    required this.hashers,
    required this.value,
  }) : super(kind: 'NMap');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV13_NMap fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV13_NMap(
        hashers: (map['hashers'] as List)
            .map((value) => StorageHasherV11.fromKey(value))
            .toList(growable: false),
        keyVec: (map['keyVec'] as List).cast<String>(),
        value: map['value'],
      );

  /// Creates Map Object from `Json`
  Map<String, dynamic> toJson() => {
        'hashers': hashers.map((e) => e.toJson()).toList(growable: false),
        'keyVec': keyVec,
        'value': value,
      };
}
