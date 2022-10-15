part of polkadart_scale_codec_core;

///
/// Codec
class Codec {
  List<CodecType> _types = <CodecType>[];

  /// Initialize the Codec types with the help of metadata
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
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
  /// var codec = Codec(types);
  /// ```
  Codec(List<Type> types) {
    _types = types.toCodecTypes();
  }

  /// Decodes the value with initialized codec
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
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
  /// var codec = Codec(types);
  ///
  /// var result = codec.decode(registry.use('Option<u8>'), '0x0108'); // 8
  /// ```
  dynamic decode(int type, dynamic data) {
    Source source = Source(data);
    var val = _decodeFromSource(type, source);
    source.assertEOF();
    return val;
  }

  /// Encodes the value to hex
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
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
  /// var codec = Codec(types);
  ///
  /// var result = codec.encode(registry.use('Option<u8>'), 8); // '0x0108'
  /// ```
  String encode(int type, dynamic val) {
    var sink = HexEncoder();
    _encodeWithHexEncoder(type, val, sink);
    return sink.toHex();
  }

  /// Decodes the [data] wrapped in [Source] object
  ///
  ///Example:
  /// ```dart
  /// Source source = Source('0x0108');
  /// var result = codec._decode(registry.use('Option<u8>'), source); // 8
  /// ```
  ///
  /// Throws `UnexpectedCaseException` if the type is not recognised.
  dynamic _decodeFromSource(int type, Source source) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        return _decodePrimitiveFromSource(
            (def as PrimitiveType).primitive, source);
      case TypeKind.Compact:
        return _decodeCompact((def as CodecCompactType), source);
      case TypeKind.BitSequence:
        return _decodeBitSequence(source);
      case TypeKind.Array:
        return _decodeArray((def as ArrayType), source);
      case TypeKind.Sequence:
        return _decodeSequence((def as SequenceType), source);
      case TypeKind.Tuple:
        return _decodeTuple((def as TupleType), source);
      case TypeKind.Struct:
        return _decodeStruct((def as CodecStructType), source);
      case TypeKind.Variant:
        return _decodeVariant((def as CodecVariantType), source);
      case TypeKind.Option:
        return _decodeOption((def as OptionType), source);
      case TypeKind.Bytes:
        return _decodeBytes(source);
      case TypeKind.BytesArray:
        return source.bytes((def as CodecBytesArrayType).len);
      default:
        throw UnexpectedCaseException(
            'Unexpected TypeKind: ${(def as Type).kind}.');
    }
  }

  /// Decodes Array
  List<dynamic> _decodeArray(ArrayType def, Source source) {
    int len = def.len;
    int type = def.type;
    List<dynamic> result = <dynamic>[]..length = len;

    for (var i = 0; i < len; i++) {
      result[i] = _decodeFromSource(type, source);
    }
    return result;
  }

  /// Decodes Bit Sequence
  List<dynamic> _decodeSequence(SequenceType def, Source source) {
    int len = source.compactLength();
    List<dynamic> result = <dynamic>[]..length = len;
    for (var i = 0; i < len; i++) {
      result[i] = _decodeFromSource(def.type, source);
    }
    return result;
  }

  /// Decodes Tuple
  List<dynamic>? _decodeTuple(TupleType def, Source source) {
    if (def.tuple.isEmpty) {
      return null;
    }
    List<dynamic> result = <dynamic>[]..length = def.tuple.length;
    for (var i = 0; i < def.tuple.length; i++) {
      result[i] = _decodeFromSource(def.tuple[i], source);
    }
    return result;
  }

  /// Decodes Struct
  Map<String, dynamic> _decodeStruct(CodecStructType def, Source source) {
    Map<String, dynamic> result = <String, dynamic>{};
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      result[f.name] = _decodeFromSource(f.type, source);
    }
    return result;
  }

  /// Decodes Variant
  Map<String, dynamic> _decodeVariant(CodecVariantType def, Source source) {
    var idx = source.u8();
    CodecVariant? variant =
        idx < def.variants.length ? def.variants[idx] : null;
    if (variant == null) {
      throw UnexpectedCaseException('Unknown variant index: $idx');
    }
    switch (variant.kind) {
      case CodecVariantKind.empty:
        return <String, dynamic>{'__kind': variant.name};
      case CodecVariantKind.tuple:
        return <String, dynamic>{
          variant.name: _decodeTuple((variant as CodecTupleVariant).def, source)
        };
      case CodecVariantKind.value:
        return <String, dynamic>{
          variant.name:
              _decodeFromSource((variant as CodecValueVariant).type, source)
        };
      case CodecVariantKind.struct:
        {
          Map<String, dynamic> value =
              _decodeStruct((variant as CodecStructVariant).def, source);
          value['__kind'] = variant.name;
          return value;
        }
    }
  }

  /// Decodes Option
  dynamic _decodeOption(OptionType def, Source source) {
    int byte = source.u8();
    switch (byte) {
      case 0:
        return null;
      case 1:
        return _decodeFromSource(def.type, source);
      default:
        throw InvalidOptionByteException('Invalid Option byte: $byte.');
    }
  }

  /// Encodes the [val] and writes the result to [sink] object
  ///
  ///Example:
  /// ```dart
  /// // Hex HexEncoder
  /// var HexEncoder = HexEncoder();
  /// codec._encode(registry.use('Option<u8>'), 8, HexEncoder);
  /// HexEncoder.toHex(); // '0x0108'
  ///
  /// ```
  void _encodeWithHexEncoder(int type, dynamic val, HexEncoder sink) {
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
        throw UnexpectedCaseException('Unexpected TypeKind: ${def.kind}.');
    }
  }

  ///
  /// Encodes Array
  void _encodeArray(ArrayType def, dynamic val, HexEncoder sink) {
    assertionCheck(val is List && val.length == def.len);

    for (var i = 0; i < val.length; i++) {
      _encodeWithHexEncoder(def.type, val[i], sink);
    }
  }

  ///
  /// Encodes Bit Sequence
  void _encodeSequence(SequenceType def, dynamic val, HexEncoder sink) {
    assertionCheck(val is List);
    sink.compact((val as List).length);
    for (var i = 0; i < val.length; i++) {
      _encodeWithHexEncoder(def.type, val[i], sink);
    }
  }

  ///
  /// Encodes Tuple
  void _encodeTuple(TupleType def, dynamic val, HexEncoder sink) {
    if (def.tuple.isEmpty) {
      assertNotNull(val == null);
      return;
    }
    assertionCheck(val is List,
        'List of values need to unwrap to tuple, but found \'${val.runtimeType}\'.');
    assertionCheck(def.tuple.length == val.length,
        'Incorrect length of values to unwrap to tuple.');
    for (var i = 0; i < val.length; i++) {
      _encodeWithHexEncoder(def.tuple[i], val[i], sink);
    }
  }

  ///
  /// Encodes Struct
  void _encodeStruct(CodecStructType def, dynamic val, HexEncoder sink) {
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      _encodeWithHexEncoder(f.type, val[f.name], sink);
    }
  }

  ///
  /// Encodes Variant
  void _encodeVariant(CodecVariantType def, dynamic val, HexEncoder sink) {
    assertionCheck(val is Map<String, dynamic>);

    for (var key in (val as Map<String, dynamic>).keys) {
      CodecVariant? variant = def.variantsByName[key];
      if (variant != null) {
        sink.u8(variant.index);
        switch (variant.kind) {
          case CodecVariantKind.empty:
            break;
          case CodecVariantKind.value:
            _encodeWithHexEncoder(
                (variant as CodecValueVariant).type, val[key], sink);
            break;
          case CodecVariantKind.tuple:
            _encodeTuple(
                (variant as CodecTupleVariant).def, val['value'], sink);
            break;
          case CodecVariantKind.struct:
            _encodeStruct((variant as CodecStructVariant).def, val, sink);
            break;
        }
      }
    }
  }

  ///
  /// Encodes Option
  void _encodeOption(OptionType def, dynamic val, HexEncoder sink) {
    if (val == null) {
      sink.u8(0);
    } else {
      sink.u8(1);
      _encodeWithHexEncoder(def.type, val, sink);
    }
  }

  ///
  /// Decodes Bytes
  List<int> _decodeBytes(Source source) {
    int len = source.compactLength();
    return source.bytes(len).toList();
  }

  ///
  /// Encodes Bytes
  void _encodeBytes(dynamic val, HexEncoder sink) {
    if (val is String) {
      val = decodeHex(val).toList();
    }
    assertionCheck(val is List,
        'Unable to encode due to invalid byte type, Try to pass \'Hex String\' or \'List<int>\'.');
    sink.compact(val.length);
    sink.bytes(val);
  }

  ///
  /// Encodes Bytes Array
  void _encodeBytesArray(
      CodecBytesArrayType def, dynamic val, HexEncoder sink) {
    assertionCheck(val is List && val.length == def.len);
    sink.bytes(val);
  }

  ///
  /// Decodes Bit Sequence
  Uint8List _decodeBitSequence(Source source) {
    var len = (source.compactLength() / 8).ceil();
    return source.bytes(len);
  }

  ///
  /// Encodes Bit Sequence
  void _encodeBitSequence(dynamic bits, HexEncoder sink) {
    assertionCheck(
        bits is List<int>, 'BitSequence can have bits of type List<int> only.');
    sink.compact(bits.length * 8);
    sink.bytes(bits);
  }

  ///
  /// Returns: `BigInt` | `int`
  dynamic _decodeCompact(CodecCompactType type, Source source) {
    var n = source.compact();

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

  /// Decodes [source] object when Primitive is known.
  dynamic _decodePrimitiveFromSource(Primitive type, Source source) {
    switch (type) {
      case Primitive.I8:
        return source.i8();
      case Primitive.U8:
        return source.u8();
      case Primitive.I16:
        return source.i16();
      case Primitive.U16:
        return source.u16();
      case Primitive.I32:
        return source.i32();
      case Primitive.U32:
        return source.u32();
      case Primitive.I64:
        return source.i64();
      case Primitive.U64:
        return source.u64();
      case Primitive.I128:
        return source.i128();
      case Primitive.U128:
        return source.u128();
      case Primitive.I256:
        return source.i256();
      case Primitive.U256:
        return source.u256();
      case Primitive.Boolean:
        return source.boolean();
      case Primitive.Str:
        return source.str();
      default:
        throw UnexpectedCaseException('Unexpected PrimitiveType: $type.');
    }
  }

  /// Encodes [source] object to `sink` when [Primitive] is know
  void _encodePrimitive(Primitive type, dynamic val, HexEncoder sink) {
    switch (type) {
      case Primitive.I8:
      case Primitive.U8:
      case Primitive.I16:
      case Primitive.U16:
      case Primitive.I32:
      case Primitive.U32:
        assertionCheck(val is int,
            'Needed val of type \'int\' but found ${val.runtimeType}.');
        break;
      case Primitive.I64:
      case Primitive.U64:
      case Primitive.I128:
      case Primitive.U128:
      case Primitive.I256:
      case Primitive.U256:
        assertionCheck(val is BigInt,
            'Needed val of type \'BigInt\' but found ${val.runtimeType}.');
        break;
      case Primitive.Boolean:
        assertionCheck(val is bool,
            'Needed val of type \'bool\' but found ${val.runtimeType}.');
        break;
      case Primitive.Str:
        assertionCheck(val is String,
            'Needed val of type \'String\' but found ${val.runtimeType}.');
        break;
      default:
        throw UnexpectedCaseException('Unexpected PrimitiveType: $type.');
    }

    var mirrorSink = reflect(sink);
    mirrorSink.invoke(Symbol(type.name.toLowerCase()), [val]);
  }
}
