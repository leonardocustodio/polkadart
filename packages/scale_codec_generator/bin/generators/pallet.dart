import 'dart:typed_data';

import './base.dart' show Generator, GeneratedOutput;
import '../class_builder.dart' show createPalletQueries;
import '../constants.dart' as constants;
import 'package:code_builder/code_builder.dart'
    show TypeReference, Expression, literalString;
import 'tuple.dart' show TupleGenerator;

enum StorageHasherType {
  identity,
  blake128,
  blake128Concat,
  twoxx64,
  twoxx64Concat,
  twoxx128,
  twoxx128Concat;

  const StorageHasherType();

  factory StorageHasherType.fromMetadataName(String name) {
    switch (name) {
      case 'Identity':
        return StorageHasherType.identity;
      case 'Twox64':
        return StorageHasherType.twoxx64;
      case 'Twox64Concat':
        return StorageHasherType.twoxx64Concat;
      case 'Twox128':
        return StorageHasherType.twoxx128;
      case 'Twox128Concat':
        return StorageHasherType.twoxx128Concat;
      case 'Blake2_128':
        return StorageHasherType.blake128;
      case 'Blake2_128Concat':
        return StorageHasherType.blake128Concat;
      default:
        throw Exception('Unknown StorageHasherType: $name');
    }
  }

  TypeReference type() {
    return constants.storageHasher.type as TypeReference;
  }

  Expression instance(Expression codecInstance) {
    return type().property(name).call([codecInstance]);
  }
}

class StorageHasher<G extends Generator> {
  final StorageHasherType hasher;
  final G codec;

  const StorageHasher({required this.hasher, required this.codec});
  const StorageHasher.identity({required this.codec})
      : hasher = StorageHasherType.identity;
  const StorageHasher.blake128({required this.codec})
      : hasher = StorageHasherType.blake128;
  const StorageHasher.blake128Concat({required this.codec})
      : hasher = StorageHasherType.blake128Concat;
  const StorageHasher.twoxx64({required this.codec})
      : hasher = StorageHasherType.twoxx64;
  const StorageHasher.twoxx64Concat({required this.codec})
      : hasher = StorageHasherType.twoxx64Concat;
  const StorageHasher.twoxx128({required this.codec})
      : hasher = StorageHasherType.twoxx128;
  const StorageHasher.twoxx128Concat({required this.codec})
      : hasher = StorageHasherType.twoxx128Concat;

  Expression instance() {
    return hasher.instance(codec.codecInstance());
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
  final Uint8List defaultValue;

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

  TypeReference type() {
    switch (hashers.length) {
      case 0:
        return constants.storageValue(valueCodec.primitive());
      case 1:
        return constants.storageMap(
            key: hashers[0].codec.primitive(), value: valueCodec.primitive());
      case 2:
        return constants.storageDoubleMap(
            key1: hashers[0].codec.primitive(),
            key2: hashers[1].codec.primitive(),
            value: valueCodec.primitive());
      case 3:
        return constants.storageTripleMap(
            key1: hashers[0].codec.primitive(),
            key2: hashers[1].codec.primitive(),
            key3: hashers[2].codec.primitive(),
            value: valueCodec.primitive());
      case 4:
        return constants.storageQuadrupleMap(
            key1: hashers[0].codec.primitive(),
            key2: hashers[1].codec.primitive(),
            key3: hashers[2].codec.primitive(),
            key4: hashers[3].codec.primitive(),
            value: valueCodec.primitive());
      case 5:
        return constants.storageQuintupleMap(
            key1: hashers[0].codec.primitive(),
            key2: hashers[1].codec.primitive(),
            key3: hashers[2].codec.primitive(),
            key4: hashers[3].codec.primitive(),
            key5: hashers[4].codec.primitive(),
            value: valueCodec.primitive());
      case 6:
        return constants.storageSextupleMap(
            key1: hashers[0].codec.primitive(),
            key2: hashers[1].codec.primitive(),
            key3: hashers[2].codec.primitive(),
            key4: hashers[3].codec.primitive(),
            key5: hashers[4].codec.primitive(),
            key6: hashers[5].codec.primitive(),
            value: valueCodec.primitive());
      default:
        throw Exception('Invalid hashers length');
    }
  }

  Expression instance(String palletName) {
    final Map<String, Expression> arguments = {
      'prefix': literalString(palletName),
      'storage': literalString(name),
      'valueCodec': valueCodec.codecInstance(),
    };

    if (hashers.length == 1) {
      arguments['hasher'] = hashers[0].instance();
    } else {
      for (int i = 0; i < hashers.length; i++) {
        arguments['hasher${i + 1}'] = hashers[i].instance();
      }
    }

    return type().constInstance([], arguments);
  }
}

class Constant {
  final String name;
  final Uint8List value;
  final Generator codec;
  final List<String> docs;

  Constant(
      {required this.name,
      required this.value,
      required this.codec,
      required this.docs});
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

  factory PalletGenerator.fromJson(
      {required String filePrefix,
      required Map<String, dynamic> json,
      required Map<int, Generator> generators}) {
    final palletName = json['name'] as String;
    if (json['storage'] == null) {
      return PalletGenerator(
        filePath: '$filePrefix/$palletName.dart',
        name: palletName,
        storages: [],
        constants: [],
      );
    }

    final prefix = json['storage']['prefix'] as String;
    final storages = (json['storage']['items'] as List).map((storage) {
      final name = storage['name'] as String;
      final isNullable = (storage['modifier'] as String) == 'Optional';
      final fallback =
          Uint8List.fromList((storage['fallback'] as List).cast<int>());

      final docs = (storage['docs'] as List).cast<String>();
      final type = storage['type'] as Map<String, dynamic>;

      final List<StorageHasher> hashers;
      final Generator valueGenerator;
      switch (type.keys.first) {
        case 'Map':
          {
            final map = type['Map'] as Map<String, dynamic>;
            final hashersJson =
                (map['hashers'] as List).cast<Map<String, dynamic>>();
            valueGenerator = generators[map['value'] as int]!;
            if (hashersJson.isEmpty) {
              throw Exception(
                  'Storage "$prefix.$name" of type Map cannot have empty hashers list');
            }
            if (hashersJson.length > 1 &&
                generators[map['key'] as int] is! TupleGenerator) {
              throw Exception('Invalid key generator type, must be Tuple!');
            }
            final List<Generator> keysGenerator;
            if (hashersJson.length == 1) {
              keysGenerator = [generators[map['key'] as int]!];
            } else {
              keysGenerator =
                  (generators[map['key'] as int]! as TupleGenerator).generators;
            }
            if (keysGenerator.length != hashersJson.length) {
              throw Exception('Number of keys and hashers doesn\'t match!!');
            }
            hashers = [];
            for (int i = 0; i < keysGenerator.length; i++) {
              final hasherType =
                  StorageHasherType.fromMetadataName(hashersJson[i].keys.first);
              hashers.add(
                  StorageHasher(hasher: hasherType, codec: keysGenerator[i]));
            }
          }
          break;
        case 'Plain':
          {
            hashers = [];
            valueGenerator = generators[type['Plain'] as int]!;
          }
          break;
        default:
          throw Exception('Unsupported storage type: ${type.keys.first}');
      }
      return Storage(
        name: name,
        hashers: hashers,
        valueCodec: valueGenerator,
        defaultValue: fallback,
        isNullable: isNullable,
        docs: docs,
      );
    }).toList();

    return PalletGenerator(
      filePath: '$filePrefix/$palletName.dart',
      name: palletName,
      storages: storages,
      constants: [],
    );
  }

  TypeReference queries() {
    return TypeReference((b) => b
      ..symbol = 'Queries'
      ..url = filePath);
  }

  GeneratedOutput generated() {
    final pallet = createPalletQueries(this);
    return GeneratedOutput(classes: [pallet], enums: [], typedefs: []);
  }
}
