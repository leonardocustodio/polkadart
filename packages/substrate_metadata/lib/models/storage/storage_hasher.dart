// ignore_for_file: camel_case_types, overridden_fields

part of models;

class StorageHasherV11 {
  final String kind;
  const StorageHasherV11({required this.kind});

  /// Creates Class Object from `Json`
  static StorageHasherV11 fromKey(MapEntry entry) {
    switch (entry.key) {
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
        throw UnexpectedTypeException('Unexpected type: ${entry.key}');
    }
  }

  /// Creates Map Object from `Class`
  MapEntry<String, dynamic> toJson() {
    switch (kind) {
      case 'Blake2_128':
        return MapEntry('Blake2_128', null);
      case 'Blake2_256':
        return MapEntry('Blake2_256', null);
      case 'Blake2_128Concat':
        return MapEntry('Blake2_128Concat', null);
      case 'Twox128':
        return MapEntry('Twox128', null);
      case 'Twox256':
        return MapEntry('Twox256', null);
      case 'Twox64Concat':
        return MapEntry('Twox64Concat', null);
      case 'Identity':
        return MapEntry('Identity', null);
      default:
        throw UnexpectedTypeException('Unexpected type: $kind');
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
