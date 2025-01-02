part of 'package:ink_abi/interfaces/interfaces_base.dart';

class OptionCodecInterface extends CodecInterface {
  int type;
  final List<Params> params;
  OptionCodecInterface({
    required super.id,
    required this.type,
    required this.params,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.option);

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': super.id,
      'type': {
        'def': {
          'Variant': {
            'variants': [
              Variants(
                name: 'None',
                fields: [],
                index: 0,
                docs: [],
              ).toJson(),
              Variants(
                name: 'Some',
                fields: [Field(type: type)],
                index: 1,
                docs: [],
              ).toJson(),
            ],
          }
        },
        'params': params.map((e) => e.toJson()).toList(),
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
