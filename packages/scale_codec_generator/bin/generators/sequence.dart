import 'package:code_builder/code_builder.dart'
    show
        Block,
        Code,
        CodeExpression,
        Expression,
        literalList,
        literalNum,
        TypeReference;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Input,
        CompactCodec,
        U8SequenceCodec,
        U16SequenceCodec,
        U32SequenceCodec,
        U64SequenceCodec,
        I8SequenceCodec,
        I16SequenceCodec,
        I32SequenceCodec,
        I64SequenceCodec;
import './base.dart' show Generator, LazyLoader;
import '../metadata_parser.dart' show Primitive;
import './primitive.dart' show PrimitiveGenerator;
import '../constants.dart' as constants;

class SequenceGenerator extends Generator {
  late Generator typeDef;

  SequenceGenerator(this.typeDef);

  SequenceGenerator._lazy();

  factory SequenceGenerator.lazy(
      {required LazyLoader loader, required int codec}) {
    final generator = SequenceGenerator._lazy();
    loader.addLoader((Map<int, Generator> register) {
      generator.typeDef = register[codec]!;
    });
    return generator;
  }

  @override
  TypeReference primitive() {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case Primitive.U8:
          return constants.uint8List.type as TypeReference;
        case Primitive.U16:
          return constants.uint16List.type as TypeReference;
        case Primitive.U32:
          return constants.uint32List.type as TypeReference;
        case Primitive.U64:
          return constants.uint64List.type as TypeReference;
        case Primitive.I8:
          return constants.int8List.type as TypeReference;
        case Primitive.I16:
          return constants.int16List.type as TypeReference;
        case Primitive.I32:
          return constants.int32List.type as TypeReference;
        case Primitive.I64:
          return constants.int64List.type as TypeReference;
        default:
          break;
      }
    }

    return constants.list(ref: typeDef.primitive());
  }

  @override
  TypeReference codec() {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case Primitive.U8:
          return constants.u8SequenceCodec.type as TypeReference;
        case Primitive.U16:
          return constants.u16SequenceCodec.type as TypeReference;
        case Primitive.U32:
          return constants.u32SequenceCodec.type as TypeReference;
        case Primitive.U64:
          return constants.u64SequenceCodec.type as TypeReference;
        case Primitive.I8:
          return constants.i8SequenceCodec.type as TypeReference;
        case Primitive.I16:
          return constants.i16SequenceCodec.type as TypeReference;
        case Primitive.I32:
          return constants.i32SequenceCodec.type as TypeReference;
        case Primitive.I64:
          return constants.i64SequenceCodec.type as TypeReference;
        default:
          break;
      }
    }

    return constants.sequenceCodec(typeDef.primitive());
  }

  @override
  Expression codecInstance() {
    final TypeReference codec = this.codec();

    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case Primitive.U8:
        case Primitive.U16:
        case Primitive.U32:
        case Primitive.U64:
        case Primitive.I8:
        case Primitive.I16:
        case Primitive.I32:
        case Primitive.I64:
          return codec.property('codec');
        default:
          break;
      }
    }

    return codec.constInstance([typeDef.codecInstance()]);
  }

  @override
  Expression valueFrom(Input input) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case Primitive.U8:
        case Primitive.Char:
          final list = U8SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint8List.newInstance([literalNum(list.length)]);
          }
          return constants.uint8List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U16:
          final list = U16SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint16List.newInstance([literalNum(list.length)]);
          }
          return constants.uint16List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U32:
          final list = U32SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint32List.newInstance([literalNum(list.length)]);
          }
          return constants.uint32List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U64:
          final list = U64SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint64List.newInstance([literalNum(list.length)]);
          }
          return constants.uint64List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I8:
          final list = I8SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int8List.newInstance([literalNum(list.length)]);
          }
          return constants.int8List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I16:
          final list = I16SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int16List.newInstance([literalNum(list.length)]);
          }
          return constants.int16List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I32:
          final list = I32SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int32List.newInstance([literalNum(list.length)]);
          }
          return constants.int32List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I64:
          final list = I64SequenceCodec.codec.decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int64List.newInstance([literalNum(list.length)]);
          }
          return constants.int64List
              .property('fromList')
              .call([literalList(list)]);
        default:
          break;
      }
    }

    final length = CompactCodec.codec.decode(input);
    return CodeExpression(Block((builder) {
      builder.statements.add(Code('['));
      for (var i = 0; i < length; i++) {
        builder.statements.add(typeDef.valueFrom(input).code);
        if (i < (length - 1)) {
          builder.statements.add(Code(', '));
        }
      }
      builder.statements.add(Code(']'));
    }));
  }
}
