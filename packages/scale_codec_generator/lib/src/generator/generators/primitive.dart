part of generators;

class PrimitiveGenerator extends Generator {
  final metadata.Primitive primitiveType;

  const PrimitiveGenerator._(this.primitiveType);

  factory PrimitiveGenerator(metadata.Primitive primitive) {
    switch (primitive) {
      case metadata.Primitive.Bool:
        return PrimitiveGenerator.bool;
      case metadata.Primitive.Str:
        return PrimitiveGenerator.str;
      case metadata.Primitive.Char:
        return PrimitiveGenerator.char;
      case metadata.Primitive.U8:
        return PrimitiveGenerator.u8;
      case metadata.Primitive.U16:
        return PrimitiveGenerator.u16;
      case metadata.Primitive.U32:
        return PrimitiveGenerator.u32;
      case metadata.Primitive.U64:
        return PrimitiveGenerator.u64;
      case metadata.Primitive.U128:
        return PrimitiveGenerator.u128;
      case metadata.Primitive.U256:
        return PrimitiveGenerator.u256;
      case metadata.Primitive.I8:
        return PrimitiveGenerator.i8;
      case metadata.Primitive.I16:
        return PrimitiveGenerator.i16;
      case metadata.Primitive.I32:
        return PrimitiveGenerator.i32;
      case metadata.Primitive.I64:
        return PrimitiveGenerator.i64;
      case metadata.Primitive.I128:
        return PrimitiveGenerator.i128;
      case metadata.Primitive.I256:
        return PrimitiveGenerator.i256;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  static const PrimitiveGenerator str =
      PrimitiveGenerator._(metadata.Primitive.Str);
  static const PrimitiveGenerator char =
      PrimitiveGenerator._(metadata.Primitive.Char);
  static const PrimitiveGenerator bool =
      PrimitiveGenerator._(metadata.Primitive.Bool);
  static const PrimitiveGenerator i8 =
      PrimitiveGenerator._(metadata.Primitive.I8);
  static const PrimitiveGenerator i16 =
      PrimitiveGenerator._(metadata.Primitive.I16);
  static const PrimitiveGenerator i32 =
      PrimitiveGenerator._(metadata.Primitive.I32);
  static const PrimitiveGenerator i64 =
      PrimitiveGenerator._(metadata.Primitive.I64);
  static const PrimitiveGenerator i128 =
      PrimitiveGenerator._(metadata.Primitive.I128);
  static const PrimitiveGenerator i256 =
      PrimitiveGenerator._(metadata.Primitive.I256);
  static const PrimitiveGenerator u8 =
      PrimitiveGenerator._(metadata.Primitive.U8);
  static const PrimitiveGenerator u16 =
      PrimitiveGenerator._(metadata.Primitive.U16);
  static const PrimitiveGenerator u32 =
      PrimitiveGenerator._(metadata.Primitive.U32);
  static const PrimitiveGenerator u64 =
      PrimitiveGenerator._(metadata.Primitive.U64);
  static const PrimitiveGenerator u128 =
      PrimitiveGenerator._(metadata.Primitive.U128);
  static const PrimitiveGenerator u256 =
      PrimitiveGenerator._(metadata.Primitive.U256);

  @override
  TypeReference primitive(BasePath from) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return constants.bool.type as TypeReference;
      case metadata.Primitive.Str:
        return constants.string.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
      case metadata.Primitive.U16:
      case metadata.Primitive.U32:
      case metadata.Primitive.I8:
      case metadata.Primitive.I16:
      case metadata.Primitive.I32:
        return constants.int.type as TypeReference;
      case metadata.Primitive.U64:
      case metadata.Primitive.U128:
      case metadata.Primitive.U256:
      case metadata.Primitive.I64:
      case metadata.Primitive.I128:
      case metadata.Primitive.I256:
        return constants.bigInt.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  TypeReference codec(BasePath from) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return constants.boolCodec.type as TypeReference;
      case metadata.Primitive.Str:
        return constants.strCodec.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
        return constants.u8Codec.type as TypeReference;
      case metadata.Primitive.U16:
        return constants.u16Codec.type as TypeReference;
      case metadata.Primitive.U32:
        return constants.u32Codec.type as TypeReference;
      case metadata.Primitive.U64:
        return constants.u64Codec.type as TypeReference;
      case metadata.Primitive.U128:
        return constants.u128Codec.type as TypeReference;
      case metadata.Primitive.U256:
        return constants.u256Codec.type as TypeReference;
      case metadata.Primitive.I8:
        return constants.i8Codec.type as TypeReference;
      case metadata.Primitive.I16:
        return constants.i16Codec.type as TypeReference;
      case metadata.Primitive.I32:
        return constants.i32Codec.type as TypeReference;
      case metadata.Primitive.I64:
        return constants.i64Codec.type as TypeReference;
      case metadata.Primitive.I128:
        return constants.i128Codec.type as TypeReference;
      case metadata.Primitive.I256:
        return constants.i256Codec.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  Expression valueFrom(BasePath from, Input input, {constant = false}) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return literalBool(BoolCodec.codec.decode(input));
      case metadata.Primitive.Str:
        return literalString(StrCodec.codec.decode(input));
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
        return literalNum(U8Codec.codec.decode(input));
      case metadata.Primitive.U16:
        return literalNum(U16Codec.codec.decode(input));
      case metadata.Primitive.U32:
        return literalNum(U32Codec.codec.decode(input));
      case metadata.Primitive.U64:
        return bigIntToExpression(U64Codec.codec.decode(input));
      case metadata.Primitive.U128:
        return bigIntToExpression(U128Codec.codec.decode(input));
      case metadata.Primitive.U256:
        return bigIntToExpression(U256Codec.codec.decode(input));
      case metadata.Primitive.I8:
        return literalNum(I8Codec.codec.decode(input));
      case metadata.Primitive.I16:
        return literalNum(I16Codec.codec.decode(input));
      case metadata.Primitive.I32:
        return literalNum(I32Codec.codec.decode(input));
      case metadata.Primitive.I64:
        return bigIntToExpression(I64Codec.codec.decode(input));
      case metadata.Primitive.I128:
        return bigIntToExpression(I128Codec.codec.decode(input));
      case metadata.Primitive.I256:
        return bigIntToExpression(I256Codec.codec.decode(input));
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return constants.bool.type as TypeReference;
      case metadata.Primitive.Str:
        return constants.string.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
      case metadata.Primitive.U16:
      case metadata.Primitive.U32:
      case metadata.Primitive.I8:
      case metadata.Primitive.I16:
      case metadata.Primitive.I32:
        return constants.int.type as TypeReference;
      case metadata.Primitive.U64:
      case metadata.Primitive.U128:
      case metadata.Primitive.U256:
      case metadata.Primitive.I64:
      case metadata.Primitive.I128:
      case metadata.Primitive.I256:
        return constants.bigInt.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
