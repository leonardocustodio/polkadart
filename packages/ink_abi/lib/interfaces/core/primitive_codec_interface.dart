part of 'package:ink_abi/interfaces/interfaces_base.dart';

class PrimitiveCodecInterface extends CodecInterface {
  final Primitive primitive;

  PrimitiveCodecInterface({
    required super.id,
    required this.primitive,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.primitive);

  static PrimitiveCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;
    final Primitive primitive = Primitive.fromString(defType.value);

    return PrimitiveCodecInterface(
      id: id,
      primitive: primitive,
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
          'Primitive': primitive.name.toString(),
        },
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
