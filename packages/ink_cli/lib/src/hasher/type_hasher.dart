part of ink_cli;

class TypeHasher extends HasherAbstract {
  final DCGHasher<CodecInterface> _dcg;

  TypeHasher(List<CodecInterface> types) : _dcg = DCGHasher(types, _computeHash);

  @override
  String getHash(final int nodeIndex) {
    return _dcg.getHash(nodeIndex);
  }
}

Map<String, dynamic> _computeHash(
  final List<CodecInterface> types,
  final HasherAbstract hasher,
  final CodecInterface type,
) {
  switch (type) {
    //
    // Primitive
    case PrimitiveCodecInterface():
      return <String, dynamic>{'primitive': toStringPrimitive(type.primitive)};
    //
    // Compact
    case CompactCodecInterface():
      final primitive = types[type.type];
      assert(primitive is PrimitiveCodecInterface);
      return <String, dynamic>{
        'primitive': toStringPrimitive((type as PrimitiveCodecInterface).primitive),
      };
    //
    // Bit Sequence
    case BitSequenceCodecInterface():
      return <String, dynamic>{'binary': true};
    //
    // Array
    case ArrayCodecInterface():
      return <String, dynamic>{'array': hasher.getHash(type.type)};
    //
    // SequenceCodec
    case SequenceCodecInterface():
      return <String, dynamic>{'array': hasher.getHash(type.type)};
    //
    // Tuple
    case TupleCodecInterface():
      return <String, dynamic>{
        'tuple': type.tuple.map((typeIndex) => hasher.getHash(typeIndex)).toList(),
      };
    //
    // Composite
    case CompositeCodecInterface():
      if (type.fields.isEmpty || type.fields[0].name == null) {
        return <String, dynamic>{
          'tuple': type.fields.map((field) => hasher.getHash(field.type)).toList(),
        };
      } else {
        final List<Field> fields = type.fields.toList();
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
    case VariantCodecInterface():
      final variants = type.variants.toList();
      variants.sort((final variantA, final variantB) => variantA.name.compareTo(variantB.name));
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
                    tuple: variant.fields.map((final Field field) => field.type).toList(),
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
    case OptionCodecInterface():
      return <String, dynamic>{'option': hasher.getHash(type.type)};

    default:
      throw Exception('');
  }
}

int compareByName(final Field a, final Field b) {
  final an = a.name!;
  final bn = b.name!;
  return an.compareTo(bn);
}

String toStringPrimitive(final Primitive primitive) {
  return switch (primitive) {
    Primitive.I8 ||
    Primitive.U8 ||
    Primitive.I16 ||
    Primitive.U16 ||
    Primitive.I32 ||
    Primitive.U32 => 'int',
    Primitive.I64 ||
    Primitive.U64 ||
    Primitive.I128 ||
    Primitive.U128 ||
    Primitive.I256 ||
    Primitive.U256 => 'BigInt',
    Primitive.Bool => 'bool',
    Primitive.Str => 'string',
    _ => throw Exception('Unexpected case: $primitive'),
  };
}

final _hashers = <List<CodecInterface>, TypeHasher>{};

TypeHasher getTypeHasher(final List<CodecInterface> types) {
  TypeHasher? hasher = _hashers[types];
  if (hasher == null) {
    hasher = TypeHasher(types);
    _hashers[types] = hasher;
  }
  return hasher;
}

String getTypeHash(final List<CodecInterface> types, final dynamic type) {
  assert(type is int || type is CodecInterface);

  final TypeHasher hasher = getTypeHasher(types);
  if (type is int) {
    return hasher.getHash(type);
  } else {
    return sha(_computeHash(types, hasher, type));
  }
}
