part of 'package:ink_abi/interfaces/interfaces_base.dart';

enum Primitive {
  i8,
  u8,
  i16,
  u16,
  i32,
  u32,
  i64,
  u64,
  i128,
  u128,
  i256,
  u256,
  bool,
  str,
  char;

  static Primitive fromString(String value) {
    switch (value.toUpperCase()) {
      case 'I8':
        return Primitive.i8;
      case 'U8':
        return Primitive.u8;
      case 'I16':
        return Primitive.i16;
      case 'U16':
        return Primitive.u16;
      case 'I32':
        return Primitive.i32;
      case 'U32':
        return Primitive.u32;
      case 'I64':
        return Primitive.i64;
      case 'U64':
        return Primitive.u64;
      case 'I128':
        return Primitive.i128;
      case 'U128':
        return Primitive.u128;
      case 'I256':
        return Primitive.i256;
      case 'U256':
        return Primitive.u256;
      case 'Bool':
        return Primitive.bool;
      case 'Str':
        return Primitive.str;
      case 'Char':
        return Primitive.char;
      default:
        throw Exception('Invalid Primitive');
    }
  }
}
