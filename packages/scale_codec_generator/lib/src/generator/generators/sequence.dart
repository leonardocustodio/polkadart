part of generators;

class SequenceGenerator extends Generator {
  late Generator typeDef;

  SequenceGenerator(this.typeDef);

  SequenceGenerator._lazy();

  factory SequenceGenerator.lazy(
      {required LazyLoader loader, required int codec}) {
    final generator = SequenceGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.typeDef = register[codec]!;
    });
    return generator;
  }

  @override
  TypeReference primitive(BasePath from) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.Char:
        case metadata.Primitive.U8:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return constants.list(ref: constants.int);
        default:
          break;
      }
    }

    return constants.list(ref: typeDef.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.U8:
          return constants.u8SequenceCodec.type as TypeReference;
        case metadata.Primitive.U16:
          return constants.u16SequenceCodec.type as TypeReference;
        case metadata.Primitive.U32:
          return constants.u32SequenceCodec.type as TypeReference;
        case metadata.Primitive.U64:
          return constants.u64SequenceCodec.type as TypeReference;
        case metadata.Primitive.I8:
          return constants.i8SequenceCodec.type as TypeReference;
        case metadata.Primitive.I16:
          return constants.i16SequenceCodec.type as TypeReference;
        case metadata.Primitive.I32:
          return constants.i32SequenceCodec.type as TypeReference;
        case metadata.Primitive.I64:
          return constants.i64SequenceCodec.type as TypeReference;
        default:
          break;
      }
    }

    return constants.sequenceCodec(typeDef.primitive(from));
  }

  @override
  Expression codecInstance(BasePath from) {
    final TypeReference codec = this.codec(from);

    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.Char:
        case metadata.Primitive.U8:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return codec.property('codec');
        default:
          break;
      }
    }

    return codec.constInstance([typeDef.codecInstance(from)]);
  }

  Expression listToExpression(List<int> values, bool constant) {
    final TypeReference listType = constants.list(ref: constants.int);
    if (!constant && values.every((value) => value == 0)) {
      return listType.newInstanceNamed(
          'filled',
          [literalNum(values.length), literalNum(0)],
          {'growable': literalTrue});
    } else if (constant) {
      return literalConstList(values, constants.int);
    }
    return literalList(values, constants.int);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.Char:
          final list = U8SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U16:
          final list = U16SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U32:
          final list = U32SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.U64:
          final list = U64SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I8:
          final list = I8SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I16:
          final list = I16SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I32:
          final list = I32SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        case metadata.Primitive.I64:
          final list = I64SequenceCodec.codec.decode(input);
          return listToExpression(list, constant);
        default:
          break;
      }
    }

    final length = CompactCodec.codec.decode(input);
    final values = <Expression>[
      for (int i = 0; i < length; i++)
        typeDef.valueFrom(from, input, constant: constant)
    ];

    if (values.every((value) => value.isConst)) {
      return literalConstList(values);
    }
    return literalList(values);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.Char:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return constants.list(ref: constants.int);
        case metadata.Primitive.U128:
        case metadata.Primitive.I128:
        case metadata.Primitive.U256:
        case metadata.Primitive.I256:
          return constants.list(ref: constants.bigInt);
        case metadata.Primitive.Str:
          return constants.list(ref: constants.string);
        case metadata.Primitive.Bool:
          return constants.list(ref: constants.bool);
        default:
          break;
      }
    }
    if (visited.contains(this)) {
      return constants.list(ref: constants.dynamic);
    }
    visited.add(this);
    final newType = constants.list(ref: typeDef.jsonType(from, visited));
    visited.remove(this);
    return newType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
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
          return obj;
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
