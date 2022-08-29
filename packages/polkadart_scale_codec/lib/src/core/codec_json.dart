part of polkadart_scale_codec_core;

class JsonCodec {
  static dynamic encode(dynamic val) {
    return toJSON(val);
  }

  List<CodecType> _types = <CodecType>[];

  JsonCodec(List<Type> types) {
    _types = toCodecTypes(types);
  }

  dynamic decode(int type, dynamic val) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        return decodePrimitive((def as PrimitiveType).primitive, val);
      case TypeKind.Compact:
        return decodePrimitive((def as CodecCompactType).integer, val);
      case TypeKind.BitSequence:
        return decodeHex(val as String);
      case TypeKind.Array:
        return _decodeArray(def as ArrayType, val);
      case TypeKind.Sequence:
        return _decodeSequence(def as SequenceType, val);
      case TypeKind.Tuple:
        return _decodeTuple(def as TupleType, val);
      case TypeKind.Struct:
        return _decodeStruct(def as CodecStructType, val);
      case TypeKind.Variant:
        return _decodeVariant(def as CodecVariantType, val);
      case TypeKind.Option:
        return _decodeOption(def as OptionType, val);
      case TypeKind.BooleanOption:
        return decodeBooleanOption(val);
      case TypeKind.Bytes:
        return decodeHex(val as String);
      case TypeKind.BytesArray:
        return decodeBinaryArray((def as CodecBytesArrayType).len, val);
      case TypeKind.DoNotConstruct:
        throw UnexpectedCaseException('DoNotConstruct type reached');
      default:
        throw UnexpectedCaseException();
    }
  }

  List<dynamic> _decodeArray(ArrayType def, dynamic value) {
    int len = def.len;
    int type = def.type;
    assertionCheck(value is List);
    assertionCheck((value as List).length == len);
    var result = []..length = len;
    for (var i = 0; i < len; i++) {
      result[i] = decode(type, value[i]);
    }
    return result;
  }

  List<dynamic> _decodeSequence(SequenceType def, dynamic value) {
    assertionCheck(value is List);
    var result = []..length = (value as List).length;
    for (var i = 0; i < value.length; i++) {
      result[i] = decode(def.type, value[i]);
    }
    return result;
  }

  dynamic _decodeTuple(TupleType def, dynamic value) {
    List<int> items = def.tuple;
    if (items.isEmpty) {
      assertionCheck(value == null || value is List && value.isEmpty);
      return null;
    } else {
      assertionCheck(value is List);
      assertionCheck((value as List).length == items.length);
      List result = []..length = items.length;
      for (var i = 0; i < items.length; i++) {
        result[i] = decode(items[i], value[i]);
      }
      return result;
    }
  }

  Map<String, dynamic> _decodeStruct(CodecStructType def, dynamic value) {
    assertionCheck(isObject(value));
    var result = <String, dynamic>{};
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      result[f.name] = decode(f.type, value[f.name]);
    }
    return result;
  }

  Map<String, dynamic> _decodeVariant(CodecVariantType def, dynamic value) {
    assertionCheck(isObject(value));
    assertionCheck(value is Map);
    assertionCheck(value['kind'] is String);
    CodecVariant? variant = def.variantsByName[value['kind']];
    if (variant == null) {
      throw Exception('Unknown variant ${value['kind']}');
    }
    switch (variant.kind) {
      case CodecVariantKind.empty:
        return <String, dynamic>{
          'kind': value['kind'],
        };
      case CodecVariantKind.value:
        return <String, dynamic>{
          'kind': value['kind'],
          'value': decode((variant as CodecValueVariant).type, value['value'])
        };
      case CodecVariantKind.tuple:
        return <String, dynamic>{
          'kind': value['kind'],
          'value': _decodeTuple((variant as CodecTupleVariant).def, value.value)
        };
      case CodecVariantKind.struct:
        Map<String, dynamic> s =
            _decodeStruct((variant as CodecStructVariant).def, value);
        s['kind'] = value['kind'];
        return s;
      default:
        throw UnexpectedCaseException(variant.kind);
    }
  }

  Map<String, dynamic>? _decodeOption(OptionType def, dynamic value) {
    return value == null ? null : decode(def.type, value);
  }
}

/// Returns: [String] | [bool] | [int] | [BigInt]
///
dynamic decodePrimitive(Primitive type, dynamic value) {
  switch (type) {
    case Primitive.I8:
      checkSignedInt(value, 8);
      return value;
    case Primitive.I16:
      checkSignedInt(value, 16);
      return value;
    case Primitive.I32:
      checkSignedInt(value, 32);
      return value;
    case Primitive.I64:
      return toSignedBigInt(value, 64);
    case Primitive.I128:
      return toSignedBigInt(value, 128);
    case Primitive.I256:
      return toSignedBigInt(value, 256);
    case Primitive.U8:
      checkUnsignedInt(value, 8);
      return value;
    case Primitive.U16:
      checkUnsignedInt(value, 16);
      return value;
    case Primitive.U32:
      checkUnsignedInt(value, 32);
      return value;
    case Primitive.U64:
      return toUnsignedBigInt(value, 64);
    case Primitive.U128:
      return toUnsignedBigInt(value, 128);
    case Primitive.U256:
      return toUnsignedBigInt(value, 256);
    case Primitive.Bool:
      assertionCheck(value is bool);
      return value;
    case Primitive.Str:
      assertionCheck(value is String);
      return value;
    default:
      throw UnexpectedCaseException(type);
  }
}

bool? decodeBooleanOption(dynamic value) {
  if (value == null) {
    return null;
  }
  assertionCheck(value is bool);
  return value;
}

Uint8List decodeBinaryArray(int len, dynamic value) {
  var data = decodeHex(value as String);
  assertionCheck(data.length == len);
  return data;
}
