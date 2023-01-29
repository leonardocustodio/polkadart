part of codec_types;

class CodecMapper {
  static Codec getCodec(String codecTypeName) {
    switch (codecTypeName.toLowerCase()) {
      case 'bool':
        return BoolCodec._();
      case 'u8':
        return U8._();
      case 'u16':
        return U16._();
      case 'u32':
        return U32._();
      case 'u64':
        return U64._();
      case 'u128':
        return U128._();
      case 'u256':
        return U256._();
      case 'i8':
        return I8._();
      case 'i16':
        return I16._();
      case 'i32':
        return I32._();
      case 'i64':
        return I64._();
      case 'i128':
        return I128._();
      case 'i256':
        return I256._();
      case 'compact':
        return Compact._();
      case 'vec':
        return Vec._();
      case 'string':
      case 'str':
        return Str._();
      case 'tuples':
        return Tuples._();
      case 'option':
        return Option._();
      case 'struct':
        return Struct._();
      case 'result':
        return Result._();
      case 'enum':
        return Enum._();
      case 'h256':
        return H256._();
      case 'btreemap':
        return BTreeMap._();
    }
    throw UnexpectedCodecException(
        'Expected a supported codec, but got $codecTypeName');
  }
}
