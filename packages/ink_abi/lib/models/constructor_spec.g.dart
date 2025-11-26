// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'constructor_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConstructorSpec _$ConstructorSpecFromJson(Map<String, dynamic> json) =>
    ConstructorSpec(
      label: json['label'] as String,
      selector: json['selector'] as String,
      args: (json['args'] as List<dynamic>)
          .map((e) => ArgSpec.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnType: TypeSpec.fromJson(json['returnType'] as Map<String, dynamic>),
      payable: json['payable'] as bool,
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ConstructorSpecToJson(ConstructorSpec instance) =>
    <String, dynamic>{
      'label': instance.label,
      'selector': instance.selector,
      'args': instance.args.map((e) => e.toJson()).toList(),
      'returnType': instance.returnType.toJson(),
      'payable': instance.payable,
      'docs': instance.docs,
    };
