part of ink_abi;

class TypeHasher extends Hasher {
  final DCGHasher<CodecInterface> _dcg;

  TypeHasher(List<CodecInterface> types)
      : _dcg = DCGHasher(types, _computeHash);

  @override
  String getHash(int nodeIndex) {
    return _dcg.getHash(nodeIndex);
  }
}

Map<String, dynamic> _computeHash(
    List<CodecInterface> types, Hasher hasher, CodecInterface type) {
  switch (type.kind) {
    //
    // Primitive
    case TypeKind.primitive:
      return <String, dynamic>{
        'primitive':
            toStringPrimitive((type as PrimitiveCodecInterface).primitive.name),
      };
    //
    // Compact
    case TypeKind.compact:
      final primitive = types[(type as CompactCodecInterface).type];
      assert(primitive.kind == TypeKind.primitive);
      return <String, dynamic>{
        'primitive':
            toStringPrimitive((type as PrimitiveCodecInterface).primitive.name),
      };
    //
    // Bit Sequence
    case TypeKind.bitsequence:
      return <String, dynamic>{'binary': true};
    //
    // Array
    case TypeKind.array:
      return <String, dynamic>{
        'array': hasher.getHash((type as ArrayCodecInterface).type),
      };
    //
    // Array
    case TypeKind.sequence:
      return <String, dynamic>{
        'array': hasher.getHash((type as SequenceCodecInterface).type),
      };
    //
    // Tuple
    case TypeKind.tuple:
      final tuple = type as TupleCodecInterface;
      return <String, dynamic>{
        'tuple':
            tuple.tuple.map((typeIndex) => hasher.getHash(typeIndex)).toList(),
      };
    //
    // Composite
    case TypeKind.composite:
      final composite = type as CompositeCodecInterface;
      if (composite.fields.isEmpty || composite.fields[0].name == null) {
        return <String, dynamic>{
          'tuple': composite.fields
              .map((field) => hasher.getHash(field.type))
              .toList(),
        };
      } else {
        final List<Field> fields = composite.fields.toList();
        fields.sort(compareByName);
        return <String, dynamic>{
          'struct': fields
              .map(
                (field) => <String, dynamic>{
                  'name': field.name,
                  'type': hasher.getHash(field.type),
                },
              )
              .toList(),
        };
      }
    //
    // Variant
    case TypeKind.variant:
      final variants = (type as VariantCodecInterface).variants.toList();
      variants.sort(compareByName);
      return <String, dynamic>{
        'variant': variants.map((variant) {
          if (variant.fields.isEmpty || variant.fields[0].name == null) {
            if (variant.fields.length == 1) {
              return <String, dynamic>{
                'name': variant.name,
                'type': hasher.getHash(variant.fields[0].type),
              };
            } else {
              return {
                'name': variant.name,
                'type': _computeHash(
                  types,
                  hasher,
                  TupleCodecInterface(
                    id: -1,
                    tuple: variant.fields
                        .map((final Field field) => field.type)
                        .toList(),
                  ),
                ),
              };
            }
          } else {
            final fields = variant.fields.toList();
            fields.sort(compareByName);
            return {
              'name': variant.name,
              'type': fields
                  .map(
                    (final Field field) => <String, dynamic>{
                      'name': field.name,
                      'type': hasher.getHash(field.type),
                    },
                  )
                  .toList(),
            };
          }
        }).toList(),
      };
    //
    // Option
    case TypeKind.option:
      return <String, dynamic>{
        'option': hasher.getHash((type as OptionCodecInterface).type),
      };
  }
}

int compareByName(dynamic a, dynamic b) {
  final an = a.name!;
  final bn = b.name!;
  return an.compareTo(bn);
}

String toStringPrimitive(String primitive) {
  switch (primitive.toUpperCase()) {
    case 'I8':
    case 'U8':
    case 'I16':
    case 'U16':
    case 'I32':
    case 'U32':
      return 'int';
    case 'I64':
    case 'U64':
    case 'I128':
    case 'U128':
    case 'I256':
    case 'U256':
      return 'BigInt';
    case 'BOOL':
      return 'bool';
    case 'STR':
      return 'string';
    default:
      throw Exception('Unexpected case: $primitive');
  }
}

final _HASHERS = <List<CodecInterface>, TypeHasher>{};

TypeHasher getTypeHasher(List<CodecInterface> types) {
  TypeHasher? hasher = _HASHERS[types];
  if (hasher == null) {
    hasher = TypeHasher(types);
    _HASHERS[types] = hasher;
  }
  return hasher;
}

String getTypeHash(List<CodecInterface> types, dynamic type) {
  assert(type is int || type is CodecInterface);

  final TypeHasher hasher = getTypeHasher(types);
  if (type is int) {
    return hasher.getHash(type);
  } else {
    return sha(_computeHash(types, hasher, type));
  }
}
