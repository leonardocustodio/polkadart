part of generators;

class OptionGenerator extends Generator {
  final int _id;
  late Generator inner;

  OptionGenerator(int id, this.inner) : _id = id;

  OptionGenerator._lazy(int id) : _id = id;

  factory OptionGenerator.lazy(
      {required int id, required LazyLoader loader, required int codec}) {
    final generator = OptionGenerator._lazy(id);
    loader.addLoader((Map<int, Generator> register) {
      generator.inner = register[codec]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return refs.option(inner.primitive(from));
    }
    return inner.primitive(from).asNullable();
  }

  @override
  TypeReference codec(BasePath from) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return refs.nestedOptionCodec(inner.primitive(from));
    }
    return refs.optionCodec(inner.primitive(from));
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([inner.codecInstance(from)]);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      if (input.read() == 0) {
        return refs.option(inner.primitive(from)).newInstanceNamed('none', []);
      } else {
        return refs.option(inner.primitive(from)).newInstanceNamed('some', [
          inner.valueFrom(from, input),
        ]);
      }
    }

    if (input.read() == 0) {
      return literalNull;
    } else {
      return inner.valueFrom(from, input);
    }
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    if (visited.contains(this)) {
      return refs.dynamic.type as TypeReference;
    }
    visited.add(this);
    final newType = Generator.cacheOrCreate(from, visited, () {
      if (inner is OptionGenerator) {
        return refs.map(
          refs.string,
          inner.jsonType(from, visited).asNullable(),
        );
      }
      return inner.jsonType(from, visited).asNullable();
    });
    visited.remove(this);
    return newType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    if (inner is OptionGenerator) {
      final valueInstance = obj.property('value');
      final innerInstance = inner.instanceToJson(from, valueInstance);
      return obj.property('isNone').conditional(
            literalMap({'None': literalNull}),
            literalMap({'Some': innerInstance}),
          );
    }
    final valueInstance = CodeExpression(Block.of([obj.code, Code('?')]));
    final innerInstance = inner.instanceToJson(from, valueInstance);
    return innerInstance == valueInstance ? obj : innerInstance;
  }
}
