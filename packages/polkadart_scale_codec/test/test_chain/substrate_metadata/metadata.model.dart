import 'dart:typed_data';

// ignore_for_file: camel_case_types

abstract class Metadata {
  final String kind;
  const Metadata({required this.kind});
}

class Metadata_V14 extends Metadata {
  final MetadataV14 value;
  const Metadata_V14({required this.value}) : super(kind: 'V14');
}

class MetadataV14 {
  final PortableRegistryV14 lookup;
  final List<PalletMetadataV14> pallets;
  final ExtrinsicMetadataV14 extrinsic;
  final int type;

  const MetadataV14(
      {required this.lookup,
      required this.pallets,
      required this.extrinsic,
      required this.type});
}

class PortableRegistryV14 {
  final List<PortableTypeV14> types;
  const PortableRegistryV14({required this.types});
}

class PalletMetadataV14 {
  final String name;
  final PalletStorageMetadataV14? storage;
  final PalletCallMetadataV14? calls;
  final PalletEventMetadataV14? events;
  final List<PalletConstantMetadataV14> constants;
  final PalletErrorMetadataV14? errors;
  final int index;

  const PalletMetadataV14(
      {required this.name,
      this.storage,
      this.calls,
      this.events,
      required this.constants,
      this.errors,
      required this.index});
}

class ExtrinsicMetadataV14 {
  final int type;
  final int version;
  final List<SignedExtensionMetadataV14> signedExtensions;
  const ExtrinsicMetadataV14(
      {required this.type,
      required this.version,
      required this.signedExtensions});
}

class PortableTypeV14 {
  final int id;
  final Si1Type type;
  const PortableTypeV14({required this.id, required this.type});
}

class PalletStorageMetadataV14 {
  final String prefix;
  final List<StorageEntryMetadataV14> items;
  const PalletStorageMetadataV14({required this.prefix, required this.items});
}

class PalletCallMetadataV14 {
  final int type;
  const PalletCallMetadataV14({required this.type});
}

class PalletEventMetadataV14 {
  final int type;
  const PalletEventMetadataV14({required this.type});
}

class PalletConstantMetadataV14 {
  final String name;
  final int type;
  final Uint8List value;
  final List<String> docs;

  const PalletConstantMetadataV14(
      {required this.name,
      required this.type,
      required this.value,
      required this.docs});
}

class PalletErrorMetadataV14 {
  final int type;
  const PalletErrorMetadataV14({required this.type});
}

class SignedExtensionMetadataV14 {
  final String identifier;
  final int type;
  final int additionalSigned;
  const SignedExtensionMetadataV14(
      {required this.identifier,
      required this.type,
      required this.additionalSigned});
}

class Si1Type {
  final List<String> path;
  final List<Si1TypeParameter> params;
  final Si1TypeDef def;
  final List<String> docs;

  const Si1Type(
      {required this.path,
      required this.params,
      required this.def,
      required this.docs});
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
}

abstract class StorageEntryModifierV9 {
  final String kind;
  const StorageEntryModifierV9({required this.kind});
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

class Si1TypeParameter {
  final String name;
  final int? type;

  const Si1TypeParameter({required this.name, this.type});
}

abstract class Si1TypeDef {
  final String kind;
  const Si1TypeDef({required this.kind});
}

class Si1TypeDef_Composite extends Si1TypeDef {
  final Si1TypeDefComposite value;
  const Si1TypeDef_Composite({required this.value}) : super(kind: 'Composite');
}

class Si1TypeDef_Variant extends Si1TypeDef {
  final Si1TypeDefVariant value;
  const Si1TypeDef_Variant({required this.value}) : super(kind: 'Variant');
}

class Si1TypeDef_Sequence extends Si1TypeDef {
  final Si1TypeDefSequence value;
  const Si1TypeDef_Sequence({required this.value}) : super(kind: 'Sequence');
}

class Si1TypeDef_Array extends Si1TypeDef {
  final Si1TypeDefArray value;
  const Si1TypeDef_Array({required this.value}) : super(kind: 'Array');
}

class Si1TypeDef_Tuple extends Si1TypeDef {
  final List<int> value;
  const Si1TypeDef_Tuple({required this.value}) : super(kind: 'Tuple');
}

class Si1TypeDef_Primitive extends Si1TypeDef {
  final Si0TypeDefPrimitive value;
  const Si1TypeDef_Primitive({required this.value}) : super(kind: 'Primitive');
}

class Si1TypeDef_Compact extends Si1TypeDef {
  final Si1TypeDefCompact value;
  const Si1TypeDef_Compact({required this.value}) : super(kind: 'Compact');
}

class Si1TypeDef_BitSequence extends Si1TypeDef {
  final Si1TypeDefBitSequence value;
  const Si1TypeDef_BitSequence({required this.value})
      : super(kind: 'BitSequence');
}

abstract class StorageEntryTypeV14 {
  final String kind;
  const StorageEntryTypeV14({required this.kind});
}

class StorageEntryTypeV14_Plain extends StorageEntryTypeV14 {
  final int value;
  const StorageEntryTypeV14_Plain({required this.value}) : super(kind: 'Plain');
}

class StorageEntryTypeV14_Map extends StorageEntryTypeV14 {
  final List<StorageHasherV11> hashers;
  final int key;
  final int value;
  const StorageEntryTypeV14_Map(
      {required this.hashers, required this.key, required this.value})
      : super(kind: 'Map');
}

abstract class StorageHasherV11 {
  final String kind;
  const StorageHasherV11({required this.kind});
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

class Si1TypeDefComposite {
  final List<Si1Field> fields;
  const Si1TypeDefComposite({required this.fields});
}

class Si1TypeDefVariant {
  final List<Si1Variant> variants;
  const Si1TypeDefVariant({required this.variants});
}

class Si1TypeDefSequence {
  final int type;
  const Si1TypeDefSequence({required this.type});
}

class Si1TypeDefArray {
  final int len;
  final int type;
  const Si1TypeDefArray({required this.len, required this.type});
}

abstract class Si0TypeDefPrimitive {
  final String kind;
  const Si0TypeDefPrimitive({required this.kind});
}

class Si0TypeDefPrimitive_Bool extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Bool() : super(kind: 'Bool');
}

class Si0TypeDefPrimitive_Char extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Char() : super(kind: 'Char');
}

class Si0TypeDefPrimitive_Str extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Str() : super(kind: 'Str');
}

class Si0TypeDefPrimitive_U8 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U8() : super(kind: 'U8');
}

class Si0TypeDefPrimitive_U16 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U16() : super(kind: 'U16');
}

class Si0TypeDefPrimitive_U32 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U32() : super(kind: 'U32');
}

class Si0TypeDefPrimitive_U64 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U64() : super(kind: 'U64');
}

class Si0TypeDefPrimitive_U128 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U128() : super(kind: 'U128');
}

class Si0TypeDefPrimitive_U256 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U256() : super(kind: 'U256');
}

class Si0TypeDefPrimitive_I8 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I8() : super(kind: 'I8');
}

class Si0TypeDefPrimitive_I16 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I16() : super(kind: 'I16');
}

class Si0TypeDefPrimitive_I32 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I32() : super(kind: 'I32');
}

class Si0TypeDefPrimitive_I64 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I64() : super(kind: 'I64');
}

class Si0TypeDefPrimitive_I128 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I128() : super(kind: 'I128');
}

class Si0TypeDefPrimitive_I256 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I256() : super(kind: 'I256');
}

class Si1TypeDefCompact {
  final int type;
  const Si1TypeDefCompact({required this.type});
}

class Si1TypeDefBitSequence {
  final int bitStoreType;
  final int bitOrderType;
  const Si1TypeDefBitSequence(
      {required this.bitOrderType, required this.bitStoreType});
}

class Si1Field {
  final String? name;
  final int type;
  final String? typeName;
  final List<String> docs;
  const Si1Field(
      {this.name, required this.type, this.typeName, required this.docs});
}

class Si1Variant {
  final String name;
  final List<Si1Field> fields;
  final int index;
  final List<String> docs;

  const Si1Variant(
      {required this.name,
      required this.fields,
      required this.index,
      required this.docs});
}
