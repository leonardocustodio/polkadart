// ignore_for_file: camel_case_types

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
        modifier: StorageEntryModifierV9.fromJson(map['modifier']),
        type: StorageEntryTypeV9.fromJson(map['type']),
        fallback: Uint8List.fromList(map['fallback'] as List<int>),
        docs: (map['docs'] as List).cast<String>(),
      );
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
        modifier: StorageEntryModifierV9.fromJson(map['modifier']),
        type: StorageEntryTypeV10.fromJson(map['type']),
        fallback: Uint8List.fromList(map['fallback'] as List<int>),
        docs: (map['docs'] as List).cast<String>(),
      );
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
        modifier: StorageEntryModifierV9.fromJson(map['modifier']),
        type: StorageEntryTypeV11.fromJson(map['type']),
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
        modifier: StorageEntryModifierV9.fromJson(map['modifier']),
        type: StorageEntryTypeV14.fromJson(map['type']),
        fallback: Uint8List.fromList((map['fallback'] as List).cast<int>()),
        docs: (map['docs'] as List).cast<String>(),
      );
}

class StorageEntryTypeV9 {
  final String kind;
  const StorageEntryTypeV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV9 fromJson(Map<String, dynamic> map) {
    switch (map['kind']) {
      case 'Plain':
        return StorageEntryTypeV9_Plain.fromJson(map);
      case 'Map':
        return StorageEntryTypeV9_Map.fromJson(map);
      case 'DoubleMap':
        return StorageEntryTypeV9_DoubleMap.fromJson(map);
      default:
        throw scale.UnexpectedTypeException();
    }
  }
}

class StorageEntryTypeV9_Plain extends StorageEntryTypeV9 {
  final String value;
  const StorageEntryTypeV9_Plain({required this.value}) : super(kind: 'Plain');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV9_Plain fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV9_Plain(value: map['value']);
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
        hasher: StorageHasherV9.fromJson(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );
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
          hasher: StorageHasherV9.fromJson(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV9.fromJson(map['key2Hasher']));
}

class StorageEntryTypeV10 {
  final String kind;
  const StorageEntryTypeV10({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV10 fromJson(Map<String, dynamic> map) {
    switch (map['kind']) {
      case 'Plain':
        return StorageEntryTypeV10_Plain.fromJson(map);
      case 'Map':
        return StorageEntryTypeV10_Map.fromJson(map);
      case 'DoubleMap':
        return StorageEntryTypeV10_DoubleMap.fromJson(map);
      default:
        throw scale.UnexpectedTypeException();
    }
  }
}

class StorageEntryTypeV10_Plain extends StorageEntryTypeV10 {
  final String value;
  const StorageEntryTypeV10_Plain({required this.value}) : super(kind: 'Plain');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV10_Plain fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV10_Plain(value: map['value']);
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
        hasher: StorageHasherV10.fromJson(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );
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
          hasher: StorageHasherV10.fromJson(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV10.fromJson(map['key2Hasher']));
}

class StorageEntryTypeV11 {
  final String kind;
  const StorageEntryTypeV11({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryTypeV11 fromJson(Map<String, dynamic> map) {
    switch (map['kind']) {
      case 'Plain':
        return StorageEntryTypeV11_Plain.fromJson(map);
      case 'Map':
        return StorageEntryTypeV11_Map.fromJson(map);
      case 'DoubleMap':
        return StorageEntryTypeV11_DoubleMap.fromJson(map);
      default:
        throw scale.UnexpectedTypeException();
    }
  }
}

class StorageEntryTypeV11_Plain extends StorageEntryTypeV11 {
  final String value;
  const StorageEntryTypeV11_Plain({required this.value}) : super(kind: 'Plain');

  /// Creates Class Object from `Json`
  static StorageEntryTypeV11_Plain fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV11_Plain(value: map['value']);
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
        hasher: StorageHasherV11.fromJson(map['hasher']),
        value: map['value'],
        linked: map['linked'],
      );
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
          hasher: StorageHasherV11.fromJson(map['hasher']),
          key1: map['key1'],
          key2: map['key2'],
          value: map['value'],
          key2Hasher: StorageHasherV11.fromJson(map['key2Hasher']));
}

///
///
///
///
/// -------------- Storage Entry [Start] --------------
///
///
///
///
class StorageEntryModifierV9 {
  final String kind;
  const StorageEntryModifierV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageEntryModifierV9 fromJson(Map<String, dynamic> map) {
    switch (map['kind']) {
      case 'Optional':
        return StorageEntryModifierV9_Optional();
      case 'Default':
        return StorageEntryModifierV9_Default();
      case 'Requried':
        return StorageEntryModifierV9_Required();
      default:
        throw scale.UnexpectedTypeException();
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
    switch (map['kind']) {
      case 'Plain':
        return StorageEntryTypeV14_Plain.fromJson(map);
      case 'Map':
        return StorageEntryTypeV14_Map.fromJson(map);
      default:
        throw scale.UnexpectedTypeException();
    }
  }
}

class StorageEntryTypeV14_Plain extends StorageEntryTypeV14 {
  @override
  final int value;
  const StorageEntryTypeV14_Plain({required this.value})
      : super(kind: 'Plain', value: value);

  /// Creates Class Object from `Json`
  static StorageEntryTypeV14_Plain fromJson(Map<String, dynamic> map) =>
      StorageEntryTypeV14_Plain(value: map['value']);
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
///
///
///
/// -------------- Storage Entry [Ends] --------------
///
///
///
///

///
///
///
///
/// -------------- Storage Hasher [Starts] --------------
///
///
///
///
class StorageHasherV9 {
  final String kind;
  const StorageHasherV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV9 fromJson(Map<String, dynamic> map) {
    switch (map['kind']) {
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
        throw scale.UnexpectedTypeException();
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
    switch (map['kind']) {
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
        throw scale.UnexpectedTypeException();
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
    switch (map['kind']) {
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
        throw scale.UnexpectedTypeException();
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

///
///
///
/// -------------- Storage Hasher [Starts] --------------
///
///
///
