
class CodecStructTypeFields {
  String? name;
  num? type;
}
abstract class CodecStructType {
    final TypeKind kind= TypeKind.Struct;
    List<CodecStructTypeFields> fields = <CodecStructTypeFields>[];
}


class CodecStructVariant {
    final String kind = 'struct';
    String? name;
    int? index;
    CodecStructType? def;
}


class CodecTupleVariant {
    final String kind =  'tuple';
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


enum CodecVariant {CodecStructVariant , CodecTupleVariant , CodecValueVariant , CodecEmptyVariant ,}


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
    PrimitiveType ,
    SequenceType ,
    BitSequenceType ,
    ArrayType ,
    TupleType ,
    OptionType ,
    DoNotConstructType ,
    CodecCompactType ,
    CodecStructType ,
    CodecVariantType ,
    CodecBytesType ,
    CodecBytesArrayType ,
    CodecBooleanOptionType,}


Type getUnwrappedType(List<Type>  types, int ti) {
    Type def = types[ti];
    switch(def.kind) {
        case TypeKind.Tuple:
        case TypeKind.Composite:
            return unwrap(def, types);
        default:
            return def;
    }
}


Type unwrap(Type def, List<Type> types, {Set<int>? visited}) {
     int next;
    switch(def.kind) {
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
                  return TupleType()..kind = TypeKind.Tuple
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


CodecType getCodecType(List<Type> types, int ti) {
    let def = getUnwrappedType(types, ti)
    switch(def.kind) {
        case TypeKind.Sequence:
            if (isPrimitive('U8', types, def.type)) {
                return {kind: TypeKind.Bytes}
            } else {
                return def
            }
        case TypeKind.Array:
            if (isPrimitive('U8', types, def.type)) {
                return {kind: TypeKind.BytesArray, len: def.len}
            } else {
                return def
            }
        // https://github.com/substrate-developer-hub/substrate-docs/issues/1061
        // case TypeKind.Option:
        //     if (isPrimitive('Bool', types, def.type)) {
        //         return {kind: TypeKind.BooleanOption}
        //     } else {
        //         return def
        //     }
        case TypeKind.Compact: {
            let type = getUnwrappedType(types, def.type)
            switch(type.kind) {
                case TypeKind.Tuple:
                    assert(type.tuple.length == 0)
                    return type
                case TypeKind.Primitive:
                    assert(type.primitive[0] == 'U')
                    return {kind: TypeKind.Compact, integer: type.primitive}
                default:
                    throwUnexpectedCase(type.kind)
            }
        }
        case TypeKind.Composite:
            return {
                kind: TypeKind.Struct,
                fields: def.fields.map(f => {
                    let name = assertNotNull(f.name)
                    return {name, type: f.type}
                })
            }
        case TypeKind.Variant: {
            let variants = def.variants.filter(v => v != null) as Variant[]
            let variantsByName: Record<string, CodecVariant> = {}
            let uniqueIndexes = new Set(variants.map(v => v.index))
            if (uniqueIndexes.size != variants.length) {
                throw new Error(`Variant type ${ti} has duplicate case indexes`)
            }
            let len = variants.reduce((len, v) => Math.max(len, v.index), 0) + 1
            let placedVariants: (CodecVariant | undefined)[] = new Array(len)
            variants.forEach(v => {
                let cv: CodecVariant
                if (v.fields[0]?.name == null) {
                    switch(v.fields.length) {
                        case 0:
                            cv = {kind: 'empty', name: v.name, index: v.index}
                            break
                        case 1:
                            cv = {kind: 'value', name: v.name, index: v.index, type: v.fields[0].type}
                            break
                        default:
                            cv = {
                                kind: 'tuple',
                                name: v.name,
                                index: v.index,
                                def: {
                                    kind: TypeKind.Tuple,
                                    tuple: v.fields.map(f => {
                                        assert(f.name == null)
                                        return f.type
                                    })
                                }
                            }
                    }
                } else {
                    cv = {
                        kind: 'struct',
                        name: v.name,
                        index: v.index,
                        def: {
                            kind: TypeKind.Struct,
                            fields: v.fields.map(f => {
                                let name = assertNotNull(f.name)
                                return {name, type: f.type}
                            })
                        }
                    }
                }
                placedVariants[v.index] = cv
                variantsByName[cv.name] = cv
            })
            return {
                kind: TypeKind.Variant,
                variants: placedVariants,
                variantsByName
            }
        }
        default:
            return def
    }
}


function isPrimitive(primitive: Primitive, types: Type[], ti: Ti): boolean {
    let type = getUnwrappedType(types, ti)
    return type.kind == TypeKind.Primitive && type.primitive == primitive
}


import 'package:scale_codec/src/core/types.dart';

export function toCodecTypes(types: Type[]): CodecType[] {
    let codecTypes: CodecType[] = new Array(types.length)
    for (let i = 0; i < types.length; i++) {
        codecTypes[i] = getCodecType(types, i)
    }
    return codecTypes
}
