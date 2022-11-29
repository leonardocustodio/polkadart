import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/exceptions/exceptions.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/old/legacy_types_model.dart';
import 'package:substrate_metadata/utils/utils.dart';
import '../storage/storage_item.model.dart';
import 'chain_description.model.dart';

part 'parse_legacy.cached.dart';

@WithCache()
abstract class ParseLegacy implements _$ParseLegacy {
  late scale_codec.TypeRegistry _registry;
  factory ParseLegacy(Metadata metadata, LegacyTypes legacyTypes) =
      _ParseLegacy;

  void _defineCalls() {
    _registry = scale_codec.TypeRegistry(
        types: legacyTypes.types, typesAlias: legacyTypes.typesAlias);
    _defineGenericExtrinsicEra();
    _defineGenericLookupSource();
    _defineOriginCaller();
    _defineGenericCall();
    _defineGenericEvent();
    _defineGenericSignature();
  }

  ChainDescription getChainDescription() {
    _defineCalls();
    var signature = _registry.getIndex('GenericSignature');
    var call = _registry.getIndex('GenericCall');
    var digest = _registry.getIndex('Digest');
    var digestItem = _registry.getIndex('DigestItem');
    var event = _registry.getIndex('GenericEvent');
    var eventRecord = _registry.getIndex('EventRecord');
    var eventRecordList = _registry.getIndex('Vec<EventRecord>');
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
    _registry.define('GenericSignature', () {
      return scale_codec.CompositeType(fields: [
        scale_codec.Field(name: 'address', type: _registry.getIndex('Address')),
        scale_codec.Field(
            name: 'signature', type: _registry.getIndex('ExtrinsicSignature')),
        scale_codec.Field(name: 'signedExtensions', type: _signedExtensions()),
      ]);
    });
  }

  @Cached()
  int _signedExtensions() {
    var fields = <scale_codec.Field>[];
    switch (metadata.kind) {
      case 'V9':
      case 'V10':
        _addSignedExtensionField(fields, 'CheckEra');
        _addSignedExtensionField(fields, 'CheckNonce');
        _addSignedExtensionField(fields, 'ChargeTransactionPayment');
        break;
      case 'V11':
      case 'V12':
      case 'V13':
        for (var name in metadata.value.extrinsic.signedExtensions) {
          _addSignedExtensionField(fields, name);
        }
        break;
      default:
        throw UnexpectedCaseException(metadata.kind);
    }
    return _registry.add(scale_codec.CompositeType(fields: fields));
  }

  void _addSignedExtensionField(List<scale_codec.Field> fields, String name) {
    var type = _getSignedExtensionType(name);
    if (type == null) return;
    fields.add(scale_codec.Field(name: name, type: type));
  }

  int? _getSignedExtensionType(String name) {
    var def = legacyTypes.signedExtensions?[name];
    if (isNotEmpty(def)) {
      return _registry.getIndex(def);
    }
    switch (name) {
      case 'ChargeTransactionPayment':
        return _registry.getIndex('Compact<Balance>');
      case 'CheckMortality':
      case 'CheckEra':
        return _registry.getIndex('ExtrinsicEra');
      case 'CheckNonce':
        return _registry.getIndex('Compact<Index>');
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
      var variants = <scale_codec.Variant>[];

      variants.add(scale_codec.Variant(name: 'Immortal', fields: [], index: 0));

      for (var index = 1; index < 256; index++) {
        variants.add(scale_codec.Variant(
            name: 'Mortal$index',
            fields: [scale_codec.Field(type: _registry.getIndex('U8'))],
            index: index));
      }

      return scale_codec.VariantType(variants: variants);
    });
  }

  void _defineGenericCall() {
    _registry.define('GenericCall', () {
      var variants = <scale_codec.Variant>[];
      _forEachPallet(
        (AnyLegacyModule mod) => mod.calls,
        (AnyLegacyModule mod, int index) {
          variants.add(
            scale_codec.Variant(
              name: mod.name,
              index: index,
              fields: [
                scale_codec.Field(type: _makeCallEnum(mod.name, mod.calls!)),
              ],
            ),
          );
        },
      );
      return scale_codec.VariantType(variants: variants);
    });
  }

  void _defineGenericEvent() {
    _registry.define('GenericEvent', () {
      var variants = <scale_codec.Variant>[];
      _forEachPallet((AnyLegacyModule mod) => mod.events?.length,
          (AnyLegacyModule mod, int index) {
        variants.add(scale_codec.Variant(name: mod.name, index: index, fields: [
          scale_codec.Field(type: _makeEventEnum(mod.name, mod.events!))
        ]));
      });
      return scale_codec.VariantType(variants: variants);
    });
  }

  int _makeEventEnum(String palletName, List<EventMetadataV9> events) {
    var variants =
        events.asMap().entries.map((MapEntry<int, EventMetadataV9> entry) {
      int index = entry.key;
      EventMetadataV9 e = entry.value;
      var fields = e.args.map((arg) {
        return scale_codec.Field(
            type: _registry.getIndex(arg, pallet: palletName));
      }).toList();

      return scale_codec.Variant(
          index: index, name: e.name, fields: fields, docs: e.docs);
    }).toList();
    return _registry.add(scale_codec.VariantType(variants: variants));
  }

  int _makeCallEnum(String palletName, List<FunctionMetadataV9> calls) {
    var variants =
        calls.asMap().entries.map((MapEntry<int, FunctionMetadataV9> entry) {
      var index = entry.key;
      var call = entry.value;
      var fields = call.args.map((arg) {
        return scale_codec.Field(
            name: arg.name,
            type: _registry.getIndex(arg.type, pallet: palletName));
      }).toList();
      return scale_codec.Variant(
          index: index, name: call.name, fields: fields, docs: call.docs);
    }).toList();
    return _registry.add(scale_codec.VariantType(variants: variants));
  }

  void _defineGenericLookupSource() {
    _registry.define('GenericLookupSource', () {
      var variants = <scale_codec.Variant>[];
      for (var i = 0; i < 0xef; i++) {
        variants.add(scale_codec.Variant(name: 'Idx$i', fields: [], index: i));
      }
      variants.add(scale_codec.Variant(
          name: 'IdxU16',
          fields: [scale_codec.Field(type: _registry.getIndex('U16'))],
          index: 0xfc));
      variants.add(scale_codec.Variant(
          name: 'IdxU32',
          fields: [scale_codec.Field(type: _registry.getIndex('U32'))],
          index: 0xfd));
      variants.add(scale_codec.Variant(
          name: 'IdxU64',
          fields: [scale_codec.Field(type: _registry.getIndex('U64'))],
          index: 0xfe));
      variants.add(scale_codec.Variant(
          name: 'AccountId',
          fields: [scale_codec.Field(type: _registry.getIndex('AccountId'))],
          index: 0xff));
      return scale_codec.VariantType(variants: variants);
    });
  }

  @Cached()
  Map<String, Map<String, StorageItem>> _storage() {
    var storage = <String, Map<String, StorageItem>>{};
    _forEachPallet(null, (AnyLegacyModule module, _) {
      dynamic mod = module;
      if (mod?.storage == null) {
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
            keys = [_registry.getIndex(e.type.key, pallet: mod.name)];
            break;
          case 'DoubleMap':
            hashers = [e.type.hasher.kind, e.type.key2Hasher.kind];
            keys = [
              _registry.getIndex(e.type.key1, pallet: mod.name),
              _registry.getIndex(e.type.key2, pallet: mod.name)
            ];
            break;
          case 'NMap':
            keys = e.type.keyVec
                .map((k) => _registry.getIndex(k, pallet: mod.name))
                .toList()
                .cast<int>();
            hashers = e.type.hashers
                .map((h) => h.kind.toString())
                .toList()
                .cast<String>();
            break;
          default:
            throw UnexpectedKindException('Unexpected Kind: ${e.type.kind}.');
        }
        items[e.name] = StorageItem(
            modifier: e.modifier.kind,
            hashers: hashers,
            keys: keys,
            value: _registry.getIndex(e.type.value, pallet: mod.name),
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
            type: _registry.getIndex(c.type, pallet: mod.name),
            value: c.value,
            docs: c.docs);
      }
    });
    return constants;
  }

  void _defineOriginCaller() {
    _registry.define('OriginCaller', () {
      var variants = <scale_codec.Variant>[];
      _forEachPallet(null, (mod, index) {
        var name = mod.name;
        String type;
        switch (name) {
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
        variants.add(scale_codec.Variant(
            name: name,
            index: index,
            fields: [scale_codec.Field(type: _registry.getIndex(type))]));
      });
      return scale_codec.VariantType(
          variants: variants, path: ['OriginCaller']);
    });
  }

  void _forEachPallet(dynamic Function(AnyLegacyModule mod)? filter,
      void Function(AnyLegacyModule mod, int index) cb) {
    switch (metadata.kind) {
      case 'V9':
      case 'V10':
      case 'V11':
        var index = 0;
        for (var mod in metadata.value.modules) {
          if (filter?.call(mod) == null) {
            continue;
          }
          cb(mod, index);
          index += 1;
        }
        return;

      case 'V12':
      case 'V13':
        for (var mod in metadata.value.modules) {
          if (filter?.call(mod) == null) {
            continue;
          }
          cb(mod, mod.index);
        }
        return;
    }
  }
}
