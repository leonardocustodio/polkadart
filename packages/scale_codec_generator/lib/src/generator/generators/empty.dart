part of generators;

class EmptyGenerator extends Generator {
  EmptyGenerator();

  @override
  TypeReference primitive(BasePath from) {
    return constants.dynamic.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.emptyCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    return literalNull;
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    return constants.dynamic.type as TypeReference;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return literalNull;
  }
}
