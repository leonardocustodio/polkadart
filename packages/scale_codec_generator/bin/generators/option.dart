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
  TypeReference primitive([ String? from ]) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return constants.option(inner.primitive(from));
    }
    return inner.primitive(from).asNullable();
  }

  @override
  TypeReference codec([ String? from ]) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      return constants.nestedOptionCodec(inner.primitive(from));
    }
    return constants.optionCodec(inner.primitive(from));
  }

  @override
  Expression codecInstance([ String? from ]) {
    return codec(from).constInstance([inner.codecInstance(from)]);
  }

  @override
  Expression valueFrom(Input input, [ String? from ]) {
    if (inner is OptionGenerator || inner.primitive(from).isNullable == true) {
      if (input.read() == 0) {
        return constants.option(inner.primitive(from)).newInstanceNamed('none', []);
      } else {
        return constants.option(inner.primitive(from)).newInstanceNamed('some', [
          inner.valueFrom(input, from),
        ]);
      }
    }

    if (input.read() == 0) {
      return literalNull;
    } else {
      return inner.valueFrom(input, from);
    }
  }
}
