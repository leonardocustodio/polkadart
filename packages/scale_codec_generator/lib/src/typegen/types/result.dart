part of generators;

class ResultGenerator extends Generator {
  final int _id;
  late Generator ok;
  late Generator err;

  ResultGenerator({
    required int id,
    required this.ok,
    required this.err,
  }) : _id = id;

  ResultGenerator._lazy(this._id);

  factory ResultGenerator.lazy(
      {required int id,
      required LazyLoader loader,
      required int ok,
      required int err}) {
    final generator = ResultGenerator._lazy(id);
    loader.addLoader((Map<int, Generator> register) {
      generator.ok = register[ok]!;
      generator.err = register[err]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    return refs.result(ok.primitive(from), err.primitive(from));
  }

  @override
  TypeReference codec(BasePath from) {
    return refs.resultCodec(ok.primitive(from), err.primitive(from));
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
    return refs.map(refs.string, refs.dynamic);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
