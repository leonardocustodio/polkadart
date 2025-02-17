part of 'package:ink_abi/interfaces/interfaces_base.dart';

class TupleCodecInterface extends CodecInterface {
  final List<int> tuple;

  TupleCodecInterface({
    required super.id,
    required this.tuple,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.tuple);

  static TupleCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception('Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;

    return TupleCodecInterface(
      id: id,
      tuple: defType.value.cast<int>(),
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
          'Tuple': tuple,
        },
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
