// ignore_for_file: camel_case_types, overridden_fields

part of models;

///
/// -------------- Storage Entry Modifier [Start] --------------
///
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

///
/// -------------- Storage Entry [Ends] --------------
///

///
/// -------------- Storage Hasher [Starts] --------------
///
class StorageHasherV9 {
  final String kind;
  const StorageHasherV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV9 fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Blake2_128':
        return StorageHasherV9_Blake2_128();
      case 'Blake2_256':
        return StorageHasherV9_Blake2_256();
      case 'Twox128':
        return StorageHasherV9_Twox128();
      case 'Twox256':
        return StorageHasherV9_Twox256();
      case 'Twox64Concat':
        return StorageHasherV9_Twox64Concat();
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class StorageHasherV9_Blake2_128 extends StorageHasherV9 {
  const StorageHasherV9_Blake2_128() : super(kind: 'Blake2_128');
}

class StorageHasherV9_Blake2_256 extends StorageHasherV9 {
  const StorageHasherV9_Blake2_256() : super(kind: 'Blake2_256');
}

class StorageHasherV9_Twox128 extends StorageHasherV9 {
  const StorageHasherV9_Twox128() : super(kind: 'Twox128');
}

class StorageHasherV9_Twox256 extends StorageHasherV9 {
  const StorageHasherV9_Twox256() : super(kind: 'Twox256');
}

class StorageHasherV9_Twox64Concat extends StorageHasherV9 {
  const StorageHasherV9_Twox64Concat() : super(kind: 'Twox64Concat');
}

class StorageHasherV10 {
  final String kind;
  const StorageHasherV10({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV10 fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Blake2_128':
        return StorageHasherV10_Blake2_128();
      case 'Blake2_256':
        return StorageHasherV10_Blake2_256();
      case 'Blake2_128Concat':
        return StorageHasherV10_Blake2_128Concat();
      case 'Twox128':
        return StorageHasherV10_Twox128();
      case 'Twox256':
        return StorageHasherV10_Twox256();
      case 'Twox64Concat':
        return StorageHasherV10_Twox64Concat();
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class StorageHasherV10_Blake2_128 extends StorageHasherV10 {
  const StorageHasherV10_Blake2_128() : super(kind: 'Blake2_128');
}

class StorageHasherV10_Blake2_256 extends StorageHasherV10 {
  const StorageHasherV10_Blake2_256() : super(kind: 'Blake2_256');
}

class StorageHasherV10_Blake2_128Concat extends StorageHasherV10 {
  const StorageHasherV10_Blake2_128Concat() : super(kind: 'Blake2_128Concat');
}

class StorageHasherV10_Twox128 extends StorageHasherV10 {
  const StorageHasherV10_Twox128() : super(kind: 'Twox128');
}

class StorageHasherV10_Twox256 extends StorageHasherV10 {
  const StorageHasherV10_Twox256() : super(kind: 'Twox256');
}

class StorageHasherV10_Twox64Concat extends StorageHasherV10 {
  const StorageHasherV10_Twox64Concat() : super(kind: 'Twox64Concat');
}

class StorageHasherV11 {
  final String kind;
  const StorageHasherV11({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV11 fromJson(Map<String, dynamic> map) {
    final key = map.keys.first;
    switch (key) {
      case 'Blake2_128':
        return StorageHasherV11_Blake2_128();
      case 'Blake2_256':
        return StorageHasherV11_Blake2_256();
      case 'Blake2_128Concat':
        return StorageHasherV11_Blake2_128Concat();
      case 'Twox128':
        return StorageHasherV11_Twox128();
      case 'Twox256':
        return StorageHasherV11_Twox256();
      case 'Twox64Concat':
        return StorageHasherV11_Twox64Concat();
      case 'Identity':
        return StorageHasherV11_Identity();
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class StorageHasherV11_Blake2_128 extends StorageHasherV11 {
  const StorageHasherV11_Blake2_128() : super(kind: 'Blake2_128');
}

class StorageHasherV11_Blake2_256 extends StorageHasherV11 {
  const StorageHasherV11_Blake2_256() : super(kind: 'Blake2_256');
}

class StorageHasherV11_Blake2_128Concat extends StorageHasherV11 {
  const StorageHasherV11_Blake2_128Concat() : super(kind: 'Blake2_128Concat');
}

class StorageHasherV11_Twox128 extends StorageHasherV11 {
  const StorageHasherV11_Twox128() : super(kind: 'Twox128');
}

class StorageHasherV11_Twox256 extends StorageHasherV11 {
  const StorageHasherV11_Twox256() : super(kind: 'Twox256');
}

class StorageHasherV11_Twox64Concat extends StorageHasherV11 {
  const StorageHasherV11_Twox64Concat() : super(kind: 'Twox64Concat');
}

class StorageHasherV11_Identity extends StorageHasherV11 {
  const StorageHasherV11_Identity() : super(kind: 'Identity');
}

/// -------------- Storage Hasher [Starts] --------------
///
///
///
