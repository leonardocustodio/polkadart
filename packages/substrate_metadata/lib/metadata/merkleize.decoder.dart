import 'dart:math';
import 'dart:typed_data';
import 'package:polkadart/scale_codec.dart';
import 'package:polkadart/substrate/substrate.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

extension ListIntExtension on List<int> {
  Input toInput() {
    return Input.fromBytes(this);
  }
}

typedef Lookup = List<LookupEntry>;

class TypeRef {
  final String tag;
  final dynamic value;

  const TypeRef({required this.tag, this.value});

  bool get isPerId => tag == 'perId';

  void encodeTo(TypeRef ref, ByteOutput output) {
    switch (ref.tag) {
      case 'Bool':
        U8Codec.codec.encodeTo(0, output);
        break;
      case 'Char':
        U8Codec.codec.encodeTo(1, output);
        break;
      case 'Str':
        U8Codec.codec.encodeTo(2, output);
        break;
      case 'U8':
        U8Codec.codec.encodeTo(3, output);
        break;
      case 'U16':
        U8Codec.codec.encodeTo(4, output);
        break;
      case 'U32':
        U8Codec.codec.encodeTo(5, output);
        break;
      case 'U64':
        U8Codec.codec.encodeTo(6, output);
        break;
      case 'U128':
        U8Codec.codec.encodeTo(7, output);
        break;
      case 'U256':
        U8Codec.codec.encodeTo(8, output);
        break;
      case 'I8':
        U8Codec.codec.encodeTo(9, output);
        break;
      case 'I16':
        U8Codec.codec.encodeTo(10, output);
        break;
      case 'I32':
        U8Codec.codec.encodeTo(11, output);
        break;
      case 'I64':
        U8Codec.codec.encodeTo(12, output);
        break;
      case 'I128':
        U8Codec.codec.encodeTo(13, output);
        break;
      case 'I256':
        U8Codec.codec.encodeTo(14, output);
        break;
      case 'compactU8':
        U8Codec.codec.encodeTo(15, output);
        break;
      case 'compactU16':
        U8Codec.codec.encodeTo(16, output);
        break;
      case 'compactU32':
        U8Codec.codec.encodeTo(17, output);
        break;
      case 'compactU64':
        U8Codec.codec.encodeTo(18, output);
        break;
      case 'compactU128':
        U8Codec.codec.encodeTo(19, output);
        break;
      case 'compactU256':
        U8Codec.codec.encodeTo(20, output);
        break;
      case 'void':
        U8Codec.codec.encodeTo(21, output);
        break;
      case 'perId':
        U8Codec.codec.encodeTo(22, output);
        CompactCodec.codec.encodeTo(value, output);
        break;
      default:
        throw Exception('Unknown type: $tag');
    }
  }
}

class LookupEntry {
  final List<String> path;
  final TypeDef typeDef;
  final int typeId;

  const LookupEntry({
    required this.typeDef,
    required this.typeId,
    required this.path,
  });

  Uint8List encode(LookupEntry value) {
    final output = ByteOutput(44);
    SequenceCodec(StrCodec.codec).encodeTo(value.path, output);
    print('Path: ${output.toBytes()}');

    if (typeDef is! TypeDefEnumeration) {
      TypeDef.codec.encodeTo(value.typeDef, output);
    } else {
      TypeDefEnumeration.codec.encodeTo(value.typeDef as TypeDefEnumeration, output);
    }

    print('After type def: ${output.toBytes()}');

    // CompactCodec.codec.encodeTo(value.typeId, output);
    return output.toBytes(copy: true);
  }

  // int sizeHint(LookupEntry value) {
  //   // final composite = TypeDefComposite(fields: [
  //   //   Field(name: 'path', typeName: 'Vec<u8>', type: TypeRef(tag: 'perId', value: 0), docs: []),
  //   //   Field(name: 'typeDef', typeName: value.typeDef, type: TypeRef(tag: 'perId', value: 1), docs: []),
  //   //   Field(name: 'typeId', typeName: 'f', type: TypeRef(tag: 'perId', value: 2), docs: []),
  //   // ]);
  //
  //   TypeDefComposite.codec.sizeHint(composite) + 1;
  // }
}

class TypeDefEnumeration extends TypeDef {
  final int index;
  final String name;
  final List<Field> fields;
  final List<String> docs;

  const TypeDefEnumeration({
    required this.index,
    required this.name,
    required this.fields,
    required this.docs,
  });

  static const $TypeDefEnumerationCodec codec = $TypeDefEnumerationCodec._();

  @override
  Set<int> typeDependencies() {
    return fields.map((field) => field.type).toSet();
  }

  @override
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
    };
    if (fields.isNotEmpty) {
      json['fields'] = fields.map((e) => e.toJson()).toList();
    }
    json['index'] = index;
    if (docs.isNotEmpty) {
      json['docs'] = docs;
    }
    return json;
  }
}

class $TypeDefEnumerationCodec implements Codec<TypeDefEnumeration> {
  const $TypeDefEnumerationCodec._();

  @override
  TypeDefEnumeration decode(Input input) {
    final name = StrCodec.codec.decode(input);
    final fields = SequenceCodec(Field.codec).decode(input);
    final index = U8Codec.codec.decode(input);
    final docs = SequenceCodec(StrCodec.codec).decode(input);
    return TypeDefEnumeration(
      index: index,
      name: name,
      fields: fields,
      docs: docs,
    );
  }

  @override
  Uint8List encode(TypeDefEnumeration enumeration) {
    final output = ByteOutput(sizeHint(enumeration));
    encodeTo(enumeration, output);
    return output.toBytes(copy: false);
  }

  @override
  void encodeTo(TypeDefEnumeration enumeration, Output output) {
    StrCodec.codec.encodeTo(enumeration.name, output);
    SequenceCodec(Field.codec).encodeTo(enumeration.fields, output);
    U8Codec.codec.encodeTo(enumeration.index, output);
    SequenceCodec(StrCodec.codec).encodeTo(enumeration.docs, output);
  }

  @override
  int sizeHint(TypeDefEnumeration enumeration) {
    int size = StrCodec.codec.sizeHint(enumeration.name);
    size += SequenceCodec(Field.codec).sizeHint(enumeration.fields);
    size += U8Codec.codec.sizeHint(enumeration.index);
    size += SequenceCodec(StrCodec.codec).sizeHint(enumeration.docs);
    return size;
  }
}

class ExtrinsicInfo {
  final int version;
  final TypeRef addressTy;
  final TypeRef callTy;
  final TypeRef signatureTy;
  final List signedExtensions;

  const ExtrinsicInfo({
    required this.version,
    required this.addressTy,
    required this.callTy,
    required this.signatureTy,
    required this.signedExtensions,
  });

  Uint8List encode() {
    final output = ByteOutput();

    U8Codec.codec.encodeTo(version, output);
    addressTy.encodeTo(addressTy, output);
    callTy.encodeTo(callTy, output);
    signatureTy.encodeTo(signatureTy, output);

    CompactBigIntCodec.codec.encodeTo(BigInt.from(signedExtensions.length), output);
    for (final extension in signedExtensions) {
      final identifier = extension.identifier;
      CompactBigIntCodec.codec.encodeTo(BigInt.from(identifier.length), output);
      for (var i = 0; i < identifier.length; i++) {
        U8Codec.codec.encodeTo(identifier.codeUnitAt(i), output);
      }

      extension.includedInExtrinsic.encodeTo(extension.includedInExtrinsic, output);
      extension.includedInSignedData.encodeTo(extension.includedInSignedData, output);
    }

    return output.toBytes();
  }
}

class ExtraInfo {
  final int specVersion;
  final String specName;
  final int base58Prefix;
  final int decimals;
  final String tokenSymbol;

  const ExtraInfo({
    required this.specVersion,
    required this.specName,
    required this.base58Prefix,
    required this.decimals,
    required this.tokenSymbol,
  });

  Uint8List encode() {
    final output = ByteOutput();

    U32Codec.codec.encodeTo(specVersion, output);
    StrCodec.codec.encodeTo(specName, output);
    U16Codec.codec.encodeTo(base58Prefix, output);
    U8Codec.codec.encodeTo(decimals, output);
    StrCodec.codec.encodeTo(tokenSymbol, output);

    return output.toBytes();
  }
}

class MetadataMerkleizer {
  final RuntimeMetadata metadata;
  final int decimals;
  final String tokenSymbol;

  late final Lookup lookup;
  late final List<Uint8List> lookupEncoded;
  late final ExtrinsicInfo extrinsicMeta;
  late final ExtraInfo extraInfo;

  MetadataMerkleizer._({
    required this.metadata,
    required this.decimals,
    required this.tokenSymbol,
  }) {
    print('Constructor of merkleizer');

    final PalletMetadata system = metadata.pallets.firstWhere((p) => p.name == 'System',
        orElse: () => throw Exception('System pallet not found'));
    final PalletConstantMetadata ss58prefix = system.constants.firstWhere(
      (c) => c.name == 'SS58Prefix',
      orElse: () => throw Exception('System.ss58Prefix constant not found'),
    );
    final PalletConstantMetadata version = system.constants.firstWhere((c) => c.name == 'Version',
        orElse: () => throw Exception('System.Version constant not found'));

    final ss58 = decodeTypeDef(
      metadata.typeById(ss58prefix.type).type.typeDef,
      ss58prefix.value.toInput(),
    );

    // TODO: Compare with hinted ss58Prefix
    assertion(ss58 != null, 'SS58 prefix not found');

    final runtime = decodeTypeDef(
      metadata.typeById(version.type).type.typeDef,
      version.value.toInput(),
    );

    // TODO: Compare with hinted specName and hinted specVersion
    assertion(runtime['spec_name'] != null, 'Spec name not found');
    assertion(runtime['spec_version'] != null, 'Spec version not found');

    print('ss58: $ss58');
    print('Spec name: ${runtime['spec_name']} - Spec version: ${runtime['spec_version']}');

    extraInfo = ExtraInfo(
        decimals: decimals,
        tokenSymbol: tokenSymbol,
        specVersion: runtime['spec_version'],
        specName: runtime['spec_name'],
        base58Prefix: ss58);

    final definitions =
        Map<int, PortableType>.fromEntries(metadata.types.map((v) => MapEntry(v.id, v)));

    // final definitions = Map<int, LookupValue>.fromEntries(
    //   metadata.types.map(
    //     (type) => MapEntry(
    //       type.id,
    //       LookupValue(
    //         id: type.id,
    //         path: type.type.path,
    //         params: type.type.params
    //             .map((param) => LookupValueParams(
    //                   name: param.name,
    //                   type: param.type,
    //                 ))
    //             .toList(),
    //         def: LookupTypeDef.fromTypeDef(type.type.typeDef),
    //       ),
    //     ),
    //   ),
    // );

    //[
    //    12,  28, 115, 112,  95,  99, 111, 114, 101, 24,
    //    99, 114, 121, 112, 116, 111,  44,  65,  99, 99,
    //   111, 117, 110, 116,  73, 100,  51,  50,   0,  4,
    //     0,  22,   4,   1,  32,  91, 117,  56,  59, 32,
    //    51,  50,  93,   0
    // ]

//  [12, 28, 115, 112, 95, 99, 111, 114, 101, 24,
//  99, 114, 121, 112, 116, 111, 44, 65, 99, 99,
//  111, 117, 110, 116, 73, 100, 51, 50, 0, 4,
//  0,        4, 1, 32, 91, 117, 56, 59, 32,
//  51, 50, 93, 0]

    print('Definitions length: ${definitions.length}');

    final Map<int, int> accessibleTypes = getAccessibleTypes(definitions);
    print('AccessibleTypes length: ${accessibleTypes.length}');

    final lookup = getLookup(definitions, accessibleTypes);
    print('Lookup length: ${lookup.length}');

    final List<Uint8List> lookupEncoded = lookup.map<Uint8List>((l) {
      final enc = l.encode(l);
      print('${l.typeDef.runtimeType}: ${enc.length}');
      print('Lookup encoded: ${enc}');

      throw UnimplementedError('');

      return enc;
    }).toList();
    // print('Lookup encoded: ${lookupEncoded[1]}');
    // print(lookupEncoded[0]);

    var x = 0;
    lookupEncoded.forEach((e) => x += e.length);
    print('Lookup encoded length: $x');

    this.lookup = lookup;
    this.lookupEncoded = lookupEncoded;
    extrinsicMeta = ExtrinsicInfo(
      version: metadata.extrinsic.version,
      addressTy: getTypeRef(definitions, accessibleTypes, metadata.extrinsic.addressType),
      callTy: getTypeRef(definitions, accessibleTypes, metadata.extrinsic.callType),
      signatureTy: getTypeRef(definitions, accessibleTypes, metadata.extrinsic.signatureType),
      signedExtensions: metadata.extrinsic.signedExtensions
          .map((se) => (
                identifier: se.identifier,
                includedInExtrinsic: getTypeRef(definitions, accessibleTypes, se.type),
                includedInSignedData: getTypeRef(definitions, accessibleTypes, se.additionalSigned),
              ))
          .toList(),
    );
  }

  int getBitSequenceBytes(String primitive) {
    switch (primitive) {
      case 'U8':
        return 1;
      case 'U16':
        return 2;
      case 'U32':
        return 4;
      case 'U64':
        return 8;
      default:
        throw Exception('Invalid primitive for BitSequence');
    }
  }

  String compactTypeRefs(String? primitive) {
    return switch (primitive) {
      null => 'void',
      'U8' => 'compactU8',
      'U16' => 'compactU16',
      'U32' => 'compactU32',
      'U64' => 'compactU64',
      'U128' => 'compactU128',
      'U256' => 'compactU256',
      _ => throw Exception('Invalid primitive for compact type'),
    };
  }

  getPrimitive(Map<int, PortableType> definitions, int frameId) {
    final def = definitions[frameId]!.type.typeDef;

    if (def is TypeDefPrimitive) {
      return def.primitive.name;
    }

    if (def is! TypeDefComposite && def is! TypeDefTuple) {
      throw Exception('TypeDef provided does not map to a primitive type');
    }
    // Check if def.value.length > 1 => throws error

    switch (def) {
      case final TypeDefComposite val:
        return val.fields.isEmpty ? null : getPrimitive(definitions, val.fields[0].type);
      case final TypeDefTuple val:
        return val.fields.isEmpty ? null : getPrimitive(definitions, val.fields[0]);
      default:
        throw Exception('TypeDef provided does not map to a primitive type');
    }
  }

  TypeRef getTypeRef(
      Map<int, PortableType> definitions, Map<int, int> accessibleTypes, int frameId) {
    final def = definitions[frameId]!.type.typeDef;

    if (def is TypeDefPrimitive) {
      return TypeRef(tag: def.primitive.name, value: null);
    }

    if (def is TypeDefCompact) {
      final primitive = getPrimitive(definitions, def.type);
      print(primitive);
      final tag = compactTypeRefs(primitive);
      return TypeRef(tag: tag, value: null);
    }

    return accessibleTypes.containsKey(frameId)
        ? TypeRef(tag: 'perId', value: accessibleTypes[frameId]!)
        : TypeRef(tag: 'void', value: null);
  }

  List<dynamic> constructLookupTypeDef(
      Map<int, PortableType> definitions, Map<int, int> accessibleTypes, int frameId) {
    final def = definitions[frameId]!.type.typeDef;

    switch (def) {
      case final TypeDefComposite val:
        return [val];
      //   return [
      //     LookupTypeDef(
      //       tag: 'composite',
      //       value: LookupTypeDefComposite(
      //         fields: val.fields
      //             .map<LookupField>(
      //               (f) => LookupField(
      //                 name: f.name,
      //                 typeName: f.typeName,
      //                 ty: getTypeRef(definitions, accessibleTypes, f.type),
      //               ),
      //             )
      //             .toList(),
      //       ),
      //     )
      //   ];
      case final TypeDefVariant val:
        return val.variants
            .map<TypeDefEnumeration>(
              (v) => TypeDefEnumeration(
                index: v.index,
                name: v.name,
                fields: v.fields,
                docs: v.docs,
              ),
            )
            .toList();
      // return val.variants
      //     .map<LookupTypeDef>(
      //       (v) => LookupTypeDef(
      //         tag: 'enumeration',
      //         value: LookupTypeDefEnumeration(
      //           name: v.name,
      //           index: v.index,
      //           fields: v.fields
      //               .map<LookupField>(
      //                 (field) => LookupField(
      //                   name: field.name,
      //                   typeName: field.typeName,
      //                   ty: getTypeRef(definitions, accessibleTypes, field.type),
      //                 ),
      //               )
      //               .toList(),
      //         ),
      //       ),
      //     )
      //     .toList();
      case final TypeDefSequence val:
        return [val];
      // return [
      //   LookupTypeDef(
      //     tag: 'sequence',
      //     value: getTypeRef(definitions, accessibleTypes, val.type),
      //   ),
      // ];
      case final TypeDefArray val:
        return [val];
      // return [
      //   LookupTypeDef(
      //     tag: 'array',
      //     value: LookupTypeDefArray(
      //       len: val.length,
      //       typeParam: getTypeRef(definitions, accessibleTypes, val.type),
      //     ),
      //   ),
      // ];
      case final TypeDefTuple val:
        return [val];
      // return [
      //   LookupTypeDef(
      //     tag: 'tuple',
      //     value: val.fields
      //         .map<TypeRef>((t) => getTypeRef(definitions, accessibleTypes, t))
      //         .toList(),
      //   ),
      // ];
      case final TypeDefBitSequence val:
        return [val];
      // final primitive = getPrimitive(definitions, val.bitStoreType);
      // final numBytes = getBitSequenceBytes(primitive);
      //
      // final storeOrderPath = definitions[val.bitOrderType]!.type.path;
      // final leastSignificantBitFirst = storeOrderPath.contains('Lsb0');
      // if (!leastSignificantBitFirst && !storeOrderPath.contains('Msb0')) {
      //   throw Exception('Invalid bit order type');
      // }
      //
      // return [
      //   LookupTypeDef(
      //     tag: 'bitSequence',
      //     value: LookupTypeDefBitSequence(
      //       numBytes: numBytes,
      //       leastSignificantBitFirst: leastSignificantBitFirst,
      //     ),
      //   )
      // ];
    }

    throw Exception('FrameId($frameId) should have been filtered out');
  }

  Lookup getLookup(Map<int, PortableType> definitions, Map<int, int> accessibleTypes) {
    final Lookup typeTree = [];

    for (final entry in accessibleTypes.entries) {
      final frameId = entry.key;
      final typeId = entry.value;
      final path = definitions[frameId]!.type.path;

      for (final def in constructLookupTypeDef(definitions, accessibleTypes, frameId)) {
        typeTree.add(LookupEntry(
          path: path,
          typeId: typeId,
          typeDef: def,
        ));
      }
    }

    typeTree.sort((a, b) {
      if (a.typeId != b.typeId) return a.typeId.compareTo(b.typeId);
      if (a.typeDef is! TypeDefEnumeration || b.typeDef is! TypeDefEnumeration) {
        throw Exception('Found two types with same id');
      }

      return (a.typeDef as TypeDefEnumeration)
          .index
          .compareTo((b.typeDef as TypeDefEnumeration).index);
    });

    return typeTree;
  }

  Map<int, int> getAccessibleTypes(Map<int, PortableType> definitions) {
    final Set<int> types = {};

    void collectTypesFromId(int id) {
      if (types.contains(id)) return;

      final def = definitions[id]!.type.typeDef;

      switch (def) {
        case final TypeDefComposite val:
          if (val.fields.isEmpty) break;
          types.add(id);
          for (var f in val.fields) {
            collectTypesFromId(f.type);
          }
          break;
        case final TypeDefVariant val:
          if (val.variants.isEmpty) break;
          types.add(id);
          for (var v in val.variants) {
            for (var f in v.fields) {
              collectTypesFromId(f.type);
            }
          }
          break;
        case final TypeDefTuple val:
          if (val.fields.isEmpty) break;
          types.add(id);
          for (var f in def.fields) {
            collectTypesFromId(f);
          }
          break;
        case final TypeDefSequence val:
          types.add(id);
          collectTypesFromId(val.type);
          break;
        case final TypeDefArray val:
          types.add(id);
          collectTypesFromId(val.type);
          break;
        case final TypeDefBitSequence _:
          types.add(id);
          break;
      }
    }

    collectTypesFromId(metadata.extrinsic.callType);
    collectTypesFromId(metadata.extrinsic.addressType);
    collectTypesFromId(metadata.extrinsic.signatureType);

    for (var ext in metadata.extrinsic.signedExtensions) {
      collectTypesFromId(ext.type);
      collectTypesFromId(ext.additionalSigned);
    }

    final List<int> sorted = types.toList()..sort();
    return sorted.asMap().map((key, value) => MapEntry(value, key));
  }

  dynamic decodePrimitive(Primitive primitive, Input input) {
    switch (primitive) {
      case Primitive.Bool:
        return BoolCodec.codec.decode(input);
      case Primitive.Char:
        return U8Codec.codec.decode(input);
      case Primitive.Str:
        return StrCodec.codec.decode(input);
      case Primitive.U8:
        return U8Codec.codec.decode(input);
      case Primitive.U16:
        return U16Codec.codec.decode(input);
      case Primitive.U32:
        return U32Codec.codec.decode(input);
      case Primitive.U64:
        return U64Codec.codec.decode(input);
      case Primitive.U128:
        return U128Codec.codec.decode(input);
      case Primitive.U256:
        return U256Codec.codec.decode(input);
      case Primitive.I8:
        return I8Codec.codec.decode(input);
      case Primitive.I16:
        return I16Codec.codec.decode(input);
      case Primitive.I32:
        return I32Codec.codec.decode(input);
      case Primitive.I64:
        return I64Codec.codec.decode(input);
      case Primitive.I128:
        return I128Codec.codec.decode(input);
      case Primitive.I256:
        return I256Codec.codec.decode(input);
    }
  }

  Map<String?, dynamic> decodeComposite(TypeDefComposite def, Input input) {
    return {
      for (final f in def.fields)
        f.name: decodeTypeDef(metadata.typeById(f.type).type.typeDef, input)
    };
  }

  List<dynamic> decodeSequence(TypeDefSequence def, Input input) {
    final typeDef = metadata.typeById(def.type).type.typeDef;
    final length = CompactCodec.codec.decode(input);

    return List.generate(length, (i) => decodeTypeDef(typeDef, input));
  }

  List<dynamic>? decodeTuple(TypeDefTuple def, Input input) {
    if (def.fields.isEmpty) return null;

    return List.generate(def.fields.length,
        (i) => decodeTypeDef(metadata.typeById(def.fields[i]).type.typeDef, input));
  }

  List<dynamic> decodeArray(TypeDefArray def, Input input) {
    final typeDef = metadata.typeById(def.type).type.typeDef;

    return List.generate(def.length, (i) => decodeTypeDef(typeDef, input));
  }

  dynamic decodeTypeDef(TypeDef def, Input input) {
    return switch (def) {
      final TypeDefComposite def => decodeComposite(def, input),
      final TypeDefSequence def => decodeSequence(def, input),
      final TypeDefTuple def => decodeTuple(def, input),
      final TypeDefArray def => decodeArray(def, input),
      final TypeDefPrimitive def => decodePrimitive(def.primitive, input),
      _ => throw Exception('TypeDef not supported: ${def.runtimeType}'),
    };
  }

  static MetadataMerkleizer fromMetadata(
    RuntimeMetadata metadata, {
    required int decimals,
    required String tokenSymbol,
  }) {
    return MetadataMerkleizer._(
      metadata: metadata,
      decimals: decimals,
      tokenSymbol: tokenSymbol,
    );
  }

  // Uint8List generateProof() {
  //
  // }

  versionDecoder(Input extrinsic) {
    final value = extrinsic.readBytes(1).first;

    return (
      version: value & ~(1 << 7),
      signed: ((value & (1 << 7)) != 0),
    );
  }

  (int version, bool signed, Uint8List bytes) decodeExtrinsic(Uint8List extrinsic) {
    final input = Input.fromBytes(extrinsic);
    CompactCodec.codec.decode(input);
    final ver = versionDecoder(input);
    final bytes = input.readBytes(input.remainingLength!);

    return (ver.version, ver.signed, bytes);
  }

  Uint8List mergeUint8(List<Uint8List> inputs) {
    final list = Uint8List(inputs.fold<int>(0, (sum, element) => sum + element.length));
    var offset = 0;
    for (final element in inputs) {
      list.setAll(offset, element);
      offset += element.length;
    }
    return list;
  }

  void skipTypeRef(TypeRef ref, Input input) {
    switch (ref.tag) {
      case 'Bool':
      case 'Char':
      case 'U8':
        U8Codec.codec.decode(input);
        break;
      case 'Str':
        StrCodec.codec.decode(input);
        break;
      case 'U16':
        U16Codec.codec.decode(input);
        break;
      case 'U32':
        U32Codec.codec.decode(input);
        break;
      case 'U64':
        U64Codec.codec.decode(input);
        break;
      case 'U128':
        U128Codec.codec.decode(input);
        break;
      case 'U256':
        U256Codec.codec.decode(input);
        break;
      case 'I8':
        I8Codec.codec.decode(input);
        break;
      case 'I16':
        I16Codec.codec.decode(input);
        break;
      case 'I32':
        I32Codec.codec.decode(input);
        break;
      case 'I64':
        I64Codec.codec.decode(input);
        break;
      case 'I128':
        I128Codec.codec.decode(input);
        break;
      case 'I256':
        I256Codec.codec.decode(input);
        break;
      case 'void':
        NullCodec.codec.decode(input);
        break;
      case 'compactU8':
      case 'compactU16':
      case 'compactU32':
      case 'compactU64':
      case 'compactU128':
      case 'compactU256':
        CompactCodec.codec.decode(input);
        break;
      default:
        throw Exception('Unsupported primitive type: ${ref.tag}');
    }
  }

  innerDecodeAndCollect(
      Input input, TypeRef typeRef, Map<int, List<int>> idToLookups, Set<int> collected) {
    // if (current.typeDef ) {
    //   skipTypeRef(typeRef, input);
    //   return;
    // }

    void handleTypeId(TypeRef typeRef) {
      innerDecodeAndCollect(input, typeRef, idToLookups, collected);
    }

    final lookupIdxs = idToLookups[typeRef]!;
    final currentIdx = lookupIdxs[0];
    final current = lookup[currentIdx];

    if (lookupIdxs.length == 1) {
      collected.add(currentIdx);
    }

    switch (current.typeDef) {
      case final TypeDefEnumeration val:
        final selectedIdx = U8Codec.codec.decode(input);
        final result =
            lookupIdxs.map((lookupIdx) => [lookup[lookupIdx].typeDef, lookupIdx]).firstWhere((x) {
          final variant = x[0] as TypeDefEnumeration;
          return variant.index == selectedIdx;
        });

        final collectedIdx = result[1] as int;
        collected.add(collectedIdx);

        final selected = result[0] as TypeDefEnumeration;
        selected.fields.forEach((field) {
          // handleTypeId(field.type);
        });
        break;
      case final TypeDefSequence val:
        final len = CompactBigIntCodec.codec.decode(input).toInt();
        for (var i = 0; i < len; i++) {
          // handleTypeId(val.type);
        }
        break;
      case final TypeDefArray val:
        for (var i = 0; i < val.length; i++) {
          // handleTypeId(val.type);
        }
        break;
      case final TypeDefComposite val:
        // val.fields.forEach((e) => handleTypeId(e.type));
        break;
      case final TypeDefTuple val:
        // val.fields.forEach((e) => handleTypeId(e));
        break;
      case final TypeDefBitSequence val:
        throw Exception('bitSequence is not supported');
    }
  }

  List<int> decodeAndCollectKnownLeafs(
    Uint8List input,
    List<TypeRef> typeRefs,
  ) {
    final idToLookups = <int, List<int>>{};
    for (var i = 0; i < lookup.length; i++) {
      final look = lookup[i];
      final arr = idToLookups[look.typeId];
      if (arr != null) {
        arr.add(i);
      } else {
        idToLookups[look.typeId] = [i];
      }
    }

    final result = <int>{};
    final bytesInput = Input.fromBytes(input);

    for (var i = 0; i < typeRefs.length; i++) {
      final typeRef = typeRefs[i];
      innerDecodeAndCollect(bytesInput, typeRef, idToLookups, result);
    }

    return result.toList()..sort();
  }

  double log2(int x) {
    return log(x) / log(2);
  }

  int getLevelFromIdx(int idx) {
    return log2(idx + 1).floor();
  }

  int jsShift(int value, int shift) {
    int sc = shift % 32;
    if (sc < 0) {
      sc += 32;
    }
    return value >> sc;
  }

  int getAncestorIdx(int from, int nLevels) {
    return jsShift(from + 1, nLevels) - 1;
  }

  getProofData(List<int> knownLeavesIdxs) {
    final knownLeaves = knownLeavesIdxs.map((idx) => lookupEncoded[idx]).toList();

    final startingIdx = lookupEncoded.length - 1;
    final leafIdxs = knownLeavesIdxs.map((idx) => startingIdx + idx).toList();

    final proofIdxs = <int>[];
    if (leafIdxs.isNotEmpty) {
      final nLevels = getLevelFromIdx(leafIdxs.last);
      final splitPosition = pow(2, nLevels) - 1;
      final splitIdx = leafIdxs.indexWhere((x) => x >= splitPosition);

      if (splitIdx > 0) {
        leafIdxs.removeRange(splitIdx, leafIdxs.length);
        leafIdxs.insertAll(0, leafIdxs.sublist(splitIdx));

        knownLeaves.removeRange(splitIdx, knownLeaves.length);
        knownLeaves.insertAll(0, knownLeaves.sublist(splitIdx));
      }
    }

    var targetIdx = 0;
    void traverse(int nodeIdx) {
      if (targetIdx == leafIdxs.length) {
        proofIdxs.add(nodeIdx);
        return;
      }

      final target = leafIdxs[targetIdx];
      if (target == nodeIdx) {
        ++targetIdx;
        return;
      }

      final currentLevel = getLevelFromIdx(nodeIdx);
      final targetLevel = getLevelFromIdx(target);

      if (nodeIdx != getAncestorIdx(target, targetLevel - currentLevel)) {
        proofIdxs.add(nodeIdx);
        return;
      }

      final leftSon = 2 * nodeIdx + 1;
      traverse(leftSon);
      traverse(leftSon + 1);
    }

    traverse(0);

    return (
      leaves: knownLeaves,
      leafIndexes: leafIdxs,
      proofIndexes: proofIdxs,
    );
  }

  Uint8List blake3Hash(Uint8List input) {
    final hasher = Blake3Hasher(32);
    return hasher.hash(input);
  }

  List<Uint8List> getHashTree() {
    if (lookupEncoded.isEmpty) {
      return [Uint8List(32)..fillRange(0, 32, 0)];
    }

    final treeSize = lookupEncoded.length * 2 - 1;
    final hashTree = List<Uint8List>.filled(treeSize, Uint8List(0));

    final leavesStartIdx = lookupEncoded.length - 1;
    for (var i = 0; i < lookupEncoded.length; i++) {
      hashTree[leavesStartIdx + i] = blake3Hash(lookupEncoded[i]);
    }

    for (var i = hashTree.length - 2; i > 0; i -= 2) {
      hashTree[(i - 1) ~/ 2] = blake3Hash(mergeUint8([hashTree[i], hashTree[i + 1]]));
    }

    return hashTree;
  }

  Uint8List generateProof(List<int> knownIndexes) {
    final proofData = getProofData(knownIndexes);
    //  [0, 3, 64, 0, 0, 0, 3, 141, 1]
    //  [0, 3, 64, 0, 0, 0,    141, 1]

    final hashTree = getHashTree();
    final proofs = proofData.proofIndexes.map((idx) => hashTree[idx]).toList();

    return mergeUint8([
      CompactCodec.codec.encode(proofData.leaves.length),
      ...proofData.leaves,
      CompactCodec.codec.encode(proofData.leafIndexes.length),
      ...proofData.leafIndexes.map((x) => U32Codec.codec.encode(x)),
      CompactCodec.codec.encode(proofs.length),
      ...proofs,
      extrinsicMeta.encode(),
      extraInfo.encode(),
    ]);
  }

  Uint8List getProofForExtrinsic(
    Uint8List transaction,
    Uint8List? txAdditionalSigned,
  ) {
    // final (version, signed, bytes) = decodeExtrinsic(transaction);
    //
    // assertion(version == extrinsicMeta.version, 'Incorrect extrinsic version');
    //
    // final List<TypeRef> typeRefs = signed
    //     ? [
    //         extrinsicMeta.addressTy,
    //         extrinsicMeta.signatureTy,
    //         ...extrinsicMeta.signedExtensions.map((x) => x.includedInExtrinsic),
    //         extrinsicMeta.callTy,
    //       ]
    //     : [extrinsicMeta.callTy];
    //
    // if (txAdditionalSigned != null) {
    //   typeRefs.addAll(extrinsicMeta.signedExtensions.map((e) => e.includedInSignedData));
    // }
    //
    // final proofBytes = txAdditionalSigned != null ? mergeUint8([bytes, txAdditionalSigned]) : bytes;
    //
    // return generateProof(decodeAndCollectKnownLeafs(proofBytes, typeRefs));
    return Uint8List(0);
  }
}
