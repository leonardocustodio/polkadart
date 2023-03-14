part of generators;

class CompactGenerator extends Generator {
  const CompactGenerator();

  @override
  TypeReference primitive(BasePath from) {
    return constants.bigInt.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.compactBigIntCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    final value = CompactBigIntCodec.codec.decode(input);
    return bigIntToExpression(value);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Object> visited = const {}]) {
    return constants.bigInt.type as TypeReference;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
