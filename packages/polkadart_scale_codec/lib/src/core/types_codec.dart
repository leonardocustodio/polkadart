import 'package:polkadart_scale_codec/src/core/types.dart';

class CodecStructTypeFields {
  String? name;
  num? type;
}

abstract class CodecStructType {
  final TypeKind kind = TypeKind.Struct;
  List<CodecStructTypeFields> fields = <CodecStructTypeFields>[];
}

class CodecStructVariant {
  final String kind = 'struct';
  String? name;
  int? index;
  CodecStructType? def;
}

class CodecTupleVariant {
  final String kind = 'tuple';
  String? name;
  num? index;
  TupleType? def;
}

class CodecValueVariant {
  final String kind = 'value';
  String? name;
  num? index;
  num? type;
}

class CodecEmptyVariant {
  final String kind = 'empty';
  String? name;
  num? index;
}

enum CodecVariant {
  CodecStructVariant,
  CodecTupleVariant,
  CodecValueVariant,
  CodecEmptyVariant,
}

class CodecVariantType {
  final TypeKind kind = TypeKind.Variant;
  List<CodecVariant?> variants = <CodecVariant?>[];
  Map<String, CodecVariant> variantsByName = <String, CodecVariant>{};
}

class CodecBytesType {
  final TypeKind kind = TypeKind.Bytes;
}

class CodecBytesArrayType {
  final TypeKind kind = TypeKind.BytesArray;
  int? len;
}

class CodecBooleanOptionType {
  final TypeKind kind = TypeKind.BooleanOption;
}

class CodecCompactType {
  final TypeKind kind = TypeKind.Compact;
  Primitive? integer;
}

enum CodecType {
  PrimitiveType,
  SequenceType,
  BitSequenceType,
  ArrayType,
  TupleType,
  OptionType,
  DoNotConstructType,
  CodecCompactType,
  CodecStructType,
  CodecVariantType,
  CodecBytesType,
  CodecBytesArrayType,
  CodecBooleanOptionType,
}

Type getUnwrappedType(List<Type> types, int ti) {
  Type def = types[ti];
  switch (def.kind) {
    case TypeKind.Tuple:
    case TypeKind.Composite:
      return unwrap(def, types);
    default:
      return def;
  }
}

Type unwrap(Type def, List<Type> types, {Set<int>? visited}) {
  int next;
  switch (def.kind) {
    case TypeKind.Tuple:
      if (def.tuple.length == 1) {
        next = def.tuple[0];
        break;
      } else {
        return def;
      }
    case TypeKind.Composite:
      if (def.fields[0]?.name == null) {
        /* 
                var tuple = def.fields.map((t) {
                    assert(t?.name == null);
                    return t.type;
                }).toList(); 
                */
        // TODO: Check this with the above function as if the same working is being done or not.
        var tuple = def.fields.cast<Field>().map((t) => t.type).toList();
        if (tuple.length == 1) {
          next = tuple[0];
          break;
        } else {
          return TupleType()
            ..kind = TypeKind.Tuple
            ..tuple = tuple;
        }
      } else {
        return def;
      }
    default:
      return def;
  }
  if (visited?.contains(next) ?? false) {
    throw Exception('Cycle of tuples involving $next');
  }
  visited = visited ?? <int>{};
  visited.add(next);
  return unwrap(types[next], types, visited: visited);
}
