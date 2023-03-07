import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, CompactBigIntCodec;
import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference, literalString, literalNum;
import '../constants.dart' as constants;
import '../utils.dart' as utils show bigIntToExpression;
import './base.dart' show Generator;

class CompactGenerator extends Generator {
  const CompactGenerator();

  @override
  TypeReference primitive() {
    return constants.bigInt.type as TypeReference;
  }

  @override
  TypeReference codec() {
    return constants.compactBigIntCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(Input input) {
    final value = CompactBigIntCodec.codec.decode(input);
    return utils.bigIntToExpression(value);
  }
}
