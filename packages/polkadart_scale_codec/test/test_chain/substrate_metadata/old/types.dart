import 'dart:collection';
import '../../utils/assertion_check.dart';

abstract class OldTypeDefinition {}

class OldTypeExp extends OldTypeDefinition {
  final String value;
  OldTypeExp(this.value);
}

class OldStructDefinition extends MapMixin<String, String>
    with OldTypeDefinition {
  final Map<String, String> data;
  OldStructDefinition(this.data);

  @override
  String? operator [](Object? key) {
    return data[key];
  }

  @override
  void operator []=(String key, String value) {
    data[key] = value;
  }

  @override
  void clear() {
    data.clear();
  }

  @override
  Iterable<String> get keys => data.keys;

  @override
  String? remove(Object? key) {
    return data.remove(key);
  }

  Map<String, String> toMap() => data;
}

class OldEnumDefinition extends OldTypeDefinition {
  /// Types allowed `enum_`: List<String> or Map<dynamic, dynamic>
  dynamic enum_;

  /// any type allowed
  dynamic set_;
  OldEnumDefinition({this.set_, required this.enum_}) {
    assertionCheck(enum_ is List<String> || enum_ is Map);
  }
}

class SetDefinition {
  final int bitLength_;
  const SetDefinition({required this.bitLength_});
}

class OldSetDefinition extends OldTypeDefinition {
  SetDefinition set_;
  dynamic enum_;

  OldSetDefinition({required this.set_, this.enum_});
}

class OldTypesAlias extends MapMixin<String, Map<String, String>> {
  final _pallet = <String, Map<String, String>>{};

  @override
  Map<String, String>? operator [](Object? key) {
    return _pallet[key];
  }

  @override
  void operator []=(String key, Map<String, String> value) {
    _pallet[key] = value;
  }

  @override
  void clear() {
    _pallet.clear();
  }

  @override
  Iterable<String> get keys => _pallet.keys;

  @override
  Map<String, String>? remove(Object? key) {
    return _pallet.remove(key);
  }
}

class OldTypes {
  final Map<String, OldTypeDefinition>? types;
  final OldTypesAlias? typesAlias;
  final Map<String, String>? signedExtensions;

  const OldTypes({this.types, this.typesAlias, this.signedExtensions});
}

//export type SpecVersionRange = [minInclusive: number | null, maxInclusive: number | null]
class SpecVersionRange extends ListMixin<int?> {
  @override
  int length = 2;

  final _data = List<int?>.filled(2, null);

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

  const OldTypesWithSpecVersionRange(
      {required this.minmax,
      Map<String, OldTypeDefinition>? types,
      OldTypesAlias? typesAlias,
      Map<String, String>? signedExtensions})
      : super(
            types: types,
            typesAlias: typesAlias,
            signedExtensions: signedExtensions);
}

class OldTypesBundle extends OldTypes {
  final List<OldTypesWithSpecVersionRange>? versions;

  const OldTypesBundle(
      {required this.versions,
      Map<String, OldTypeDefinition>? types,
      OldTypesAlias? typesAlias,
      Map<String, String>? signedExtensions})
      : super(
            types: types,
            typesAlias: typesAlias,
            signedExtensions: signedExtensions);
}
