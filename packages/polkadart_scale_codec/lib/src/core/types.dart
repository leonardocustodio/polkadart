part of polkadart_scale_codec_core;

/// [Primitive] enum
///
/// This tells about the primitive type it is going to hold.
enum Primitive {
  /// Signed i8
  I8,

  /// Signed i16
  I16,

  /// Signed i32
  I32,

  /// Signed i64
  I64,

  /// Signed i128
  I128,

  /// Signed i256
  I256,

  /// Unsigned u8
  U8,

  /// Unsigned u16
  U16,

  /// Unsigned u32
  U32,

  /// Unsigned u64
  U64,

  /// Unsigned u128
  U128,

  /// Unsigned u256
  U256,

  /// Boolean
  Boolean,

  /// String
  Str,

  /// Single Character
  Char,
}

///
/// PrimitiveType
class PrimitiveType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// Value from [Primitive] enum which denotes the type of value from Primitives enums
  final Primitive primitive;
  PrimitiveType({required this.primitive, super.path, super.docs})
      : super(kind: TypeKind.Primitive);
}

///
/// CompactType
class CompactType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// type which this Type denotes
  final int type;
  CompactType({required this.type, super.path, super.docs})
      : super(kind: TypeKind.Compact);
}

///
/// SequenceType
class SequenceType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// type which this sequence denotes
  final int type;
  SequenceType({required this.type, super.path, super.docs})
      : super(kind: TypeKind.Sequence);
}

///
/// BitSequenceType
class BitSequenceType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;
  final int bitStoreType;
  final int bitOrderType;
  BitSequenceType(
      {required this.bitStoreType,
      required this.bitOrderType,
      super.path,
      super.docs})
      : super(kind: TypeKind.BitSequence);
}

///
/// ArrayType
class ArrayType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// length of this array
  final int len;

  /// type which this array denotes
  final int type;
  ArrayType({required this.len, required this.type, super.path, super.docs})
      : super(kind: TypeKind.Array);
}

///
/// TupleType
class TupleType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// [Optional] tuple
  final List<int> tuple;
  TupleType({this.tuple = const <int>[], super.path, super.docs})
      : super(kind: TypeKind.Tuple);
}

///
/// CompositeType
class CompositeType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// [Optional] fields
  final List<Field> fields;
  CompositeType({this.fields = const <Field>[], super.path, super.docs})
      : super(kind: TypeKind.Composite);
}

///
/// Field
class Field {
  /// [Optional] name
  final String? name;

  /// type which this Field denotes
  final int type;
  final List<String>? docs;
  Field({required this.type, this.name, this.docs});
}

///
/// VariantType
class VariantType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// Variants it can hold
  final List<Variant> variants;
  VariantType({this.variants = const <Variant>[], super.path, super.docs})
      : super(kind: TypeKind.Variant);
}

///
/// Variant
class Variant {
  /// index of variant
  final int index;

  /// name of this variant
  final String name;

  /// [Optional] fields
  final List<Field> fields;
  List<String>? docs;
  Variant(
      {this.fields = const <Field>[],
      required this.index,
      required this.name,
      this.docs});
}

///
/// OptionType
class OptionType extends Type with CodecType {
  @override
  List<String>? docs;

  @override
  List<String>? path;

  /// type which this Optional Value denotes
  final int type;
  OptionType({required this.type, super.path, super.docs})
      : super(kind: TypeKind.Option);
}

///
/// DoNotConstructType
class DoNotConstructType extends Type with CodecType {
  DoNotConstructType() : super(kind: TypeKind.DoNotConstruct);
}

///
/// Generic `Type` Class which helps to define TypeKind and helps to handle sub-types easily
abstract class Type {
  List<String>? path;

  List<String>? docs;

  /// `TypeKind` to tell which child `Type Class` is being referenced.
  final TypeKind kind;
  Type({required this.kind, this.path, this.docs});
}

/// All `Scale Codec` supported types implements [CodecType]
///
/// Supported types:
/// ```dart
/// CodecU8();
/// ```
///
/// See also: https://docs.substrate.io/reference/scale-codec/
abstract class NewCodecType {
  String encodeToHex(value);

  dynamic decodeFromHex(String encodedData);
}
