part of descriptors;

class OptionDescriptor extends TypeDescriptor {
  final int _id;
  late TypeDescriptor inner;

  OptionDescriptor(int id, this.inner) : _id = id;

  OptionDescriptor._lazy(int id) : _id = id;

  factory OptionDescriptor.lazy({required int id, required LazyLoader loader, required int codec}) {
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
  LiteralValue valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (inner is OptionDescriptor || inner.primitive(from).isNullable == true) {
      if (input.read() == 0) {
        return refs
            .option(inner.primitive(from))
            .newInstanceNamed('none', [])
            .asLiteralValue(isConstant: true);
      } else {
        final innerValue = inner.valueFrom(from, input);
        return refs
            .option(inner.primitive(from))
            .newInstanceNamed('some', [innerValue])
            .asLiteralValue(isConstant: constant && innerValue.isConstant);
      }
    }

    if (input.read() == 0) {
      return literalNull.asLiteralValue(isConstant: true);
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
      return refs.map(refs.string, innerJsonType);
    }
    return innerJsonType;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    if (inner is OptionDescriptor) {
      final valueInstance = obj.property('value');
      final innerInstance = inner.instanceToJson(from, valueInstance);
      return obj
          .property('isNone')
          .conditional(literalMap({'None': literalNull}), literalMap({'Some': innerInstance}));
    }
    // For nullable options, check if the inner type actually transforms the object
    final nonNullObj = CodeExpression(Block.of([obj.code, Code('!')]));
    final innerInstance = inner.instanceToJson(from, nonNullObj);
    if (innerInstance == nonNullObj) {
      // If inner doesn't transform the object, just return it as is (already nullable)
      return obj;
    }
    // use null-aware operator
    if (inner is CompositeBuilder || inner is VariantBuilder) {
      return obj.nullSafeProperty('toJson').call([]);
    }
    if (inner is ArrayDescriptor) {
      final arrayDesc = inner as ArrayDescriptor;
      if (arrayDesc.typeDef is PrimitiveDescriptor) {
        // Primitive arrays just call .toList()
        return obj.nullSafeProperty('toList').call([]);
      } else {
        return obj
            .nullSafeProperty('map')
            .call([
              Method.returnsVoid(
                (b) => b
                  ..requiredParameters.add(Parameter((b) => b..name = 'value'))
                  ..lambda = true
                  ..body = arrayDesc.typeDef.instanceToJson(from, refer('value')).code,
              ).closure,
            ])
            .property('toList')
            .call([]);
      }
    }
    if (inner is SequenceDescriptor) {
      final seqDesc = inner as SequenceDescriptor;
      if (seqDesc.typeDef is PrimitiveDescriptor) {
        return obj.nullSafeProperty('toList').call([]);
      } else {
        return obj
            .nullSafeProperty('map')
            .call([
              Method.returnsVoid(
                (b) => b
                  ..requiredParameters.add(Parameter((b) => b..name = 'value'))
                  ..lambda = true
                  ..body = seqDesc.typeDef.instanceToJson(from, refer('value')).code,
              ).closure,
            ])
            .property('toList')
            .call([]);
      }
    }
    // TypeDefBuilder
    if (inner is TypeDefBuilder) {
      final typedef = inner as TypeDefBuilder;
      final typeDefInner = typedef.generator;
      // For nested options (Option<TypeDef<Option<T>>>), delegate to the typedef's instanceToJson
      // which will handle the inner option correctly with null-safe operators
      if (typeDefInner is OptionDescriptor) {
        return typedef.instanceToJson(from, obj);
      }
      if (typeDefInner is ArrayDescriptor) {
        if (typeDefInner.typeDef is PrimitiveDescriptor) {
          return obj.nullSafeProperty('toList').call([]);
        }
      }
      if (typeDefInner is SequenceDescriptor) {
        if (typeDefInner.typeDef is PrimitiveDescriptor) {
          return obj.nullSafeProperty('toList').call([]);
        }
      }
    }
    // For other types (like Tuple), keep the conditional to avoid type issues
    return obj.notEqualTo(literalNull).conditional(innerInstance, literalNull);
  }
}
