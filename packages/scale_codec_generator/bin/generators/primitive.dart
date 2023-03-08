import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Input,
        BoolCodec,
        StrCodec,
        U8Codec,
        U16Codec,
        U32Codec,
        U64Codec,
        U128Codec,
        I8Codec,
        I16Codec,
        I32Codec,
        I64Codec,
        I128Codec;
import 'package:code_builder/code_builder.dart'
    show TypeReference, Expression, literalBool, literalString, literalNum;
import '../metadata_parser.dart' show Primitive;
import './base.dart' show BasePath, Generator;
import '../constants.dart' as constants;
import '../utils.dart' as utils show bigIntToExpression;

class PrimitiveGenerator extends Generator {
  final Primitive primitiveType;

  const PrimitiveGenerator._(this.primitiveType);

  factory PrimitiveGenerator(Primitive primitive) {
    switch (primitive) {
      case Primitive.Bool:
        return PrimitiveGenerator.bool;
      case Primitive.Str:
        return PrimitiveGenerator.str;
      case Primitive.Char:
        return PrimitiveGenerator.char;
      case Primitive.U8:
        return PrimitiveGenerator.u8;
      case Primitive.U16:
        return PrimitiveGenerator.u16;
      case Primitive.U32:
        return PrimitiveGenerator.u32;
      case Primitive.U64:
        return PrimitiveGenerator.u64;
      case Primitive.U128:
        return PrimitiveGenerator.u128;
      case Primitive.I8:
        return PrimitiveGenerator.i8;
      case Primitive.I16:
        return PrimitiveGenerator.i16;
      case Primitive.I32:
        return PrimitiveGenerator.i32;
      case Primitive.I64:
        return PrimitiveGenerator.i64;
      case Primitive.I128:
        return PrimitiveGenerator.u128;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  static const PrimitiveGenerator str = PrimitiveGenerator._(Primitive.Str);
  static const PrimitiveGenerator char = PrimitiveGenerator._(Primitive.Char);
  static const PrimitiveGenerator bool = PrimitiveGenerator._(Primitive.Bool);
  static const PrimitiveGenerator i8 = PrimitiveGenerator._(Primitive.I8);
  static const PrimitiveGenerator i16 = PrimitiveGenerator._(Primitive.I16);
  static const PrimitiveGenerator i32 = PrimitiveGenerator._(Primitive.I32);
  static const PrimitiveGenerator i64 = PrimitiveGenerator._(Primitive.I64);
  static const PrimitiveGenerator i128 = PrimitiveGenerator._(Primitive.I128);
  static const PrimitiveGenerator u8 = PrimitiveGenerator._(Primitive.U8);
  static const PrimitiveGenerator u16 = PrimitiveGenerator._(Primitive.U16);
  static const PrimitiveGenerator u32 = PrimitiveGenerator._(Primitive.U32);
  static const PrimitiveGenerator u64 = PrimitiveGenerator._(Primitive.U64);
  static const PrimitiveGenerator u128 = PrimitiveGenerator._(Primitive.U128);

  @override
  TypeReference primitive(BasePath from) {
    switch (primitiveType) {
      case Primitive.Bool:
        return constants.bool.type as TypeReference;
      case Primitive.Str:
        return constants.string.type as TypeReference;
      case Primitive.Char:
      case Primitive.U8:
      case Primitive.U16:
      case Primitive.U32:
      case Primitive.I8:
      case Primitive.I16:
      case Primitive.I32:
        return constants.int.type as TypeReference;
      case Primitive.U64:
      case Primitive.U128:
      case Primitive.I64:
      case Primitive.I128:
        return constants.bigInt.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  TypeReference codec(BasePath from) {
    switch (primitiveType) {
      case Primitive.Bool:
        return constants.boolCodec.type as TypeReference;
      case Primitive.Str:
        return constants.strCodec.type as TypeReference;
      case Primitive.Char:
      case Primitive.U8:
        return constants.u8Codec.type as TypeReference;
      case Primitive.U16:
        return constants.u16Codec.type as TypeReference;
      case Primitive.U32:
        return constants.u32Codec.type as TypeReference;
      case Primitive.U64:
        return constants.u64Codec.type as TypeReference;
      case Primitive.U128:
        return constants.u128Codec.type as TypeReference;
      case Primitive.I8:
        return constants.i8Codec.type as TypeReference;
      case Primitive.I16:
        return constants.i16Codec.type as TypeReference;
      case Primitive.I32:
        return constants.i32Codec.type as TypeReference;
      case Primitive.I64:
        return constants.i64Codec.type as TypeReference;
      case Primitive.I128:
        return constants.i128Codec.type as TypeReference;
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  Expression valueFrom(BasePath from, Input input) {
    switch (primitiveType) {
      case Primitive.Bool:
        return literalBool(BoolCodec.codec.decode(input));
      case Primitive.Str:
        return literalString(StrCodec.codec.decode(input));
      case Primitive.Char:
      case Primitive.U8:
        return literalNum(U8Codec.codec.decode(input));
      case Primitive.U16:
        return literalNum(U16Codec.codec.decode(input));
      case Primitive.U32:
        return literalNum(U32Codec.codec.decode(input));
      case Primitive.U64:
        return utils.bigIntToExpression(U64Codec.codec.decode(input));
      case Primitive.U128:
        return utils.bigIntToExpression(U128Codec.codec.decode(input));
      case Primitive.I8:
        return literalNum(I8Codec.codec.decode(input));
      case Primitive.I16:
        return literalNum(I16Codec.codec.decode(input));
      case Primitive.I32:
        return literalNum(I32Codec.codec.decode(input));
      case Primitive.I64:
        return utils.bigIntToExpression(I64Codec.codec.decode(input));
      case Primitive.I128:
        return utils.bigIntToExpression(I128Codec.codec.decode(input));
      default:
        throw Exception('Unsupported primitive $primitive');
    }
  }

  @override
  Expression instanceToJson(BasePath from, Expression obj) {
    return obj;
  }
}
