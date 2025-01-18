part of metadata;

/// The metadata of a runtime.
abstract class PolkadartMetadata implements RuntimeMetadata {
  /// Type registry containing all types used in the metadata.
  final List<PortableType> types;

  /// Metadata of all the pallets.
  final List<PalletMetadata> pallets;

  /// Metadata of the extrinsic.
  final ExtrinsicMetadata extrinsic;

  /// The type of the `Runtime`.
  final TypeId runtimeTypeId;

  /// Metadata of the apis.
  final List<ApiMetadata> apis;

  /// Metadata of the outer enums.
  final OuterEnumMetadata outerEnums;

  /// custom.
  final CustomMetadata custom;

  static const $PolkadartMetadataCodec codec = $PolkadartMetadataCodec._();

  PolkadartMetadata({
    required this.types,
    required this.pallets,
    required this.extrinsic,
    required this.runtimeTypeId,
    required this.apis,
    required this.outerEnums,
    required this.custom,
  });

  PortableType typeById(int id) {
    return types.firstWhere((type) => type.id == id);
  }

  @override
  int runtimeMetadataVersion();

  @override
  Map<String, dynamic> toJson() => {
        'types': types.map((type) => type.toJson()).toList(),
        'pallets': pallets.map((pallet) => pallet.toJson()).toList(),
        'extrinsic': extrinsic.toJson(),
        'ty': runtimeTypeId,
        'apis': apis,
        'outerEnums': outerEnums,
        'custom': custom,
      };
}

class $PolkadartMetadataCodec implements Codec<PolkadartMetadata> {
  const $PolkadartMetadataCodec._();

  @override
  PolkadartMetadata decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);
    final pallets = SequenceCodec(PalletMetadata.codec).decode(input);
    final extrinsic = ExtrinsicMetadata.codec.decode(input);
    final runtimeTypeId = TypeIdCodec.codec.decode(input);
    final apis = SequenceCodec(ApiMetadata.codec).decode(input);
    final outerEnums = OuterEnumMetadata.codec.decode(input);
    final custom = CustomMetadata.codec.decode(input);
    return RuntimeMetadataV15(
      types: types,
      pallets: pallets,
      extrinsic: extrinsic,
      runtimeTypeId: runtimeTypeId,
      apis: apis,
      outerEnums: outerEnums,
      custom: custom,
    );
  }

  @override
  Uint8List encode(PolkadartMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PolkadartMetadata metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);
    SequenceCodec(PalletMetadata.codec).encodeTo(metadata.pallets, output);
    ExtrinsicMetadata.codec.encodeTo(metadata.extrinsic, output);
    TypeIdCodec.codec.encodeTo(metadata.runtimeTypeId, output);
    SequenceCodec(ApiMetadata.codec).encodeTo(metadata.apis!, output);
    OuterEnumMetadata.codec.encodeTo(metadata.outerEnums!, output);
    CustomMetadata.codec.encodeTo(metadata.custom!, output);
  }

  @override
  int sizeHint(PolkadartMetadata metadata) {
    int size = SequenceCodec(PortableType.codec).sizeHint(metadata.types);
    size += SequenceCodec(PalletMetadata.codec).sizeHint(metadata.pallets);
    size += ExtrinsicMetadata.codec.sizeHint(metadata.extrinsic);
    size += TypeIdCodec.codec.sizeHint(metadata.runtimeTypeId);
    size += SequenceCodec(ApiMetadata.codec).sizeHint(metadata.apis!);
    size += OuterEnumMetadata.codec.sizeHint(metadata.outerEnums!);
    size += CustomMetadata.codec.sizeHint(metadata.custom!);
    return size;
  }
}

/// Hasher used by storage maps
enum StorageHasher {
  /// 128-bit Blake2 hash.
  blake2_128(false),

  /// 256-bit Blake2 hash.
  blake2_256(false),

  /// Multiple 128-bit Blake2 hashes concatenated.
  blake2_128Concat(true),

  /// 128-bit XX hash.
  twox128(false),

  /// 256-bit XX hash.
  twox256(false),

  /// Multiple 64-bit XX hashes concatenated.
  twox64Concat(true),

  /// Identity hashing (no hashing).
  identity(true);

  /// Wether the hasher is concatenating the original.
  final bool concat;

  static const $StorageHasherCodec codec = $StorageHasherCodec._();

  /// Creates a new storage hasher.
  const StorageHasher(this.concat);

  factory StorageHasher.fromJson(Map<String, dynamic> json) {
    switch (json.keys.first) {
      case 'Blake2_128':
        return blake2_128;
      case 'Blake2_256':
        return blake2_256;
      case 'Blake2_128Concat':
        return blake2_128Concat;
      case 'Twox128':
        return twox128;
      case 'Twox256':
        return twox256;
      case 'Twox64Concat':
        return twox64Concat;
      case 'Identity':
        return identity;
      default:
        throw Exception('Unknown storage hasher: "${json.keys.first}"');
    }
  }

  @override
  String toString() {
    switch (this) {
      case blake2_128:
        return 'Blake2_128';
      case blake2_256:
        return 'Blake2_256';
      case blake2_128Concat:
        return 'Blake2_128Concat';
      case twox128:
        return 'Twox128';
      case twox256:
        return 'Twox256';
      case twox64Concat:
        return 'Twox64Concat';
      case identity:
        return 'Identity';
      default:
        return name;
    }
  }
}

class $StorageHasherCodec implements Codec<StorageHasher> {
  const $StorageHasherCodec._();

  @override
  StorageHasher decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return StorageHasher.blake2_128;
      case 1:
        return StorageHasher.blake2_256;
      case 2:
        return StorageHasher.blake2_128Concat;
      case 3:
        return StorageHasher.twox128;
      case 4:
        return StorageHasher.twox256;
      case 5:
        return StorageHasher.twox64Concat;
      case 6:
        return StorageHasher.identity;
      default:
        throw Exception('Unknown StorageHasher variant index $index');
    }
  }

  @override
  Uint8List encode(StorageHasher storageHasher) {
    return Uint8List.fromList([storageHasher.index]);
  }

  @override
  void encodeTo(StorageHasher storageHasher, Output output) {
    output.pushByte(storageHasher.index);
  }

  @override
  int sizeHint(StorageHasher storageHasher) {
    return 1;
  }
}

/// A type of storage value.
class StorageEntryType {
  /// zero or more hashers, should be one hasher per key element.
  final List<StorageHasher> hashers;

  /// The type of the key, can be a tuple with elements for each of the hashers.
  /// `null` when hashers.length == 0
  final int? key;

  /// The type of the value.
  final int value;

  static const $StorageEntryTypeCodec codec = $StorageEntryTypeCodec._();

  StorageEntryType({required this.hashers, this.key, required this.value});

  factory StorageEntryType.fromJson(Map<String, dynamic> json) {
    final List<StorageHasher> hashers;
    final int? key;
    final int value;

    switch (json.keys.first) {
      case 'Map':
        final map = json['Map'] as Map<String, dynamic>;
        hashers = (map['hashers'] as List)
            .cast<Map<String, dynamic>>()
            .map((json) => StorageHasher.fromJson(json))
            .toList();
        key = map['key'] as int;
        value = map['value'] as int;
        break;
      case 'Plain':
        hashers = [];
        key = null;
        value = json['Plain'] as int;
        break;
      default:
        throw Exception('Unknown storage type: ${json.keys.first}');
    }

    return StorageEntryType(
      hashers: hashers,
      key: key,
      value: value,
    );
  }

  Map<String, dynamic> toJson() {
    if (key != null) {
      return {
        'Map': {
          'hashers': hashers.map((hasher) => hasher.toString()).toList(),
          'key': key,
          'value': value,
        }
      };
    }
    return {
      'Plain': value,
    };
  }
}

class $StorageEntryTypeCodec implements Codec<StorageEntryType> {
  const $StorageEntryTypeCodec._();

  @override
  StorageEntryType decode(Input input) {
    final variantType = input.read();
    TypeId value;
    TypeId? key;
    List<StorageHasher> hashers;
    switch (variantType) {
      case 0:
        {
          hashers = [];
          key = null;
          value = TypeIdCodec.codec.decode(input);
          break;
        }
      case 1:
        {
          hashers = SequenceCodec(StorageHasher.codec).decode(input);
          key = TypeIdCodec.codec.decode(input);
          value = TypeIdCodec.codec.decode(input);
          break;
        }
      default:
        throw Exception('Unknown StorageEntryType variant index $variantType');
    }
    return StorageEntryType(
      hashers: hashers,
      key: key,
      value: value,
    );
  }

  @override
  Uint8List encode(StorageEntryType entryType) {
    final output = ByteOutput(sizeHint(entryType));
    encodeTo(entryType, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(StorageEntryType entryType, Output output) {
    if (entryType.key == null) {
      output.pushByte(0);
      TypeIdCodec.codec.encodeTo(entryType.value, output);
    } else {
      output.pushByte(1);
      SequenceCodec(StorageHasher.codec).encodeTo(entryType.hashers, output);
      TypeIdCodec.codec.encodeTo(entryType.key!, output);
      TypeIdCodec.codec.encodeTo(entryType.value, output);
    }
  }

  @override
  int sizeHint(StorageEntryType entryType) {
    int size = 1 + TypeIdCodec.codec.sizeHint(entryType.value);
    if (entryType.key != null) {
      size += TypeIdCodec.codec.sizeHint(entryType.key!);
      size += SequenceCodec(StorageHasher.codec).sizeHint(entryType.hashers);
    }
    return size;
  }
}

/// A storage entry modifier indicates how a storage entry is returned when fetched and what the value will be if the key is not present.
/// Specifically this refers to the "return type" when fetching a storage entry, and what the value will be if the key is not present.
///
/// `optional` means you should expect an `T?`, with `null` returned if the key is not present.
/// `default_` means you should expect a `T` with the default value of default if the key is not present.
enum StorageEntryModifier {
  /// The storage entry returns an `Option<T>`, with `None` if the key is not present.
  optional,

  /// The storage entry returns `T::Default` if the key is not present.
  default_;

  static const $StorageEntryModifierCodec codec =
      $StorageEntryModifierCodec._();

  factory StorageEntryModifier.fromString(String str) {
    switch (str) {
      case 'Optional':
        return optional;
      case 'Default':
        return default_;
      default:
        throw Exception('Unknown storage modifier: "$str"');
    }
  }

  @override
  String toString() {
    switch (this) {
      case StorageEntryModifier.optional:
        return 'Optional';
      case StorageEntryModifier.default_:
        return 'Default';
    }
  }
}

class $StorageEntryModifierCodec implements Codec<StorageEntryModifier> {
  const $StorageEntryModifierCodec._();

  @override
  StorageEntryModifier decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return StorageEntryModifier.optional;
      case 1:
        return StorageEntryModifier.default_;
      default:
        throw Exception('Unknown storage modifier variant index $index');
    }
  }

  @override
  Uint8List encode(StorageEntryModifier value) {
    return Uint8List.fromList([value.index]);
  }

  @override
  void encodeTo(StorageEntryModifier value, Output output) {
    output.pushByte(value.index);
  }

  @override
  int sizeHint(StorageEntryModifier value) {
    return 1;
  }
}

/// Metadata about one storage entry.
class StorageEntryMetadata {
  /// Variable name of the storage entry.
  final String name;

  /// An `Option` modifier of that storage entry.
  final StorageEntryModifier modifier;

  /// Type of the value stored in the entry.
  final StorageEntryType type;

  /// Default value (SCALE encoded).
  final List<int> defaultValue;

  /// Storage entry documentation.
  final List<String> docs;

  static const $StorageEntryMetadataCodec codec =
      $StorageEntryMetadataCodec._();

  const StorageEntryMetadata(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.defaultValue,
      required this.docs});

  factory StorageEntryMetadata.fromJson(Map<String, dynamic> json) {
    return StorageEntryMetadata(
      name: (json['name'] as String),
      modifier: StorageEntryModifier.fromString(json['modifier'] as String),
      type: StorageEntryType.fromJson(json['type'] as Map<String, dynamic>),
      defaultValue: Uint8List.fromList((json['fallback'] as List).cast<int>()),
      docs: (json['docs'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'modifier': modifier.toString(),
        'ty': type.toJson(),
        'default': defaultValue,
        'docs': docs,
      };
}

class $StorageEntryMetadataCodec implements Codec<StorageEntryMetadata> {
  const $StorageEntryMetadataCodec._();

  @override
  StorageEntryMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final modifier = StorageEntryModifier.codec.decode(input);
    final type = StorageEntryType.codec.decode(input);
    final defaultValue = U8SequenceCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return StorageEntryMetadata(
      name: name,
      modifier: modifier,
      type: type,
      defaultValue: defaultValue,
      docs: docs,
    );
  }

  @override
  Uint8List encode(StorageEntryMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(StorageEntryMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    StorageEntryModifier.codec.encodeTo(metadata.modifier, output);
    StorageEntryType.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.defaultValue, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(StorageEntryMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += StorageEntryModifier.codec.sizeHint(metadata.modifier);
    size += StorageEntryType.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.defaultValue);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// Metadata for all calls in a pallet
class PalletCallMetadata {
  /// The call type for the pallet
  final TypeId type;

  static const $PalletCallMetadataCodec codec = $PalletCallMetadataCodec._();

  const PalletCallMetadata(this.type);

  Map<String, int> toJson() => {
        'ty': type,
      };
}

class $PalletCallMetadataCodec implements Codec<PalletCallMetadata> {
  const $PalletCallMetadataCodec._();

  @override
  PalletCallMetadata decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletCallMetadata(type);
  }

  @override
  Uint8List encode(PalletCallMetadata metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletCallMetadata metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletCallMetadata metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// All metadata of the pallet's storage.
class PalletStorageMetadata {
  /// The common prefix used by all storage entries.
  final String prefix;

  /// Metadata for all storage entries.
  final List<StorageEntryMetadata> entries;

  static const $PalletStorageMetadataCodec codec =
      $PalletStorageMetadataCodec._();

  const PalletStorageMetadata({required this.prefix, required this.entries});

  factory PalletStorageMetadata.fromJson(Map<String, dynamic> json) {
    final prefix = (json['prefix'] as String);
    final items = (json['items'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => StorageEntryMetadata.fromJson(json))
        .toList();

    return PalletStorageMetadata(
      prefix: prefix,
      entries: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'entries': entries.map((entry) => entry.toJson()).toList(),
      };
}

class $PalletStorageMetadataCodec implements Codec<PalletStorageMetadata> {
  const $PalletStorageMetadataCodec._();

  @override
  PalletStorageMetadata decode(Input input) {
    final prefix = StrCodec.codec.decode(input);
    final entries = SequenceCodec(StorageEntryMetadata.codec).decode(input);
    return PalletStorageMetadata(
      prefix: prefix,
      entries: entries,
    );
  }

  @override
  Uint8List encode(PalletStorageMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletStorageMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.prefix, output);
    SequenceCodec(StorageEntryMetadata.codec)
        .encodeTo(metadata.entries, output);
  }

  @override
  int sizeHint(PalletStorageMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.prefix);
    size +=
        SequenceCodec(StorageEntryMetadata.codec).sizeHint(metadata.entries);
    return size;
  }
}

/// Metadata about one pallet constant.
class PalletConstantMetadata {
  /// Name of the pallet constant.
  final String name;

  /// Type of the pallet constant.
  final TypeId type;

  /// Value stored in the constant (SCALE encoded).
  final List<int> value;

  /// Documentation of the constant.
  final List<String> docs;

  static const $PalletConstantMetadataCodec codec =
      $PalletConstantMetadataCodec._();

  const PalletConstantMetadata({
    required this.name,
    required this.type,
    required this.value,
    required this.docs,
  });

  factory PalletConstantMetadata.fromJson(Map<String, dynamic> json) {
    return PalletConstantMetadata(
      name: json['name'],
      type: json['ty'],
      value: Uint8List.fromList((json['value'] as List).cast<int>()),
      docs: (json['docs'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'ty': type,
        'value': value,
        'docs': docs,
      };
}

class $PalletConstantMetadataCodec implements Codec<PalletConstantMetadata> {
  const $PalletConstantMetadataCodec._();

  @override
  PalletConstantMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    final value = U8SequenceCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return PalletConstantMetadata(
      name: name,
      type: type,
      value: value,
      docs: docs,
    );
  }

  @override
  Uint8List encode(PalletConstantMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletConstantMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.value, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(PalletConstantMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.value);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

class MethodInputEntryType {
  final String name;
  final TypeId type;

  static const $MethodInputEntryTypeCodec codec =
      $MethodInputEntryTypeCodec._();

  MethodInputEntryType({required this.name, required this.type});

  factory MethodInputEntryType.fromJson(Map<String, dynamic> json) {
    return MethodInputEntryType(
      name: (json['name'] as String),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
      };
}

class $MethodInputEntryTypeCodec implements Codec<MethodInputEntryType> {
  const $MethodInputEntryTypeCodec._();

  @override
  MethodInputEntryType decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    return MethodInputEntryType(
      name: name,
      type: type,
    );
  }

  @override
  Uint8List encode(MethodInputEntryType metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(MethodInputEntryType metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(MethodInputEntryType metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    return size;
  }
}

/// Metadata about one pallet constant.
class ApiMethodMetadata {
  final String name;
  final List<MethodInputEntryType> inputs;
  final TypeId output;
  final List<String> docs;

  static const $ApiMethodMetadataCodec codec = $ApiMethodMetadataCodec._();

  const ApiMethodMetadata({
    required this.name,
    required this.inputs,
    required this.output,
    required this.docs,
  });

  factory ApiMethodMetadata.fromJson(Map<String, dynamic> json) {
    return ApiMethodMetadata(
      name: json['name'],
      inputs: json['inputs'],
      output: json['output'],
      docs: (json['docs'] as List).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'inputs': inputs,
        'output': output,
        'docs': docs,
      };
}

class $ApiMethodMetadataCodec implements Codec<ApiMethodMetadata> {
  const $ApiMethodMetadataCodec._();

  @override
  ApiMethodMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final inputs = SequenceCodec(MethodInputEntryType.codec).decode(input);
    final output = TypeIdCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return ApiMethodMetadata(
      name: name,
      inputs: inputs,
      output: output,
      docs: docs,
    );
  }

  @override
  Uint8List encode(ApiMethodMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ApiMethodMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    SequenceCodec(MethodInputEntryType.codec).encodeTo(metadata.inputs, output);
    TypeIdCodec.codec.encodeTo(metadata.output, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(ApiMethodMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += SequenceCodec(MethodInputEntryType.codec).sizeHint(metadata.inputs);
    size += TypeIdCodec.codec.sizeHint(metadata.output);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

class ApiMetadata {
  final String name;
  final List<ApiMethodMetadata> methods;
  final List<String> docs;

  static const $ApiMetadataCodec codec = $ApiMetadataCodec._();

  ApiMetadata({
    required this.name,
    required this.methods,
    required this.docs,
  });
}

class $ApiMetadataCodec implements Codec<ApiMetadata> {
  const $ApiMetadataCodec._();

  @override
  ApiMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final methods = SequenceCodec(ApiMethodMetadata.codec).decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return ApiMetadata(
      name: name,
      methods: methods,
      docs: docs,
    );
  }

  @override
  Uint8List encode(ApiMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ApiMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    SequenceCodec(ApiMethodMetadata.codec).encodeTo(metadata.methods, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(ApiMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += SequenceCodec(ApiMethodMetadata.codec).sizeHint(metadata.methods);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// All metadata about an runtime pallet.
class PalletMetadata {
  /// Pallet name.
  final String name;

  /// Pallet storage metadata.
  final PalletStorageMetadata? storage;

  /// Pallet calls metadata.
  final PalletCallMetadata? calls;

  /// Pallet event metadata.
  final PalletEventMetadata? event;

  /// Pallet constants metadata.
  final List<PalletConstantMetadata> constants;

  /// Pallet constants metadata.
  final PalletErrorMetadata? error;

  /// Define the index of the pallet, this index will be used for the encoding of pallet event,
  /// call and origin variants.
  final int index;

  /// Pallet docs
  final List<String> docs;

  static const $PalletMetadataCodec codec = $PalletMetadataCodec._();

  PalletMetadata({
    required this.name,
    required this.storage,
    required this.constants,
    required this.index,
    required this.docs,
    this.calls,
    this.event,
    this.error,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'storage': storage?.toJson(),
        'calls': calls?.toJson(),
        'event': event?.toJson(),
        'constants': constants.map((c) => c.toJson()).toList(),
        'error': error?.toJson(),
        'index': index,
        'docs': docs,
      };
}

class $PalletMetadataCodec implements Codec<PalletMetadata> {
  const $PalletMetadataCodec._();

  @override
  PalletMetadata decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final storage = OptionCodec(PalletStorageMetadata.codec).decode(input);
    final calls = OptionCodec(PalletCallMetadata.codec).decode(input);
    final events = OptionCodec(PalletEventMetadata.codec).decode(input);
    final constants = SequenceCodec(PalletConstantMetadata.codec).decode(input);
    final errors = OptionCodec(PalletErrorMetadata.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return PalletMetadata(
      name: name,
      storage: storage,
      calls: calls,
      event: events,
      constants: constants,
      error: errors,
      index: index,
      docs: docs,
    );
  }

  @override
  Uint8List encode(PalletMetadata metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    OptionCodec(PalletStorageMetadata.codec).encodeTo(metadata.storage, output);
    OptionCodec(PalletCallMetadata.codec).encodeTo(metadata.calls, output);
    OptionCodec(PalletEventMetadata.codec).encodeTo(metadata.event, output);
    SequenceCodec(PalletConstantMetadata.codec)
        .encodeTo(metadata.constants, output);
    OptionCodec(PalletErrorMetadata.codec).encodeTo(metadata.error, output);
    U8Codec.codec.encodeTo(metadata.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(PalletMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += OptionCodec(PalletStorageMetadata.codec).sizeHint(metadata.storage);
    size += OptionCodec(PalletCallMetadata.codec).sizeHint(metadata.calls);
    size += OptionCodec(PalletEventMetadata.codec).sizeHint(metadata.event);
    size += SequenceCodec(PalletConstantMetadata.codec)
        .sizeHint(metadata.constants);
    size += OptionCodec(PalletErrorMetadata.codec).sizeHint(metadata.error);
    size += U8Codec.codec.sizeHint(metadata.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// Metadata about the pallet Event type.
class PalletEventMetadata {
  /// The type of the pallet event.
  final TypeId type;

  static const $PalletEventMetadataCodec codec = $PalletEventMetadataCodec._();

  PalletEventMetadata(this.type);

  Map<String, int> toJson() => {
        'ty': type,
      };
}

class $PalletEventMetadataCodec implements Codec<PalletEventMetadata> {
  const $PalletEventMetadataCodec._();

  @override
  PalletEventMetadata decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletEventMetadata(type);
  }

  @override
  Uint8List encode(PalletEventMetadata metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletEventMetadata metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletEventMetadata metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// Metadata about the pallet Event type.
class PalletErrorMetadata {
  /// The type of the pallet event.
  final TypeId type;

  static const $PalletErrorMetadataCodec codec = $PalletErrorMetadataCodec._();

  PalletErrorMetadata(this.type);

  Map<String, dynamic> toJson() => {
        'ty': type,
      };
}

class $PalletErrorMetadataCodec implements Codec<PalletErrorMetadata> {
  const $PalletErrorMetadataCodec._();

  @override
  PalletErrorMetadata decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletErrorMetadata(type);
  }

  @override
  Uint8List encode(PalletErrorMetadata metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletErrorMetadata metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletErrorMetadata metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// Metadata of an extrinsic signed extension.
class SignedExtensionMetadata {
  /// The unique signed extension identifier, which may be different from the type name.
  final String identifier;

  /// The type of the signed extension, with the data to be included in the extrinsic.
  final TypeId type;

  /// The type of the additional signed data, with the data to be included in the signed payload
  final TypeId additionalSigned;

  static const $SignedExtensionMetadataCodec codec =
      $SignedExtensionMetadataCodec._();

  SignedExtensionMetadata({
    required this.identifier,
    required this.type,
    required this.additionalSigned,
  });

  factory SignedExtensionMetadata.fromJson(Map<String, dynamic> json) {
    return SignedExtensionMetadata(
      identifier: json['identifier'],
      type: json['type'],
      additionalSigned: json['additionalSigned'],
    );
  }

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'ty': type,
        'additional_signed': additionalSigned,
      };
}

class $SignedExtensionMetadataCodec implements Codec<SignedExtensionMetadata> {
  const $SignedExtensionMetadataCodec._();

  @override
  SignedExtensionMetadata decode(Input input) {
    final identifier = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    final additionalSigned = TypeIdCodec.codec.decode(input);
    return SignedExtensionMetadata(
      identifier: identifier,
      type: type,
      additionalSigned: additionalSigned,
    );
  }

  @override
  Uint8List encode(SignedExtensionMetadata value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(SignedExtensionMetadata metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.identifier, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    TypeIdCodec.codec.encodeTo(metadata.additionalSigned, output);
  }

  @override
  int sizeHint(SignedExtensionMetadata metadata) {
    int size = StrCodec.codec.sizeHint(metadata.identifier);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    size += TypeIdCodec.codec.sizeHint(metadata.additionalSigned);
    return size;
  }
}

/// Metadata of the extrinsic used by the runtime.
class ExtrinsicMetadata {
  /// Extrinsic version.
  final int version;

  /// The type of the address.
  final TypeId addressType;

  /// The type of the call.
  final TypeId callType;

  /// The type of the signature.
  final TypeId signatureType;

  /// The type of the extra.
  final TypeId extraType;

  /// The signed extensions in the order they appear in the extrinsic.
  final List<SignedExtensionMetadata> signedExtensions;

  static const $ExtrinsicMetadataCodec codec = $ExtrinsicMetadataCodec._();

  ExtrinsicMetadata({
    required this.version,
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
    required this.signedExtensions,
  });

  factory ExtrinsicMetadata.fromJson(Map<String, dynamic> json) {
    final signedExtensions = (json['signedExtensions'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => SignedExtensionMetadata.fromJson(json))
        .toList();

    return ExtrinsicMetadata(
      version: json['version'],
      addressType: json['addressType'],
      callType: json['callType'],
      signatureType: json['signatureType'],
      extraType: json['extraType'],
      signedExtensions: signedExtensions,
    );
  }

  Map<String, dynamic> toJson() => {
        'version': version,
        'address_type': addressType,
        'call_type': callType,
        'signature_type': signatureType,
        'extra_type': extraType,
        'signed_extensions': signedExtensions.map((e) => e.toJson()).toList(),
      };
}

class $ExtrinsicMetadataCodec implements Codec<ExtrinsicMetadata> {
  const $ExtrinsicMetadataCodec._();

  @override
  ExtrinsicMetadata decode(Input input) {
    final version = U8Codec.codec.decode(input);
    final addressType = TypeIdCodec.codec.decode(input);
    final callType = TypeIdCodec.codec.decode(input);
    final signatureType = TypeIdCodec.codec.decode(input);
    final extraType = TypeIdCodec.codec.decode(input);
    final signedExtensions =
        SequenceCodec(SignedExtensionMetadata.codec).decode(input);
    return ExtrinsicMetadata(
      version: version,
      addressType: addressType,
      callType: callType,
      signatureType: signatureType,
      extraType: extraType,
      signedExtensions: signedExtensions,
    );
  }

  @override
  Uint8List encode(ExtrinsicMetadata value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ExtrinsicMetadata metadata, Output output) {
    U8Codec.codec.encodeTo(metadata.version, output);
    TypeIdCodec.codec.encodeTo(metadata.addressType, output);
    TypeIdCodec.codec.encodeTo(metadata.callType, output);
    TypeIdCodec.codec.encodeTo(metadata.signatureType, output);
    TypeIdCodec.codec.encodeTo(metadata.extraType, output);
    SequenceCodec(SignedExtensionMetadata.codec)
        .encodeTo(metadata.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadata metadata) {
    int size = U8Codec.codec.sizeHint(metadata.version);
    size += TypeIdCodec.codec.sizeHint(metadata.addressType);
    size += TypeIdCodec.codec.sizeHint(metadata.callType);
    size += TypeIdCodec.codec.sizeHint(metadata.signatureType);
    size += TypeIdCodec.codec.sizeHint(metadata.extraType);
    size += SequenceCodec(SignedExtensionMetadata.codec)
        .sizeHint(metadata.signedExtensions);
    return size;
  }
}

class OuterEnumMetadata {
  final TypeId callType;
  final TypeId eventType;
  final TypeId errorType;

  static const $OuterEnumMetadataCodec codec = $OuterEnumMetadataCodec._();

  OuterEnumMetadata({
    required this.callType,
    required this.eventType,
    required this.errorType,
  });

  factory OuterEnumMetadata.fromJson(Map<String, dynamic> json) {
    return OuterEnumMetadata(
      callType: json['callType'],
      eventType: json['eventType'],
      errorType: json['errorType'],
    );
  }

  Map<String, dynamic> toJson() => {
        'callType': callType,
        'eventType': eventType,
        'errorType': errorType,
      };
}

class $OuterEnumMetadataCodec implements Codec<OuterEnumMetadata> {
  const $OuterEnumMetadataCodec._();

  @override
  OuterEnumMetadata decode(Input input) {
    final callType = TypeIdCodec.codec.decode(input);
    final eventType = TypeIdCodec.codec.decode(input);
    final errorType = TypeIdCodec.codec.decode(input);

    return OuterEnumMetadata(
      callType: callType,
      eventType: eventType,
      errorType: errorType,
    );
  }

  @override
  Uint8List encode(OuterEnumMetadata value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(OuterEnumMetadata metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.callType, output);
    TypeIdCodec.codec.encodeTo(metadata.eventType, output);
    TypeIdCodec.codec.encodeTo(metadata.errorType, output);
  }

  @override
  int sizeHint(OuterEnumMetadata metadata) {
    int size = TypeIdCodec.codec.sizeHint(metadata.callType);
    size += TypeIdCodec.codec.sizeHint(metadata.eventType);
    size += TypeIdCodec.codec.sizeHint(metadata.errorType);
    return size;
  }
}

class CustomMetadata {
  final Map<String, CustomMetadataEntry> map;

  static const $CustomMetadataCodec codec = $CustomMetadataCodec._();

  CustomMetadata({
    required this.map,
  });

  factory CustomMetadata.fromJson(Map<String, dynamic> json) {
    return CustomMetadata(
        map: json['map'].map((json) => CustomMetadataEntry.fromJson(json)));
  }

  Map<String, dynamic> toJson() => {
        'map': map,
      };
}

class $CustomMetadataCodec implements Codec<CustomMetadata> {
  const $CustomMetadataCodec._();

  @override
  CustomMetadata decode(Input input) {
    final map = BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntry.codec)
        .decode(input);
    return CustomMetadata(
      map: map,
    );
  }

  @override
  Uint8List encode(CustomMetadata value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(CustomMetadata metadata, Output output) {
    BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntry.codec)
        .encodeTo(metadata.map, output);
  }

  @override
  int sizeHint(CustomMetadata metadata) {
    int size = BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntry.codec)
        .sizeHint(metadata.map);
    return size;
  }
}

/// A type of storage value.
class CustomMetadataEntry {
  final TypeId type;
  final List<int> value;

  static const $CustomMetadataEntryCodec codec = $CustomMetadataEntryCodec._();

  CustomMetadataEntry({
    required this.type,
    required this.value,
  });

  factory CustomMetadataEntry.fromJson(Map<String, dynamic> json) {
    return CustomMetadataEntry(type: json['type'], value: json['value']);
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}

class $CustomMetadataEntryCodec implements Codec<CustomMetadataEntry> {
  const $CustomMetadataEntryCodec._();

  @override
  CustomMetadataEntry decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    final value = U8SequenceCodec.codec.decode(input);

    return CustomMetadataEntry(
      type: type,
      value: value,
    );
  }

  @override
  Uint8List encode(CustomMetadataEntry value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(CustomMetadataEntry metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.value, output);
  }

  @override
  int sizeHint(CustomMetadataEntry metadata) {
    int size = TypeIdCodec.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.value);
    return size;
  }
}
