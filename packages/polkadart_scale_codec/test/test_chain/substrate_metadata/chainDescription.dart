// ignore_for_file: file_names, no_leading_underscores_for_local_identifiers

import 'dart:typed_data';
import 'package:polkadart_scale_codec/src/util/utils.dart';

import '../utils/common_utils.dart';
import './old/types.dart';
import 'old/type_registry.dart';
import 'util.dart';
import 'types.dart';
import 'models/models.dart';
import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'storage.dart';

part 'chainDescription.cached.dart';

class ChainDescription {
  final List<Type> types;
  final int call;
  final int digest;
  final int digestItem;
  final int event;
  final int eventRecord;
  final int eventRecordList;
  final int signature;
  final Map<String, Map<String, StorageItem>> storage;
  final Map<String, Map<String, Constant>> constants;

  const ChainDescription({
    required this.types,
    required this.call,
    required this.digest,
    required this.digestItem,
    required this.event,
    required this.eventRecord,
    required this.eventRecordList,
    required this.signature,
    required this.storage,
    required this.constants,
  });
}

class Constant {
  final int type;
  final Uint8List value;
  final List<String> docs;
  const Constant({required this.type, required this.value, required this.docs});
}

ChainDescription getChainDescriptionFromMetadata(
    Metadata metadata, OldTypes? oldTypes) {
  switch (metadata.kind) {
    case "V9":
    case "V10":
    case "V11":
    case "V12":
    case "V13":
      scale.assertNotNull(oldTypes,
          msg: 'Type definitions are required for metadata ${metadata.kind}');
      return FromOld(metadata, oldTypes!).convert();
    case "V14":
      return FromV14((metadata as Metadata_V14).value).convert();
    default:
      throw Exception('Unsupported metadata version: ${metadata.kind}');
  }
}

@WithCache()
abstract class FromV14 implements _$FromV14 {
  factory FromV14(MetadataV14 _metadata) = _FromV14;

  ChainDescription convert() {
    return ChainDescription(
        types: _types(),
        call: _call(),
        digest: _digest(),
        digestItem: _digestItem(),
        event: _event(),
        eventRecord: _eventRecord(),
        eventRecordList: _eventRecordList(),
        signature: _signature(),
        storage: _storage(),
        constants: _constants());
  }

  @Cached()
  int _digest() {
    return _getStorageItem('System', 'Digest').value;
  }

  @Cached()
  int _digestItem() {
    var digest = _types()[_digest()];
    scale.assertionCheck(digest.kind == scale.TypeKind.Composite);
    for (var field in (digest as CompositeType).fields) {
      if (field.name == 'logs') {
        var seq = _types()[field.type];
        scale.assertionCheck(seq.kind == scale.TypeKind.Sequence);
        return (seq as SequenceType).type;
      }
    }
    throw Exception('Can\'t extract DigestItem from Digest');
  }

  @Cached()
  int _event() {
    var rec = _types()[_eventRecord()];
    scale.assertionCheck(rec.kind == scale.TypeKind.Composite);
    Field? eventField;
    for (var f in (rec as CompositeType).fields) {
      if (f.name == 'event') {
        eventField = f;
        break;
      }
    }
    scale.assertionCheck(eventField != null);
    return eventField!.type;
  }

  @Cached()
  int _eventRecord() {
    var types = _types();
    var eventRecordList = _eventRecordList();
    var seq = types[eventRecordList];
    scale.assertionCheck(seq.kind == scale.TypeKind.Sequence);
    return (seq as SequenceType).type;
  }

  @Cached()
  int _eventRecordList() {
    return _getStorageItem('System', 'Events').value;
  }

  @Cached()
  int _signature() {
    var types = _types();

    Type signedExtensionsType = CompositeType(
      path: ['SignedExtensions'],
      fields: _metadata.extrinsic!.signedExtensions
          .map((ext) {
            return Field(name: ext.identifier, type: ext.type!);
          })
          .where((f) => !isUnitType(scale.getUnwrappedType(types, f.type)))
          .toList(),
    );

    types.add(signedExtensionsType);

    var signedExtensions = types.length - 1;

    Type signatureType = CompositeType(fields: [
      Field(
        name: "address",
        type: _address(),
      ),
      Field(
        name: "signature",
        type: _extrinsicSignature(),
      ),
      Field(name: 'signedExtensions', type: signedExtensions),
    ], path: [
      'ExtrinsicSignature'
    ]);
    types.add(signatureType);
    return types.length - 1;
  }

  @Cached()
  int _address() {
    return _getTypeParameter(_uncheckedExtrinsic(), 0);
  }

  @Cached()
  int _call() {
    return _getTypeParameter(_uncheckedExtrinsic(), 1);
  }

  @Cached()
  int _extrinsicSignature() {
    return _getTypeParameter(_uncheckedExtrinsic(), 2);
  }

  @Cached()
  int _uncheckedExtrinsic() {
    for (var i = 0; i < (_metadata.lookup?.types.length ?? 0); i++) {
      var def = _metadata.lookup!.types[i].type;
      if (def.path.isNotEmpty &&
          def.path[0] == 'sp_runtime' &&
          def.path.last == 'UncheckedExtrinsic') {
        return i;
      }
    }
    throw Exception('Failed to find UncheckedExtrinsic type in metadata');
  }

  int _getTypeParameter(int ti, int idx) {
    var def = _metadata.lookup!.types[ti];
    if (def.type.params.length <= idx) {
      var name = def.type.path.isNotEmpty ? def.type.path.join('::') : '$ti';
      throw Exception(
          'Type $name should have at least ${idx + 1} type parameter${idx > 0 ? 's' : ''}');
    }
    return scale.assertNotNull(def.type.params[idx].type);
  }

  StorageItem _getStorageItem(String prefix, String name) {
    var storage = _storage();
    var item = storage[prefix]?[name];
    return scale.assertNotNull(item,
        msg: 'Can\'t find $prefix.$name storage item');
  }

  @Cached()
  Map<String, Map<String, StorageItem>> _storage() {
    var storage = <String, Map<String, StorageItem>>{};
    _metadata.pallets?.forEach((pallet) {
      if (pallet.storage == null) {
        return;
      }
      var items = storage[pallet.storage!.prefix] = <String, StorageItem>{};
      for (var e in pallet.storage!.items) {
        var hashers = <String>[];
        List<int> keys;
        switch (e.type.kind) {
          case 'Plain':
            hashers = [];
            keys = [];
            break;
          case 'Map':
            hashers = (e.type as StorageEntryTypeV14_Map)
                .hashers
                .map((h) => h.kind)
                .toList();
            if (hashers.length == 1) {
              keys = [(e.type as StorageEntryTypeV14_Map).key];
            } else {
              var keyDef = _types()[(e.type as StorageEntryTypeV14_Map).key];
              scale.assertionCheck(keyDef.kind == scale.TypeKind.Tuple);
              scale.assertionCheck(
                  (keyDef as TupleType).tuple.length == hashers.length);
              keys = keyDef.tuple;
            }
            break;
          default:
            throw scale.UnexpectedCaseException();
        }
        items[e.name] = StorageItem(
            modifier: e.modifier.kind,
            hashers: hashers,
            keys: keys,
            value: e.type.value,
            fallback: e.fallback,
            docs: e.docs);
      }
    });
    return storage;
  }

  @Cached()
  Map<String, Map<String, Constant>> _constants() {
    var constants = <String, Map<String, Constant>>{};
    _metadata.pallets?.forEach((pallet) {
      for (var c in pallet.constants) {
        var pc = constants[pallet.name] ??
            (constants[pallet.name] = <String, Constant>{});
        pc[c.name] = Constant(type: c.type, value: c.value, docs: c.docs);
      }
    });
    return constants;
  }

  @Cached()
  List<Type> _types() {
    List<Type> types = _metadata.lookup?.types.map((t) {
          var info = {'path': t.type.path, 'docs': t.type.docs};
          var def = t.type.def;
          switch (def.kind) {
            case 'Primitive':
              return PrimitiveType(
                primitive: (def as Si1TypeDef_Primitive).value.kind,
                path: info['path'],
                docs: info['docs'],
              );
            case "Compact":
              return CompactType(
                type: (def as Si1TypeDef_Compact).value.type,
                path: info['path'],
                docs: info['docs'],
              );
            case "Sequence":
              return SequenceType(
                type: (def as Si1TypeDef_Sequence).value.type,
                path: info['path'],
                docs: info['docs'],
              );
            case "BitSequence":
              return BitSequenceType(
                bitStoreType:
                    (def as Si1TypeDef_BitSequence).value.bitStoreType,
                bitOrderType: def.value.bitOrderType,
                path: info['path'],
                docs: info['docs'],
              );
            case "Array":
              return ArrayType(
                type: (def as Si1TypeDef_Array).value.type,
                len: def.value.len,
                path: info['path'],
                docs: info['docs'],
              );
            case "Tuple":
              return TupleType(
                tuple: (def as Si1TypeDef_Tuple).value,
                path: info['path'],
                docs: info['docs'],
              );
            case "Composite":
              return CompositeType(
                fields: (def as Si1TypeDef_Composite).value.fields,
                path: info['path'],
                docs: info['docs'],
              );
            case "Variant":
              return VariantType(
                variants: (def as Si1TypeDef_Variant).value.variants,
                path: info['path'],
                docs: info['docs'],
              );
            default:
              throw scale.UnexpectedCaseException(def.kind);
          }
        }).toList() ??
        <Type>[];

    return normalizeMetadataTypes(types);
  }
}

@WithCache()
abstract class FromOld implements _$FromOld {
  late OldTypeRegistry _registry;
  factory FromOld(Metadata _metadata, OldTypes _oldTypes) = _FromOld;

  ///
  /// TODO: find a way to generate constructor with initialization
  ///
  /// _FromOld(this._metadata, this._oldTypes) {
  ///   _registry = OldTypeRegistry(_oldTypes);
  ///   _defineGenericExtrinsicEra();
  ///   _defineGenericLookupSource();
  ///   _defineOriginCaller();
  ///   _defineGenericCall();
  ///   _defineGenericEvent();
  ///   _defineGenericSignature();
  /// }
  ///

  ChainDescription convert() {
    var signature = _registry.use('GenericSignature');
    var call = _registry.use('GenericCall');
    var digest = _registry.use('Digest');
    var digestItem = _registry.use('DigestItem');
    var event = _registry.use('GenericEvent');
    var eventRecord = _registry.use('EventRecord');
    var eventRecordList = _registry.use('Vec<EventRecord>');
    var storage = _storage();
    var constants = _constants();

    return ChainDescription(
        types: _registry.getTypes(),
        call: call,
        digest: digest,
        digestItem: digestItem,
        event: event,
        eventRecord: eventRecord,
        eventRecordList: eventRecordList,
        signature: signature,
        storage: storage,
        constants: constants);
  }

  void _defineGenericSignature() {
    _registry.define("GenericSignature", () {
      return CompositeType(fields: [
        Field(name: "address", type: _registry.use("Address")),
        Field(name: "signature", type: _registry.use("ExtrinsicSignature")),
        Field(name: 'signedExtensions', type: _signedExtensions()),
      ]);
    });
  }

  @Cached()
  int _signedExtensions() {
    var fields = <Field>[];
    switch (_metadata.kind) {
      case "V9":
      case "V10":
        _addSignedExtensionField(fields, 'CheckEra');
        _addSignedExtensionField(fields, 'CheckNonce');
        _addSignedExtensionField(fields, 'ChargeTransactionPayment');
        break;
      case "V11":
      case "V12":
      case "V13":
        for (var name in _metadata.value.extrinsic.signedExtensions) {
          _addSignedExtensionField(fields, name);
        }
        break;
      default:
        throw UnexpectedCaseException(_metadata.kind);
    }
    return _registry.add(CompositeType(fields: fields));
  }

  void _addSignedExtensionField(List<Field> fields, String name) {
    var type = _getSignedExtensionType(name);
    if (type == null) return;
    fields.add(Field(name: name, type: type));
  }

  int? _getSignedExtensionType(String name) {
    var def = _oldTypes.signedExtensions?[name];
    if (isNotEmpty(def)) {
      return _registry.use(def);
    }
    switch (name) {
      case 'ChargeTransactionPayment':
        return _registry.use('Compact<Balance>');
      case 'CheckMortality':
      case 'CheckEra':
        return _registry.use('ExtrinsicEra');
      case 'CheckNonce':
        return _registry.use('Compact<Index>');
      case 'CheckBlockGasLimit':
      case 'CheckGenesis':
      case 'CheckNonZeroSender':
      case 'CheckSpecVersion':
      case 'CheckTxVersion':
      case 'CheckVersion':
      case 'CheckWeight':
      case 'LockStakingStatus':
      case 'ValidateEquivocationReport':
        return null;
      default:
        throw Exception('Unknown signed extension: $name');
    }
  }

  void _defineGenericExtrinsicEra() {
    _registry.define('GenericExtrinsicEra', () {
      var variants = <Variant>[];

      variants.add(Variant(name: 'Immortal', fields: [], index: 0));

      for (var index = 1; index < 256; index++) {
        variants.add(Variant(
            name: 'Mortal$index',
            fields: [Field(type: _registry.use('U8'))],
            index: index));
      }

      return VariantType(variants: variants);
    });
  }

  void _defineGenericCall() {
    _registry.define('GenericCall', () {
      var variants = <Variant>[];
      _forEachPallet((AnyOldModule mod) => mod.calls,
          (AnyOldModule mod, int index) {
        variants.add(Variant(
            name: mod.name,
            index: index,
            fields: [Field(type: _makeCallEnum(mod.name, mod.calls!))]));
      });
      return VariantType(variants: variants);
    });
  }

  void _defineGenericEvent() {
    _registry.define('GenericEvent', () {
      var variants = <Variant>[];
      _forEachPallet((AnyOldModule mod) => mod.events?.length,
          (AnyOldModule mod, int index) {
        variants.add(Variant(
            name: mod.name,
            index: index,
            fields: [Field(type: _makeEventEnum(mod.name, mod.events!))]));
      });
      return VariantType(variants: variants);
    });
  }

  int _makeEventEnum(String palletName, List<EventMetadataV9> events) {
    var variants =
        events.asMap().entries.map((MapEntry<int, EventMetadataV9> entry) {
      int index = entry.key;
      EventMetadataV9 e = entry.value;
      var fields = e.args.map((arg) {
        return Field(type: _registry.use(arg, pallet: palletName));
      }).toList();

      return Variant(index: index, name: e.name, fields: fields, docs: e.docs);
    }).toList();
    return _registry.add(VariantType(variants: variants));
  }

  int _makeCallEnum(String palletName, List<FunctionMetadataV9> calls) {
    var variants =
        calls.asMap().entries.map((MapEntry<int, FunctionMetadataV9> entry) {
      var index = entry.key;
      var call = entry.value;
      var fields = call.args.map((arg) {
        return Field(
            name: arg.name, type: _registry.use(arg.type, pallet: palletName));
      }).toList();
      return Variant(
          index: index, name: call.name, fields: fields, docs: call.docs);
    }).toList();
    return _registry.add(VariantType(variants: variants));
  }

  void _defineGenericLookupSource() {
    _registry.define('GenericLookupSource', () {
      var variants = <Variant>[];
      for (var i = 0; i < 0xef; i++) {
        variants.add(Variant(name: 'Idx$i', fields: [], index: i));
      }
      variants.add(Variant(
          name: 'IdxU16',
          fields: [Field(type: _registry.use('U16'))],
          index: 0xfc));
      variants.add(Variant(
          name: 'IdxU32',
          fields: [Field(type: _registry.use('U32'))],
          index: 0xfd));
      variants.add(Variant(
          name: 'IdxU64',
          fields: [Field(type: _registry.use('U64'))],
          index: 0xfe));
      variants.add(Variant(
          name: 'AccountId',
          fields: [Field(type: _registry.use('AccountId'))],
          index: 0xff));
      return VariantType(variants: variants);
    });
  }

  @Cached()
  Map<String, Map<String, StorageItem>> _storage() {
    var storage = <String, Map<String, StorageItem>>{};
    _forEachPallet(null, (AnyOldModule _mod, _) {
      dynamic mod = _mod;
      if (mod.storage == null) {
        return;
      }
      var items = <String, StorageItem>{};
      items = storage[mod.storage.prefix] ?? <String, StorageItem>{};
      mod.storage.items.forEach((e) {
        var hashers = <String>[];
        var keys = <int>[];
        switch (e.type.kind) {
          case 'Plain':
            break;
          case 'Map':
            hashers = [e.type.hasher.kind];
            keys = [_registry.use(e.type.key, pallet: mod.name)];
            break;
          case 'DoubleMap':
            hashers = [e.type.hasher.kind, e.type.key2Hasher.kind];
            keys = [
              _registry.use(e.type.key1, pallet: mod.name),
              _registry.use(e.type.key2, pallet: mod.name)
            ];
            break;
          case 'NMap':
            keys = e.type.keyVec
                .map((k) => _registry.use(k, pallet: mod.name))
                .toList()
                .cast<int>();
            hashers = e.type.hashers
                .map((h) => h.kind.toString())
                .toList()
                .cast<String>();
            break;
          default:
            throw UnexpectedCaseException();
        }
        items[e.name] = StorageItem(
            modifier: e.modifier.kind,
            hashers: hashers,
            keys: keys,
            value: _registry.use(e.type.value, pallet: mod.name),
            fallback: e.fallback,
            docs: e.docs);
      });
      storage[mod.storage.prefix] = items;
    });
    return storage;
  }

  @Cached()
  Map<String, Map<String, Constant>> _constants() {
    var constants = <String, Map<String, Constant>>{};
    _forEachPallet(null, (mod, _) {
      for (var c in mod.constants) {
        constants[mod.name] ??= <String, Constant>{};
        var pc = constants[mod.name]!;
        pc[c.name] = Constant(
            type: _registry.use(c.type, pallet: mod.name),
            value: c.value,
            docs: c.docs);
      }
    });
    return constants;
  }

  void _defineOriginCaller() {
    _registry.define('OriginCaller', () {
      var variants = <Variant>[];
      _forEachPallet(null, (mod, index) {
        // TODO: Check if no-usage of name is making any issue ??
        // ignore: unused_local_variable
        var name = mod.name;
        String type;
        switch (mod.name) {
          case 'Authority':
            type = 'AuthorityOrigin';
            break;
          case 'Council':
          case 'TechnicalCommittee':
          case 'GeneralCouncil':
            type = 'CollectiveOrigin';
            break;
          case 'System':
            type = 'SystemOrigin';
            name = 'system';
            break;
          case 'Xcm':
          case 'XcmPallet':
            type = 'XcmOrigin';
            break;
          default:
            return;
        }
        variants.add(Variant(
            name: mod.name,
            index: index,
            fields: [Field(type: _registry.use(type))]));
      });
      return VariantType(variants: variants, path: ['OriginCaller']);
    });
  }

  void _forEachPallet(dynamic Function(AnyOldModule mod)? filter,
      void Function(AnyOldModule mod, int index) cb) {
    switch (_metadata.kind) {
      case 'V9':
      case 'V10':
      case 'V11':
        var index = 0;
        for (var mod in _metadata.value.modules) {
          if (filter != null && !isNotEmpty(filter(mod))) {
            continue;
          }
          cb(mod, index);
          index += 1;
        }
        return;

      case 'V12':
      case 'V13':
        for (var mod in _metadata.value.modules) {
          if (filter != null && !isNotEmpty(filter(mod))) {
            continue;
          }
          cb(mod, mod.index);
        }
        return;
    }
  }
}
