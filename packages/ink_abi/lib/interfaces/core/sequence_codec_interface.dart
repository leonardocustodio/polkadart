part of 'package:ink_abi/interfaces/interfaces_base.dart';

class SequenceCodecInterface extends CodecInterface {
  final int type;

  SequenceCodecInterface({
    required super.id,
    required this.type,
    /* required super.params, */
    super.path,
    super.docs,
  }) : super(kind: TypeKind.sequence);

  static SequenceCodecInterface fromJson(Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;

    return SequenceCodecInterface(
      id: id,
      type: defType.value['type'],
      /* params: typeObject['params']?.map((e) => Params.fromJson(e))?.toList(), */
      path: typeObject['path']?.cast<String>(),
      docs: typeObject['docs']?.cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': {
        'def': {
          'Sequence': {'type': type},
        },
        /* if (params != null) 'params': params!.map((e) => e.toJson()).toList(), */
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
