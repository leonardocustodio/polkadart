import 'package:code_builder/code_builder.dart'
    show TypeReference, Expression, literalNull;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' show Input;
import '../constants.dart' as constants;
import './base.dart' show BasePath, Generator;

class EmptyGenerator extends Generator {
  EmptyGenerator();

  @override
  TypeReference primitive(BasePath from) {
    return constants.dynamic.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.emptyCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(BasePath from, Input input) {
    return literalNull;
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Generator> visited = const {}]) {
    return constants.dynamic.type as TypeReference;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return literalNull;
  }
}
