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
  TypeReference primitive([String? from]) {
    return constants.result(ok.primitive(from), err.primitive(from));
  }

  @override
  TypeReference codec([String? from]) {
    return constants.resultCodec(ok.primitive(from), err.primitive(from));
  }

  @override
  Expression valueFrom(Input input, [String? from]) {
    if (input.read() == 0) {
      return primitive(from)
          .newInstanceNamed('ok', [ok.valueFrom(input, from)]);
    } else {
      return primitive(from)
          .newInstanceNamed('err', [err.valueFrom(input, from)]);
    }
  }

  @override
  Expression codecInstance([String? from]) {
    return codec(from)
        .constInstance([ok.codecInstance(from), err.codecInstance(from)]);
  }
}
