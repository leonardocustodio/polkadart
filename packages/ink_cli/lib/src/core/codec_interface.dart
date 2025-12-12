// ignore_for_file: constant_identifier_names

part of ink_cli;

/// Primitive type enumeration
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
  Char;

  String get name => toString().split('.').last;
}

/// Field definition for composite and variant types
class Field {
  final String? name;
  final int type;
  final String? typeName;
  final List<String>? docs;

  const Field({this.name, required this.type, this.typeName, this.docs});
}

/// Variant definition for variant types
class Variants {
  final String name;
  final List<Field> fields;
  final int index;
  final List<String>? docs;

  const Variants({required this.name, required this.fields, required this.index, this.docs});
}

/// Base CodecInterface - abstract class for all type interfaces
abstract class CodecInterface {
  List<String>? get path;
  List<String>? get docs;
}

/// Primitive codec interface
class PrimitiveCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final Primitive primitive;

  const PrimitiveCodecInterface({this.path, this.docs, required this.primitive});
}

/// Composite codec interface (structs)
class CompositeCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final List<Field> fields;

  const CompositeCodecInterface({this.path, this.docs, required this.fields});
}

/// Variant codec interface (enums)
class VariantCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final List<Variants> variants;

  const VariantCodecInterface({this.path, this.docs, required this.variants});
}

/// Sequence codec interface (`Vec<T>`)
class SequenceCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int type; // element type index

  const SequenceCodecInterface({this.path, this.docs, required this.type});
}

/// Array codec interface ([T; N])
class ArrayCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int len;
  final int type; // element type index

  const ArrayCodecInterface({this.path, this.docs, required this.len, required this.type});
}

/// Tuple codec interface
class TupleCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int? id; // optional type id for internal use
  final List<int> tuple; // list of type indices

  const TupleCodecInterface({this.path, this.docs, this.id, required this.tuple});
}

/// Compact codec interface
class CompactCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int type; // inner type index

  const CompactCodecInterface({this.path, this.docs, required this.type});
}

/// BitSequence codec interface
class BitSequenceCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int bitStoreType;
  final int bitOrderType;

  const BitSequenceCodecInterface({
    this.path,
    this.docs,
    required this.bitStoreType,
    required this.bitOrderType,
  });
}

/// Option codec interface
class OptionCodecInterface implements CodecInterface {
  @override
  final List<String>? path;
  @override
  final List<String>? docs;
  final int type; // inner type index

  const OptionCodecInterface({this.path, this.docs, required this.type});
}
