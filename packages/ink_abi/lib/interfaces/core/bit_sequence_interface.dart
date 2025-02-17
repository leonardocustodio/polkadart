part of 'package:ink_abi/interfaces/interfaces_base.dart';

class BitSequenceCodecInterface extends CodecInterface {
  final int bitStoreType;
  final int bitOrderType;

  BitSequenceCodecInterface({
    required super.id,
    required this.bitStoreType,
    required this.bitOrderType,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.bitsequence);

  static BitSequenceCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception('Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;

    return BitSequenceCodecInterface(
      id: id,
      bitStoreType: defType.value['bit_store_type'],
      bitOrderType: defType.value['bit_order_type'],
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
          'BitSequence': {
            'bit_store_type': bitStoreType,
            'bit_order_type': bitOrderType,
          }
        },
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
