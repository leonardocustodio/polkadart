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
  /// var registry = TypeRegistry(
  ///   types: <String, dynamic>{
  ///     'Codec': {
  ///       'vec_u8': 'Vec<u8>',
  ///       'option_u8': 'Option<u8>',
  ///       'primitive_compact_u8': 'Compact<u8>',
  ///       'primitive_i8': 'i8',
  ///       'primitive_i16': 'i16',
  ///       'primitive_i32': 'i32',
  ///       'primitive_i64': 'i64',
  ///       'primitive_i128': 'i128',
  ///       'primitive_i256': 'i256',
  ///       'primitive_u8': 'u8',
  ///       'primitive_u16': 'u16',
  ///       'primitive_u32': 'u32',
  ///       'primitive_u64': 'u64',
  ///       'primitive_u128': 'u128',
  ///       'primitive_u256': 'u256',
  ///     },
  ///   },
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
  /// var registry = TypeRegistry(
  ///   types: <String, dynamic>{
  ///     'Codec': {
  ///       'vec_u8': 'Vec<u8>',
  ///       'option_u8': 'Option<u8>',
  ///       'primitive_compact_u8': 'Compact<u8>',
  ///       'primitive_i8': 'i8',
  ///       'primitive_i16': 'i16',
  ///       'primitive_i32': 'i32',
  ///       'primitive_i64': 'i64',
  ///       'primitive_i128': 'i128',
  ///       'primitive_i256': 'i256',
  ///       'primitive_u8': 'u8',
  ///       'primitive_u16': 'u16',
  ///       'primitive_u32': 'u32',
  ///       'primitive_u64': 'u64',
  ///       'primitive_u128': 'u128',
  ///       'primitive_u256': 'u256',
  ///     },
  ///   },
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
    var value = decodeFromSource(type, source);
    source.assertEOF();
    return value;
  }

  /// Encodes the value to hex
  ///
  /// Example:
  /// ```dart
  /// import 'package:polkadart_scale_codec/polkadart_scale_codec.dart';
  ///
  /// // Creates the registry for parsing the types and selecting particular schema.
  /// var registry = TypeRegistry(
  ///   types: <String, dynamic>{
  ///     'Codec': {
  ///       'vec_u8': 'Vec<u8>',
  ///       'option_u8': 'Option<u8>',
  ///       'primitive_compact_u8': 'Compact<u8>',
  ///       'primitive_i8': 'i8',
  ///       'primitive_i16': 'i16',
  ///       'primitive_i32': 'i32',
  ///       'primitive_i64': 'i64',
  ///       'primitive_i128': 'i128',
  ///       'primitive_i256': 'i256',
  ///       'primitive_u8': 'u8',
  ///       'primitive_u16': 'u16',
  ///       'primitive_u32': 'u32',
  ///       'primitive_u64': 'u64',
  ///       'primitive_u128': 'u128',
  ///       'primitive_u256': 'u256',
  ///     },
  ///   },
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
  String encode(int type, dynamic value) {
    var encoder = HexEncoder();
    encodeWithEncoder(type, value, encoder);
    return encoder.toHex();
  }

  /// Decodes the [data] wrapped in [Source] object
  ///
  ///Example:
  /// ```dart
  /// Source source = Source('0x0108');
  /// var result = codec.decodeFromSource(registry.use('Option<u8>'), source); // 8
  /// ```
  ///
  /// Throws `UnexpectedCaseException` if the type is not recognised.
  dynamic decodeFromSource(int type, Source source) {
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
        return _decodeBytesArray((def as CodecBytesArrayType).length, source);
      default:
        throw UnexpectedCaseException(
            'Unexpected TypeKind: ${(def as Type).kind}.');
    }
  }

  String _decodeBytesArray(int length, Source source) {
    return encodeHex(source.bytes(length)).substring(2);
  }

  /// Decodes Array
  List<dynamic> _decodeArray(ArrayType def, Source source) {
    int length = def.length;
    int type = def.type;
    List<dynamic> result = <dynamic>[]..length = length;

    for (var i = 0; i < length; i++) {
      result[i] = decodeFromSource(type, source);
    }
    return result;
  }

  /// Decodes Bit Sequence
  List<dynamic> _decodeSequence(SequenceType def, Source source) {
    int length = source.compactLength();
    List<dynamic> result = <dynamic>[]..length = length;
    for (var i = 0; i < length; i++) {
      result[i] = decodeFromSource(def.type, source);
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
      result[i] = decodeFromSource(def.tuple[i], source);
    }
    return result;
  }

  /// Decodes Struct
  Map<String, dynamic> _decodeStruct(CodecStructType def, Source source) {
    Map<String, dynamic> result = <String, dynamic>{};
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      result[f.name] = decodeFromSource(f.type, source);
    }
    return result;
  }

  /// Decodes Variant
  dynamic _decodeVariant(CodecVariantType def, Source source) {
    var idx = source.u8();
    CodecVariant? variant =
        idx < def.variants.length ? def.variants[idx] : null;
    if (variant == null) {
      throw UnknownVariantException('Unknown variant index: $idx');
    }
    switch (variant.kind) {
      case CodecVariantKind.empty:
        return variant.name;
      case CodecVariantKind.tuple:
        return <String, dynamic>{
          variant.name: _decodeTuple((variant as CodecTupleVariant).def, source)
        };
      case CodecVariantKind.value:
        return <String, dynamic>{
          variant.name:
              decodeFromSource((variant as CodecValueVariant).type, source)
        };
      case CodecVariantKind.struct:
        return {
          variant.name:
              _decodeStruct((variant as CodecStructVariant).def, source)
        };
    }
  }

  /// Decodes Option
  dynamic _decodeOption(OptionType def, Source source) {
    int byte = source.u8();
    switch (byte) {
      case 0:
        return None;
      case 1:
        return Some(decodeFromSource(def.type, source));
      default:
        throw InvalidOptionByteException('Invalid Option byte: $byte.');
    }
  }

  /// Encodes the [value] and writes the result to [encoder] object
  ///
  ///Example:
  /// ```dart
  /// // Hex HexEncoder
  /// var encoder = HexEncoder();
  /// codec.encodeWithEncoder(registry.use('Option<u8>'), 8, HexEncoder);
  /// encoder.toHex(); // '0x0108'
  /// ```
  void encodeWithEncoder(int type, dynamic value, ScaleCodecEncoder encoder) {
    var def = _types[type];
    switch (def.kind) {
      case TypeKind.Primitive:
        _encodePrimitive((def as PrimitiveType).primitive, value, encoder);
        break;
      case TypeKind.Compact:
        encoder.compact(value);
        break;
      case TypeKind.BitSequence:
        _encodeBitSequence(value, encoder);
        break;
      case TypeKind.Array:
        _encodeArray((def as ArrayType), value, encoder);
        break;
      case TypeKind.Sequence:
        _encodeSequence((def as SequenceType), value, encoder);
        break;
      case TypeKind.Tuple:
        _encodeTuple((def as TupleType), value, encoder);
        break;
      case TypeKind.Struct:
        _encodeStruct((def as CodecStructType), value, encoder);
        break;
      case TypeKind.Variant:
        _encodeVariant((def as CodecVariantType), value, encoder);
        break;
      case TypeKind.BytesArray:
        _encodeBytesArray((def as CodecBytesArrayType), value, encoder);
        break;
      case TypeKind.Bytes:
        _encodeBytes(value, encoder);
        break;
      case TypeKind.Option:
        _encodeOption((def as OptionType), value, encoder);
        break;
      default:
        throw UnexpectedCaseException('Unexpected TypeKind: ${def.kind}.');
    }
  }

  ///
  /// Encodes Array
  void _encodeArray(ArrayType def, dynamic value, ScaleCodecEncoder encoder) {
    assertionCheck(value is List && value.length == def.length);

    for (var i = 0; i < value.length; i++) {
      encodeWithEncoder(def.type, value[i], encoder);
    }
  }

  ///
  /// Encodes Bit Sequence
  void _encodeSequence(
      SequenceType def, dynamic value, ScaleCodecEncoder encoder) {
    assertionCheck(value is List);
    encoder.compact((value as List).length);
    for (var i = 0; i < value.length; i++) {
      encodeWithEncoder(def.type, value[i], encoder);
    }
  }

  ///
  /// Encodes Tuple
  void _encodeTuple(TupleType def, dynamic value, ScaleCodecEncoder encoder) {
    if (def.tuple.isEmpty) {
      assertNotNull(value == null);
      return;
    }
    assertionCheck(value is List,
        'List of values need to unwrap to tuple, but found \'${value.runtimeType}\'.');
    assertionCheck(def.tuple.length == value.length,
        'Incorrect length of values to unwrap to tuple.');
    for (var i = 0; i < value.length; i++) {
      encodeWithEncoder(def.tuple[i], value[i], encoder);
    }
  }

  ///
  /// Encodes Struct
  void _encodeStruct(
      CodecStructType def, dynamic value, ScaleCodecEncoder encoder) {
    for (var i = 0; i < def.fields.length; i++) {
      CodecStructTypeFields f = def.fields[i];
      if (value is! Map) {
        throw UnknownVariantException(
            'Needed variant \'value\' of type Map<String, dynamic> but found: ${value.runtimeType}');
      }
      encodeWithEncoder(f.type, value[f.name], encoder);
    }
  }

  ///
  /// Encodes Variant
  void _encodeVariant(
      CodecVariantType def, dynamic value, ScaleCodecEncoder encoder) {
    assertionCheck(value is Map<String, dynamic> || value is String,
        'not a variant type value');

    late String key;

    if (value is Map<String, dynamic>) {
      key = value.keys.first;
    } else {
      key = value;
    }

    final CodecVariant? variant = def.variantsByName[key];
    if (variant == null) {
      throw UnknownVariantException('Unknown variant: $key');
    }

    encoder.u8(variant.index);
    switch (variant.kind) {
      case CodecVariantKind.empty:
        break;
      case CodecVariantKind.value:
        encodeWithEncoder(
            (variant as CodecValueVariant).type, value[key], encoder);
        break;
      case CodecVariantKind.tuple:
        _encodeTuple((variant as CodecTupleVariant).def, value[key], encoder);
        break;
      case CodecVariantKind.struct:
        _encodeStruct((variant as CodecStructVariant).def, value[key], encoder);
        break;
    }
  }

  ///
  /// Encodes Option
  void _encodeOption(OptionType def, dynamic value, ScaleCodecEncoder encoder) {
    assertionCheck(value is _Option || value is Some || value == None,
        'Unable to encode due to invalid value type. Needed value either Some() or None, but found of type: \'${value.runtimeType}\'.');
    if (value == None) {
      encoder.u8(0);
    } else {
      encoder.u8(1);
      encodeWithEncoder(def.type, (value as Some).value, encoder);
    }
  }

  ///
  /// Decodes Bytes
  List<int> _decodeBytes(Source source) {
    int length = source.compactLength();
    return source.bytes(length).toList();
  }

  ///
  /// Encodes Bytes
  void _encodeBytes(dynamic value, ScaleCodecEncoder encoder) {
    if (value is String) {
      value = decodeHex(value).toList();
    }
    assertionCheck(value is List,
        'Unable to encode due to invalid byte type, Try to pass \'Hex String\' or \'List<int>\'.');
    encoder.compact(value.length);
    encoder.bytes(value);
  }

  ///
  /// Encodes Bytes Array
  void _encodeBytesArray(
      CodecBytesArrayType def, dynamic value, ScaleCodecEncoder encoder) {
    if (value is String) {
      value = decodeHex(value).toList();
    }
    assertionCheck(value is List && value.length == def.length);
    encoder.bytes(value);
  }

  ///
  /// Decodes Bit Sequence
  List<int> _decodeBitSequence(Source source) {
    var length = (source.compactLength() / 8).ceil();
    return source.bytes(length).toList();
  }

  ///
  /// Encodes Bit Sequence
  void _encodeBitSequence(dynamic bits, ScaleCodecEncoder encoder) {
    assertionCheck(
        bits is List<int>, 'BitSequence can have bits of type List<int> only.');
    encoder.compact(bits.length * 8);
    encoder.bytes(bits);
  }

  ///
  /// Returns: `BigInt` | `int`
  dynamic _decodeCompact(CodecCompactType type, Source source) {
    var n = source.decodeCompact();

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

  /// Encodes [source] object to `encoder` when [Primitive] is know
  void _encodePrimitive(
      Primitive type, dynamic value, ScaleCodecEncoder encoder) {
    // name = 'I8' | 'U8' ......;
    final String name = type.name;

    // Integer and BigInt
    if (name.startsWith('I') || name.startsWith('U')) {
      // check for int matching
      if (name.endsWith('I8') ||
          name.endsWith('U8') ||
          name.endsWith('16') ||
          name.endsWith('32')) {
        assertionCheck(value is int,
            'Needed value of type \'int\' but found ${value.runtimeType}.');
      } else if (name.endsWith('64') ||
          name.endsWith('128') ||
          name.endsWith('256')) {
        // check for BigInt matching
        assertionCheck(value is BigInt,
            'Needed value of type \'BigInt\' but found ${value.runtimeType}.');
      } else {
        throw UnexpectedCaseException('Unexpected PrimitiveType: $type.');
      }
    }

    switch (type) {
      // signed integers
      case Primitive.I8:
        encoder.i8(value);
        return;
      case Primitive.I16:
        encoder.i16(value);
        return;
      case Primitive.I32:
        encoder.i32(value);
        return;
      case Primitive.I64:
        encoder.i64(value);
        return;
      case Primitive.I128:
        encoder.i128(value);
        return;
      case Primitive.I256:
        encoder.i256(value);
        return;
      // unsigned integers
      case Primitive.U8:
        encoder.u8(value);
        return;
      case Primitive.U16:
        encoder.u16(value);
        return;
      case Primitive.U32:
        encoder.u32(value);
        return;
      case Primitive.U64:
        encoder.u64(value);
        return;
      case Primitive.U128:
        encoder.u128(value);
        return;
      case Primitive.U256:
        encoder.u256(value);
        return;
      // boolean
      case Primitive.Boolean:
        assertionCheck(value is bool,
            'Needed value of type \'bool\' but found ${value.runtimeType}.');
        encoder.boolean(value);
        return;
      // string
      case Primitive.Str:
        assertionCheck(value is String,
            'Needed value of type \'String\' but found ${value.runtimeType}.');
        encoder.str(value);
        return;
      // unknown case
      default:
        throw UnexpectedCaseException('Unexpected PrimitiveType: $type.');
    }
  }
}
