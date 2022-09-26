// ignore_for_file: annotate_overrides

part of polkadart_scale_codec_core;

enum Primitive {
  I8,
  U8,
  I16,
  U16,
  I32,
  U32,
  I64,
  U64,
  I128,
  U128,
  I256,
  U256,
  Bool,
  Str,
  Char,
}

class PrimitiveType extends Type with CodecType {
  final Primitive primitive;
  const PrimitiveType({required this.primitive})
      : super(kind: TypeKind.Primitive);
}

class CompactType extends Type with CodecType {
  final int type;
  const CompactType({required this.type}) : super(kind: TypeKind.Compact);
}

class SequenceType extends Type with CodecType {
  final int type;
  const SequenceType({required this.type}) : super(kind: TypeKind.Sequence);
}

class BitSequenceType extends Type with CodecType {
  final int bitStoreType;
  final int bitOrderType;
  const BitSequenceType(
      {required this.bitStoreType, required this.bitOrderType})
      : super(kind: TypeKind.BitSequence);
}

class ArrayType extends Type with CodecType {
  final int len;
  final int type;
  const ArrayType({required this.len, required this.type})
      : super(kind: TypeKind.Array);
}

class TupleType extends Type with CodecType {
  final List<int> tuple;
  const TupleType({this.tuple = const <int>[]}) : super(kind: TypeKind.Tuple);
}

class CompositeType extends Type with CodecType {
  final List<Field> fields;
  const CompositeType({this.fields = const <Field>[]})
      : super(kind: TypeKind.Composite);
}

class Field {
  final String? name;
  final int type;
  const Field({required this.type, this.name});
}

class VariantType extends Type with CodecType {
  final List<Variant> variants;
  const VariantType({this.variants = const <Variant>[]})
      : super(kind: TypeKind.Variant);
}

class Variant {
  final int index;
  final String name;
  final List<Field> fields;
  const Variant(
      {this.fields = const <Field>[], required this.index, required this.name});
}

class OptionType extends Type with CodecType {
  final int type;
  const OptionType({required this.type}) : super(kind: TypeKind.Option);
}

class DoNotConstructType extends Type with CodecType {
  const DoNotConstructType() : super(kind: TypeKind.DoNotConstruct);
}

abstract class Type {
  final TypeKind kind;
  const Type({required this.kind});
}
