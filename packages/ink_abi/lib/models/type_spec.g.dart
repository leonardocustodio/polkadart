// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeSpec _$TypeSpecFromJson(Map<String, dynamic> json) => TypeSpec(
      typeId: (json['type'] as num).toInt(),
      displayName: (json['displayName'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$TypeSpecToJson(TypeSpec instance) => <String, dynamic>{
      'type': instance.typeId,
      'displayName': instance.displayName,
    };
