

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

enum TypeKind {
  Primitive,
  Compact,
  Sequence,
  BitSequence,
  Array,
  Tuple,
  Composite,
  Variant,
  Option,
  DoNotConstruct,
  /*
     * @internal
     */
  BooleanOption,
  /*
     * @internal
     */
  Bytes,
  /*
     * @internal
     */
  BytesArray,
  /*
     * @internal
     */
  Struct
}

class PrimitiveType extends Type {
  @override
  final TypeKind kind = TypeKind.Primitive;
  @override
  late Primitive primitive;
}

class CompactType extends Type {
  @override
  final TypeKind kind = TypeKind.Compact;
  @override
  late int type;
}

class SequenceType extends Type {
  @override
  final TypeKind kind = TypeKind.Sequence;
  @override
  late int type;
}

class BitSequenceType extends Type {
  @override
  final TypeKind kind = TypeKind.BitSequence;
  @override
  late num bitStoreType;
  @override
  late num bitOrderType;
}

class ArrayType extends Type {
  @override
  final TypeKind kind = TypeKind.Array;
  @override
  late int len;
  @override
  late int type;
}

class TupleType extends Type {
  @override
  final TypeKind kind = TypeKind.Tuple;
  @override
  late int len;
  @override
  List<int> tuple = <int>[];
}

class CompositeType extends Type {
  @override
  final TypeKind kind = TypeKind.Composite;
  @override
  List<Field?> fields = <Field?>[];
}

class Field extends Type {
  @override
  String? name;
  @override
  late int type;
}

class VariantType extends Type {
  final TypeKind king = TypeKind.Variant;
  List<Variant> variants = <Variant>[];
}

class Variant {
  late num index;
  late String name;
  List<Field> fields = <Field>[];
}

class OptionType extends Type {
  @override
  final TypeKind kind = TypeKind.Option;
  @override
  late int type;
}

class DoNotConstructType extends Type {
  @override
  final TypeKind kind = TypeKind.DoNotConstruct;
}

abstract class Type {
  late TypeKind kind;
  late int index;
  String? name;
  late int type;
  late int len;
  late List<Field?> fields;
  late num bitStoreType;
  late num bitOrderType;
  late Primitive primitive;
  late List<int> tuple;
}
/* 
class Type extends ListMixin<Type> {
  final List<Type> _data = [
    PrimitiveType(),
    CompactType(),
    SequenceType(),
    BitSequenceType(),
    ArrayType(),
    TupleType(),
    CompositeType(),
    VariantType(),
    OptionType(),
    DoNotConstructType()
  ];

  @override
  Type operator [](int index) {
    return _data[index];
  }

  @override
  int get length => _data.length;

  @override
  void operator []=(int index, Type value) {
    _data[index] = value;
  }

  @override
  set length(int newLength) {
    throw Exception('Not implemented');
  }
}
 */
