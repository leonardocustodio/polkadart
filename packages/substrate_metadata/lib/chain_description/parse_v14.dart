import 'package:cached_annotation/cached_annotation.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Type,
        TypeKind,
        CompactType,
        BitSequenceType,
        TupleType,
        CompositeType,
        VariantType,
        SequenceType,
        PrimitiveType,
        ArrayType,
        Field,
        TypeRegistry;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'package:substrate_metadata/exceptions/exceptions.dart';
import 'package:substrate_metadata/models/models.dart';
import 'package:substrate_metadata/utils/utils.dart';

import '../storage/storage_item.model.dart';
import 'chain_description.model.dart';

part 'parse_v14.cached.dart';

@WithCache()
abstract class ParseV14 implements _$ParseV14 {
  factory ParseV14(MetadataV14 metadata) = _ParseV14;

  ChainDescription getChainDescription() {
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
    assertionCheck(digest.kind == TypeKind.Composite);
    for (var field in (digest as CompositeType).fields) {
      if (field.name == 'logs') {
        var seq = _types()[field.type];
        assertionCheck(seq.kind == TypeKind.Sequence);
        return (seq as SequenceType).type;
      }
    }
    throw Exception('Can\'t extract DigestItem from Digest');
  }

  @Cached()
  int _event() {
    var rec = _types()[_eventRecord()];
    assertionCheck(rec.kind == TypeKind.Composite);
    Field? eventField;
    for (var f in (rec as CompositeType).fields) {
      if (f.name == 'event') {
        eventField = f;
        break;
      }
    }
    assertionCheck(eventField != null);
    return eventField!.type;
  }

  @Cached()
  int _eventRecord() {
    var types = _types();
    var eventRecordList = _eventRecordList();
    var seq = types[eventRecordList];
    assertionCheck(seq.kind == TypeKind.Sequence);
    return (seq as SequenceType).type;
  }

  @Cached()
  int _eventRecordList() {
    return _getStorageItem('System', 'Events').value;
  }

  bool _isUnitType(Type type) {
    if (type.kind == TypeKind.Tuple) {
      try {
        return (type as TupleType).tuple.isEmpty;
      } catch (e) {
        rethrow;
      }
    }
    return false;
  }

  @Cached()
  int _signature() {
    List<Type> types = _types();

    Type signedExtensionsType = CompositeType(
      path: ['SignedExtensions'],
      fields: metadata.extrinsic!.signedExtensions
          .map((ext) {
            return Field(name: ext.identifier, type: ext.type!);
          })
          .where((f) => !_isUnitType(types.getUnwrappedType(f.type)))
          .toList(),
    );

    types.add(signedExtensionsType);

    var signedExtensions = types.length - 1;

    Type signatureType = CompositeType(fields: [
      Field(
        name: 'address',
        type: _address(),
      ),
      Field(
        name: 'signature',
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
    final List<int> candidates = <int>[];
    for (var i = 0; i < (metadata.lookup?.types.length ?? 0); i++) {
      var def = metadata.lookup!.types[i].type;
      if (def.path.isNotEmpty &&
          def.path[0] == 'sp_runtime' &&
          def.path.last == 'UncheckedExtrinsic') {
        candidates.add(i);
      }
    }
    switch (candidates.length) {
      case 0:
        throw Exception('Failed to find UncheckedExtrinsic type in metadata');
      case 1:
        return candidates[0];
      default:
        return metadata.extrinsic?.type != null &&
                candidates.contains(metadata.extrinsic!.type!)
            ? metadata.extrinsic!.type!
            : candidates[0];
    }
  }

  int _getTypeParameter(int ti, int idx) {
    var def = metadata.lookup!.types[ti];
    if (def.type.params.length <= idx) {
      var name = def.type.path.isNotEmpty ? def.type.path.join('::') : '$ti';
      throw Exception(
          'Type $name should have at least ${idx + 1} type parameter${idx > 0 ? 's' : ''}');
    }
    return assertNotNull(def.type.params[idx].type);
  }

  StorageItem _getStorageItem(String prefix, String name) {
    var storage = _storage();
    var item = storage[prefix]?[name];
    return assertNotNull(item, 'Can\'t find $prefix.$name storage item');
  }

  @Cached()
  Map<String, Map<String, StorageItem>> _storage() {
    var storage = <String, Map<String, StorageItem>>{};
    metadata.pallets?.forEach((pallet) {
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
              assertionCheck(keyDef.kind == TypeKind.Tuple);
              assertionCheck(
                  (keyDef as TupleType).tuple.length == hashers.length);
              keys = keyDef.tuple;
            }
            break;
          default:
            throw UnexpectedKindException('Unexpected kind: ${e.type.kind}.');
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
    metadata.pallets?.forEach((pallet) {
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
    List<Type> typesValue = metadata.lookup?.types.map((PortableTypeV14 t) {
          var info = {'path': t.type.path, 'docs': t.type.docs};
          var def = t.type.def;
          switch (def.kind) {
            case 'Primitive':
              return PrimitiveType(
                primitive: (def as Si1TypeDef_Primitive).value.kind,
                path: info['path'],
                docs: info['docs'],
              );
            case 'Compact':
              // ignore: unnecessary_cast
              return CompactType(
                type: (def as Si1TypeDef_Compact).value.type,
                path: info['path'],
                docs: info['docs'],
              ) as Type;
            case 'Sequence':
              return SequenceType(
                type: (def as Si1TypeDef_Sequence).value.type,
                path: info['path'],
                docs: info['docs'],
              );
            case 'BitSequence':
              return BitSequenceType(
                bitStoreType:
                    (def as Si1TypeDef_BitSequence).value.bitStoreType,
                bitOrderType: def.value.bitOrderType,
                path: info['path'],
                docs: info['docs'],
              );
            case 'Array':
              return ArrayType(
                type: (def as Si1TypeDef_Array).value.type,
                length: def.value.len,
                path: info['path'],
                docs: info['docs'],
              );
            case 'Tuple':
              return TupleType(
                tuple: (def as Si1TypeDef_Tuple).value,
                path: info['path'],
                docs: info['docs'],
              );
            case 'Composite':
              return CompositeType(
                fields: (def as Si1TypeDef_Composite).value.fields,
                path: info['path'],
                docs: info['docs'],
              );
            case 'Variant':
              return VariantType(
                variants: (def as Si1TypeDef_Variant).value.variants,
                path: info['path'],
                docs: info['docs'],
              );
            default:
              throw UnexpectedCaseException(def.kind);
          }
        }).toList() ??
        <Type>[];
    return TypeRegistry().normalizeMetadataTypes(typesValue);
  }
}
