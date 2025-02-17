part of descriptors;

class PrimitiveDescriptor extends TypeDescriptor {
  final int _id;
  final metadata.Primitive primitiveType;

  const PrimitiveDescriptor._(int id, this.primitiveType) : _id = id;

  PrimitiveDescriptor({required int id, required metadata.Primitive primitive})
      : primitiveType = primitive,
        _id = id;

  factory PrimitiveDescriptor.str(int id) => PrimitiveDescriptor._(id, metadata.Primitive.Str);
  factory PrimitiveDescriptor.char(int id) => PrimitiveDescriptor._(id, metadata.Primitive.Char);
  factory PrimitiveDescriptor.bool(int id) => PrimitiveDescriptor._(id, metadata.Primitive.Bool);
  factory PrimitiveDescriptor.i8(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I8);
  factory PrimitiveDescriptor.i16(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I16);
  factory PrimitiveDescriptor.i32(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I32);
  factory PrimitiveDescriptor.i64(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I64);
  factory PrimitiveDescriptor.i128(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I128);
  factory PrimitiveDescriptor.i256(int id) => PrimitiveDescriptor._(id, metadata.Primitive.I256);
  factory PrimitiveDescriptor.u8(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U8);
  factory PrimitiveDescriptor.u16(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U16);
  factory PrimitiveDescriptor.u32(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U32);
  factory PrimitiveDescriptor.u64(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U64);
  factory PrimitiveDescriptor.u128(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U128);
  factory PrimitiveDescriptor.u256(int id) => PrimitiveDescriptor._(id, metadata.Primitive.U256);

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
    }
  }

  @override
  LiteralValue valueFrom(BasePath from, Input input, {constant = false}) {
    switch (primitiveType) {
      case metadata.Primitive.Bool:
        return literalBool(BoolCodec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.Str:
        return literalString(StrCodec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.Char:
      case metadata.Primitive.U8:
        return literalNum(U8Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.U16:
        return literalNum(U16Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.U32:
        return literalNum(U32Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.U64:
        return bigIntToExpression(U64Codec.codec.decode(input)).asLiteralValue();
      case metadata.Primitive.U128:
        return bigIntToExpression(U128Codec.codec.decode(input)).asLiteralValue();
      case metadata.Primitive.U256:
        return bigIntToExpression(U256Codec.codec.decode(input)).asLiteralValue();
      case metadata.Primitive.I8:
        return literalNum(I8Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.I16:
        return literalNum(I16Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.I32:
        return literalNum(I32Codec.codec.decode(input)).asLiteralValue(isConstant: true);
      case metadata.Primitive.I64:
        return bigIntToExpression(I64Codec.codec.decode(input)).asLiteralValue();
      case metadata.Primitive.I128:
        return bigIntToExpression(I128Codec.codec.decode(input)).asLiteralValue();
      case metadata.Primitive.I256:
        return bigIntToExpression(I256Codec.codec.decode(input)).asLiteralValue();
    }
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
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
    }
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
