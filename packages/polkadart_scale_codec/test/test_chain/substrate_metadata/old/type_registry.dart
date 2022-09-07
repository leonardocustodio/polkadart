// ignore_for_file: file_names
import '../../utils/common_utils.dart';
import '../types.dart';
import '../util.dart';
import 'package:utility/utility.dart';
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;
import 'types.dart' as old;
import './type_exp.dart' as texp;

class TypeAlias {
  int kind = -1;
  int alias;
  String name;

  TypeAlias({required this.alias, required this.name});
}

typedef TypeCallback = Type Function();

class OldTypeRegistry {
  /// [Private]
  ///
  /// Allowed list types: `Type` or `TypeAlias`
  final List<dynamic> _types = <dynamic>[];

  /// [Private]
  ///
  /// HashMap to store already looked data and traverse back easily
  final Map<String, int> _lookup = <String, int>{};

  /// [Private]
  ///
  /// Allowed list types: `Type` or `TypeAlias`
  final Map<String, TypeCallback> _definitions = <String, TypeCallback>{};

  late old.OldTypes _oldTypes;

  OldTypeRegistry(old.OldTypes oldTypes) {
    _oldTypes = oldTypes;
  }

  List<Type> getTypes() {
    _replaceAliases();
    return normalizeMetadataTypes(_types.cast<Type>());
  }

  void _replaceAliases() {
    var types = _types;
    var seen = <int>{};

    Type replace(int ti) {
      var a = types[ti];
      if (a is Type || (a as TypeAlias).kind != -1) {
        return a;
      }
      if (seen.contains(ti)) {
        throw Exception('Cycle of non-constructable types involving ${a.name}');
      } else {
        seen.add(ti);
      }
      var type = replace(a.alias);
      type.path = [a.name];
      return types[ti] = type;
    }

    for (var ti = 0; ti < types.length; ti++) {
      replace(ti);
    }
  }

  void define(String typeName, TypeCallback fn) {
    _definitions[typeName] = fn;
  }

  int use(dynamic typeExp, {String? pallet}) {
    texp.Type type;
    if (typeExp is String) {
      type = texp.parse(typeExp);
      type = _normalizeType(type, pallet);
    } else {
      type = typeExp;
    }

    // No Worries here as toString() is implemented in type_exp.dart at line [12]
    var key = type.toString();
    var ti = _lookup[key];
    if (ti == null) {
      _types.add(DoNotConstructType());
      ti = _types.length - 1;
      _lookup[key] = ti;
      _types[ti] = _buildScaleType(type);
    }
    return ti;
  }

  texp.Type _normalizeType(texp.Type type, String? pallet) {
    switch (type.kind) {
      case "array":
        return texp.ArrayType(
          item: _normalizeType((type as texp.ArrayType).item, pallet),
          len: type.len,
        );
      case "tuple":
        return texp.TupleType(
          params: (type as texp.TupleType)
              .params
              .map(
                (item) => _normalizeType(item, pallet),
              )
              .toList(),
        );
      default:
        return _normalizeNamedType(type as texp.NamedType, pallet);
    }
  }

  texp.Type _normalizeNamedType(texp.NamedType type, String? pallet) {
    if (pallet != null) {
      var section = pallet.camelCase;
      var alias = _oldTypes.typesAlias?[section]?[type.name];
      if (isNotEmpty(alias)) {
        return texp.NamedType(
          name: alias!,
          params: [],
        );
      }
    }

    if (isNotEmpty(_oldTypes.types?[type.name])) {
      return texp.NamedType(
        name: type.name,
        params: [],
      );
    }

    var primitive = asPrimitive(type.name);
    if (primitive != null) {
      assertNoParams(type);
      return texp.NamedType(
        name: primitive.name,
        params: [],
      );
    }

    switch (type.name) {
      case 'Null':
        return texp.TupleType(
          params: [],
        );
      case 'UInt':
        return texp.NamedType(
          name: convertGenericIntegerToPrimitive('U', type),
          params: [],
        );
      case 'Int':
        return texp.NamedType(
          name: convertGenericIntegerToPrimitive('I', type),
          params: [],
        );
      case 'Box':
        return _normalizeType(assertOneParam(type), pallet);
      case 'Bytes':
        assertNoParams(type);

        return texp.NamedType(
          name: 'Vec',
          params: [
            texp.NamedType(
              name: 'U8',
              params: [],
            ),
          ],
        );
      case 'Vec':
      case 'VecDeque':
      case 'WeakVec':
      case 'BoundedVec':
      case 'WeakBoundedVec':
        {
          var param = _normalizeType(assertOneParam(type), pallet);
          return texp.NamedType(
            name: 'Vec',
            params: [param],
          );
        }
      case 'BTreeMap':
      case 'BoundedBTreeMap':
        {
          var list = assertTwoParams(type);
          var key = list[0];
          var val = list[1];
          return _normalizeType(
              texp.NamedType(
                name: 'Vec',
                params: [
                  texp.TupleType(params: [key, val])
                ],
              ),
              pallet);
        }
      case 'BTreeSet':
      case 'BoundedBTreeSet':
        return _normalizeType(
            texp.NamedType(name: 'Vec', params: [assertOneParam(type)]),
            pallet);
      case 'RawAddress':
        return _normalizeType(
            texp.NamedType(
              name: 'Address',
              params: [],
            ),
            pallet);
      case 'PairOf':
      case 'Range':
      case 'RangeInclusive':
        {
          var param = _normalizeType(assertOneParam(type), pallet);
          return texp.TupleType(params: [param, param]);
        }
      default:
        return texp.NamedType(
            name: type.name,
            params: type.params
                .map((p) => p is int ? p : _normalizeType(p, pallet))
                .toList());
    }
  }

  Type _buildScaleType(texp.Type type) {
    switch (type.kind) {
      case 'named':
        return _buildNamedType(type as texp.NamedType);
      case 'array':
        return _buildArray(type as texp.ArrayType);
      case 'tuple':
        return _buildTuple(type as texp.TupleType);
      default:
        throw scale.UnexpectedCaseException(type.kind);
    }
  }

  Type _buildNamedType(texp.NamedType type) {
    if (_definitions[type.name] != null) {
      return _definitions[type.name]!();
    }

    var def = _oldTypes.types?[type.name];
    if (isNotEmpty(def)) {
      return _buildFromDefinition(type.name, def);
    }

    var primitive = asPrimitive(type.name);
    if (primitive != null) {
      assertNoParams(type);
      return PrimitiveType(primitive: primitive);
    }

    switch (type.name) {
      case 'DoNotConstruct':
        return DoNotConstructType();
      case 'Vec':
        var param = use(assertOneParam(type));
        return SequenceType(type: param);

      case 'BitVec':
        return BitSequenceType(
          bitStoreType: use('U8'),
          bitOrderType: -1,
        );
      case 'Option':
        {
          var param = use(assertOneParam(type));
          return OptionType(type: param);
        }
      case 'Result':
        {
          var list = assertTwoParams(type);
          var ok = list[0];
          var error = list[1];

          return VariantType(variants: [
            Variant(index: 0, name: 'Ok', fields: [Field(type: use(ok))]),
            Variant(index: 1, name: 'Err', fields: [Field(type: use(error))])
          ]);
        }
      case 'Compact':
        return CompactType(type: use(assertOneParam(type)));
    }

    throw Exception('Type ${type.name} is not defined');
  }

  ///
  /// Returns `Type` or `TypeAlias`
  ///
  dynamic _buildFromDefinition(String typeName, old.OldTypeDefinition def) {
    Type result;
    if (def is String) {
      return TypeAlias(
        alias: use(def),
        name: typeName,
      );
    } else if (def is old.OldEnumDefinition && def.enum_ != null) {
      result = _buildEnum(def);
    } else if (def is old.OldSetDefinition && isNotEmpty(def.set_.bitLength_)) {
      return _types[_buildSet(def)];
    } else {
      result = _buildStruct(def as old.OldStructDefinition);
    }
    result.path = [typeName];
    return result;
  }

  int _buildSet(old.OldSetDefinition def) {
    var len = def.set_.bitLength_ == 0 ? 8 : def.set_.bitLength_;
    switch (len) {
      case 8:
      case 16:
      case 32:
      case 64:
      case 128:
      case 256:
        return use('U$len');
      default:
        scale.assertionCheck(len % 8 == 0, 'bit length must me aligned');
        return use('[u8; ${len / 8}]');
    }
  }

  Type _buildEnum(old.OldEnumDefinition def) {
    var variants = <Variant>[];
    if (def.enum_ is List) {
      for (var index = 0; index < def.enum_.length; index++) {
        variants.add(
          Variant(name: def.enum_[index], index: index, fields: []),
        );
      }
    } else if (isIndexedEnum(def)) {
      for (var entry in (def.enum_ as Map<String, int>).entries) {
        variants.add(Variant(name: entry.key, index: entry.value, fields: []));
      }
    } else {
      var index = 0;
      for (var name in (def.enum_ as Map).keys) {
        var type = def.enum_[name];
        var fields = <Field>[];
        if (type is String) {
          fields.add(Field(type: use(type)));
        } else if (type != null) {
          scale.assertionCheck(type is old.OldStructDefinition);
          for (var key in (type as old.OldStructDefinition).keys) {
            fields.add(Field(name: key, type: use(type[key])));
          }
        }
        variants.add(Variant(
          name: name,
          index: index,
          fields: fields,
        ));
        index += 1;
      }
    }
    return VariantType(variants: variants);
  }

  Type _buildStruct(old.OldStructDefinition def) {
    var fields = <Field>[];
    for (var name in def.data.keys) {
      fields.add(Field(name: name, type: use(def[name])));
    }
    return CompositeType(
      fields: fields,
    );
  }

  Type _buildArray(texp.ArrayType type) {
    return ArrayType(type: use(type.item), len: type.len);
  }

  Type _buildTuple(texp.TupleType type) {
    return TupleType(tuple: type.params.map((p) => use(p)).toList());
  }

  int add(Type type) {
    _types.add(type);
    return _types.length - 1;
  }

  Type get(int ti) {
    return scale.assertNotNull(_types[ti]);
  }
}

bool isIndexedEnum(old.OldEnumDefinition def) {
  if (def.enum_ is! Map) {
    return false;
  }
  for (var key in def.enum_) {
    if (def.enum_[key] is! int) {
      return false;
    }
  }
  return true;
}

texp.Type assertOneParam(texp.NamedType type) {
  if (type.params.isEmpty) {
    throw Exception(
        'Invalid type ${type.toString()}: one type parameter expected');
  }
  var param = type.params[0];
  if (param is int) {
    throw Exception(
        'Invalid type ${type.toString()}: type parameter should refer to a type, not to bit size');
  }
  return param;
}

List<texp.Type> assertTwoParams(texp.NamedType type) {
  if (type.params.length < 2) {
    throw Exception(
        'Invalid type ${type.toString()}: two type parameters expected');
  }
  var param1 = type.params[0];
  if (param1 is int) {
    throw Exception(
        'Invalid type ${type.toString()}: first type parameter should refer to a type, not to bit size');
  }
  var param2 = type.params[1];
  if (param2 is int) {
    throw Exception(
        'Invalid type ${type.toString()}: second type parameter should refer to a type, not to bit size');
  }
  return [param1, param2];
}

void assertNoParams(texp.NamedType type) {
  if (type.params.isNotEmpty) {
    throw Exception(
        'Invalid type ${type.toString()}: no type parameters expected for ${type.name}');
  }
}

String convertGenericIntegerToPrimitive(String kind, texp.NamedType type) {
  if (type.params.isEmpty) {
    throw Exception(
        'Invalid type ${type.toString()}: bit size is not specified');
  }
  var size = type.params[0];
  if (size is int) {
    throw Exception(
        'Invalid type ${type.toString()}: bit size expected as a first type parameter, e.g. ${type.name}<32>');
  }
  switch (size) {
    case 8:
    case 16:
    case 32:
    case 64:
    case 128:
    case 256:
      return '$kind$size';
    default:
      throw Exception(
          'Invalid type ${type.toString()}: invalid bit size $size');
  }
}

scale.Primitive? asPrimitive(String name) {
  switch (name.toLowerCase()) {
    case 'i8':
      return scale.Primitive.I8;
    case 'u8':
      return scale.Primitive.U8;
    case 'i16':
      return scale.Primitive.I16;
    case 'u16':
      return scale.Primitive.U16;
    case 'i32':
      return scale.Primitive.I32;
    case 'u32':
      return scale.Primitive.U32;
    case 'i64':
      return scale.Primitive.I64;
    case 'u64':
      return scale.Primitive.U64;
    case 'i128':
      return scale.Primitive.I128;
    case 'u128':
      return scale.Primitive.U128;
    case 'i256':
      return scale.Primitive.I256;
    case 'u256':
      return scale.Primitive.U256;
    case 'bool':
      return scale.Primitive.Bool;
    case 'str':
    case 'text':
      return scale.Primitive.Str;
    default:
      return null;
  }
}
