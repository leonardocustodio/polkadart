import 'dart:typed_data' show Uint8List;
import 'package:code_builder/code_builder.dart'
    show
        Block,
        Class,
        Code,
        CodeExpression,
        Constructor,
        Expression,
        Field,
        FieldModifier,
        Method,
        MethodModifier,
        Parameter,
        Reference,
        TypeReference,
        declareFinal,
        literalString,
        refer;
import 'package:path/path.dart' as p;
import 'package:polkadart/scale_codec.dart' as scale_codec;
import 'package:recase/recase.dart' show ReCase;
import '../typegen/typegen.dart' as typegen
    show
        TypeDescriptor,
        BasePath,
        TupleBuilder,
        GeneratedOutput,
        Field,
        VariantBuilder;
import '../typegen/runtime_metadata_v14.dart' as metadata;
import '../typegen/references.dart' as refs;
import '../utils/utils.dart' show sanitize, sanitizeDocs;

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

  TypeReference type(typegen.BasePath from) {
    return refs.storageHasher.type as TypeReference;
  }

  Expression instance(Expression codecInstance, typegen.BasePath from) {
    return type(from).property(name).call([codecInstance]);
  }
}

class StorageHasher<G extends typegen.TypeDescriptor> {
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

  Expression instance(typegen.BasePath from) {
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
  final typegen.TypeDescriptor valueCodec;

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
      Map<int, typegen.TypeDescriptor> registry) {
    final type = storageMetadata.type;
    final valueCodec = registry[type.value]!;
    final List<typegen.TypeDescriptor> keysCodec;

    // Load key hashers
    if (type.key != null) {
      final keyId = type.key!;
      if (type.hashers.isEmpty) {
        throw Exception(
            'Invalid storage, hashers cannot be empty when key is present');
      } else if (type.hashers.length == 1) {
        keysCodec = [registry[keyId]!];
      } else {
        final tupleCodec = registry[keyId]! as typegen.TupleBuilder;
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
        return refs.storageValue(valueCodec.primitive(from));
      case 1:
        return refs.storageMap(
            key: hashers[0].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 2:
        return refs.storageDoubleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 3:
        return refs.storageTripleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 4:
        return refs.storageQuadrupleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            key4: hashers[3].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 5:
        return refs.storageQuintupleMap(
            key1: hashers[0].codec.primitive(from),
            key2: hashers[1].codec.primitive(from),
            key3: hashers[2].codec.primitive(from),
            key4: hashers[3].codec.primitive(from),
            key5: hashers[4].codec.primitive(from),
            value: valueCodec.primitive(from));
      case 6:
        return refs.storageSextupleMap(
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

  Expression instance(typegen.BasePath from, String palletName) {
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

class Tx {
  final String name;
  final List<typegen.Field> fields;
  final typegen.TypeDescriptor codec;
  final int index;
  final List<String> docs;

  const Tx({
    required this.name,
    required this.fields,
    required this.index,
    required this.docs,
    required this.codec,
  });

  factory Tx.fromMetadata(
    metadata.CallEntryMetadata callMetadata,
    int type,
    Map<int, typegen.TypeDescriptor> registry,
  ) {
    final typeDescriptor = registry[type]!;

    return Tx(
      name: callMetadata.name,
      fields: callMetadata.fields
          .map(
            (field) => typegen.Field(
              originalName: field.name,
              codec: registry[field.type]!,
              docs: field.docs,
            ),
          )
          .toList(),
      index: callMetadata.index,
      codec: typeDescriptor,
      docs: callMetadata.docs,
    );
  }
}

class Constant {
  final String name;
  final List<int> value;
  final typegen.TypeDescriptor codec;
  final List<String> docs;

  const Constant({
    required this.name,
    required this.value,
    required this.codec,
    required this.docs,
  });

  factory Constant.fromMetadata(
    metadata.PalletConstantMetadata constantMetadata,
    Map<int, typegen.TypeDescriptor> registry,
  ) {
    // Build pallet
    return Constant(
      name: constantMetadata.name,
      value: constantMetadata.value,
      codec: registry[constantMetadata.type]!,
      docs: constantMetadata.docs,
    );
  }
}

class PalletGenerator {
  String filePath;
  String name;
  List<Storage> storages;
  List<Tx> txs;
  List<Constant> constants;
  typegen.TypeDescriptor runtimeCall;

  PalletGenerator({
    required this.filePath,
    required this.name,
    required this.storages,
    required this.txs,
    required this.constants,
    required this.runtimeCall,
  });

  factory PalletGenerator.fromMetadata({
    required String filePath,
    required metadata.PalletMetadata palletMetadata,
    required Map<int, typegen.TypeDescriptor> registry,
  }) {
    // Load storages
    final List<Storage>? storages = palletMetadata.storage?.entries
        .map((storageMetadata) =>
            Storage.fromMetadata(storageMetadata, registry))
        .toList();

    // Load calls
    final List<Tx>? txs = palletMetadata.call?.entries
        .map((callMetadata) =>
            Tx.fromMetadata(callMetadata, palletMetadata.call!.type, registry))
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
      txs: txs ?? [],
      constants: constants,
      runtimeCall: registry[palletMetadata.runtimeCallType]!,
    );
  }

  TypeReference queries(typegen.BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Queries'
      ..url = p.relative(filePath, from: from));
  }

  TypeReference exts(typegen.BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Txs'
      ..url = p.relative(filePath, from: from));
  }

  TypeReference constantsType(typegen.BasePath from) {
    return TypeReference((b) => b
      ..symbol = 'Constants'
      ..url = p.relative(filePath, from: from));
  }

  typegen.GeneratedOutput generated() {
    final List<Class> classes = [];
    if (storages.isNotEmpty) {
      classes.add(createPalletQueries(this));
    }
    if (txs.isNotEmpty) {
      classes.add(createPalletTxs(this));
    }
    if (constants.isNotEmpty) {
      classes.add(createPalletConstants(this));
    }
    return typegen.GeneratedOutput(classes: classes, enums: [], typedefs: []);
  }
}

Class createPalletQueries(
  PalletGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Queries'
        ..constructors.add(Constructor((b) => b
          ..constant = true
          ..requiredParameters.add(Parameter((b) => b
            ..toThis = true
            ..required = false
            ..named = false
            ..name = '__api'))))
        ..fields.add(Field((b) => b
          ..name = '__api'
          ..type = refs.stateApi
          ..modifier = FieldModifier.final$))
        ..fields.addAll(generator.storages.map((storage) => Field((b) => b
          ..name = '_${ReCase(storage.name).camelCase}'
          ..type = storage.type(dirname)
          ..modifier = FieldModifier.final$
          ..assignment = storage.instance(dirname, generator.name).code)))
        ..methods.addAll(generator.storages.map((storage) => Method((builder) {
              final storageName = ReCase(storage.name).camelCase;
              final Reference primitive;
              if (storage.isNullable) {
                primitive = storage.valueCodec.primitive(dirname).asNullable();
              } else {
                primitive = storage.valueCodec.primitive(dirname);
              }
              builder
                ..name = sanitize(storageName, recase: false)
                ..docs.addAll(sanitizeDocs(storage.docs))
                ..returns = refs.future(primitive)
                ..modifier = MethodModifier.async
                ..optionalParameters.add(Parameter((b) => b
                  ..type = refs.blockHash.asNullable()
                  ..named = true
                  ..name = 'at'))
                ..requiredParameters
                    .addAll(storage.hashers.map((hasher) => Parameter((b) => b
                      ..type = hasher.codec.primitive(dirname)
                      ..name = 'key${storage.hashers.indexOf(hasher) + 1}')))
                ..body = Block((b) => b
                  // final hashedKey = _storageName.hashedKeyFor(key1);
                  ..statements.add(declareFinal('hashedKey')
                      .assignHashedKey(storageName, storage)
                      .statement)
                  // final bytes = await api.queryStorage([hashedKey]);
                  ..statements.add(declareFinal('bytes')
                      .assign(refer('__api').property('getStorage').call(
                          [refer('hashedKey')], {'at': refer('at')}).awaited)
                      .statement)
                  ..statements.add(Code('if (bytes != null) {'))
                  ..statements
                      .add(Code('  return _$storageName.decodeValue(bytes);'))
                  ..statements.add(Code('}'))
                  ..statements.add(storage.isNullable
                      ? Code('return null; /* Nullable */')
                      : storage.valueCodec
                          .valueFrom(
                            dirname,
                            scale_codec.ByteInput(
                                Uint8List.fromList(storage.defaultValue)),
                          )
                          .returned
                          .statement)
                  ..statements.add(
                      storage.isNullable ? Code('') : Code('/* Default */')));
            })))
        ..methods.addAll(generator.storages.map((storage) => Method((builder) {
              final storageName = ReCase(storage.name).camelCase;
              builder
                ..name = sanitize(storage.keyMethodName(), recase: false)
                ..docs.addAll(sanitizeDocs(
                    ['Returns the storage key for `$storageName`.']))
                ..returns = refs.uint8List
                ..requiredParameters
                    .addAll(storage.hashers.map((hasher) => Parameter((b) => b
                      ..type = hasher.codec.primitive(dirname)
                      ..name = 'key${storage.hashers.indexOf(hasher) + 1}')))
                ..body = Block((b) => b
                  ..statements.add(declareFinal('hashedKey')
                      .assignHashedKey(storageName, storage)
                      .statement)
                  ..statements.add(Code('  return hashedKey;')));
            })))
        ..methods.addAll(generator.storages
            // We don't support maps with depth > 2 yet.
            .where((storage) =>
                storage.hashers.isNotEmpty && storage.hashers.length < 3)
            .map((storage) => Method((builder) {
                  final storageName = ReCase(storage.name).camelCase;
                  builder
                    ..name =
                        sanitize(storage.mapPrefixMethodName(), recase: false)
                    ..docs.addAll(sanitizeDocs([
                      'Returns the storage map key prefix for `$storageName`.'
                    ]))
                    ..returns = refs.uint8List
                    ..requiredParameters.addAll(storage.hashers
                        .getRange(0, storage.hashers.length - 1)
                        .map((hasher) => Parameter((b) => b
                          ..type = hasher.codec.primitive(dirname)
                          ..name =
                              'key${storage.hashers.indexOf(hasher) + 1}')))
                    ..body = Block((b) => b
                      ..statements.add(declareFinal('hashedKey')
                          .assignMapPrefix(storageName, storage)
                          .statement)
                      ..statements.add(Code('  return hashedKey;')));
                })));
    });

Class createPalletTxs(
  PalletGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Txs'
        ..constructors.add(Constructor((b) => b..constant = true))
        ..methods.addAll(generator.txs.map((tx) => Method((builder) {
              var txName = ReCase(tx.name).camelCase;
              final Reference primitive = tx.codec.primitive(dirname);
              final Reference runtimePrimitive =
                  generator.runtimeCall.primitive(dirname);
              final isEnumClass = tx.codec is typegen.VariantBuilder &&
                  (tx.codec as typegen.VariantBuilder)
                      .variants
                      .every((variant) => variant.fields.isEmpty);

              builder
                ..name = sanitize(txName, recase: false)
                ..docs.addAll(sanitizeDocs(tx.docs))
                ..returns = runtimePrimitive
                ..optionalParameters.addAll(
                  tx.fields.map(
                    (field) => Parameter(
                      (b) => b
                        ..required =
                            field.codec.primitive(dirname).isNullable != true
                        ..named = true
                        ..name = field.sanitizedName
                        ..type = field.codec.primitive(dirname),
                    ),
                  ),
                )
                ..body = Block((b) {
                  if (sanitize(txName) ==
                      sanitize(primitive.symbol.toString())) {
                    txName = '${txName}Variant';
                  }

                  Expression expression =
                      declareFinal('_call').assign(primitive);

                  if (isEnumClass == false) {
                    // not an simple enum class, contains parametrized fields.
                    expression = expression
                        .property('values')
                        .property(sanitize(txName, recase: false))
                        .call([], {
                      for (final field in tx.fields)
                        field.sanitizedName:
                            CodeExpression(Code(field.sanitizedName))
                    });
                  } else {
                    // simple enum class no need to call () contructor
                    // instead leaving it as a property.
                    expression =
                        expression.property(sanitize(txName, recase: false));
                  }

                  b
                    ..statements.add(expression.statement)
                    ..statements.add(runtimePrimitive
                        .property('values')
                        .property(ReCase(generator.name).camelCase)
                        .call([CodeExpression(Code('_call'))])
                        .returned
                        .statement);
                });
            })));
    });

Class createPalletConstants(
  PalletGenerator generator,
) =>
    Class((classBuilder) {
      final dirname = p.dirname(generator.filePath);
      classBuilder
        ..name = 'Constants'
        ..constructors.add(Constructor((b) => b..constant = false))
        ..fields.addAll(generator.constants.map((constant) => Field((b) => b
          ..name = sanitize(constant.name)
          ..type = constant.codec.primitive(dirname)
          ..modifier = FieldModifier.final$
          ..docs.addAll(sanitizeDocs(constant.docs))
          ..assignment = constant.codec
              .valueFrom(dirname,
                  scale_codec.ByteInput(Uint8List.fromList(constant.value)),
                  constant: true)
              .code)));
    });

extension MethodNameExtension on Storage {
  /// Name of the generated method returning the key of a storage.
  String keyMethodName() {
    return '${name}Key';
  }

  /// Name of the generated method returning the key prefix of a storage.
  String mapPrefixMethodName() {
    return '${name}MapPrefix';
  }
}

extension AssignHashedKeyExtension on Expression {
  Expression assignHashedKey(String storageName, Storage storage) {
    return assign(refer('_$storageName')
        .property(storage.hashers.isEmpty ? 'hashedKey' : 'hashedKeyFor')
        .call(storage.hashers.map(
            (hasher) => refer('key${storage.hashers.indexOf(hasher) + 1}'))));
  }

  Expression assignMapPrefix(String storageName, Storage storage) {
    if (storage.hashers.isEmpty) {
      throw Exception(
        'Bad code generation path; can\'t create keyPrefix method without hashers.',
      );
    }

    if (storage.hashers.length > 2) {
      throw Exception(
        'Bad code generation path; keyPrefix method for maps with depth > 2 are not supported yet.',
      );
    }

    return assign(refer('_$storageName').property('mapPrefix').call(storage
        .hashers
        // Checked above that hasher is not empty.
        .getRange(0, storage.hashers.length - 1)
        .map((hasher) => refer('key${storage.hashers.indexOf(hasher) + 1}'))));
  }
}
