import 'package:code_builder/code_builder.dart' show TypeReference, Expression, literalNull;
import 'package:scale_codec/scale_codec.dart' show Input;
import '../constants.dart' as constants;
import './base.dart' show Generator;

class EmptyGenerator extends Generator {

  const EmptyGenerator();

  @override
  TypeReference primitive() {
    return constants.dynamic.type as TypeReference;
  }

  @override
  TypeReference codec() {
    return constants.emptyCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(Input input) {
    return literalNull;
  }
}
