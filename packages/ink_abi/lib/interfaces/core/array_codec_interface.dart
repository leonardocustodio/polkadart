part of 'package:ink_abi/interfaces/interfaces_base.dart';

class ArrayCodecInterface extends CodecInterface {
  final int len;
  final int type;

  ArrayCodecInterface({
    required super.id,
    required this.type,
    required this.len,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.array);

  static ArrayCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;

    final int len = defType.value['len'];
    final int type = defType.value['type'];
    return ArrayCodecInterface(
      id: id,
      type: type,
      len: len,
      path: typeObject['path']?.cast<String>(),
      docs: typeObject['docs']?.cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': {
        'def': {
          'Array': {
            'len': len,
            'type': type,
          },
        },
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
