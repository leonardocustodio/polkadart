import 'dart:collection';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;

abstract class OldTypeDefinition {}

class OldTypesAlias extends MapMixin<String, Map<String, String>> {
  final Map<String, Map<String, String>> data;

  OldTypesAlias(this.data);

  @override
  Map<String, String>? operator [](Object? key) {
    return data[key];
  }

  @override
  void operator []=(String key, Map<String, String> value) {
    data[key] = value;
  }

  @override
  void clear() {
    data.clear();
  }

  @override
  Iterable<String> get keys => data.keys;

  @override
  Map<String, String>? remove(Object? key) {
    return data.remove(key);
  }
}

class OldTypes {
  Map<String, dynamic>? types;
  OldTypesAlias? typesAlias;
  Map<String, String>? signedExtensions;

  OldTypes({this.types, this.typesAlias, this.signedExtensions});

  static OldTypes fromMap(Map<String, dynamic> map) {
    return OldTypes(
        types: map['types'],
        typesAlias: OldTypesAlias(map['typesAlias']),
        signedExtensions: map['signedExtensions']);
  }
}

class SpecVersionRange extends ListMixin<int?> {
  @override
  int length = 2;

  final List<int?> _data = List<int?>.filled(2, null);

  SpecVersionRange(List<int?> value) {
    scale.assertionCheck(value.length == 2);
    _data[0] = value[0];
    _data[1] = value[1];
  }

  @override
  int? operator [](int index) {
    return _data[index];
  }

  @override
  void operator []=(int index, int? value) {
    _data[index] = value;
  }
}

class OldTypesWithSpecVersionRange extends OldTypes {
  final SpecVersionRange minmax;

  OldTypesWithSpecVersionRange(
      {required this.minmax,
      super.types,
      super.typesAlias,
      super.signedExtensions});

  static OldTypesWithSpecVersionRange fromMap(Map<String, dynamic> map) {
    return OldTypesWithSpecVersionRange(
        minmax: SpecVersionRange((map['minmax'] as List).cast<int?>()),
        types: map['types'],
        typesAlias:
            map['typesAlias'] == null ? null : OldTypesAlias(map['typesAlias']),
        signedExtensions: map['signedExtensions']);
  }
}

class OldTypesBundle extends OldTypes {
  List<OldTypesWithSpecVersionRange>? versions;

  OldTypesBundle(
      {this.versions, super.types, super.typesAlias, super.signedExtensions});

  static OldTypesBundle fromMap(Map<String, dynamic> map) {
    var obj = OldTypesBundle(
        types: map['types'], signedExtensions: map['signedExtensions']);

    if (map['versions'] != null) {
      obj.versions = (map['versions'] as List)
          .map((value) => OldTypesWithSpecVersionRange.fromMap(value))
          .toList();
    }
    if (map['typesAlias'] != null) {
      obj.typesAlias = OldTypesAlias(map['typesAlias']);
    }

    return obj;
  }
}
