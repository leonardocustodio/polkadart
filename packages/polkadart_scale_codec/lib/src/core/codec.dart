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
    _types = types.toCodecTypes();
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
    Source src = Source(data);
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
  /// var result = codec.encodeToHex(registry.use('Option<u8>'), 8); // '0x0108'
  /// ```
  String encodeToHex(int type, dynamic val) {
    var sink = HexSink();
    encode(type, val, sink);
    return sink.toHex();
  }

  /// Encodes the [val] and outputs `Uint8List`
  ///
  ///Example:
  /// ```dart
  /// var result = codec.encodeToBinary(registry.use('Option<u8>'), 8); // [1, 8]
  /// ```
  Uint8List encodeToBinary(int type, dynamic val) {
    var sink = ByteSink();
    encode(type, val, sink);
    return sink.toBytes();
  }

  /// Decodes the [data] wrapped in [Source] object
  ///
  ///Example:
  /// ```dart
  /// Src src = Source('0x0108');
  /// var result = codec.decode(registry.use('Option<u8>'), src); // 8
  /// ```
  ///
  /// Throws `UnexpectedCaseException` if the type is not recognised.
  dynamic decode(int type, Source src) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        return _decodePrimitiveFromSource(
            (def as PrimitiveType).primitive, src);
      case TypeKind.Compact:
        return _decodeCompact((def as CodecCompactType), src);
      case TypeKind.BitSequence:
        return _decodeBitSequence(src);
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
        return _decodeBytes(src);
      case TypeKind.BytesArray:
        return src.bytes((def as CodecBytesArrayType).len);
      default:
        throw UnexpectedCaseException((def as Type).kind);
    }
  }

  /// Decodes Array
  List<dynamic> _decodeArray(ArrayType def, Source src) {
    int len = def.len;
    int type = def.type;
    List<dynamic> result = <dynamic>[]..length = len;

    for (var i = 0; i < len; i++) {
      result[i] = decode(type, src);
    }
    return result;
  }

  /// Decodes Bit Sequence
  List<dynamic> _decodeSequence(SequenceType def, Source src) {
    int len = src.compactLength();
    List<dynamic> result = <dynamic>[]..length = len;
    for (var i = 0; i < len; i++) {
      result[i] = decode(def.type, src);
    }
    return result;
  }

  /// Decodes Tuple
  List<dynamic>? _decodeTuple(TupleType def, Source src) {
    if (def.tuple.isEmpty) {
      return null;
    }
    List<dynamic> result = <dynamic>[]..length = def.tuple.length;
    for (var i = 0; i < def.tuple.length; i++) {
      result[i] = decode(def.tuple[i], src);
    }
    return result;
  }

  /// Decodes Struct
  Map<String, dynamic> _decodeStruct(CodecStructType def, Source src) {
    Map<String, dynamic> result = <String, dynamic>{};
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      result[f.name] = decode(f.type, src);
    }
    return result;
  }

  /// Decodes Variant
  Map<String, dynamic> _decodeVariant(CodecVariantType def, Source src) {
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

  /// Decodes Option
  dynamic _decodeOption(OptionType def, Source src) {
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

  /// Encodes the [val] and writes the result to [sink] object
  ///
  ///Example:
  /// ```dart
  /// // Byte ScaleCodecSink
  /// var byteSink = ByteSink();
  /// codec.encode(registry.use('Option<u8>'), 8, byteSink);
  /// byteSink.toBytes(); // [1, 8]
  ///
  /// //or
  /// // Hex ScaleCodecSink
  /// var hexSink = HexSink();
  /// codec.encode(registry.use('Option<u8>'), 8, hexSink);
  /// hexSink.toHex(); // '0x0108'
  ///
  /// ```
  void encode(int type, dynamic val, ScaleCodecSink sink) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        _encodePrimitive((def as PrimitiveType).primitive, val, sink);
        break;
      case TypeKind.Compact:
        sink.compact(val);
        break;
      case TypeKind.BitSequence:
        _encodeBitSequence(val, sink);
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
        _encodeBytesArray((def as CodecBytesArrayType), val, sink);
        break;
      case TypeKind.Bytes:
        _encodeBytes(val, sink);
        break;
      case TypeKind.Option:
        _encodeOption((def as OptionType), val, sink);
        break;
      default:
        throw UnexpectedCaseException(def.kind);
    }
  }

  ///
  /// Encodes Array
  void _encodeArray(ArrayType def, dynamic val, ScaleCodecSink sink) {
    assertionCheck(val is List && val.length == def.len);

    for (var i = 0; i < val.length; i++) {
      encode(def.type, val[i], sink);
    }
  }

  ///
  /// Encodes Bit Sequence
  void _encodeSequence(SequenceType def, dynamic val, ScaleCodecSink sink) {
    assertionCheck(val is List);
    sink.compact((val as List).length);
    for (var i = 0; i < val.length; i++) {
      encode(def.type, val[i], sink);
    }
  }

  ///
  /// Encodes Tuple
  void _encodeTuple(TupleType def, dynamic val, ScaleCodecSink sink) {
    if (def.tuple.isEmpty) {
      assert(val == null);
      return;
    }
    assertionCheck(val is List && def.tuple.length == val.length);
    for (var i = 0; i < val.length; i++) {
      encode(def.tuple[i], val[i], sink);
    }
  }

  ///
  /// Encodes Struct
  void _encodeStruct(CodecStructType def, dynamic val, ScaleCodecSink sink) {
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      encode(f.type, val[f.name], sink);
    }
  }

  ///
  /// Encodes Variant
  void _encodeVariant(CodecVariantType def, dynamic val, ScaleCodecSink sink) {
    assertionCheck(val is Map<String, dynamic>);
    assertionCheck(val['__kind'] is String, 'not a variant type value');

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

  ///
  /// Encodes Option
  void _encodeOption(OptionType def, dynamic val, ScaleCodecSink sink) {
    if (val == null) {
      sink.u8(0);
    } else {
      sink.u8(1);
      encode(def.type, val, sink);
    }
  }

  ///
  /// Decodes Bytes
  Uint8List _decodeBytes(Source src) {
    int len = src.compactLength();
    return src.bytes(len);
  }

  ///
  /// Encodes Bytes
  void _encodeBytes(dynamic val, ScaleCodecSink sink) {
    assertionCheck(val is List);
    sink.compact(val.length);
    sink.bytes(val);
  }

  ///
  /// Encodes Bytes Array
  void _encodeBytesArray(
      CodecBytesArrayType def, dynamic val, ScaleCodecSink sink) {
    assertionCheck(val is List && val.length == def.len);
    sink.bytes(val);
  }

  ///
  /// Decodes Bit Sequence
  Uint8List _decodeBitSequence(Source src) {
    var len = (src.compactLength() / 8).ceil();
    return src.bytes(len);
  }

  ///
  /// Encodes Bit Sequence
  void _encodeBitSequence(dynamic bits, ScaleCodecSink sink) {
    assertionCheck(bits is List);
    sink.compact(bits.length * 8);
    sink.bytes(bits);
  }

  ///
  /// Returns: `BigInt` | `int`
  dynamic _decodeCompact(CodecCompactType type, Source src) {
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

  /// Decodes [src] object when Primitive is known.
  dynamic _decodePrimitiveFromSource(Primitive type, Source src) {
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

  /// Encodes [src] object to `sink` when [Primitive] is know
  void _encodePrimitive(Primitive type, dynamic val, ScaleCodecSink sink) {
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
}
