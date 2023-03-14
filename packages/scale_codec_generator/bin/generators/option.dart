import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show
        Expression,
        TypeReference,
        literalNull,
        literalMap,
        Code,
        Block,
        CodeExpression;
import '../constants.dart' as constants
    show Nullable, option, optionCodec, nestedOptionCodec, dynamic, map, string;
import './base.dart' show BasePath, Generator, LazyLoader;
import 'primitive.dart' show PrimitiveGenerator;

class OptionGenerator extends Generator {
  late Generator inner;

  OptionGenerator(this.inner);

  OptionGenerator._lazy();

  factory OptionGenerator.lazy(
      {required LazyLoader loader, required int codec}) {
    final generator = OptionGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.inner = register[codec]!;
    });
    return generator;
  }

  @override
  TypeReference primitive(BasePath from) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return constants.option(inner.primitive(from));
    }
    return inner.primitive(from).asNullable();
  }

  @override
  TypeReference codec(BasePath from) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return constants.nestedOptionCodec(inner.primitive(from));
    }
    return constants.optionCodec(inner.primitive(from));
  }

  @override
  Expression codecInstance(BasePath from) {
    return codec(from).constInstance([inner.codecInstance(from)]);
  }

  @override
  Expression valueFrom(BasePath from, Input input, {bool constant = false}) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      if (input.read() == 0) {
        return constants
            .option(inner.primitive(from))
            .newInstanceNamed('none', []);
      } else {
        return constants
            .option(inner.primitive(from))
            .newInstanceNamed('some', [
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
      return constants.dynamic.type as TypeReference;
    }
    visited.add(this);
    final newType = Generator.cacheOrCreate(from, visited, () {
      if (inner is OptionGenerator) {
        return constants.map(
          constants.string,
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
