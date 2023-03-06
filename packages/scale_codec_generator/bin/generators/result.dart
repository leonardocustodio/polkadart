import 'package:code_builder/code_builder.dart' show Expression, TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import './base.dart' show Generator, LazyLoader;
import '../constants.dart' as constants;

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
  TypeReference primitive() {
    return constants.result(ok.primitive(), err.primitive());
  }

  @override
  TypeReference codec() {
    return constants.resultCodec(ok.primitive(), err.primitive());
  }

  @override
  Expression valueFrom(Input input) {
    if (input.read() == 0) {
      return primitive().newInstanceNamed('ok', [ok.valueFrom(input)]);
    } else {
      return primitive().newInstanceNamed('err', [err.valueFrom(input)]);
    }
  }

  @override
  Expression codecInstance() {
    return codec().constInstance([ok.codecInstance(), err.codecInstance()]);
  }
}
