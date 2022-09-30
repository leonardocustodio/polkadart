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
  Bool,

  /// String
  Str,

  /// Single Character
  Char,
}

///
/// PrimitiveType
class PrimitiveType extends Type with CodecType {
  /// Value from [Primitive] enum which denotes the type of value from Primitives enums
  final Primitive primitive;
  const PrimitiveType({required this.primitive})
      : super(kind: TypeKind.Primitive);
}

///
/// CompactType
class CompactType extends Type with CodecType {
  /// type which this Type denotes
  final int type;
  const CompactType({required this.type}) : super(kind: TypeKind.Compact);
}

///
/// SequenceType
class SequenceType extends Type with CodecType {
  /// type which this sequence denotes
  final int type;
  const SequenceType({required this.type}) : super(kind: TypeKind.Sequence);
}

///
/// BitSequenceType
class BitSequenceType extends Type with CodecType {
  final int bitStoreType;
  final int bitOrderType;
  const BitSequenceType(
      {required this.bitStoreType, required this.bitOrderType})
      : super(kind: TypeKind.BitSequence);
}

///
/// ArrayType
class ArrayType extends Type with CodecType {
  /// length of this array
  final int len;

  /// type which this array denotes
  final int type;
  const ArrayType({required this.len, required this.type})
      : super(kind: TypeKind.Array);
}

///
/// TupleType
class TupleType extends Type with CodecType {
  /// [Optional] tuple
  final List<int> tuple;
  const TupleType({this.tuple = const <int>[]}) : super(kind: TypeKind.Tuple);
}

///
/// CompositeType
class CompositeType extends Type with CodecType {
  /// [Optional] fields
  final List<Field> fields;
  const CompositeType({this.fields = const <Field>[]})
      : super(kind: TypeKind.Composite);
}

///
/// Field
class Field {
  /// [Optional] name
  final String? name;

  /// type which this Field denotes
  final int type;
  const Field({required this.type, this.name});
}

///
/// VariantType
class VariantType extends Type with CodecType {
  /// Variants it can hold
  final List<Variant> variants;
  const VariantType({this.variants = const <Variant>[]})
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
  const Variant(
      {this.fields = const <Field>[], required this.index, required this.name});
}

///
/// OptionType
class OptionType extends Type with CodecType {
  /// type which this Optional Value denotes
  final int type;
  const OptionType({required this.type}) : super(kind: TypeKind.Option);
}

///
/// DoNotConstructType
class DoNotConstructType extends Type with CodecType {
  const DoNotConstructType() : super(kind: TypeKind.DoNotConstruct);
}

///
/// Generic `Type` Class which helps to define TypeKind and helps to handle sub-types easily
abstract class Type {
  /// `TypeKind` to tell which child `Type Class` is being referenced.
  final TypeKind kind;
  const Type({required this.kind});
}
