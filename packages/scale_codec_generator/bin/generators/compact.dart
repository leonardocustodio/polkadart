import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, CompactBigIntCodec;
import 'package:code_builder/code_builder.dart' show Expression, TypeReference;
import '../constants.dart' as constants;
import '../utils.dart' as utils show bigIntToExpression;
import './base.dart' show BasePath, Generator;

class CompactGenerator extends Generator {
  const CompactGenerator();

  @override
  TypeReference primitive(BasePath from) {
    return constants.bigInt.type as TypeReference;
  }

  @override
  TypeReference codec(BasePath from) {
    return constants.compactBigIntCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(BasePath from, Input input, { bool constant = false }) {
    final value = CompactBigIntCodec.codec.decode(input);
    return utils.bigIntToExpression(value);
  }

  @override
  TypeReference jsonType(BasePath from, [Set<Object> visited = const {}]) {
    return constants.bigInt.type as TypeReference;
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
