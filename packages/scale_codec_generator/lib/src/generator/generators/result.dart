part of generators;

class ResultGenerator extends Generator {
  late Generator ok;
  late Generator err;

  ResultGenerator({
    required this.ok,
    required this.err,
  });

  ResultGenerator._lazy();

  factory ResultGenerator.lazy(
      {required LazyLoader loader, required int ok, required int err}) {
    final generator = ResultGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.ok = register[ok]!;
      generator.err = register[err]!;
    });
    return generator;
  }

  @override
  TypeReference primitive(BasePath from) {
    return constants.result(ok.primitive(from), err.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.resultCodec(ok.primitive(from), err.primitive(from));
  }

  @override
  Expression valueFrom(BasePath from, Input input, {constant = false}) {
    if (input.read() == 0) {
      return primitive(from)
          .newInstanceNamed('ok', [ok.valueFrom(from, input)]);
    } else {
      return primitive(from)
          .newInstanceNamed('err', [err.valueFrom(from, input)]);
    }
  }

  @override
  Expression codecInstance(String from) {
    return codec(from)
        .constInstance([ok.codecInstance(from), err.codecInstance(from)]);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    return constants.map(constants.string, constants.dynamic);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
