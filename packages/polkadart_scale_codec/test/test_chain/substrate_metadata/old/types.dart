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
  final Map<String, dynamic>? types;
  final OldTypesAlias? typesAlias;
  final Map<String, String>? signedExtensions;

  const OldTypes({this.types, this.typesAlias, this.signedExtensions});
}

//export type SpecVersionRange = [minInclusive: number | null, maxInclusive: number | null]
class SpecVersionRange extends ListMixin<int?> {
  @override
  int length = 2;

  final List<int?> _data = List<int?>.filled(2, null);

  SpecVersionRange(List<int?> value) {
    assertionCheck(value.length == 2);
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

  const OldTypesWithSpecVersionRange(
      {required this.minmax,
      Map<String, dynamic>? types,
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
      Map<String, dynamic>? types,
      OldTypesAlias? typesAlias,
      Map<String, String>? signedExtensions})
      : super(
            types: types,
            typesAlias: typesAlias,
            signedExtensions: signedExtensions);
}
