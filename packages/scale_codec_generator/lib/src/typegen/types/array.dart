part of generators;

class ArrayGenerator extends Generator {
  final int _id;
  late Generator typeDef;
  final int length;

  ArrayGenerator(
      {required int id, required Generator codec, required this.length})
      : typeDef = codec,
        _id = id;
  ArrayGenerator._lazy(this._id, this.length);

  factory ArrayGenerator.lazy(
      {required int id,
      required LazyLoader loader,
      required int codec,
      required int length}) {
    final generator = ArrayGenerator._lazy(id, length);
    loader.addLoader((Map<int, Generator> register) {
      generator.typeDef = register[codec]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case metadata.Primitive.U8:
        case metadata.Primitive.U16:
        case metadata.Primitive.U32:
        case metadata.Primitive.U64:
        case metadata.Primitive.I8:
        case metadata.Primitive.I16:
        case metadata.Primitive.I32:
        case metadata.Primitive.I64:
          return refs.list(ref: refs.int);
        default:
          break;
      }
    }
    return refs.list(ref: typeDef.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
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

    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
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

  Expression listToExpression(List<int> values, bool constant) {
    final TypeReference listType = refs.list(ref: refs.int);
    if (!constant && values.every((value) => value == 0)) {
      return listType.newInstanceNamed(
          'filled',
          [literalNum(values.length), literalNum(0)],
          {'growable': literalFalse});
    } else if (constant) {
      return literalConstList(values, refs.int);
    }
    return literalList(values, refs.int);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
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
          return listToExpression(list, constant);
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
          return listToExpression(list, constant);
        default:
          break;
      }
    }

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
          return refs.list(ref: refs.int);
        case metadata.Primitive.U128:
        case metadata.Primitive.I128:
        case metadata.Primitive.U256:
        case metadata.Primitive.I256:
          return refs.list(ref: refs.bigInt);
        case metadata.Primitive.Str:
          return refs.list(ref: refs.string);
        case metadata.Primitive.Bool:
          return refs.list(ref: refs.bool);
        default:
          break;
      }
    }
    if (visited.contains(this)) {
      return refs.list(ref: refs.dynamic);
    }
    visited.add(this);
    final type = Generator.cacheOrCreate(
        from, visited, () => refs.list(ref: typeDef.jsonType(from, visited)));
    visited.remove(this);
    return type;
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
