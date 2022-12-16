// ignore_for_file: overridden_fields

import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    as scale_codec;
import 'types_hashing.dart' show getTypeHash;
import 'utils/utils.dart';

class Definition extends scale_codec.Variant {
  final String pallet;
  Definition({
    super.fields = const <scale_codec.Field>[],
    required super.index,
    required this.pallet,
    required super.name,
    super.docs,
  });
}

/// Event Registry
class EventRegistry {
  final _definitions = <String, Definition>{};

  Map<String, Definition> get definitions => _definitions;

  final _hashes = <String, String>{};
  late List<scale_codec.Type> _types;

  EventRegistry(List<scale_codec.Type> types, int index) {
    _types = types;
    final scale_codec.Type pallet = types[index];
    assertionCheck(pallet.kind == scale_codec.TypeKind.Variant);

    for (var pallet in (pallet as scale_codec.VariantType).variants) {
      assertionCheck(pallet.fields.length == 1);
      var palletType = types[pallet.fields[0].type];
      assertionCheck(palletType.kind == scale_codec.TypeKind.Variant);
      for (var def in (palletType as scale_codec.VariantType).variants) {
        _definitions['${pallet.name}.${def.name}'] = Definition(
          fields: def.fields,
          index: def.index,
          pallet: pallet.name,
          name: def.name,
          docs: def.docs,
        );
      }
    }
  }

  Definition get(String name) {
    if (_definitions[name] == null) {
      throw Exception('$name not found');
    }
    return _definitions[name]!;
  }

  String getHash(String name) {
    var hash = _hashes[name];
    if (hash == null) {
      return _hashes[name] = _computeHash(name);
    } else {
      return hash;
    }
  }

  String _computeHash(String name) {
    var def = get(name);
    var fields = def.fields.map((f) {
      return <String, dynamic>{
        'name': f.name,
        'type': getTypeHash(_types, f.type)
      };
    });
    return sha256(fields);
  }
}
