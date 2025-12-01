part of metadata;

enum Primitive {
  Bool,
  Char,
  Str,
  U8,
  U16,
  U32,
  U64,
  U128,
  U256,
  I8,
  I16,
  I32,
  I64,
  I128,
  I256;

  static const $Primitive codec = $Primitive._();
}

class $Primitive with Codec<Primitive> {
  const $Primitive._();

  @override
  Primitive decode(Input input) {
    final primitiveIndex = input.read();
    if (primitiveIndex < 0 || primitiveIndex >= Primitive.values.length) {
      throw Exception('Unknown primitive type at index: $primitiveIndex');
    }
    return Primitive.values[primitiveIndex];
  }

  @override
  void encodeTo(Primitive value, Output output) {
    output.pushByte(value.index);
  }

  @override
  int sizeHint(final Primitive value) => 1;
}

/// A primitive Rust type.
class TypeDefPrimitive extends TypeDef {
  /// The primitive type.
  final Primitive primitive;
  const TypeDefPrimitive(this.primitive);

  static const $TypeDef codec = TypeDef.codec;

  factory TypeDefPrimitive.fromString(String primitive) {
    switch (primitive) {
      case 'Bool':
        return TypeDefPrimitive(Primitive.Bool);
      case 'Char':
        return TypeDefPrimitive(Primitive.Char);
      case 'Str':
        return TypeDefPrimitive(Primitive.Str);
      case 'U8':
        return TypeDefPrimitive(Primitive.U8);
      case 'U16':
        return TypeDefPrimitive(Primitive.U16);
      case 'U32':
        return TypeDefPrimitive(Primitive.U32);
      case 'U64':
        return TypeDefPrimitive(Primitive.U64);
      case 'U128':
        return TypeDefPrimitive(Primitive.U128);
      case 'U256':
        return TypeDefPrimitive(Primitive.U256);
      case 'I8':
        return TypeDefPrimitive(Primitive.I8);
      case 'I16':
        return TypeDefPrimitive(Primitive.I16);
      case 'I32':
        return TypeDefPrimitive(Primitive.I32);
      case 'I64':
        return TypeDefPrimitive(Primitive.I64);
      case 'I128':
        return TypeDefPrimitive(Primitive.I128);
      case 'I256':
        return TypeDefPrimitive(Primitive.I256);
      default:
        throw Exception('Unknown primitive type $primitive');
    }
  }

  @override
  Set<int> typeDependencies() => <int>{};

  @override
  Map<String, String> toJson() => {'primitive': primitive.name.toLowerCase()};
}

/// A primitive Rust type.
class $TypeDefPrimitive with Codec<TypeDefPrimitive> {
  const $TypeDefPrimitive._();

  @override
  TypeDefPrimitive decode(Input input) {
    final primitive = Primitive.codec.decode(input);
    return TypeDefPrimitive(primitive);
  }

  @override
  void encodeTo(TypeDefPrimitive typeDef, Output output) {
    Primitive.codec.encodeTo(typeDef.primitive, output);
  }

  @override
  int sizeHint(TypeDefPrimitive value) {
    return Primitive.codec.sizeHint(value.primitive);
  }
}
