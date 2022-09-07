import 'package:polkadart_scale_codec/polkadart_scale_codec.dart' as scale;

/// Parent Class Holder to mimic multiple types under one type
mixin Type implements scale.Type {
  List<String>? path;
  List<String>? docs;
  @override
  scale.TypeKind get kind;
}

class DoNotConstructType extends scale.DoNotConstructType implements Type {
  @override
  List<String>? docs = throw UnimplementedError();

  @override
  List<String>? path = throw UnimplementedError();

  @override
  scale.TypeKind get kind => scale.TypeKind.DoNotConstruct;
}

class PrimitiveType extends scale.PrimitiveType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  PrimitiveType({
    required scale.Primitive primitive,
    this.path,
    this.docs,
  }) : super(primitive: primitive);
}

class CompactType extends scale.CompactType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  CompactType({
    required int type,
    this.path,
    this.docs,
  }) : super(type: type);

  @override
  scale.TypeKind get kind => scale.TypeKind.Compact;
}

class SequenceType extends scale.SequenceType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  SequenceType({
    required int type,
    this.path,
    this.docs,
  }) : super(type: type);

  @override
  scale.TypeKind get kind => scale.TypeKind.Sequence;
}

class BitSequenceType extends scale.BitSequenceType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  BitSequenceType({
    required int bitStoreType,
    required int bitOrderType,
    this.path,
    this.docs,
  }) : super(bitStoreType: bitStoreType, bitOrderType: bitOrderType);

  @override
  scale.TypeKind get kind => scale.TypeKind.BitSequence;
}

class ArrayType extends scale.ArrayType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  ArrayType({
    required int type,
    required int len,
    this.path,
    this.docs,
  }) : super(len: len, type: type);

  @override
  scale.TypeKind get kind => scale.TypeKind.Array;
}

/// Tuple Type
class TupleType extends scale.TupleType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  TupleType({
    required List<int> tuple,
    this.path,
    this.docs,
  }) : super(tuple: tuple);

  @override
  scale.TypeKind get kind => scale.TypeKind.Tuple;
}

class OptionType extends scale.OptionType implements Type {
  @override
  List<String>? path;

  @override
  List<String>? docs;

  /// Constructor
  OptionType({
    required int type,
    this.path,
    this.docs,
  }) : super(type: type);

  @override
  scale.TypeKind get kind => scale.TypeKind.Option;
}

class Field extends scale.Field {
  final List<String>? docs;
  const Field({this.docs, required int type, String? name})
      : super(type: type, name: name);
}

class CompositeType extends scale.CompositeType implements Type {
  @override
  final List<Field> fields;
  @override
  List<String>? path;

  @override
  List<String>? docs;

  CompositeType({this.fields = const <Field>[], this.path, this.docs})
      : super(fields: fields);

  @override
  scale.TypeKind get kind => scale.TypeKind.Composite;
}

class Variant extends scale.Variant {
  @override
  final List<Field> fields;
  List<String>? docs;
  Variant(
      {this.fields = const <Field>[],
      required int index,
      required String name,
      this.docs})
      : super(fields: fields, index: index, name: name);
}

class VariantType extends scale.VariantType implements Type {
  @override
  final List<Variant> variants;
  @override
  List<String>? path;

  @override
  List<String>? docs;

  VariantType({this.variants = const <Variant>[], this.path, this.docs})
      : super(variants: variants);

  @override
  scale.TypeKind get kind => scale.TypeKind.Variant;
}
