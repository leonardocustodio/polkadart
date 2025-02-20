part of 'package:ink_abi/interfaces/interfaces_base.dart';

class VariantCodecInterface extends CodecInterface {
  List<Variants> variants;
  List<Params>? params;

  VariantCodecInterface({
    required super.id,
    required this.variants,
    this.params,
    super.path,
    super.docs,
  }) : super(kind: TypeKind.variant);

  static VariantCodecInterface fromJson(final Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception('Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;
    final List<Variants> variants = <Variants>[];
    if (defType.value['variants'] != null) {
      for (final variant in defType.value['variants']) {
        variants.add(Variants.fromJson(variant));
      }
    }
    return VariantCodecInterface(
      id: id,
      variants: variants,
      params: typeObject['params']?.map((final e) => Params.fromJson(e))?.toList()?.cast<Params>(),
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
          'Variant': {
            'variants': variants.map((final Variants variant) => variant.toJson()).toList(),
          }
        },
        if (params != null) 'params': params!.map((final Params param) => param.toJson()).toList(),
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}

class Variants {
  final String name;
  final int index;
  List<Field> fields;
  final List<String>? docs;

  Variants({
    required this.name,
    required this.index,
    required this.fields,
    this.docs,
  });

  static Variants fromJson(final Map<String, dynamic> json) {
    if (json['name'] == null || json['index'] == null) {
      throw Exception('Exception as didn\'t found the name neither the index for this json: $json');
    }
    final String name = json['name'];
    final int index = json['index'];
    final List<Field> fields = <Field>[];
    for (final field in json['fields'] ?? []) {
      fields.add(Field.fromJson(field));
    }

    return Variants(
      name: name,
      index: index,
      fields: fields,
      docs: json['docs']?.cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'index': index,
      'fields': fields.map((final Field field) => field.toJson()).toList(),
      'docs': docs ?? <String>[],
    };
  }
}
