library scale_info;

// import './utils.dart' show parseOption;
import 'dart:typed_data' show Uint8List;

part './field.dart';
part './type_parameter.dart';
part './type_definition.dart';
part './variant.dart';

T? parseOption<T>(dynamic obj) {
  if (obj == null) {
    return null;
  }

  T? value;
  if (obj.runtimeType == T) {
    value = obj as T;
  } else if ((obj as Map).containsKey('Some')) {
    value = obj['Some'] as T;
  }
  return value;
}

abstract class TypeDef {
  const TypeDef();

  Set<int> typeDependencies();

  factory TypeDef.fromJson(Map<String, dynamic> json) {
    final String typeName = json.keys.first;
    switch (typeName) {
      case 'Composite':
        {
          return TypeDefComposite.fromJson(json['Composite']);
        }
      case 'Variant':
        {
          return TypeDefVariant.fromJson(json['Variant']);
        }
      case 'Tuple':
        {
          return TypeDefTuple(types: (json['Tuple'] as List).cast<int>());
        }
      case 'Compact':
        {
          return TypeDefCompact.fromJson(json['Compact']);
        }
      case 'Array':
        {
          return TypeDefArray.fromJson(json['Array']);
        }
      case 'Sequence':
        {
          return TypeDefSequence.fromJson(json['Sequence']);
        }
      case 'Primitive':
        {
          return TypeDefPrimitive.fromString(json['Primitive']);
        }
      case 'BitSequence':
        {
          return TypeDefBitSequence.fromJson(json['BitSequence']);
        }
      default:
        {
          throw Exception('Unknown primitive type $typeName');
        }
    }
  }
}

/// A composite type, consisting of either named (struct) or unnamed (tuple
/// struct) fields
class TypeDefComposite extends TypeDef {
  /// The fields of the composite type.
  final List<Field> fields;

  /// Creates a new struct definition with named fields.
  const TypeDefComposite({required this.fields});

  factory TypeDefComposite.fromJson(Map<String, dynamic> json) {
    final List<Field> fields =
        (json['fields'] as List).map((field) => Field.fromJson(field)).toList();
    return TypeDefComposite(fields: fields);
  }

  @override
  Set<int> typeDependencies() {
    return fields.map((field) => field.type).toSet();
  }
}

/// A Enum type (consisting of variants).
class TypeDefVariant extends TypeDef {
  /// The variants of a variant type
  final List<Variant> variants;

  /// Create a new `TypeDefVariant` with the given variants
  const TypeDefVariant({required this.variants});

  factory TypeDefVariant.fromJson(Map<String, dynamic> json) {
    final List<Variant> variants = (json['variants'] as List)
        .map((field) => Variant.fromJson(field))
        .toList();
    return TypeDefVariant(variants: variants);
  }

  @override
  Set<int> typeDependencies() {
    final Set<int> dependencies = {};
    for (final variant in variants) {
      dependencies.addAll(variant.typeDependencies());
    }
    return dependencies;
  }
}

/// A type to refer to a sequence of elements of the same type.
class TypeDefSequence extends TypeDef {
  /// The element type of the sequence type.
  final int type;

  /// Creates a new sequence type.
  const TypeDefSequence({required this.type});

  factory TypeDefSequence.fromJson(Map<String, dynamic> json) {
    return TypeDefSequence(type: json['type'] as int);
  }

  @override
  Set<int> typeDependencies() {
    return {type};
  }
}

/// An array type.
class TypeDefArray extends TypeDef {
  /// The element type of the array type.
  final int type;

  /// The length of the array type.
  final int length;

  /// Creates a new array type.
  const TypeDefArray({required this.type, required this.length});

  factory TypeDefArray.fromJson(Map<String, dynamic> json) {
    return TypeDefArray(
      type: json['type'] as int,
      length: json['len'] as int,
    );
  }

  @override
  Set<int> typeDependencies() {
    return {type};
  }
}

/// A type wrapped in [`Compact`].
class TypeDefCompact extends TypeDef {
  /// The element type of the compact type.
  final int type;

  /// Creates a new compact type.
  const TypeDefCompact({required this.type});

  factory TypeDefCompact.fromJson(Map<String, dynamic> json) {
    return TypeDefCompact(type: json['type'] as int);
  }

  @override
  Set<int> typeDependencies() {
    return {type};
  }
}

/// A type to refer to tuple types.
class TypeDefTuple extends TypeDef {
  /// The element type of the compact type.
  final List<int> types;

  /// Creates a new compact type.
  const TypeDefTuple({required this.types});

  @override
  Set<int> typeDependencies() {
    return types.toSet();
  }
}

enum Primitive {
  Bool,
  Char,
  Str,
  U8,
  U16,
  U32,
  U64,
  U128,
  U256,
  I8,
  I16,
  I32,
  I64,
  I128,
  I256;

  /// Creates a new compact type.
  const Primitive();
}

/// A primitive Rust type.
class TypeDefPrimitive extends TypeDef {
  /// The primitive type.
  final Primitive primitive;

  /// Creates a new primitive type.
  const TypeDefPrimitive(this.primitive);

  factory TypeDefPrimitive.fromString(String primitive) {
    switch (primitive) {
      case 'Bool':
        return TypeDefPrimitive(Primitive.Bool);
      case 'Char':
        return TypeDefPrimitive(Primitive.Char);
      case 'Str':
        return TypeDefPrimitive(Primitive.Str);
      case 'U8':
        return TypeDefPrimitive(Primitive.U8);
      case 'U16':
        return TypeDefPrimitive(Primitive.U16);
      case 'U32':
        return TypeDefPrimitive(Primitive.U32);
      case 'U64':
        return TypeDefPrimitive(Primitive.U64);
      case 'U128':
        return TypeDefPrimitive(Primitive.U128);
      case 'U256':
        return TypeDefPrimitive(Primitive.U256);
      case 'I8':
        return TypeDefPrimitive(Primitive.I8);
      case 'I16':
        return TypeDefPrimitive(Primitive.I16);
      case 'I32':
        return TypeDefPrimitive(Primitive.I32);
      case 'I64':
        return TypeDefPrimitive(Primitive.I64);
      case 'I128':
        return TypeDefPrimitive(Primitive.I128);
      case 'I256':
        return TypeDefPrimitive(Primitive.I256);
      default:
        throw Exception('Unknown primitive type $primitive');
    }
  }

  @override
  Set<int> typeDependencies() {
    return <int>{};
  }
}

/// Type describing a [`bitvec::vec::BitVec`].
class TypeDefBitSequence extends TypeDef {
  /// The type of the BitStore
  final int bitStoreType;

  /// The type of the BitOrder
  final int bitOrderType;

  /// Creates a new bit sequence type.
  const TypeDefBitSequence(
      {required this.bitStoreType, required this.bitOrderType});

  factory TypeDefBitSequence.fromJson(Map<String, dynamic> json) {
    return TypeDefBitSequence(
      bitStoreType: json['bitStoreType'] as int,
      bitOrderType: json['bitOrderType'] as int,
    );
  }

  @override
  Set<int> typeDependencies() {
    return {bitStoreType, bitOrderType};
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

  final bool concat;

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
  final Uint8List defaultValue;

  /// Storage entry documentation.
  final List<String> docs;

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
}

class PalletCallMetadata {
  /// The call type for the pallet
  final int type;

  /// The calls from the pallet
  final List<CallEntryMetadata> entries;

  const PalletCallMetadata({
    required this.type,
    required this.entries,
  });

  factory PalletCallMetadata.fromJson(
      Map<String, dynamic> json, List<TypeMetadata> registry) {
    final typeDef = registry.firstWhere((e) => e.id == json['type']).typeDef
        as TypeDefVariant;
    final calls =
        typeDef.variants.map((e) => CallEntryMetadata.fromVariant(e)).toList();

    return PalletCallMetadata(
      type: json['type'] as int,
      entries: calls,
    );
  }
}

/// All metadata of the pallet's extrinsics.
class CallEntryMetadata {
  /// Type of the pallet call.
  final String name;

  final List<Field> fields;

  final int index;

  final List<String> docs;

  const CallEntryMetadata({
    required this.name,
    required this.fields,
    required this.index,
    required this.docs,
  });

  factory CallEntryMetadata.fromVariant(Variant variant) {
    return CallEntryMetadata(
      name: variant.name,
      fields: variant.fields,
      index: variant.index,
      docs: variant.docs,
    );
  }
}

/// All metadata of the pallet's storage.
class PalletStorageMetadata {
  /// The common prefix used by all storage entries.
  final String prefix;

  /// Metadata for all storage entries.
  final List<StorageEntryMetadata> entries;

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
}

/// Metadata about one pallet constant.
class PalletConstantMetadata {
  /// Name of the pallet constant.
  final String name;

  /// Type of the pallet constant.
  final int type;

  /// Value stored in the constant (SCALE encoded).
  final Uint8List value;

  /// Documentation of the constant.
  final List<String> docs;

  const PalletConstantMetadata({
    required this.name,
    required this.type,
    required this.value,
    required this.docs,
  });

  factory PalletConstantMetadata.fromJson(Map<String, dynamic> json) {
    return PalletConstantMetadata(
      name: json['name'],
      type: json['type'],
      value: Uint8List.fromList((json['value'] as List).cast<int>()),
      docs: (json['docs'] as List).cast<String>(),
    );
  }
}

/// All metadata about an runtime pallet.
class PalletMetadata {
  /// Pallet name.
  final String name;

  /// Pallet storage metadata.
  final PalletStorageMetadata? storage;

  /// Pallet constants metadata.
  final List<PalletConstantMetadata> constants;

  /// Pallet extrinsics metadata.
  final PalletCallMetadata? call;

  /// Define the index of the pallet, this index will be used for the encoding of pallet event,
  /// call and origin variants.
  final int index;

  /// The RuntimeCall type.
  final int runtimeCallType;

  PalletMetadata({
    required this.name,
    required this.storage,
    required this.constants,
    required this.call,
    required this.index,
    required this.runtimeCallType,
  });

  factory PalletMetadata.fromJson(Map<String, dynamic> json,
      List<TypeMetadata> lookupTypes, int extrinsicType) {
    final storage = json['storage'] != null
        ? PalletStorageMetadata.fromJson(json['storage'])
        : null;

    final call = json['calls'] != null
        ? PalletCallMetadata.fromJson(json['calls'], lookupTypes)
        : null;

    final constants = (json['constants'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => PalletConstantMetadata.fromJson(json))
        .toList();

    return PalletMetadata(
      name: json['name'],
      storage: storage,
      constants: constants,
      call: call,
      index: json['index'],

      /// This type is fixed at `params[1].type`
      runtimeCallType: lookupTypes[extrinsicType].params[1].type!,
    );
  }
}

/// Metadata of an extrinsic signed extension.
class SignedExtensionMetadata {
  /// The unique signed extension identifier, which may be different from the type name.
  final String identifier;

  /// The type of the signed extension, with the data to be included in the extrinsic.
  final int type;

  /// The type of the additional signed data, with the data to be included in the signed payload
  final int additionalSigned;

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
}

/// Metadata of the extrinsic used by the runtime.
class ExtrinsicMetadata {
  /// The type of the extrinsic.
  final int type;

  /// Extrinsic version.
  final int version;

  /// The signed extensions in the order they appear in the extrinsic.
  final List<SignedExtensionMetadata> signedExtensions;

  ExtrinsicMetadata({
    required this.type,
    required this.version,
    required this.signedExtensions,
  });

  factory ExtrinsicMetadata.fromJson(Map<String, dynamic> json) {
    final signedExtensions = (json['signedExtensions'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => SignedExtensionMetadata.fromJson(json))
        .toList();

    return ExtrinsicMetadata(
      type: json['type'],
      version: json['version'],
      signedExtensions: signedExtensions,
    );
  }
}

/// The metadata of a runtime.
class RuntimeMetadataV14 {
  /// Type registry containing all types used in the metadata.
  final List<TypeMetadata> registry;

  /// Metadata of all the pallets.
  final List<PalletMetadata> pallets;

  /// Metadata of the extrinsic.
  final ExtrinsicMetadata extrinsic;

  /// The type of the `Runtime`.
  final int runtimeTypeId;

  RuntimeMetadataV14({
    required this.registry,
    required this.pallets,
    required this.extrinsic,
    required this.runtimeTypeId,
  });

  factory RuntimeMetadataV14.fromJson(Map<String, dynamic> json) {
    final extrinsicMetadata = ExtrinsicMetadata.fromJson(json['extrinsic']);

    final types = (json['lookup']['types'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) => TypeMetadata.fromJson(json))
        .toList();

    final pallets = (json['pallets'] as List)
        .cast<Map<String, dynamic>>()
        .map((json) =>
            PalletMetadata.fromJson(json, types, extrinsicMetadata.type))
        .toList();

    return RuntimeMetadataV14(
      registry: types,
      pallets: pallets,
      extrinsic: extrinsicMetadata,
      runtimeTypeId: json['type'],
    );
  }
}
