// ignore_for_file: camel_case_types

part of models;

class Si0TypeDefPrimitive {
  final String kind;
  const Si0TypeDefPrimitive({required this.kind});

  /// Creates Class Object from `Json`
  static Si0TypeDefPrimitive fromKey(String key) {
    switch (key) {
      case 'Bool':
        return Si0TypeDefPrimitive_Bool();
      case 'Char':
        return Si0TypeDefPrimitive_Char();
      case 'Str':
        return Si0TypeDefPrimitive_Str();
      case 'U8':
        return Si0TypeDefPrimitive_U8();
      case 'U16':
        return Si0TypeDefPrimitive_U16();
      case 'U32':
        return Si0TypeDefPrimitive_U32();
      case 'U64':
        return Si0TypeDefPrimitive_U64();
      case 'U128':
        return Si0TypeDefPrimitive_U128();
      case 'U256':
        return Si0TypeDefPrimitive_U256();
      case 'I8':
        return Si0TypeDefPrimitive_I8();
      case 'I16':
        return Si0TypeDefPrimitive_I16();
      case 'I32':
        return Si0TypeDefPrimitive_I32();
      case 'I64':
        return Si0TypeDefPrimitive_I64();
      case 'I128':
        return Si0TypeDefPrimitive_I128();
      case 'I256':
        return Si0TypeDefPrimitive_I256();
      default:
        throw UnexpectedTypeException('Unexpected type: $key');
    }
  }
}

class Si0TypeDefPrimitive_Bool extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Bool() : super(kind: 'Bool');
}

class Si0TypeDefPrimitive_Char extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Char() : super(kind: 'Char');
}

class Si0TypeDefPrimitive_Str extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_Str() : super(kind: 'Str');
}

class Si0TypeDefPrimitive_U8 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U8() : super(kind: 'U8');
}

class Si0TypeDefPrimitive_U16 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U16() : super(kind: 'U16');
}

class Si0TypeDefPrimitive_U32 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U32() : super(kind: 'U32');
}

class Si0TypeDefPrimitive_U64 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U64() : super(kind: 'U64');
}

class Si0TypeDefPrimitive_U128 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U128() : super(kind: 'U128');
}

class Si0TypeDefPrimitive_U256 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_U256() : super(kind: 'U256');
}

class Si0TypeDefPrimitive_I8 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I8() : super(kind: 'I8');
}

class Si0TypeDefPrimitive_I16 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I16() : super(kind: 'I16');
}

class Si0TypeDefPrimitive_I32 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I32() : super(kind: 'I32');
}

class Si0TypeDefPrimitive_I64 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I64() : super(kind: 'I64');
}

class Si0TypeDefPrimitive_I128 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I128() : super(kind: 'I128');
}

class Si0TypeDefPrimitive_I256 extends Si0TypeDefPrimitive {
  const Si0TypeDefPrimitive_I256() : super(kind: 'I256');
}
