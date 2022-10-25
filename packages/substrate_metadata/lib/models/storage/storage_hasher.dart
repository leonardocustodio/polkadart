// ignore_for_file: camel_case_types, overridden_fields

part of models;

class StorageHasherV9 {
  final String kind;
  const StorageHasherV9({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV9 fromKey(String key) {
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
  static StorageHasherV10 fromKey(String key) {
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
  static StorageHasherV11 fromKey(String key) {
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
