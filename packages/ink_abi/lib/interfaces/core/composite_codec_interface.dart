part of 'package:ink_abi/interfaces/interfaces_base.dart';

class Field {
  String? name;
  final int type;
  final String? typeName;
  final List<String>? docs;

  Field({
    required this.type,
    this.name,
    this.typeName,
    this.docs,
  });

  static Field fromJson(Map<String, dynamic> json) {
    if (json['type'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int type = json['type'];
    final String? typeName = json['typeName'];
    final String? name = json['name'];
    final List<String>? docs = json['docs'];
    return Field(
      type: type,
      typeName: typeName,
      name: name,
      docs: docs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      if (name != null) 'name': name,
      if (typeName != null) 'typeName': typeName,
      'docs': docs ?? <String>[],
    };
  }
}

class CompositeCodecInterface extends CodecInterface {
  List<Field> fields;

  CompositeCodecInterface({
    required super.id,
    required this.fields,
    /* required super.params, */
    super.path,
    super.docs,
  }) : super(kind: TypeKind.composite);

  static CompositeCodecInterface fromJson(Map<String, dynamic> json) {
    if (json['type'] == null || json['id'] == null) {
      throw Exception(
          'Exception as didn\'t found the type for this json: $json');
    }
    final int id = json['id'];
    final Map<String, dynamic> typeObject = json['type'];
    final MapEntry defType = (typeObject['def'] as Map).entries.first;
    List<Field> fields = <Field>[];
    if (defType.value['fields'] != null) {
      fields = (defType.value['fields'] as List)
          .map((dynamic field) => Field.fromJson(field))
          .toList();
    }

    return CompositeCodecInterface(
      id: id,
      fields: fields,
      /* params: typeObject['params']
          ?.map((e) => Params.fromJson(e))
          ?.toList()
          .cast<Params>(), */
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
          'Composite': {
            'fields': fields.map((field) => field.toJson()).toList(),
          }
        },
        /* if (params != null) 'params': params!.map((e) => e.toJson()).toList(), */
        'path': super.path ?? <String>[],
        'docs': super.docs ?? <String>[],
      }
    };
  }
}
