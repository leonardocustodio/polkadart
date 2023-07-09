part of descriptors;

class OptionDescriptor extends TypeDescriptor {
  final int _id;
  late TypeDescriptor inner;

  OptionDescriptor(int id, this.inner) : _id = id;

  OptionDescriptor._lazy(int id) : _id = id;

  factory OptionDescriptor.lazy(
      {required int id, required LazyLoader loader, required int codec}) {
    final generator = OptionDescriptor._lazy(id);
    loader.addLoader((Map<int, TypeDescriptor> register) {
      generator.inner = register[codec]!;
    });
    return generator;
  }

  @override
  int id() => _id;

  @override
  TypeReference primitive(BasePath from) {
    if (inner is OptionDescriptor || inner.primitive(from).isNullable == true) {
      return refs.option(inner.primitive(from));
    }
    return inner.primitive(from).asNullable();
  }

  @override
  TypeReference codec(BasePath from) {
    if (inner is OptionDescriptor || inner.primitive(from).isNullable == true) {
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
    if (inner is OptionDescriptor || inner.primitive(from).isNullable == true) {
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
  TypeReference jsonType(bool isCircular, TypeBuilderContext context) {
    if (isCircular) {
      return refs.dynamic.type as TypeReference;
    }
    final innerJsonType = context.jsonTypeFrom(inner).asNullable();
    if (inner is OptionDescriptor) {
      return refs.map(
        refs.string,
        innerJsonType,
      );
    }
    return innerJsonType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    if (inner is OptionDescriptor) {
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
