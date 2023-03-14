part of generators;

enum StorageHasherType {
  /// Identity hashing (no hashing).
  identity,
  blake2b128,
  blake2b128Concat,
  blake2b256,
  twoxx64,
  twoxx64Concat,
  twoxx128,
  twoxx128Concat,
  twoxx256;

  const StorageHasherType();

  TypeReference type(BasePath from) {
    return constants.storageHasher.type as TypeReference;
  }

  Expression instance(Expression codecInstance, BasePath from) {
    return type(from).property(name).call([codecInstance]);
  }
}

class StorageHasher<G extends Generator> {
  final StorageHasherType hasher;
  final G codec;

  const StorageHasher({required this.hasher, required this.codec});
  const StorageHasher.identity({required this.codec})
      : hasher = StorageHasherType.identity;
  const StorageHasher.blake128({required this.codec})
      : hasher = StorageHasherType.blake2b128;
  const StorageHasher.blake128Concat({required this.codec})
      : hasher = StorageHasherType.blake2b128Concat;
  const StorageHasher.blake256({required this.codec})
      : hasher = StorageHasherType.blake2b256;
  const StorageHasher.twoxx64({required this.codec})
      : hasher = StorageHasherType.twoxx64;
  const StorageHasher.twoxx64Concat({required this.codec})
      : hasher = StorageHasherType.twoxx64Concat;
  const StorageHasher.twoxx128({required this.codec})
      : hasher = StorageHasherType.twoxx128;
  const StorageHasher.twoxx128Concat({required this.codec})
      : hasher = StorageHasherType.twoxx128Concat;
  const StorageHasher.twoxx256({required this.codec})
      : hasher = StorageHasherType.twoxx256;

  Expression instance(BasePath from) {
    return hasher.instance(codec.codecInstance(from), from);
  }

  factory StorageHasher.fromMetadata({
    required metadata.StorageHasher hasher,
    required G codec,
  }) {
    switch (hasher) {
      case metadata.StorageHasher.blake2_128:
        return StorageHasher.blake128(codec: codec);
      case metadata.StorageHasher.blake2_128Concat:
        return StorageHasher.blake128Concat(codec: codec);
      case metadata.StorageHasher.blake2_256:
        return StorageHasher.blake256(codec: codec);
      case metadata.StorageHasher.twox64Concat:
        return StorageHasher.twoxx64Concat(codec: codec);
      case metadata.StorageHasher.twox128:
        return StorageHasher.twoxx128(codec: codec);
      case metadata.StorageHasher.twox256:
        return StorageHasher.twoxx256(codec: codec);
      case metadata.StorageHasher.identity:
        return StorageHasher.identity(codec: codec);
      default:
        throw Exception('Unknown hasher type: ${hasher.name}');
    }
  }
}

class Storage {
  /// Variable name of the storage entry.
  final String name;

  /// A type of storage value.
  final List<StorageHasher> hashers;

  /// Type of the value stored
  final Generator valueCodec;

  /// Default value (SCALE encoded)
  final List<int> defaultValue;

  /// Storage entry documentation.
  final List<String> docs;

  /// The storage entry returns an `Option<T>`, with `None` if the key is not present.
  final bool isNullable;

  const Storage({
    required this.name,
    required this.hashers,
    required this.valueCodec,
    required this.defaultValue,
    this.isNullable = false,
    this.docs = const [],
  });

  factory Storage.fromMetadata(metadata.StorageEntryMetadata storageMetadata,
      Map<int, Generator> registry) {
    final type = storageMetadata.type;
    final valueCodec = registry[type.value]!;
    final List<Generator> keysCodec;

    // Load key hashers
    if (type.key != null) {
      final keyId = type.key!;
      if (type.hashers.isEmpty) {
        throw Exception(
            'Invalid storage, hashers cannot be empty when key is present');
      } else if (type.hashers.length == 1) {
        keysCodec = [registry[keyId]!];
      } else {
        final tupleCodec = registry[keyId]! as TupleGenerator;
        keysCodec = tupleCodec.generators;
      }
    } else {
      keysCodec = [];
    }

    // Check if hasher's amount matches key's amount
    if (keysCodec.length != type.hashers.length) {
      throw Exception(
          'Invalid storage, hasher\'s amount does not match key\'s amount');
    }

    // Build storage hashers
    final hashers = [
      for (int i = 0; i < type.hashers.length; i++)
        StorageHasher.fromMetadata(
          hasher: type.hashers[i],
          codec: keysCodec[i],
        )
    ];

    return Storage(
      name: storageMetadata.name,
      hashers: hashers,
      valueCodec: valueCodec,
      defaultValue: storageMetadata.defaultValue,
      isNullable:
          storageMetadata.modifier == metadata.StorageEntryModifier.optional,
      docs: storageMetadata.docs,
    );
  }

  TypeReference type(String from) {
    switch (hashers.length) {
      case 0:
        return constants.storageValue(valueCodec.primitive(from));
      case 1:
        return constants.storageMap(
            key: hashers[0].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 2:
        return constants.storageDoubleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 3:
        return constants.storageTripleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 4:
        return constants.storageQuadrupleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            key4: hashers[3].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 5:
        return constants.storageQuintupleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            key4: hashers[3].codec.primitive(from),
            key5: hashers[4].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 6:
        return constants.storageSextupleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            key4: hashers[3].codec.primitive(from),
            key5: hashers[4].codec.primitive(from),
            key6: hashers[5].codec.primitive(from),
            value: valueCodec.primitive(from));
      default:
        throw Exception('Invalid hashers length');
    }
  }

  Expression instance(BasePath from, String palletName) {
    final Map<String, Expression> arguments = {
      'prefix': literalString(palletName),
      'storage': literalString(name),
      'valueCodec': valueCodec.codecInstance(from),
    };

    if (hashers.length == 1) {
      arguments['hasher'] = hashers[0].instance(from);
    } else {
      for (int i = 0; i < hashers.length; i++) {
        arguments['hasher${i + 1}'] = hashers[i].instance(from);
      }
    }

    return type(from).constInstance([], arguments);
  }
}

class Constant {
  final String name;
  final List<int> value;
  final Generator codec;
  final List<String> docs;

  const Constant(
      {required this.name,
      required this.value,
      required this.codec,
      required this.docs});

  factory Constant.fromMetadata(
      metadata.PalletConstantMetadata constantMetadata,
      Map<int, Generator> registry) {
    // Build pallet
    return Constant(
        name: constantMetadata.name,
        value: constantMetadata.value,
        codec: registry[constantMetadata.type]!,
        docs: constantMetadata.docs);
  }
}

class PalletGenerator {
  String filePath;
  String name;
  List<Storage> storages;
  List<Constant> constants;

  PalletGenerator({
    required this.filePath,
    required this.name,
    required this.storages,
    required this.constants,
  });

  factory PalletGenerator.fromMetadata(
      {required String filePath,
      required metadata.PalletMetadata palletMetadata,
      required Map<int, Generator> registry}) {
    // Load storages
    final List<Storage>? storages = palletMetadata.storage?.entries
        .map((storageMetadata) =>
            Storage.fromMetadata(storageMetadata, registry))
        .toList();

    // Load constants
    final List<Constant> constants = palletMetadata.constants
        .map((constantMetadata) =>
            Constant.fromMetadata(constantMetadata, registry))
        .toList();

    // Build pallet
    return PalletGenerator(
        filePath: filePath,
        name: palletMetadata.name,
        storages: storages ?? [],
        constants: constants);
  }

  TypeReference queries(BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Queries'
      ..url = p.relative(filePath, from: from));
  }

  TypeReference constantsType(BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Constants'
      ..url = p.relative(filePath, from: from));
  }

  GeneratedOutput generated() {
    final List<Class> classes = [];
    if (storages.isNotEmpty) {
      classes.add(classbuilder.createPalletQueries(this));
    }
    if (constants.isNotEmpty) {
      classes.add(classbuilder.createPalletConstants(this));
    }
    return GeneratedOutput(classes: classes, enums: [], typedefs: []);
  }
}
