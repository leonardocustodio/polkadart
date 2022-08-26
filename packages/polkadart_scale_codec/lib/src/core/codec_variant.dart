import 'codec_type.dart';
import 'types.dart';

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
  @override
  final String name;
  final int? index;
  final CodecStructType? def;
  const CodecStructVariant({required this.name, this.index, this.def})
      : super(kind: CodecVariantKind.struct, name: name);
}

///
/// CodecTupleVariant
class CodecTupleVariant extends CodecVariant {
  @override
  final String name;
  final int? index;
  final TupleType? def;
  const CodecTupleVariant({required this.name, this.index, this.def})
      : super(kind: CodecVariantKind.tuple, name: name);
}

///
/// CodecValueVariant
class CodecValueVariant extends CodecVariant {
  @override
  final String name;
  final int? index;
  final int? type;
  const CodecValueVariant({required this.name, this.index, this.type})
      : super(kind: CodecVariantKind.value, name: name);
}

///
/// CodecEmptyVariant
class CodecEmptyVariant extends CodecVariant {
  @override
  final String name;
  final int? index;
  const CodecEmptyVariant({required this.name, this.index})
      : super(kind: CodecVariantKind.empty, name: name);
}

///
/// CodecVariant
class CodecVariant {
  final CodecVariantKind kind;
  final String name;
  const CodecVariant({required this.kind, required this.name});
}
