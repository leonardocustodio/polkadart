// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arg_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArgSpec _$ArgSpecFromJson(Map<String, dynamic> json) => ArgSpec(
      label: json['label'] as String,
      type: TypeSpec.fromJson(json['type'] as Map<String, dynamic>),
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ArgSpecToJson(ArgSpec instance) => <String, dynamic>{
      'label': instance.label,
      'type': instance.type.toJson(),
      'docs': instance.docs,
    };
