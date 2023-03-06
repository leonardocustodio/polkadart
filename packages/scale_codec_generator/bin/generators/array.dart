import 'package:code_builder/code_builder.dart'
    show
        Code,
        CodeExpression,
        TypeReference,
        Expression,
        Block,
        literalNum,
        literalList;
import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'
    show
        Input,
        U8ArrayCodec,
        U16ArrayCodec,
        U32ArrayCodec,
        U64ArrayCodec,
        I8ArrayCodec,
        I16ArrayCodec,
        I32ArrayCodec,
        I64ArrayCodec;
import '../metadata_parser.dart' show Primitive;
import '../constants.dart' as constants;
import './base.dart' show Generator, LazyLoader;
import './primitive.dart' show PrimitiveGenerator;

class ArrayGenerator extends Generator {
  late Generator typeDef;
  final int length;

  ArrayGenerator({required Generator codec, required this.length})
      : typeDef = codec;
  ArrayGenerator._lazy({required this.length});

  factory ArrayGenerator.lazy(
      {required LazyLoader loader, required int codec, required int length}) {
    final generator = ArrayGenerator._lazy(length: length);
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
          return constants.u8ArrayCodec.type as TypeReference;
        case Primitive.U16:
          return constants.u16ArrayCodec.type as TypeReference;
        case Primitive.U32:
          return constants.u32ArrayCodec.type as TypeReference;
        case Primitive.U64:
          return constants.u64ArrayCodec.type as TypeReference;
        case Primitive.I8:
          return constants.i8ArrayCodec.type as TypeReference;
        case Primitive.I16:
          return constants.i16ArrayCodec.type as TypeReference;
        case Primitive.I32:
          return constants.i32ArrayCodec.type as TypeReference;
        case Primitive.I64:
          return constants.i64ArrayCodec.type as TypeReference;
        default:
          break;
      }
    }

    return constants.arrayCodec(typeDef.primitive());
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
          return codec.constInstance([literalNum(length)]);
        default:
          break;
      }
    }

    return codec.constInstance([
      typeDef.codecInstance(),
      literalNum(length),
    ]);
  }

  @override
  Expression valueFrom(Input input) {
    if (typeDef is PrimitiveGenerator) {
      switch ((typeDef as PrimitiveGenerator).primitiveType) {
        case Primitive.U8:
        case Primitive.Char:
          final list = U8ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint8List.newInstance([literalNum(list.length)]);
          }
          return constants.uint8List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U16:
          final list = U16ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint16List.newInstance([literalNum(list.length)]);
          }
          return constants.uint16List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U32:
          final list = U32ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint32List.newInstance([literalNum(list.length)]);
          }
          return constants.uint32List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.U64:
          final list = U64ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.uint64List.newInstance([literalNum(list.length)]);
          }
          return constants.uint64List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I8:
          final list = I8ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int8List.newInstance([literalNum(list.length)]);
          }
          return constants.int8List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I16:
          final list = I16ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int16List.newInstance([literalNum(list.length)]);
          }
          return constants.int16List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I32:
          final list = I32ArrayCodec(length).decode(input);
          if (list.every((value) => value == 0)) {
            return constants.int32List.newInstance([literalNum(list.length)]);
          }
          return constants.int32List
              .property('fromList')
              .call([literalList(list)]);
        case Primitive.I64:
          final list = I64ArrayCodec(length).decode(input);
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
