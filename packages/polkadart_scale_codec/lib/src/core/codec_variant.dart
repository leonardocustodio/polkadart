import 'types.dart';
import 'types_codec.dart';

class CodecStructVariant extends CodecVariant {
  String? name;
  int? index;
  CodecStructType? def;
  CodecStructVariant({this.name, this.index, this.def}) : super(kind: 'struct');
}

class CodecTupleVariant extends CodecVariant {
  String? name;
  int? index;
  TupleType? def;
  CodecTupleVariant({this.name, this.index, this.def}) : super(kind: 'tuple');
}

class CodecValueVariant extends CodecVariant {
  String? name;
  int? index;
  int? type;
  CodecValueVariant({this.name, this.index, this.type}) : super(kind: 'value');
}

class CodecEmptyVariant extends CodecVariant {
  String? name;
  int? index;
  CodecEmptyVariant({this.name, this.index}) : super(kind: 'empty');
}

class CodecVariant {
  final String kind;
  const CodecVariant({required this.kind});
}
