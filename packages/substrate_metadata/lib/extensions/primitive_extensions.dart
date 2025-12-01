import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
import 'package:substrate_metadata/substrate_metadata.dart';

extension PrimitiveExtension on Primitive {
  Codec get primitiveCodec {
    return switch (this) {
      Primitive.Bool => BoolCodec.codec,
      Primitive.Char => U32Codec.codec, // Char is u32 in Rust
      Primitive.Str => StrCodec.codec,
      Primitive.U8 => U8Codec.codec,
      Primitive.U16 => U16Codec.codec,
      Primitive.U32 => U32Codec.codec,
      Primitive.U64 => U64Codec.codec,
      Primitive.U128 => U128Codec.codec,
      Primitive.U256 => U256Codec.codec,
      Primitive.I8 => I8Codec.codec,
      Primitive.I16 => I16Codec.codec,
      Primitive.I32 => I32Codec.codec,
      Primitive.I64 => I64Codec.codec,
      Primitive.I128 => I128Codec.codec,
      Primitive.I256 => I256Codec.codec,
    };
  }
}
