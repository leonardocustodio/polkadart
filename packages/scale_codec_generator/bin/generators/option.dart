import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalNull;
import '../constants.dart' as constants
    show Nullable, option, optionCodec, nestedOptionCodec;
import './base.dart' show Generator, LazyLoader;

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
  TypeReference primitive() {
    if (inner is OptionGenerator || inner.primitive().isNullable == true) {
      return constants.option(inner.primitive());
    }
    return inner.primitive().asNullable();
  }

  @override
  TypeReference codec() {
    if (inner is OptionGenerator || inner.primitive().isNullable == true) {
      return constants.nestedOptionCodec(inner.primitive());
    }
    return constants.optionCodec(inner.primitive());
  }

  @override
  Expression codecInstance() {
    return codec().constInstance([inner.codecInstance()]);
  }

  @override
  Expression valueFrom(Input input) {
    if (inner is OptionGenerator || inner.primitive().isNullable == true) {
      if (input.read() == 0) {
        return constants.option(inner.primitive()).newInstanceNamed('none', []);
      } else {
        return constants.option(inner.primitive()).newInstanceNamed('some', [
          inner.valueFrom(input),
        ]);
      }
    }

    if (input.read() == 0) {
      return literalNull;
    } else {
      return inner.valueFrom(input);
    }
  }
}
