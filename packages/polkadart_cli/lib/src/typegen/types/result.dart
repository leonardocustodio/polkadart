part of descriptors;

class ResultDescriptor extends TypeDescriptor {
  final int _id;
  late TypeDescriptor ok;
  late TypeDescriptor err;

  ResultDescriptor({
    required int id,
    required this.ok,
    required this.err,
  }) : _id = id;

  ResultDescriptor._lazy(this._id);

  factory ResultDescriptor.lazy(
      {required int id, required LazyLoader loader, required int ok, required int err}) {
    final generator = ResultDescriptor._lazy(id);
    loader.addLoader((Map<int, TypeDescriptor> register) {
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
  LiteralValue valueFrom(BasePath from, Input input, {constant = false}) {
    final bool isOk = input.read() == 0;
    LiteralValue value;
    if (isOk) {
      value = ok.valueFrom(from, input);
    } else {
      value = err.valueFrom(from, input);
    }
    return primitive(from).newInstanceNamed(isOk ? 'ok' : 'err', [value]).asLiteralValue(
        isConstant: constant && value.isConstant);
  }

  @override
  Expression codecInstance(String from) {
    return codec(from).constInstance([ok.codecInstance(from), err.codecInstance(from)]);
  }

  @override
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    return refs.map(refs.string, refs.dynamic);
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj.property('toJson').call([]);
  }
}
