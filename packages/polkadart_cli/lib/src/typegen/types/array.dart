part of descriptors;

class ArrayDescriptor extends TypeDescriptor {
  final int _id;
  late TypeDescriptor typeDef;
  final int length;

  ArrayDescriptor({required int id, required TypeDescriptor codec, required this.length})
      : typeDef = codec,
        _id = id;
  ArrayDescriptor._lazy(this._id, this.length);

  factory ArrayDescriptor.lazy(
      {required int id, required LazyLoader loader, required int codec, required int length}) {
    final generator = ArrayDescriptor._lazy(id, length);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      generator.typeDef = register[codec]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
          return refs.list(ref: refs.int);
        case metadata.Primitive.I64:
        case metadata.Primitive.U64:
          return refs.list(ref: refs.bigInt);
        default:
          break;
      }
    }
    return refs.list(ref: typeDef.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.U8:
          return refs.u8ArrayCodec.type as TypeReference;
        case metadata.Primitive.U16:
          return refs.u16ArrayCodec.type as TypeReference;
        case metadata.Primitive.U32:
          return refs.u32ArrayCodec.type as TypeReference;
        case metadata.Primitive.U64:
          return refs.u64ArrayCodec.type as TypeReference;
        case metadata.Primitive.I8:
          return refs.i8ArrayCodec.type as TypeReference;
        case metadata.Primitive.I16:
          return refs.i16ArrayCodec.type as TypeReference;
        case metadata.Primitive.I32:
          return refs.i32ArrayCodec.type as TypeReference;
        case metadata.Primitive.I64:
          return refs.i64ArrayCodec.type as TypeReference;
        default:
          break;
      }
    }

    return refs.arrayCodec(typeDef.primitive(from));
  }

  @override
  Expression codecInstance(BasePath from) {
    final TypeReference codec = this.codec(from);

    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return codec.constInstance([literalNum(length)]);
        default:
          break;
      }
    }

    return codec.constInstance([
      typeDef.codecInstance(from),
      literalNum(length),
    ]);
  }

  LiteralValue listToExpression(List<int> values, bool constant) {
    final TypeReference listType = refs.list(ref: refs.int);
    if (!constant && values.every((value) => value == 0)) {
      return listType.newInstanceNamed('filled', [literalNum(values.length), literalNum(0)],
          {'growable': literalFalse}).asLiteralValue();
    } else if (constant) {
      return literalConstList(values, refs.int).asLiteralValue(isConstant: true);
    }
    return literalList(values, refs.int).asLiteralValue();
  }

  LiteralValue listToExpressionBigInt(List<BigInt> values, bool constant) {
    final TypeReference listType = refs.list(ref: refs.bigInt);
    if (!constant && values.every((value) => value == BigInt.zero)) {
      return listType.newInstanceNamed('filled', [literalNum(values.length), refer('BigInt.zero')],
          {'growable': literalFalse}).asLiteralValue();
    }

    final bigIntExpressions = values.map((value) {
      return refer('BigInt.from').call([literalNum(value.toInt())]);
    }).toList();

    return literalList(bigIntExpressions, refs.bigInt).asLiteralValue();
  }

  @override
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.Char:
          final list = U8ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U16:
          final list = U16ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U32:
          final list = U32ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U64:
          final list = U64ArrayCodec(length).decode(input);
          return listToExpressionBigInt(list, constant);
        case metadata.Primitive.I8:
          final list = I8ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I16:
          final list = I16ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I32:
          final list = I32ArrayCodec(length).decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I64:
          final list = I64ArrayCodec(length).decode(input);
          return listToExpressionBigInt(list, constant);
        default:
          break;
      }
    }

    final values = <LiteralValue>[
      for (int i = 0; i < length; i++) typeDef.valueFrom(from, input, constant: constant)
    ];

    if (constant && values.every((value) => value.isConstant)) {
      return literalConstList(values).asLiteralValue(isConstant: true);
    }
    return literalList(values).asLiteralValue();
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.Char:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
          return refs.list(ref: refs.int);
        case metadata.Primitive.U64:
        case metadata.Primitive.I64:
        case metadata.Primitive.U128:
        case metadata.Primitive.I128:
        case metadata.Primitive.U256:
        case metadata.Primitive.I256:
          return refs.list(ref: refs.bigInt);
        case metadata.Primitive.Str:
          return refs.list(ref: refs.string);
        case metadata.Primitive.Bool:
          return refs.list(ref: refs.bool);
      }
    }
    if (isCircular) {
      return refs.list(ref: refs.dynamic);
    }
    return refs.list(ref: context.jsonTypeFrom(typeDef));
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    if (typeDef is PrimitiveDescriptor) {
      switch ((typeDef as PrimitiveDescriptor).primitiveType) {
        case metadata.Primitive.Str:
        case metadata.Primitive.U8:
        case metadata.Primitive.Char:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return obj.property('toList').call([]);
        default:
          break;
      }
    }

    return obj
        .property('map')
        .call([
          Method.returnsVoid((b) => b
            ..requiredParameters.add(Parameter((b) => b..name = 'value'))
            ..lambda = true
            ..body = typeDef.instanceToJson(from, refer('value')).code).closure
        ])
        .property('toList')
        .call([]);
  }
}
