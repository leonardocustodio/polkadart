part of polkadart_scale_codec_core;

///
/// Codec
class Codec {
  List<CodecType> _types = <CodecType>[];

  /// Initialize the Codec types with the help of metadata
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'as scale_codec;
  /// import 'package:substrate_metadata/old/types.dart' as old_types;
  /// import 'package:substrate_metadata/old/type_registry.dart';
  ///
  ///
  /// // Creates the registry for parsing the types and selecting particular schema.
  /// var registry = OldTypeRegistry(
  ///   old_types.OldTypes(
  ///     types: <String, dynamic>{
  ///       'Codec': {
  ///         'vec_u8': 'Vec<u8>',
  ///         'option_u8': 'Option<u8>',
  ///         'primitive_compact_u8': 'Compact<u8>',
  ///         'primitive_i8': 'i8',
  ///         'primitive_i16': 'i16',
  ///         'primitive_i32': 'i32',
  ///         'primitive_i64': 'i64',
  ///         'primitive_i128': 'i128',
  ///         'primitive_i256': 'i256',
  ///         'primitive_u8': 'u8',
  ///         'primitive_u16': 'u16',
  ///         'primitive_u32': 'u32',
  ///         'primitive_u64': 'u64',
  ///         'primitive_u128': 'u128',
  ///         'primitive_u256': 'u256',
  ///       },
  ///     },
  ///   ),
  /// );
  ///
  /// // specifying which schema type to use when creating types
  /// registry.use('Codec');
  ///
  /// // fetching the parsed types from `Json` to `Type`
  /// var types = registry.getTypes();
  ///
  /// // Initializing Scale-Codec object
  /// var codec = scale_codec.Codec(types);
  /// ```
  Codec(List<Type> types) {
    _types = toCodecTypes(types);
  }

  /// Decodes the value with initialized codec
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'as scale_codec;
  /// import 'package:substrate_metadata/old/types.dart' as old_types;
  /// import 'package:substrate_metadata/old/type_registry.dart';
  ///
  ///
  /// // Creates the registry for parsing the types and selecting particular schema.
  /// var registry = OldTypeRegistry(
  ///   old_types.OldTypes(
  ///     types: <String, dynamic>{
  ///       'Codec': {
  ///         'vec_u8': 'Vec<u8>',
  ///         'option_u8': 'Option<u8>',
  ///         'primitive_compact_u8': 'Compact<u8>',
  ///         'primitive_i8': 'i8',
  ///         'primitive_i16': 'i16',
  ///         'primitive_i32': 'i32',
  ///         'primitive_i64': 'i64',
  ///         'primitive_i128': 'i128',
  ///         'primitive_i256': 'i256',
  ///         'primitive_u8': 'u8',
  ///         'primitive_u16': 'u16',
  ///         'primitive_u32': 'u32',
  ///         'primitive_u64': 'u64',
  ///         'primitive_u128': 'u128',
  ///         'primitive_u256': 'u256',
  ///       },
  ///     },
  ///   ),
  /// );
  ///
  /// // specifying which schema type to use when creating types
  /// registry.use('Codec');
  ///
  /// // fetching the parsed types from `Json` to `Type`
  /// var types = registry.getTypes();
  ///
  /// // Initializing Scale-Codec object
  /// var codec = scale_codec.Codec(types);
  ///
  /// var result = codec.decodeBinary(registry.use('Option<u8>'), '0x0108'); // 8
  /// ```
  dynamic decodeBinary(int type, dynamic data) {
    Src src = Src(data);
    var val = decode(type, src);
    src.assertEOF();
    return val;
  }

  /// Encodes the value to hex
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart'as scale_codec;
  /// import 'package:substrate_metadata/old/types.dart' as old_types;
  /// import 'package:substrate_metadata/old/type_registry.dart';
  ///
  ///
  /// // Creates the registry for parsing the types and selecting particular schema.
  /// var registry = OldTypeRegistry(
  ///   old_types.OldTypes(
  ///     types: <String, dynamic>{
  ///       'Codec': {
  ///         'vec_u8': 'Vec<u8>',
  ///         'option_u8': 'Option<u8>',
  ///         'primitive_compact_u8': 'Compact<u8>',
  ///         'primitive_i8': 'i8',
  ///         'primitive_i16': 'i16',
  ///         'primitive_i32': 'i32',
  ///         'primitive_i64': 'i64',
  ///         'primitive_i128': 'i128',
  ///         'primitive_i256': 'i256',
  ///         'primitive_u8': 'u8',
  ///         'primitive_u16': 'u16',
  ///         'primitive_u32': 'u32',
  ///         'primitive_u64': 'u64',
  ///         'primitive_u128': 'u128',
  ///         'primitive_u256': 'u256',
  ///       },
  ///     },
  ///   ),
  /// );
  ///
  /// // specifying which schema type to use when creating types
  /// registry.use('Codec');
  ///
  /// // fetching the parsed types from `Json` to `Type`
  /// var types = registry.getTypes();
  ///
  /// // Initializing Scale-Codec object
  /// var codec = scale_codec.Codec(types);
  ///
  /// var result = codec.decodeBinary(registry.use('Option<u8>'), '0x0108'); // 8
  /// ```
  String encodeToHex(int type, dynamic val) {
    var sink = HexSink();
    encode(type, val, sink);
    return sink.toHex();
  }

  Uint8List encodeToBinary(int type, dynamic val) {
    var sink = ByteSink();
    encode(type, val, sink);
    return sink.toBytes();
  }

  dynamic decode(int type, Src src) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        return decodePrimitiveFromSrc((def as PrimitiveType).primitive, src);
      case TypeKind.Compact:
        return decodeCompact((def as CodecCompactType), src);
      case TypeKind.BitSequence:
        return decodeBitSequence(src);
      case TypeKind.Array:
        return _decodeArray((def as ArrayType), src);
      case TypeKind.Sequence:
        return _decodeSequence((def as SequenceType), src);
      case TypeKind.Tuple:
        return _decodeTuple((def as TupleType), src);
      case TypeKind.Struct:
        return _decodeStruct((def as CodecStructType), src);
      case TypeKind.Variant:
        return _decodeVariant((def as CodecVariantType), src);
      case TypeKind.Option:
        return _decodeOption((def as OptionType), src);
      case TypeKind.Bytes:
        return decodeBytes(src);
      case TypeKind.BytesArray:
        return src.bytes((def as CodecBytesArrayType).len);
      default:
        throw UnexpectedCaseException((def as Type).kind);
    }
  }

  List<dynamic> _decodeArray(ArrayType def, Src src) {
    int len = def.len;
    int type = def.type;
    List<dynamic> result = <dynamic>[]..length = len;

    for (var i = 0; i < len; i++) {
      result[i] = decode(type, src);
    }
    return result;
  }

  List<dynamic> _decodeSequence(SequenceType def, Src src) {
    int len = src.compactLength();
    List<dynamic> result = <dynamic>[]..length = len;
    for (var i = 0; i < len; i++) {
      result[i] = decode(def.type, src);
    }
    return result;
  }

  List<dynamic>? _decodeTuple(TupleType def, Src src) {
    if (def.tuple.isEmpty) {
      return null;
    }
    List<dynamic> result = <dynamic>[]..length = def.tuple.length;
    for (var i = 0; i < def.tuple.length; i++) {
      result[i] = decode(def.tuple[i], src);
    }
    return result;
  }

  Map<String, dynamic> _decodeStruct(CodecStructType def, Src src) {
    Map<String, dynamic> result = <String, dynamic>{};
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      result[f.name] = decode(f.type, src);
    }
    return result;
  }

  Map<String, dynamic> _decodeVariant(CodecVariantType def, Src src) {
    var idx = src.u8();
    CodecVariant? variant =
        idx < def.variants.length ? def.variants[idx] : null;
    if (variant == null) {
      throw UnexpectedCaseException('unknown variant index: $idx');
    }
    switch (variant.kind) {
      case CodecVariantKind.empty:
        return <String, dynamic>{'__kind': variant.name};
      case CodecVariantKind.tuple:
        return <String, dynamic>{
          '__kind': variant.name,
          'value': _decodeTuple((variant as CodecTupleVariant).def, src)
        };
      case CodecVariantKind.value:
        return <String, dynamic>{
          '__kind': variant.name,
          'value': decode((variant as CodecValueVariant).type, src)
        };
      case CodecVariantKind.struct:
        {
          Map<String, dynamic> value =
              _decodeStruct((variant as CodecStructVariant).def, src);
          value['__kind'] = variant.name;
          return value;
        }
    }
  }

  dynamic _decodeOption(OptionType def, Src src) {
    int byte = src.u8();
    switch (byte) {
      case 0:
        return null;
      case 1:
        return decode(def.type, src);
      default:
        throw UnexpectedCaseException(byte);
    }
  }

  void encode(int type, dynamic val, Sink sink) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        encodePrimitive((def as PrimitiveType).primitive, val, sink);
        break;
      case TypeKind.Compact:
        sink.compact(val);
        break;
      case TypeKind.BitSequence:
        encodeBitSequence(val, sink);
        break;
      case TypeKind.Array:
        _encodeArray((def as ArrayType), val, sink);
        break;
      case TypeKind.Sequence:
        _encodeSequence((def as SequenceType), val, sink);
        break;
      case TypeKind.Tuple:
        _encodeTuple((def as TupleType), val, sink);
        break;
      case TypeKind.Struct:
        _encodeStruct((def as CodecStructType), val, sink);
        break;
      case TypeKind.Variant:
        _encodeVariant((def as CodecVariantType), val, sink);
        break;
      case TypeKind.BytesArray:
        encodeBytesArray((def as CodecBytesArrayType), val, sink);
        break;
      case TypeKind.Bytes:
        encodeBytes(val, sink);
        break;
      case TypeKind.Option:
        _encodeOption((def as OptionType), val, sink);
        break;
      default:
        throw UnexpectedCaseException(def.kind);
    }
  }

  void _encodeArray(ArrayType def, dynamic val, Sink sink) {
    assertNotNull(val is List && val.length == def.len);

    for (var i = 0; i < val.length; i++) {
      encode(def.type, val[i], sink);
    }
  }

  void _encodeSequence(SequenceType def, dynamic val, Sink sink) {
    assertNotNull(val is List);
    sink.compact((val as List).length);
    for (var i = 0; i < val.length; i++) {
      encode(def.type, val[i], sink);
    }
  }

  void _encodeTuple(TupleType def, dynamic val, Sink sink) {
    if (def.tuple.isEmpty) {
      assert(val == null);
      return;
    }
    assertNotNull(val is List && def.tuple.length == val.length);
    for (var i = 0; i < val.length; i++) {
      encode(def.tuple[i], val[i], sink);
    }
  }

  void _encodeStruct(CodecStructType def, dynamic val, Sink sink) {
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      encode(f.type, val[f.name], sink);
    }
  }

  void _encodeVariant(CodecVariantType def, dynamic val, Sink sink) {
    assertNotNull(val is Map<String, dynamic>);
    assertNotNull(val['__kind'] is String, 'not a variant type value');

    CodecVariant? variant = def.variantsByName[val['__kind']];
    if (variant == null) {
      throw Exception('Unknown variant: ${val['__kind']}');
    }
    sink.u8(variant.index);
    switch (variant.kind) {
      case CodecVariantKind.empty:
        break;
      case CodecVariantKind.value:
        encode((variant as CodecValueVariant).type, val['value'], sink);
        break;
      case CodecVariantKind.tuple:
        _encodeTuple((variant as CodecTupleVariant).def, val['value'], sink);
        break;
      case CodecVariantKind.struct:
        _encodeStruct((variant as CodecStructVariant).def, val, sink);
        break;
    }
  }

  void _encodeOption(OptionType def, dynamic val, Sink sink) {
    if (val == null) {
      sink.u8(0);
    } else {
      sink.u8(1);
      encode(def.type, val, sink);
    }
  }
}

Uint8List decodeBytes(Src src) {
  int len = src.compactLength();
  return src.bytes(len);
}

void encodeBytes(dynamic val, Sink sink) {
  assertNotNull(val is List);
  sink.compact(val.length);
  sink.bytes(val);
}

void encodeBytesArray(CodecBytesArrayType def, dynamic val, Sink sink) {
  assertNotNull(val is List && val.length == def.len);
  sink.bytes(val);
}

Uint8List decodeBitSequence(Src src) {
  var len = (src.compactLength() / 8).ceil();
  return src.bytes(len);
}

void encodeBitSequence(dynamic bits, Sink sink) {
  assertNotNull(bits is List);
  sink.compact(bits.length * 8);
  sink.bytes(bits);
}

///
/// Returns: `BigInt` | `int`
dynamic decodeCompact(CodecCompactType type, Src src) {
  var n = src.compact();

  // n is either [BigInt] or [int]
  switch (type.integer) {
    case Primitive.U8:
    case Primitive.U16:
    case Primitive.U32:
      return n;
    default:
      return n is int ? BigInt.from(n) : n;
  }
}

dynamic decodePrimitiveFromSrc(Primitive type, Src src) {
  switch (type) {
    case Primitive.I8:
      return src.i8();
    case Primitive.U8:
      return src.u8();
    case Primitive.I16:
      return src.i16();
    case Primitive.U16:
      return src.u16();
    case Primitive.I32:
      return src.i32();
    case Primitive.U32:
      return src.u32();
    case Primitive.I64:
      return src.i64();
    case Primitive.U64:
      return src.u64();
    case Primitive.I128:
      return src.i128();
    case Primitive.U128:
      return src.u128();
    case Primitive.I256:
      return src.i256();
    case Primitive.U256:
      return src.u256();
    case Primitive.Bool:
      return src.boolean();
    case Primitive.Str:
      return src.str();
    default:
      throw UnexpectedCaseException(type);
  }
}

void encodePrimitive(Primitive type, dynamic val, Sink sink) {
  switch (type) {
    case Primitive.I8:
      sink.i8(val);
      break;
    case Primitive.U8:
      sink.u8(val);
      break;
    case Primitive.I16:
      sink.i16(val);
      break;
    case Primitive.U16:
      sink.u16(val);
      break;
    case Primitive.I32:
      sink.i32(val);
      break;
    case Primitive.U32:
      sink.u32(val);
      break;
    case Primitive.I64:
      sink.i64(val);
      break;
    case Primitive.U64:
      sink.u64(val);
      break;
    case Primitive.I128:
      sink.i128(val);
      break;
    case Primitive.U128:
      sink.u128(val);
      break;
    case Primitive.I256:
      sink.i256(val);
      break;
    case Primitive.U256:
      sink.u256(val);
      break;
    case Primitive.Bool:
      sink.boolean(val);
      break;
    case Primitive.Str:
      sink.str(val);
      break;
    default:
      throw UnexpectedCaseException(type);
  }
}
