import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show Input, CompactBigIntCodec;
import 'package:code_builder/code_builder.dart'
    show Expression, TypeReference;
import '../constants.dart' as constants;
import '../utils.dart' as utils show bigIntToExpression;
import './base.dart' show Generator;

class CompactGenerator extends Generator {
  const CompactGenerator();

  @override
  TypeReference primitive([ String? from ]) {
    return constants.bigInt.type as TypeReference;
  }

  @override
  TypeReference codec([ String? from ]) {
    return constants.compactBigIntCodec.type as TypeReference;
  }

  @override
  Expression valueFrom(Input input, [ String? from ]) {
    final value = CompactBigIntCodec.codec.decode(input);
    return utils.bigIntToExpression(value);
  }
}
