part of metadata;

/// The metadata of a runtime.
class RuntimeMetadataV15 implements RuntimeMetadata {
  /// Type registry containing all types used in the metadata.
  final List<PortableType> types;

  /// Metadata of all the pallets.
  final List<PalletMetadataV15> pallets;

  /// Metadata of the extrinsic.
  final ExtrinsicMetadataV15 extrinsic;

  /// The type of the `Runtime`.
  final TypeId runtimeTypeId;

  /// Metadata of the apis.
  final List<ApiMetadataV15> apis;

  /// Metadata of the outer enums.
  final OuterEnumMetadataV15 outerEnums;

  /// custom.
  final CustomMetadataV15 custom;

  static const $RuntimeMetadataV15Codec codec = $RuntimeMetadataV15Codec._();

  RuntimeMetadataV15({
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
  int runtimeMetadataVersion() {
    return 15;
  }

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

class $RuntimeMetadataV15Codec implements Codec<RuntimeMetadataV15> {
  const $RuntimeMetadataV15Codec._();

  @override
  RuntimeMetadataV15 decode(Input input) {
    final types = SequenceCodec(PortableType.codec).decode(input);
    final pallets = SequenceCodec(PalletMetadataV15.codec).decode(input);
    final extrinsic = ExtrinsicMetadataV15.codec.decode(input);
    final runtimeTypeId = TypeIdCodec.codec.decode(input);
    final apis = SequenceCodec(ApiMetadataV15.codec).decode(input);
    final outerEnums = OuterEnumMetadataV15.codec.decode(input);
    final custom = CustomMetadataV15.codec.decode(input);
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
  Uint8List encode(RuntimeMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(RuntimeMetadataV15 metadata, Output output) {
    SequenceCodec(PortableType.codec).encodeTo(metadata.types, output);
    SequenceCodec(PalletMetadataV15.codec).encodeTo(metadata.pallets, output);
    ExtrinsicMetadataV15.codec.encodeTo(metadata.extrinsic, output);
    TypeIdCodec.codec.encodeTo(metadata.runtimeTypeId, output);
    SequenceCodec(ApiMetadataV15.codec).encodeTo(metadata.apis, output);
    OuterEnumMetadataV15.codec.encodeTo(metadata.outerEnums, output);
    CustomMetadataV15.codec.encodeTo(metadata.custom, output);
  }

  @override
  int sizeHint(RuntimeMetadataV15 metadata) {
    int size = SequenceCodec(PortableType.codec).sizeHint(metadata.types);
    size += SequenceCodec(PalletMetadataV15.codec).sizeHint(metadata.pallets);
    size += ExtrinsicMetadataV15.codec.sizeHint(metadata.extrinsic);
    size += TypeIdCodec.codec.sizeHint(metadata.runtimeTypeId);
    size += SequenceCodec(ApiMetadataV15.codec).sizeHint(metadata.apis);
    size += OuterEnumMetadataV15.codec.sizeHint(metadata.outerEnums);
    size += CustomMetadataV15.codec.sizeHint(metadata.custom);
    return size;
  }
}

/// Hasher used by storage maps
enum StorageHasherV15 {
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

  static const $StorageHasherCodecV15 codec = $StorageHasherCodecV15._();

  /// Creates a new storage hasher.
  const StorageHasherV15(this.concat);

  factory StorageHasherV15.fromJson(Map<String, dynamic> json) {
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

class $StorageHasherCodecV15 implements Codec<StorageHasherV15> {
  const $StorageHasherCodecV15._();

  @override
  StorageHasherV15 decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return StorageHasherV15.blake2_128;
      case 1:
        return StorageHasherV15.blake2_256;
      case 2:
        return StorageHasherV15.blake2_128Concat;
      case 3:
        return StorageHasherV15.twox128;
      case 4:
        return StorageHasherV15.twox256;
      case 5:
        return StorageHasherV15.twox64Concat;
      case 6:
        return StorageHasherV15.identity;
      default:
        throw Exception('Unknown StorageHasher variant index $index');
    }
  }

  @override
  Uint8List encode(StorageHasherV15 storageHasher) {
    return Uint8List.fromList([storageHasher.index]);
  }

  @override
  void encodeTo(StorageHasherV15 storageHasher, Output output) {
    output.pushByte(storageHasher.index);
  }

  @override
  int sizeHint(StorageHasherV15 storageHasher) {
    return 1;
  }
}

/// A type of storage value.
class StorageEntryTypeV15 {
  /// zero or more hashers, should be one hasher per key element.
  final List<StorageHasherV15> hashers;

  /// The type of the key, can be a tuple with elements for each of the hashers.
  /// `null` when hashers.length == 0
  final int? key;

  /// The type of the value.
  final int value;

  static const $StorageEntryTypeCodecV15 codec = $StorageEntryTypeCodecV15._();

  StorageEntryTypeV15({required this.hashers, this.key, required this.value});

  factory StorageEntryTypeV15.fromJson(Map<String, dynamic> json) {
    final List<StorageHasherV15> hashers;
    final int? key;
    final int value;

    switch (json.keys.first) {
      case 'Map':
        final map = json['Map'] as Map<String, dynamic>;
        hashers = (map['hashers'] as List)
            .cast<Map<String, dynamic>>()
            .map((json) => StorageHasherV15.fromJson(json))
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

    return StorageEntryTypeV15(
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

class $StorageEntryTypeCodecV15 implements Codec<StorageEntryTypeV15> {
  const $StorageEntryTypeCodecV15._();

  @override
  StorageEntryTypeV15 decode(Input input) {
    final variantType = input.read();
    TypeId value;
    TypeId? key;
    List<StorageHasherV15> hashers;
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
          hashers = SequenceCodec(StorageHasherV15.codec).decode(input);
          key = TypeIdCodec.codec.decode(input);
          value = TypeIdCodec.codec.decode(input);
          break;
        }
      default:
        throw Exception('Unknown StorageEntryType variant index $variantType');
    }
    return StorageEntryTypeV15(
      hashers: hashers,
      key: key,
      value: value,
    );
  }

  @override
  Uint8List encode(StorageEntryTypeV15 entryType) {
    final output = ByteOutput(sizeHint(entryType));
    encodeTo(entryType, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(StorageEntryTypeV15 entryType, Output output) {
    if (entryType.key == null) {
      output.pushByte(0);
      TypeIdCodec.codec.encodeTo(entryType.value, output);
    } else {
      output.pushByte(1);
      SequenceCodec(StorageHasherV15.codec).encodeTo(entryType.hashers, output);
      TypeIdCodec.codec.encodeTo(entryType.key!, output);
      TypeIdCodec.codec.encodeTo(entryType.value, output);
    }
  }

  @override
  int sizeHint(StorageEntryTypeV15 entryType) {
    int size = 1 + TypeIdCodec.codec.sizeHint(entryType.value);
    if (entryType.key != null) {
      size += TypeIdCodec.codec.sizeHint(entryType.key!);
      size += SequenceCodec(StorageHasherV15.codec).sizeHint(entryType.hashers);
    }
    return size;
  }
}

/// A storage entry modifier indicates how a storage entry is returned when fetched and what the value will be if the key is not present.
/// Specifically this refers to the "return type" when fetching a storage entry, and what the value will be if the key is not present.
///
/// `optional` means you should expect an `T?`, with `null` returned if the key is not present.
/// `default_` means you should expect a `T` with the default value of default if the key is not present.
enum StorageEntryModifierV15 {
  /// The storage entry returns an `Option<T>`, with `None` if the key is not present.
  optional,

  /// The storage entry returns `T::Default` if the key is not present.
  default_;

  static const $StorageEntryModifierCodecV15 codec =
      $StorageEntryModifierCodecV15._();

  factory StorageEntryModifierV15.fromString(String str) {
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
      case StorageEntryModifierV15.optional:
        return 'Optional';
      case StorageEntryModifierV15.default_:
        return 'Default';
    }
  }
}

class $StorageEntryModifierCodecV15 implements Codec<StorageEntryModifierV15> {
  const $StorageEntryModifierCodecV15._();

  @override
  StorageEntryModifierV15 decode(Input input) {
    final index = input.read();
    switch (index) {
      case 0:
        return StorageEntryModifierV15.optional;
      case 1:
        return StorageEntryModifierV15.default_;
      default:
        throw Exception('Unknown storage modifier variant index $index');
    }
  }

  @override
  Uint8List encode(StorageEntryModifierV15 value) {
    return Uint8List.fromList([value.index]);
  }

  @override
  void encodeTo(StorageEntryModifierV15 value, Output output) {
    output.pushByte(value.index);
  }

  @override
  int sizeHint(StorageEntryModifierV15 value) {
    return 1;
  }
}

/// Metadata about one storage entry.
class StorageEntryMetadataV15 {
  /// Variable name of the storage entry.
  final String name;

  /// An `Option` modifier of that storage entry.
  final StorageEntryModifierV15 modifier;

  /// Type of the value stored in the entry.
  final StorageEntryTypeV15 type;

  /// Default value (SCALE encoded).
  final List<int> defaultValue;

  /// Storage entry documentation.
  final List<String> docs;

  static const $StorageEntryMetadataCodecV15 codec =
      $StorageEntryMetadataCodecV15._();

  const StorageEntryMetadataV15(
      {required this.name,
      required this.modifier,
      required this.type,
      required this.defaultValue,
      required this.docs});

  factory StorageEntryMetadataV15.fromJson(Map<String, dynamic> json) {
    return StorageEntryMetadataV15(
      name: (json['name'] as String),
      modifier: StorageEntryModifierV15.fromString(json['modifier'] as String),
      type: StorageEntryTypeV15.fromJson(json['type'] as Map<String, dynamic>),
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

class $StorageEntryMetadataCodecV15 implements Codec<StorageEntryMetadataV15> {
  const $StorageEntryMetadataCodecV15._();

  @override
  StorageEntryMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final modifier = StorageEntryModifierV15.codec.decode(input);
    final type = StorageEntryTypeV15.codec.decode(input);
    final defaultValue = U8SequenceCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return StorageEntryMetadataV15(
      name: name,
      modifier: modifier,
      type: type,
      defaultValue: defaultValue,
      docs: docs,
    );
  }

  @override
  Uint8List encode(StorageEntryMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(StorageEntryMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    StorageEntryModifierV15.codec.encodeTo(metadata.modifier, output);
    StorageEntryTypeV15.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.defaultValue, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(StorageEntryMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += StorageEntryModifierV15.codec.sizeHint(metadata.modifier);
    size += StorageEntryTypeV15.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.defaultValue);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// Metadata for all calls in a pallet
class PalletCallMetadataV15 {
  /// The call type for the pallet
  final TypeId type;

  static const $PalletCallMetadataCodecV15 codec =
      $PalletCallMetadataCodecV15._();

  const PalletCallMetadataV15(this.type);

  Map<String, int> toJson() => {
        'ty': type,
      };
}

class $PalletCallMetadataCodecV15 implements Codec<PalletCallMetadataV15> {
  const $PalletCallMetadataCodecV15._();

  @override
  PalletCallMetadataV15 decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletCallMetadataV15(type);
  }

  @override
  Uint8List encode(PalletCallMetadataV15 metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletCallMetadataV15 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletCallMetadataV15 metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// All metadata of the pallet's storage.
class PalletStorageMetadataV15 {
  /// The common prefix used by all storage entries.
  final String prefix;

  /// Metadata for all storage entries.
  final List<StorageEntryMetadataV15> entries;

  static const $PalletStorageMetadataCodecV15 codec =
      $PalletStorageMetadataCodecV15._();

  const PalletStorageMetadataV15({required this.prefix, required this.entries});

  factory PalletStorageMetadataV15.fromJson(Map<String, dynamic> json) {
    final prefix = (json['prefix'] as String);
    final items = (json['items'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => StorageEntryMetadataV15.fromJson(json))
        .toList();

    return PalletStorageMetadataV15(
      prefix: prefix,
      entries: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'prefix': prefix,
        'entries': entries.map((entry) => entry.toJson()).toList(),
      };
}

class $PalletStorageMetadataCodecV15
    implements Codec<PalletStorageMetadataV15> {
  const $PalletStorageMetadataCodecV15._();

  @override
  PalletStorageMetadataV15 decode(Input input) {
    final prefix = StrCodec.codec.decode(input);
    final entries = SequenceCodec(StorageEntryMetadataV15.codec).decode(input);
    return PalletStorageMetadataV15(
      prefix: prefix,
      entries: entries,
    );
  }

  @override
  Uint8List encode(PalletStorageMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletStorageMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.prefix, output);
    SequenceCodec(StorageEntryMetadataV15.codec)
        .encodeTo(metadata.entries, output);
  }

  @override
  int sizeHint(PalletStorageMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.prefix);
    size +=
        SequenceCodec(StorageEntryMetadataV15.codec).sizeHint(metadata.entries);
    return size;
  }
}

/// Metadata about one pallet constant.
class PalletConstantMetadataV15 {
  /// Name of the pallet constant.
  final String name;

  /// Type of the pallet constant.
  final TypeId type;

  /// Value stored in the constant (SCALE encoded).
  final List<int> value;

  /// Documentation of the constant.
  final List<String> docs;

  static const $PalletConstantMetadataCodecV15 codec =
      $PalletConstantMetadataCodecV15._();

  const PalletConstantMetadataV15({
    required this.name,
    required this.type,
    required this.value,
    required this.docs,
  });

  factory PalletConstantMetadataV15.fromJson(Map<String, dynamic> json) {
    return PalletConstantMetadataV15(
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

class $PalletConstantMetadataCodecV15
    implements Codec<PalletConstantMetadataV15> {
  const $PalletConstantMetadataCodecV15._();

  @override
  PalletConstantMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    final value = U8SequenceCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return PalletConstantMetadataV15(
      name: name,
      type: type,
      value: value,
      docs: docs,
    );
  }

  @override
  Uint8List encode(PalletConstantMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletConstantMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.value, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(PalletConstantMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.value);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

class MethodInputEntryTypeV15 {
  final String name;
  final TypeId type;

  static const $MethodInputEntryTypeCodecV15 codec =
      $MethodInputEntryTypeCodecV15._();

  MethodInputEntryTypeV15({required this.name, required this.type});

  factory MethodInputEntryTypeV15.fromJson(Map<String, dynamic> json) {
    return MethodInputEntryTypeV15(
      name: (json['name'] as String),
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
      };
}

class $MethodInputEntryTypeCodecV15 implements Codec<MethodInputEntryTypeV15> {
  const $MethodInputEntryTypeCodecV15._();

  @override
  MethodInputEntryTypeV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    return MethodInputEntryTypeV15(
      name: name,
      type: type,
    );
  }

  @override
  Uint8List encode(MethodInputEntryTypeV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(MethodInputEntryTypeV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(MethodInputEntryTypeV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    return size;
  }
}

/// Metadata about one pallet constant.
class ApiMethodMetadataV15 {
  final String name;
  final List<MethodInputEntryTypeV15> inputs;
  final TypeId output;
  final List<String> docs;

  static const $ApiMethodMetadataCodecV15 codec =
      $ApiMethodMetadataCodecV15._();

  const ApiMethodMetadataV15({
    required this.name,
    required this.inputs,
    required this.output,
    required this.docs,
  });

  factory ApiMethodMetadataV15.fromJson(Map<String, dynamic> json) {
    return ApiMethodMetadataV15(
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

class $ApiMethodMetadataCodecV15 implements Codec<ApiMethodMetadataV15> {
  const $ApiMethodMetadataCodecV15._();

  @override
  ApiMethodMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final inputs = SequenceCodec(MethodInputEntryTypeV15.codec).decode(input);
    final output = TypeIdCodec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return ApiMethodMetadataV15(
      name: name,
      inputs: inputs,
      output: output,
      docs: docs,
    );
  }

  @override
  Uint8List encode(ApiMethodMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ApiMethodMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    SequenceCodec(MethodInputEntryTypeV15.codec)
        .encodeTo(metadata.inputs, output);
    TypeIdCodec.codec.encodeTo(metadata.output, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(ApiMethodMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size +=
        SequenceCodec(MethodInputEntryTypeV15.codec).sizeHint(metadata.inputs);
    size += TypeIdCodec.codec.sizeHint(metadata.output);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

class ApiMetadataV15 {
  final String name;
  final List<ApiMethodMetadataV15> methods;
  final List<String> docs;

  static const $ApiMetadataCodecV15 codec = $ApiMetadataCodecV15._();

  ApiMetadataV15({
    required this.name,
    required this.methods,
    required this.docs,
  });
}

class $ApiMetadataCodecV15 implements Codec<ApiMetadataV15> {
  const $ApiMetadataCodecV15._();

  @override
  ApiMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final methods = SequenceCodec(ApiMethodMetadataV15.codec).decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return ApiMetadataV15(
      name: name,
      methods: methods,
      docs: docs,
    );
  }

  @override
  Uint8List encode(ApiMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ApiMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    SequenceCodec(ApiMethodMetadataV15.codec)
        .encodeTo(metadata.methods, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(ApiMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size +=
        SequenceCodec(ApiMethodMetadataV15.codec).sizeHint(metadata.methods);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// All metadata about an runtime pallet.
class PalletMetadataV15 {
  /// Pallet name.
  final String name;

  /// Pallet storage metadata.
  final PalletStorageMetadataV15? storage;

  /// Pallet calls metadata.
  final PalletCallMetadataV15? calls;

  /// Pallet event metadata.
  final PalletEventMetadataV15? event;

  /// Pallet constants metadata.
  final List<PalletConstantMetadataV15> constants;

  /// Pallet constants metadata.
  final PalletErrorMetadataV15? error;

  /// Define the index of the pallet, this index will be used for the encoding of pallet event,
  /// call and origin variants.
  final int index;

  /// Pallet docs
  final List<String> docs;

  static const $PalletMetadataCodecV15 codec = $PalletMetadataCodecV15._();

  PalletMetadataV15({
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

class $PalletMetadataCodecV15 implements Codec<PalletMetadataV15> {
  const $PalletMetadataCodecV15._();

  @override
  PalletMetadataV15 decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final storage = OptionCodec(PalletStorageMetadataV15.codec).decode(input);
    final calls = OptionCodec(PalletCallMetadataV15.codec).decode(input);
    final events = OptionCodec(PalletEventMetadataV15.codec).decode(input);
    final constants =
        SequenceCodec(PalletConstantMetadataV15.codec).decode(input);
    final errors = OptionCodec(PalletErrorMetadataV15.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return PalletMetadataV15(
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
  Uint8List encode(PalletMetadataV15 metadata) {
    final output = ByteOutput(sizeHint(metadata));
    encodeTo(metadata, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(PalletMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.name, output);
    OptionCodec(PalletStorageMetadataV15.codec)
        .encodeTo(metadata.storage, output);
    OptionCodec(PalletCallMetadataV15.codec).encodeTo(metadata.calls, output);
    OptionCodec(PalletEventMetadataV15.codec).encodeTo(metadata.event, output);
    SequenceCodec(PalletConstantMetadataV15.codec)
        .encodeTo(metadata.constants, output);
    OptionCodec(PalletErrorMetadataV15.codec).encodeTo(metadata.error, output);
    U8Codec.codec.encodeTo(metadata.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(metadata.docs, output);
  }

  @override
  int sizeHint(PalletMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.name);
    size +=
        OptionCodec(PalletStorageMetadataV15.codec).sizeHint(metadata.storage);
    size += OptionCodec(PalletCallMetadataV15.codec).sizeHint(metadata.calls);
    size += OptionCodec(PalletEventMetadataV15.codec).sizeHint(metadata.event);
    size += SequenceCodec(PalletConstantMetadataV15.codec)
        .sizeHint(metadata.constants);
    size += OptionCodec(PalletErrorMetadataV15.codec).sizeHint(metadata.error);
    size += U8Codec.codec.sizeHint(metadata.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(metadata.docs);
    return size;
  }
}

/// Metadata about the pallet Event type.
class PalletEventMetadataV15 {
  /// The type of the pallet event.
  final TypeId type;

  static const $PalletEventMetadataCodecV15 codec =
      $PalletEventMetadataCodecV15._();

  PalletEventMetadataV15(this.type);

  Map<String, int> toJson() => {
        'ty': type,
      };
}

class $PalletEventMetadataCodecV15 implements Codec<PalletEventMetadataV15> {
  const $PalletEventMetadataCodecV15._();

  @override
  PalletEventMetadataV15 decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletEventMetadataV15(type);
  }

  @override
  Uint8List encode(PalletEventMetadataV15 metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletEventMetadataV15 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletEventMetadataV15 metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// Metadata about the pallet Event type.
class PalletErrorMetadataV15 {
  /// The type of the pallet event.
  final TypeId type;

  static const $PalletErrorMetadataCodecV15 codec =
      $PalletErrorMetadataCodecV15._();

  PalletErrorMetadataV15(this.type);

  Map<String, dynamic> toJson() => {
        'ty': type,
      };
}

class $PalletErrorMetadataCodecV15 implements Codec<PalletErrorMetadataV15> {
  const $PalletErrorMetadataCodecV15._();

  @override
  PalletErrorMetadataV15 decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    return PalletErrorMetadataV15(type);
  }

  @override
  Uint8List encode(PalletErrorMetadataV15 metadata) {
    return TypeIdCodec.codec.encode(metadata.type);
  }

  @override
  void encodeTo(PalletErrorMetadataV15 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
  }

  @override
  int sizeHint(PalletErrorMetadataV15 metadata) {
    return TypeIdCodec.codec.sizeHint(metadata.type);
  }
}

/// Metadata of an extrinsic signed extension.
class SignedExtensionMetadataV15 {
  /// The unique signed extension identifier, which may be different from the type name.
  final String identifier;

  /// The type of the signed extension, with the data to be included in the extrinsic.
  final TypeId type;

  /// The type of the additional signed data, with the data to be included in the signed payload
  final TypeId additionalSigned;

  static const $SignedExtensionMetadataCodecV15 codec =
      $SignedExtensionMetadataCodecV15._();

  SignedExtensionMetadataV15({
    required this.identifier,
    required this.type,
    required this.additionalSigned,
  });

  factory SignedExtensionMetadataV15.fromJson(Map<String, dynamic> json) {
    return SignedExtensionMetadataV15(
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

class $SignedExtensionMetadataCodecV15
    implements Codec<SignedExtensionMetadataV15> {
  const $SignedExtensionMetadataCodecV15._();

  @override
  SignedExtensionMetadataV15 decode(Input input) {
    final identifier = StrCodec.codec.decode(input);
    final type = TypeIdCodec.codec.decode(input);
    final additionalSigned = TypeIdCodec.codec.decode(input);
    return SignedExtensionMetadataV15(
      identifier: identifier,
      type: type,
      additionalSigned: additionalSigned,
    );
  }

  @override
  Uint8List encode(SignedExtensionMetadataV15 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(SignedExtensionMetadataV15 metadata, Output output) {
    StrCodec.codec.encodeTo(metadata.identifier, output);
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    TypeIdCodec.codec.encodeTo(metadata.additionalSigned, output);
  }

  @override
  int sizeHint(SignedExtensionMetadataV15 metadata) {
    int size = StrCodec.codec.sizeHint(metadata.identifier);
    size += TypeIdCodec.codec.sizeHint(metadata.type);
    size += TypeIdCodec.codec.sizeHint(metadata.additionalSigned);
    return size;
  }
}

/// Metadata of the extrinsic used by the runtime.
class ExtrinsicMetadataV15 {
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
  final List<SignedExtensionMetadataV15> signedExtensions;

  static const $ExtrinsicMetadataCodecV15 codec =
      $ExtrinsicMetadataCodecV15._();

  ExtrinsicMetadataV15({
    required this.version,
    required this.addressType,
    required this.callType,
    required this.signatureType,
    required this.extraType,
    required this.signedExtensions,
  });

  factory ExtrinsicMetadataV15.fromJson(Map<String, dynamic> json) {
    final signedExtensions = (json['signedExtensions'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => SignedExtensionMetadataV15.fromJson(json))
        .toList();

    return ExtrinsicMetadataV15(
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
        'addressType': addressType,
        'callType': callType,
        'signatureType': signatureType,
        'extraType': extraType,
        'signed_extensions': signedExtensions.map((e) => e.toJson()).toList(),
      };
}

class $ExtrinsicMetadataCodecV15 implements Codec<ExtrinsicMetadataV15> {
  const $ExtrinsicMetadataCodecV15._();

  @override
  ExtrinsicMetadataV15 decode(Input input) {
    final version = U8Codec.codec.decode(input);
    final addressType = TypeIdCodec.codec.decode(input);
    final callType = TypeIdCodec.codec.decode(input);
    final signatureType = TypeIdCodec.codec.decode(input);
    final extraType = TypeIdCodec.codec.decode(input);
    final signedExtensions =
        SequenceCodec(SignedExtensionMetadataV15.codec).decode(input);
    return ExtrinsicMetadataV15(
      version: version,
      addressType: addressType,
      callType: callType,
      signatureType: signatureType,
      extraType: extraType,
      signedExtensions: signedExtensions,
    );
  }

  @override
  Uint8List encode(ExtrinsicMetadataV15 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(ExtrinsicMetadataV15 metadata, Output output) {
    U8Codec.codec.encodeTo(metadata.version, output);
    TypeIdCodec.codec.encodeTo(metadata.addressType, output);
    TypeIdCodec.codec.encodeTo(metadata.callType, output);
    TypeIdCodec.codec.encodeTo(metadata.signatureType, output);
    TypeIdCodec.codec.encodeTo(metadata.extraType, output);
    SequenceCodec(SignedExtensionMetadataV15.codec)
        .encodeTo(metadata.signedExtensions, output);
  }

  @override
  int sizeHint(ExtrinsicMetadataV15 metadata) {
    int size = U8Codec.codec.sizeHint(metadata.version);
    size += TypeIdCodec.codec.sizeHint(metadata.addressType);
    size += TypeIdCodec.codec.sizeHint(metadata.callType);
    size += TypeIdCodec.codec.sizeHint(metadata.signatureType);
    size += TypeIdCodec.codec.sizeHint(metadata.extraType);
    size += SequenceCodec(SignedExtensionMetadataV15.codec)
        .sizeHint(metadata.signedExtensions);
    return size;
  }
}

class OuterEnumMetadataV15 {
  final TypeId callType;
  final TypeId eventType;
  final TypeId errorType;

  static const $OuterEnumMetadataCodecV15 codec =
      $OuterEnumMetadataCodecV15._();

  OuterEnumMetadataV15({
    required this.callType,
    required this.eventType,
    required this.errorType,
  });

  factory OuterEnumMetadataV15.fromJson(Map<String, dynamic> json) {
    return OuterEnumMetadataV15(
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

class $OuterEnumMetadataCodecV15 implements Codec<OuterEnumMetadataV15> {
  const $OuterEnumMetadataCodecV15._();

  @override
  OuterEnumMetadataV15 decode(Input input) {
    final callType = TypeIdCodec.codec.decode(input);
    final eventType = TypeIdCodec.codec.decode(input);
    final errorType = TypeIdCodec.codec.decode(input);

    return OuterEnumMetadataV15(
      callType: callType,
      eventType: eventType,
      errorType: errorType,
    );
  }

  @override
  Uint8List encode(OuterEnumMetadataV15 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(OuterEnumMetadataV15 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.callType, output);
    TypeIdCodec.codec.encodeTo(metadata.eventType, output);
    TypeIdCodec.codec.encodeTo(metadata.errorType, output);
  }

  @override
  int sizeHint(OuterEnumMetadataV15 metadata) {
    int size = TypeIdCodec.codec.sizeHint(metadata.callType);
    size += TypeIdCodec.codec.sizeHint(metadata.eventType);
    size += TypeIdCodec.codec.sizeHint(metadata.errorType);
    return size;
  }
}

class CustomMetadataV15 {
  final Map<String, CustomMetadataEntryV15> map;

  static const $CustomMetadataCodecV15 codec = $CustomMetadataCodecV15._();

  CustomMetadataV15({
    required this.map,
  });

  factory CustomMetadataV15.fromJson(Map<String, dynamic> json) {
    return CustomMetadataV15(
        map: json['map'].map((json) => CustomMetadataEntryV15.fromJson(json)));
  }

  Map<String, dynamic> toJson() => {
        'map': map,
      };
}

class $CustomMetadataCodecV15 implements Codec<CustomMetadataV15> {
  const $CustomMetadataCodecV15._();

  @override
  CustomMetadataV15 decode(Input input) {
    final map = BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntryV15.codec)
        .decode(input);
    return CustomMetadataV15(
      map: map,
    );
  }

  @override
  Uint8List encode(CustomMetadataV15 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(CustomMetadataV15 metadata, Output output) {
    BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntryV15.codec)
        .encodeTo(metadata.map, output);
  }

  @override
  int sizeHint(CustomMetadataV15 metadata) {
    int size = BTreeMapCodec(
            keyCodec: StrCodec.codec, valueCodec: CustomMetadataEntryV15.codec)
        .sizeHint(metadata.map);
    return size;
  }
}

/// A type of storage value.
class CustomMetadataEntryV15 {
  final TypeId type;
  final List<int> value;

  static const $CustomMetadataEntryCodecV15 codec =
      $CustomMetadataEntryCodecV15._();

  CustomMetadataEntryV15({
    required this.type,
    required this.value,
  });

  factory CustomMetadataEntryV15.fromJson(Map<String, dynamic> json) {
    return CustomMetadataEntryV15(type: json['type'], value: json['value']);
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'value': value,
      };
}

class $CustomMetadataEntryCodecV15 implements Codec<CustomMetadataEntryV15> {
  const $CustomMetadataEntryCodecV15._();

  @override
  CustomMetadataEntryV15 decode(Input input) {
    final type = TypeIdCodec.codec.decode(input);
    final value = U8SequenceCodec.codec.decode(input);

    return CustomMetadataEntryV15(
      type: type,
      value: value,
    );
  }

  @override
  Uint8List encode(CustomMetadataEntryV15 value) {
    final output = ByteOutput(sizeHint(value));
    encodeTo(value, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(CustomMetadataEntryV15 metadata, Output output) {
    TypeIdCodec.codec.encodeTo(metadata.type, output);
    U8SequenceCodec.codec.encodeTo(metadata.value, output);
  }

  @override
  int sizeHint(CustomMetadataEntryV15 metadata) {
    int size = TypeIdCodec.codec.sizeHint(metadata.type);
    size += U8SequenceCodec.codec.sizeHint(metadata.value);
    return size;
  }
}
