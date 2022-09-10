// ignore_for_file: file_names

import 'dart:typed_data';
import './old/types.dart' as old;
import 'util.dart';
import 'types.dart';
import 'models/models.dart';
import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'storage.dart';

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
    Metadata metadata, old.OldTypes? oldTypes) {
  switch (metadata.kind) {
    // TODO: Uncomment and correct this function.
    /* case "V9":
        case "V10":
        case "V11":
        case "V12":
        case "V13":
            scale.assertionCheck(isNotEmpty(oldTypes), 'Type definitions are required for metadata ${metadata.kind}');
            return FromOld(metadata, oldTypes).convert(); */
    case "V14":
      return FromV14((metadata as Metadata_V14).value).convert();
    default:
      throw Exception('Unsupported metadata version: ${metadata.kind}');
  }
}

class FromV14 {
  late final MetadataV14 _metadata;

  FromV14(MetadataV14 metadata) : _metadata = metadata;

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
          .where(
              (f) => !isUnitType(scale.getUnwrappedType(types, f.type) as Type))
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
    List<Type> types = _metadata.lookup!.types.map((t) {
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
            bitStoreType: (def as Si1TypeDef_BitSequence).value.bitStoreType,
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
            // TODO: correct below line
            //fields: (def as Si1TypeDef_Composite).value.fields,
            path: info['path'],
            docs: info['docs'],
          );
        case "Variant":
          return VariantType(
            // TODO: correct below line
            // variants: (def as Si1TypeDef_Variant).value.variants,
            path: info['path'],
            docs: info['docs'],
          );
        default:
          throw scale.UnexpectedCaseException(def.kind);
      }
    }).toList();

    return normalizeMetadataTypes(types);
  }
}
