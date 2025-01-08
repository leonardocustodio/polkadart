part of 'package:ink_abi/interfaces/interfaces_base.dart';

class CompactCodecInterface extends CodecInterface {
  int type;
  CompactCodecInterface({
    required super.id,
    required this.type,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.compact);

  static CompactCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;

    return CompactCodecInterface(
      id: id,
      type: defType.value['type'],
      path: typeObject['path']?.cast<String>(),
      docs: typeObject['docs']?.cast<String>(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'type': {
        'def': {
          'Compact': {
            'type': type,
          }
        },
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
