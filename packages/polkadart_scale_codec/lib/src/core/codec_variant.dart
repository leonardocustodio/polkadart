part of polkadart_scale_codec_core;

/// enum [CodecVariantKind]
enum CodecVariantKind {
  struct,
  tuple,
  value,
  empty,
}

///
/// CodecStructVariant
class CodecStructVariant extends CodecVariant {
  final CodecStructType def;
  const CodecStructVariant(
      {required super.name, required super.index, required this.def})
      : super(kind: CodecVariantKind.struct);
}

///
/// CodecTupleVariant
class CodecTupleVariant extends CodecVariant {
  final TupleType def;
  const CodecTupleVariant(
      {required super.name, required super.index, required this.def})
      : super(kind: CodecVariantKind.tuple);
}

///
/// CodecValueVariant
class CodecValueVariant extends CodecVariant {
  final int type;
  const CodecValueVariant(
      {required super.name, required super.index, required this.type})
      : super(kind: CodecVariantKind.value);
}

///
/// CodecEmptyVariant
class CodecEmptyVariant extends CodecVariant {
  const CodecEmptyVariant({required super.name, required super.index})
      : super(kind: CodecVariantKind.empty);
}

///
/// CodecVariant
class CodecVariant {
  final CodecVariantKind kind;
  final String name;
  final int index;
  const CodecVariant(
      {required this.kind, required this.name, required this.index});
}
