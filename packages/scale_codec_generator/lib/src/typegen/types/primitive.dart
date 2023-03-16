part of generators;

class PrimitiveGenerator extends Generator {
  final int _id;
  final metadata.Primitive primitiveType;

  const PrimitiveGenerator._(int id, this.primitiveType) : _id = id;

  PrimitiveGenerator({required int id, required metadata.Primitive primitive})
      : primitiveType = primitive,
        _id = id;

  factory PrimitiveGenerator.str(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.Str);
  factory PrimitiveGenerator.char(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.Char);
  factory PrimitiveGenerator.bool(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.Bool);
  factory PrimitiveGenerator.i8(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I8);
  factory PrimitiveGenerator.i16(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I16);
  factory PrimitiveGenerator.i32(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I32);
  factory PrimitiveGenerator.i64(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I64);
  factory PrimitiveGenerator.i128(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I128);
  factory PrimitiveGenerator.i256(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.I256);
  factory PrimitiveGenerator.u8(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U8);
  factory PrimitiveGenerator.u16(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U16);
  factory PrimitiveGenerator.u32(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U32);
  factory PrimitiveGenerator.u64(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U64);
  factory PrimitiveGenerator.u128(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U128);
  factory PrimitiveGenerator.u256(int id) =>
      PrimitiveGenerator._(id, metadata.Primitive.U256);

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return refs.bool.type as TypeReference;
      case metadata.Primitive.Str:
        return refs.string.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
      case metadata.Primitive.U16:
      case metadata.Primitive.U32:
      case metadata.Primitive.I8:
      case metadata.Primitive.I16:
      case metadata.Primitive.I32:
        return refs.int.type as TypeReference;
      case metadata.Primitive.U64:
      case metadata.Primitive.U128:
      case metadata.Primitive.U256:
      case metadata.Primitive.I64:
      case metadata.Primitive.I128:
      case metadata.Primitive.I256:
        return refs.bigInt.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  TypeReference codec(BasePath from) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return refs.boolCodec.type as TypeReference;
      case metadata.Primitive.Str:
        return refs.strCodec.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
        return refs.u8Codec.type as TypeReference;
      case metadata.Primitive.U16:
        return refs.u16Codec.type as TypeReference;
      case metadata.Primitive.U32:
        return refs.u32Codec.type as TypeReference;
      case metadata.Primitive.U64:
        return refs.u64Codec.type as TypeReference;
      case metadata.Primitive.U128:
        return refs.u128Codec.type as TypeReference;
      case metadata.Primitive.U256:
        return refs.u256Codec.type as TypeReference;
      case metadata.Primitive.I8:
        return refs.i8Codec.type as TypeReference;
      case metadata.Primitive.I16:
        return refs.i16Codec.type as TypeReference;
      case metadata.Primitive.I32:
        return refs.i32Codec.type as TypeReference;
      case metadata.Primitive.I64:
        return refs.i64Codec.type as TypeReference;
      case metadata.Primitive.I128:
        return refs.i128Codec.type as TypeReference;
      case metadata.Primitive.I256:
        return refs.i256Codec.type as TypeReference;
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
        return refs.bool.type as TypeReference;
      case metadata.Primitive.Str:
        return refs.string.type as TypeReference;
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
      case metadata.Primitive.U16:
      case metadata.Primitive.U32:
      case metadata.Primitive.I8:
      case metadata.Primitive.I16:
      case metadata.Primitive.I32:
        return refs.int.type as TypeReference;
      case metadata.Primitive.U64:
      case metadata.Primitive.U128:
      case metadata.Primitive.U256:
      case metadata.Primitive.I64:
      case metadata.Primitive.I128:
      case metadata.Primitive.I256:
        return refs.bigInt.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
