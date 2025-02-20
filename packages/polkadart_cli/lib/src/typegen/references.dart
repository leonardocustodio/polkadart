import 'dart:core' as core;
import 'package:code_builder/code_builder.dart' show TypeReference, Reference;

/// Helper to make a type nullable
extension Nullable on Reference {
  TypeReference asNullable() {
    final TypeReference type;
    if (this is TypeReference) {
      type = this as TypeReference;
    } else {
      type = this.type as TypeReference;
    }

    // The type 'dynamic' cannot be nullable
    if (type.symbol == 'dynamic' && type.types.isEmpty) {
      return type;
    }

    // Make type nullable
    if (type.isNullable != true) {
      final builder = type.toBuilder();
      builder.isNullable = true;
      return builder.build();
    }
    return type;
  }
}

////////////////
// Dart Types //
////////////////
const bool = Reference('bool', 'dart:core');
const dynamic = Reference('dynamic');
const int = Reference('int', 'dart:core');
const void_ = Reference('void', 'dart:core');
const object = Reference('Object', 'dart:core');
const identical = Reference('identical', 'dart:core');
const string = Reference('String', 'dart:core');
const uri = Reference('Uri', 'dart:core');
const bigInt = Reference('BigInt', 'dart:core');
const uint8List = Reference('Uint8List', 'dart:typed_data');
const uint8Buffer = Reference('Uint8Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableUint8ListView = Reference('UnmodifiableUint8ListView', 'dart:typed_data');
const uint16List = Reference('Uint16List', 'dart:typed_data');
const uint16Buffer = Reference('Uint16Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableUint16ListView = Reference('UnmodifiableUint16ListView', 'dart:typed_data');
const uint32List = Reference('Uint32List', 'dart:typed_data');
const uint32Buffer = Reference('Uint32Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableUint32ListView = Reference('UnmodifiableUint32ListView', 'dart:typed_data');
const int8List = Reference('Int8List', 'dart:typed_data');
const int8Buffer = Reference('Int8Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableInt8ListView = Reference('UnmodifiableInt8ListView', 'dart:typed_data');
const int16List = Reference('Int16List', 'dart:typed_data');
const int16Buffer = Reference('Int16Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableInt16ListView = Reference('UnmodifiableInt16ListView', 'dart:typed_data');
const int32List = Reference('Int32List', 'dart:typed_data');
const int32Buffer = Reference('Int32Buffer', 'package:typed_data/typed_buffers.dart');
const unmodifiableInt32ListView = Reference('UnmodifiableInt32ListView', 'dart:typed_data');
const mapEntry = Reference('MapEntry', 'dart:core');

TypeReference list({Reference? ref}) {
  return TypeReference((b) {
    b
      ..symbol = 'List'
      ..url = 'dart:core';
    if (ref != null) {
      b.types.add(ref);
    }
  });
}

TypeReference map(Reference key, Reference value) {
  return TypeReference((b) => b
    ..symbol = 'Map'
    ..url = 'dart:core'
    ..types.addAll([key, value]));
}

TypeReference future([Reference? ref]) {
  return TypeReference((builder) {
    builder
      ..symbol = 'Future'
      ..url = 'dart:async';

    if (ref != null) {
      builder.types.add(ref);
    }
  });
}

///////////////////////
// Scale Codec types //
///////////////////////
const input = Reference('Input', 'package:polkadart/scale_codec.dart');
const output = Reference('Output', 'package:polkadart/scale_codec.dart');
const byteOutput = Reference('ByteOutput', 'package:polkadart/scale_codec.dart');
const emptyCodec = Reference('NullCodec', 'package:polkadart/scale_codec.dart');
const bitArray = Reference('BitArray', 'package:polkadart/scale_codec.dart');
const bitStore = Reference('BitStore', 'package:polkadart/scale_codec.dart');
const bitOrder = Reference('BitOrder', 'package:polkadart/scale_codec.dart');
const compactCodec = Reference('CompactCodec', 'package:polkadart/scale_codec.dart');
const compactBigIntCodec = Reference('CompactBigIntCodec', 'package:polkadart/scale_codec.dart');
const bitSequenceCodec = Reference('BitSequenceCodec', 'package:polkadart/scale_codec.dart');
const strCodec = Reference('StrCodec', 'package:polkadart/scale_codec.dart');
const boolCodec = Reference('BoolCodec', 'package:polkadart/scale_codec.dart');
const u8Codec = Reference('U8Codec', 'package:polkadart/scale_codec.dart');
const u8ArrayCodec = Reference('U8ArrayCodec', 'package:polkadart/scale_codec.dart');
const u8SequenceCodec = Reference('U8SequenceCodec', 'package:polkadart/scale_codec.dart');
const u16Codec = Reference('U16Codec', 'package:polkadart/scale_codec.dart');
const u16ArrayCodec = Reference('U16ArrayCodec', 'package:polkadart/scale_codec.dart');
const u16SequenceCodec = Reference('U16SequenceCodec', 'package:polkadart/scale_codec.dart');
const u32Codec = Reference('U32Codec', 'package:polkadart/scale_codec.dart');
const u32ArrayCodec = Reference('U32ArrayCodec', 'package:polkadart/scale_codec.dart');
const u32SequenceCodec = Reference('U32SequenceCodec', 'package:polkadart/scale_codec.dart');
const u64Codec = Reference('U64Codec', 'package:polkadart/scale_codec.dart');
const u64ArrayCodec = Reference('U64ArrayCodec', 'package:polkadart/scale_codec.dart');
const u64SequenceCodec = Reference('U64SequenceCodec', 'package:polkadart/scale_codec.dart');
const u128Codec = Reference('U128Codec', 'package:polkadart/scale_codec.dart');
const u256Codec = Reference('U256Codec', 'package:polkadart/scale_codec.dart');
const i8Codec = Reference('I8Codec', 'package:polkadart/scale_codec.dart');
const i8ArrayCodec = Reference('I8ArrayCodec', 'package:polkadart/scale_codec.dart');
const i8SequenceCodec = Reference('I8SequenceCodec', 'package:polkadart/scale_codec.dart');
const i16Codec = Reference('I16Codec', 'package:polkadart/scale_codec.dart');
const i16ArrayCodec = Reference('I16ArrayCodec', 'package:polkadart/scale_codec.dart');
const i16SequenceCodec = Reference('I16SequenceCodec', 'package:polkadart/scale_codec.dart');
const i32Codec = Reference('I32Codec', 'package:polkadart/scale_codec.dart');
const i32ArrayCodec = Reference('I32ArrayCodec', 'package:polkadart/scale_codec.dart');
const i32SequenceCodec = Reference('I32SequenceCodec', 'package:polkadart/scale_codec.dart');
const i64Codec = Reference('I64Codec', 'package:polkadart/scale_codec.dart');
const i64ArrayCodec = Reference('I64ArrayCodec', 'package:polkadart/scale_codec.dart');
const i64SequenceCodec = Reference('I64SequenceCodec', 'package:polkadart/scale_codec.dart');
const i128Codec = Reference('I128Codec', 'package:polkadart/scale_codec.dart');
const i256Codec = Reference('I256Codec', 'package:polkadart/scale_codec.dart');

TypeReference codec({Reference? ref}) {
  return TypeReference((b) {
    b
      ..symbol = 'Codec'
      ..url = 'package:polkadart/scale_codec.dart';
    if (ref != null) {
      b.types.add(ref);
    }
  });
}

TypeReference option(Reference ref) {
  return TypeReference((b) => b
    ..symbol = 'Option'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.add(ref));
}

TypeReference optionCodec(Reference ref) {
  return TypeReference((b) => b
    ..symbol = 'OptionCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.add(ref));
}

TypeReference nestedOptionCodec(Reference ref) {
  return TypeReference((b) => b
    ..symbol = 'NestedOptionCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.add(ref));
}

TypeReference result(Reference key, Reference value) {
  return TypeReference((b) => b
    ..symbol = 'Result'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.addAll([key, value]));
}

TypeReference resultCodec(Reference key, Reference value) {
  return TypeReference((b) => b
    ..symbol = 'ResultCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.addAll([key, value]));
}

TypeReference sequenceCodec(Reference ref, {core.bool nullable = false}) {
  return TypeReference((b) => b
    ..symbol = 'SequenceCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.add(nullable ? option(ref) : ref));
}

TypeReference arrayCodec(Reference ref, {core.bool nullable = false}) {
  return TypeReference((b) => b
    ..symbol = 'ArrayCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.add(nullable ? option(ref) : ref));
}

TypeReference bTreeMapCodec(Reference key, Reference value) {
  return TypeReference((b) => b
    ..symbol = 'BTreeMapCodec'
    ..url = 'package:polkadart/scale_codec.dart'
    ..types.addAll([key, value]));
}

/////////////////////
// Substrate types //
/////////////////////
const storageHasher = Reference('StorageHasher', 'package:polkadart/polkadart.dart');
const provider = Reference('Provider', 'package:polkadart/polkadart.dart');
const stateApi = Reference('StateApi', 'package:polkadart/polkadart.dart');
const systemApi = Reference('SystemApi', 'package:polkadart/polkadart.dart');
const blockHash = Reference('BlockHash', 'package:polkadart/polkadart.dart');

TypeReference storageValue(Reference value) {
  return TypeReference((b) => b
    ..symbol = 'StorageValue'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.add(value));
}

TypeReference storageMap({required Reference key, required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key, value]));
}

TypeReference storageDoubleMap(
    {required Reference key1, required Reference key2, required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageDoubleMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key1, key2, value]));
}

TypeReference storageTripleMap(
    {required Reference key1,
    required Reference key2,
    required Reference key3,
    required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageTripleMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key1, key2, key3, value]));
}

TypeReference storageQuadrupleMap(
    {required Reference key1,
    required Reference key2,
    required Reference key3,
    required Reference key4,
    required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageQuadrupleMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key1, key2, key3, key4, value]));
}

TypeReference storageQuintupleMap(
    {required Reference key1,
    required Reference key2,
    required Reference key3,
    required Reference key4,
    required Reference key5,
    required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageQuintupleMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key1, key2, key3, key4, key5, value]));
}

TypeReference storageSextupleMap(
    {required Reference key1,
    required Reference key2,
    required Reference key3,
    required Reference key4,
    required Reference key5,
    required Reference key6,
    required Reference value}) {
  return TypeReference((b) => b
    ..symbol = 'StorageSextupleMap'
    ..url = 'package:polkadart/polkadart.dart'
    ..types.addAll([key1, key2, key3, key4, key5, key6, value]));
}

////////////
// Quiver //
////////////
const quiverListsEqual = Reference('listsEqual', 'package:quiver/collection.dart');

const quiverMapsEqual = Reference('mapsEqual', 'package:quiver/collection.dart');
