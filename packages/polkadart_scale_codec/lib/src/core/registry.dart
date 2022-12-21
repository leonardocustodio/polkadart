part of polkadart_scale_codec_core;

typedef TypeCallback = Type Function();

class TypeRegistry {
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
  /// HashMap to store index of already looked ([typeExp] as String).
  /// So as to look back and quickly pin-point the index of the desired types to be used.
  final Map<String, int> _fastLookup = <String, int>{};

  /// [Private]
  ///
  /// Allows to add custom Definitions by
  final Map<String, TypeCallback> _definitions = <String, TypeCallback>{};

  Map<String, Map<String, String>>? typesAlias;
  Map<String, dynamic>? types;

  ///
  /// Constructor to initialize TypeRegistry Object
  TypeRegistry({this.types, this.typesAlias});

  void select(dynamic typeExp, {String? pallet}) =>
      _use(typeExp, pallet: pallet);

  int getIndex(dynamic typeExp, {String? pallet}) =>
      _use(typeExp, pallet: pallet);

  List<Type> getTypes() {
    _replaceAliases();
    return normalizeMetadataTypes(_types.cast<Type>());
  }

  List<Type> normalizeMetadataTypes(List<Type> types) {
    types = _fixWrapperKeepOpaqueTypes(types);
    types = _fixU256Structs(types);
    types = _introduceOptionType(types);
    types = _eliminateOptionsChain(types);
    types = _removeUnitFieldsFromStructs(types);
    types = _replaceUnitOptionWithBoolean(types);
    types = _normalizeFieldNames(types);
    return types;
  }

  List<Type> _fixWrapperKeepOpaqueTypes(List<Type> types) {
    var u8 = types.length;
    var replaced = false;
    types = types.map((Type type) {
      if (!isNotEmpty(type.path?.length)) {
        return type;
      }
      if (type.path!.last != 'WrapperKeepOpaque') {
        return type;
      }
      if (type.kind != TypeKind.Composite) {
        return type;
      }
      if (type is CompositeType && type.fields.length != 2) {
        return type;
      }
      if (type is CompositeType &&
          types[type.fields[0].type].kind != TypeKind.Compact) {
        return type;
      }
      replaced = true;
      return SequenceType(type: u8);
    }).toList();
    if (replaced) {
      types.add(PrimitiveType(primitive: Primitive.U8));
    }
    return types;
  }

  //
  // Reference: https://github.com/subsquid/squid-sdk/blob/5ece47edd3bd8da88643cc6a735b13eea2a5eeb6/substrate/substrate-metadata/src/util.ts#L46
  List<Type> _fixU256Structs(List<Type> types) {
    return types.map((type) {
      bool isU256 = false;
      //
      // Check if type.path is not null and not empty
      if (type.path != null && type.path!.isNotEmpty) {
        //
        // Check if the last element of type.path is 'U256'
        // and type.kind is TypeKind.Composite
        // and type.fields.length is 1
        if (type.path!.last == 'U256' &&
            type.kind == TypeKind.Composite &&
            (type as CompositeType).fields.length == 1) {
          final Type field = types[type.fields[0].type];
          //
          // Check if field.kind is TypeKind.Array
          // and field.length is 4
          if (field.kind == TypeKind.Array &&
              (field as ArrayType).length == 4) {
            final Type element = types[field.type];
            //
            // Check if element.kind is TypeKind.Primitive
            // and element.primitive is Primitive.U64
            if (element.kind == TypeKind.Primitive &&
                (element as PrimitiveType).primitive == Primitive.U64) {
              isU256 = true;
            }
          }
        }
      }

      if (isU256) {
        return PrimitiveType(primitive: Primitive.U256);
      }
      return type;
    }).toList();
  }

  List<Type> _introduceOptionType(List<Type> types) {
    return types.map((Type type) {
      if (_isOptionType(type) && type is VariantType) {
        return OptionType(
          type: type.variants[1].fields[0].type,
          docs: type.docs,
          path: type.path,
        );
      } else {
        return type;
      }
    }).toList();
  }

  bool _isOptionType(Type type) {
    if (type.kind != TypeKind.Variant) {
      return false;
    }
    if (type is VariantType && type.variants.length != 2) {
      return false;
    }
    var v0 = (type as VariantType).variants[0];
    var v1 = type.variants[1];
    return v0.name == 'None' &&
        v0.fields.isEmpty &&
        v0.index == 0 &&
        v1.name == 'Some' &&
        v1.index == 1 &&
        v1.fields.length == 1 &&
        v1.fields[0].name == null;
  }

  List<Type> _eliminateOptionsChain(List<Type> types) {
    return types.map((Type type) {
      if (type.kind != TypeKind.Option) {
        return type;
      }
      final int param = (type as OptionType).type;
      if (types[param].kind != TypeKind.Option) {
        return type;
      }
      return VariantType(
        variants: [
          Variant(
            name: 'None',
            index: 0,
            fields: [],
          ),
          Variant(
            name: 'Some',
            index: 1,
            fields: [Field(type: param)],
          ),
        ],
      );
    }).toList();
  }

  List<Type> _removeUnitFieldsFromStructs(List<Type> types) {
    var changed = true;
    while (changed) {
      changed = false;
      types = types
          .map((Type type) {
            switch (type.kind) {
              case TypeKind.Composite:
                if ((type as CompositeType).fields.isEmpty ||
                    type.fields[0].name == null) {
                  return type;
                }
                var fields = type.fields.where((f) {
                  var fieldType = types.getUnwrappedType(f.type);
                  return !_isUnitType(fieldType);
                }).toList();
                if (fields.length == type.fields.length) {
                  return type;
                }
                changed = true;

                return CompositeType(
                  path: type.path,
                  docs: type.docs,
                  fields: fields,
                );

              case TypeKind.Variant:
                var variants = (type as VariantType).variants.map((v) {
                  if (v.fields.isEmpty || v.fields[0].name == null) {
                    return v;
                  }
                  var fields = v.fields.where((Field f) {
                    var fieldType = types.getUnwrappedType(f.type);
                    return !_isUnitType(fieldType);
                  }).toList();

                  if (fields.length == v.fields.length) {
                    return v;
                  }
                  if (fields.isNotEmpty && v.fields[0].name == null) {
                    return v;
                  }
                  changed = true;

                  return Variant(
                    fields: fields,
                    docs: v.docs,
                    index: v.index,
                    name: v.name,
                  );
                }).toList();

                return VariantType(
                  variants: variants,
                  path: type.path,
                  docs: type.docs,
                );
              default:
                return type;
            }
          })
          .toList()
          .cast<Type>();
    }
    return types;
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

  List<Type> _replaceUnitOptionWithBoolean(List<Type> types) {
    return types.map((Type type) {
      if (type.kind == TypeKind.Option &&
          _isUnitType(types.getUnwrappedType((type as OptionType).type))) {
        return PrimitiveType(
          primitive: Primitive.Boolean,
          path: type.path,
          docs: type.docs,
        );
      } else {
        return type;
      }
    }).toList();
  }

  List<Type> _normalizeFieldNames(List<Type> types) {
    return types
        .map((Type type) {
          switch (type.kind) {
            case TypeKind.Composite:
              return CompositeType(
                  path: type.path,
                  docs: type.docs,
                  fields: (type as CompositeType).fields);
            case TypeKind.Variant:
              return VariantType(
                path: type.path,
                docs: type.docs,
                variants: (type as VariantType)
                    .variants
                    .map((Variant v) => Variant(
                          index: v.index,
                          name: v.name,
                          docs: v.docs,
                          fields: v.fields,
                        ))
                    .toList(),
              );
            default:
              return type;
          }
        })
        .toList()
        .cast();
  }

  void define(String typeName, TypeCallback fn) {
    _definitions[typeName] = fn;
  }

  void _replaceAliases() {
    var types = _types;
    var seen = <int>{};

    Type replace(int index) {
      var a = types[index];
      if (a is Type || (a is Map && a['kind'] != -1)) {
        return a;
      }
      assertionCheck(a is Map);
      if (seen.contains(index)) {
        throw Exception(
            'Cycle of non-constructable types involving ${a['name']}');
      } else {
        seen.add(index);
      }
      var type = replace(a['alias']);
      type.path = [a['name']];
      return types[index] = type;
    }

    for (var index = 0; index < types.length; index++) {
      replace(index);
    }
  }

  int _use(dynamic typeExp, {String? pallet}) {
    RegistryType type;
    if (typeExp is String) {
      if (_fastLookup[typeExp] != null) {
        return _fastLookup[typeExp]!;
      }
      type = TypeExpParser(typeExp).parse();
      type = _normalizeType(type, pallet);
    } else {
      type = typeExp;
    }

    // No Worries here as `toString()` is implemented in type_exp.dart at line [14]
    // It will return parsed string instead of Object's Name.
    var key = type.toString();
    var index = _lookup[key];
    if (index == null) {
      _types.add(DoNotConstructType());
      index = _types.length - 1;
      _lookup[key] = index;
      _fastLookup[typeExp is String ? typeExp : key] = index;
      _types[index] = _buildScaleType(type);
    }
    return index;
  }

  RegistryType _normalizeType(RegistryType type, String? pallet) {
    switch (type.kind) {
      case "array":
        return RegistryArrayType(
          item: _normalizeType((type as RegistryArrayType).item, pallet),
          length: type.length,
        );
      case "tuple":
        return RegistryTupleType(
          params: (type as RegistryTupleType).params.map((item) {
            return _normalizeType(item, pallet);
          }).toList(),
        );
      default:
        return _normalizeNamedType(type as RegistryNamedType, pallet);
    }
  }

  RegistryType _normalizeNamedType(RegistryNamedType type, String? pallet) {
    if (pallet != null) {
      var section = pallet.camelCase;
      var alias = typesAlias?[section]?[type.name];
      if (isNotEmpty(alias)) {
        return RegistryNamedType(
          name: alias!,
          params: [],
        );
      }
    }

    if (isNotEmpty(types?[type.name])) {
      return RegistryNamedType(
        name: type.name,
        params: [],
      );
    }

    var primitive = asPrimitive(type.name);
    if (primitive != null) {
      assertNoParams(type);
      return RegistryNamedType(
        name: primitive.name,
        params: [],
      );
    }

    switch (type.name) {
      case 'Null':
        return RegistryTupleType(
          params: [],
        );
      case 'UInt':
        return RegistryNamedType(
          name: convertGenericIntegerToPrimitive('U', type),
          params: [],
        );
      case 'Int':
        return RegistryNamedType(
          name: convertGenericIntegerToPrimitive('I', type),
          params: [],
        );
      case 'Box':
        return _normalizeType(assertOneParam(type), pallet);
      case 'Bytes':
        assertNoParams(type);

        return RegistryNamedType(
          name: 'Vec',
          params: [
            RegistryNamedType(
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
          return RegistryNamedType(
            name: 'Vec',
            params: [param],
          );
        }
      case 'BTreeMap':
      case 'BoundedBTreeMap':
        {
          var list = assertTwoParams(type);
          var key = list[0];
          var value = list[1];
          return _normalizeType(
              RegistryNamedType(
                name: 'Vec',
                params: [
                  RegistryTupleType(params: [key, value])
                ],
              ),
              pallet);
        }
      case 'BTreeSet':
      case 'BoundedBTreeSet':
        return _normalizeType(
            RegistryNamedType(name: 'Vec', params: [assertOneParam(type)]),
            pallet);
      case 'RawAddress':
        return _normalizeType(
            RegistryNamedType(
              name: 'Address',
              params: [],
            ),
            pallet);
      case 'PairOf':
      case 'Range':
      case 'RangeInclusive':
        {
          var param = _normalizeType(assertOneParam(type), pallet);
          return RegistryTupleType(params: [param, param]);
        }
      default:
        return RegistryNamedType(
            name: type.name,
            params: type.params
                .map((p) => p is int ? p : _normalizeType(p, pallet))
                .toList());
    }
  }

  dynamic _buildScaleType(RegistryType type) {
    switch (type.kind) {
      case 'named':
        return _buildNamedType(type as RegistryNamedType);
      case 'array':
        return _buildArray(type as RegistryArrayType);
      case 'tuple':
        return _buildTuple(type as RegistryTupleType);
      default:
        throw UnexpectedCaseException(
            'Unexpected RegistryTypeKind: ${type.kind}.');
    }
  }

  dynamic _buildNamedType(RegistryNamedType type) {
    if (_definitions[type.name] != null) {
      return _definitions[type.name]!();
    }
    var def = types?[type.name];
    if (def != null) {
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
        var param = _use(assertOneParam(type));
        return SequenceType(type: param);

      case 'BitVec':
        return BitSequenceType(
          bitStoreType: _use('U8'),
          bitOrderType: -1,
        );
      case 'Option':
        {
          var param = _use(assertOneParam(type));
          return OptionType(type: param);
        }
      case 'Result':
        {
          var list = assertTwoParams(type);
          var ok = list[0];
          var error = list[1];

          return VariantType(variants: [
            Variant(index: 0, name: 'Ok', fields: [Field(type: _use(ok))]),
            Variant(index: 1, name: 'Err', fields: [Field(type: _use(error))])
          ]);
        }
      case 'Compact':
        return CompactType(type: _use(assertOneParam(type)));
    }

    throw Exception('Type ${type.name} is not defined');
  }

  ///
  /// Returns `Type` or `Map`
  ///
  dynamic _buildFromDefinition(String typeName, dynamic def) {
    Type result;
    if (def is String) {
      return <String, dynamic>{
        'kind': -1,
        'alias': _use(def),
        'name': typeName,
      };
    } else if (def is Map && def['_enum'] != null) {
      result = _buildEnum(def);
    } else if (def is Map && def['_set'] != null) {
      return _types[_buildSet(def)];
    } else if (def is Map && def['_struct'] != null) {
      return _buildStruct(def['_struct']);
    } else {
      result = _buildStruct(def);
    }
    result.path = [typeName];
    return result;
  }

  int _buildSet(dynamic def) {
    var length =
        (def?['_set']?['_bitLength'] ?? 0) == 0 ? 8 : def['_set']['_bitLength'];
    switch (length) {
      case 8:
      case 16:
      case 32:
      case 64:
      case 128:
      case 256:
        return _use('U$length');
      default:
        assertionCheck(length % 8 == 0, 'bit length must me aligned');
        return _use('[u8; ${length / 8}]');
    }
  }

  Type _buildEnum(dynamic def) {
    var variants = <Variant>[];
    if (def['_enum'] is List) {
      for (var index = 0; index < (def['_enum'] as List).length; index++) {
        variants.add(
          Variant(name: def['_enum'][index], index: index, fields: []),
        );
      }
    } else if (isIndexedEnum(def)) {
      for (var entry in (def['_enum'] as Map<String, int>).entries) {
        variants.add(Variant(name: entry.key, index: entry.value, fields: []));
      }
    } else {
      var index = 0;
      for (var name in (def['_enum'] as Map).keys) {
        var type = def['_enum'][name];
        var fields = <Field>[];
        if (type is String) {
          fields.add(Field(type: _use(type)));
        } else if (type != null) {
          assertionCheck(type is Map);
          for (var key in (type as Map).keys) {
            fields.add(Field(name: key, type: _use(type[key])));
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

  Type _buildStruct(Map def) {
    var fields = <Field>[];
    for (var name in def.keys) {
      fields.add(Field(name: name, type: _use(def[name])));
    }
    return CompositeType(
      fields: fields,
    );
  }

  Type _buildArray(RegistryArrayType type) {
    return ArrayType(type: _use(type.item), length: type.length);
  }

  Type _buildTuple(RegistryTupleType type) {
    return TupleType(tuple: type.params.map((p) => _use(p)).toList());
  }

  int add(Type type) {
    _types.add(type);
    return _types.length - 1;
  }

  Type get(int index) {
    return assertNotNull(_types[index]);
  }
}

bool isIndexedEnum(dynamic def) {
  if (def['_enum'] is! Map) {
    return false;
  }
  for (var key in (def['_enum'] as Map).keys) {
    if (def['_enum'][key] is! int) {
      return false;
    }
  }
  return true;
}

RegistryType assertOneParam(RegistryNamedType type) {
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

List<RegistryType> assertTwoParams(RegistryNamedType type) {
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

void assertNoParams(RegistryNamedType type) {
  if (type.params.isNotEmpty) {
    throw Exception(
        'Invalid type ${type.toString()}: no type parameters expected for ${type.name}');
  }
}

String convertGenericIntegerToPrimitive(String kind, RegistryNamedType type) {
  if (type.params.isEmpty) {
    throw Exception(
        'Invalid type ${type.toString()}: bit size is not specified');
  }
  var size = type.params[0];
  if (size is! int) {
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

Primitive? asPrimitive(String name) {
  switch (name.toLowerCase()) {
    case 'i8':
      return Primitive.I8;
    case 'u8':
      return Primitive.U8;
    case 'i16':
      return Primitive.I16;
    case 'u16':
      return Primitive.U16;
    case 'i32':
      return Primitive.I32;
    case 'u32':
      return Primitive.U32;
    case 'i64':
      return Primitive.I64;
    case 'u64':
      return Primitive.U64;
    case 'i128':
      return Primitive.I128;
    case 'u128':
      return Primitive.U128;
    case 'i256':
      return Primitive.I256;
    case 'u256':
      return Primitive.U256;
    case 'boolean':
    case 'bool':
      return Primitive.Boolean;
    case 'str':
    case 'string':
    case 'text':
      return Primitive.Str;
    case 'char':
      return Primitive.Char;
    default:
      return null;
  }
}
