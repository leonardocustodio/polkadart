part of 'package:ink_abi/interfaces/interfaces_base.dart';

abstract class CodecInterface {
  int id;
  List<String>? path;
  List<String>? docs;
  final TypeKind kind;

  CodecInterface({
    required this.kind,
    required this.id,
    this.path,
    this.docs,
  });

  static CodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['id'] == null || json['type'] == null) {
      throw Exception(
          'Exception as didn\'t found the id neither the type for this json: $json');
    }

    MapEntry? defType;
    if (json['type']['def'] != null && json['type']['def'].isNotEmpty) {
      defType = json['type']['def'].entries.first;
    }
    if (defType == null) {
      throw Exception('Can\'t find the .');
    }

    switch (defType.key.toLowerCase()) {
      case 'array':
        return ArrayCodecInterface.fromJson(json);
      case 'bitsequence':
        return BitSequenceCodecInterface.fromJson(json);
      case 'compact':
        return CompactCodecInterface.fromJson(json);
      case 'composite':
        return CompositeCodecInterface.fromJson(json);
      case 'primitive':
        return PrimitiveCodecInterface.fromJson(json);
      case 'sequence':
        return SequenceCodecInterface.fromJson(json);
      case 'tuple':
        return TupleCodecInterface.fromJson(json);
      case 'variant':
        return VariantCodecInterface.fromJson(json);
      default:
        throw Exception('Unknown type found: $defType');
    }
  }

  Map<String, dynamic> toJson();
}
