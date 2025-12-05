// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ink_abi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TypeSpec _$TypeSpecFromJson(Map<String, dynamic> json) => TypeSpec(
      typeId: (json['type'] as num).toInt(),
      displayName: (json['displayName'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TypeSpecToJson(TypeSpec instance) => <String, dynamic>{
      'type': instance.typeId,
      'displayName': instance.displayName,
    };

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

Map<String, dynamic> _$EventSpecToJson(EventSpec instance) => <String, dynamic>{
      'stringify': instance.stringify,
      'hashCode': instance.hashCode,
      'label': instance.label,
      'typeId': instance.typeId,
      'amountIndexed': instance.amountIndexed,
      'signatureTopic': instance.signatureTopic,
      'docs': instance.docs,
      'props': instance.props,
    };

ConstructorSpec _$ConstructorSpecFromJson(Map<String, dynamic> json) => ConstructorSpec(
      label: json['label'] as String,
      selector: json['selector'] as String,
      args: (json['args'] as List<dynamic>)
          .map((e) => ArgSpec.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnType: json['returnType'] == null
          ? null
          : TypeSpec.fromJson(json['returnType'] as Map<String, dynamic>),
      payable: json['payable'] as bool,
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ConstructorSpecToJson(ConstructorSpec instance) => <String, dynamic>{
      'label': instance.label,
      'selector': instance.selector,
      'args': instance.args.map((e) => e.toJson()).toList(),
      'returnType': instance.returnType?.toJson(),
      'payable': instance.payable,
      'docs': instance.docs,
    };

MessageSpec _$MessageSpecFromJson(Map<String, dynamic> json) => MessageSpec(
      label: json['label'] as String,
      selector: json['selector'] as String,
      args: (json['args'] as List<dynamic>)
          .map((e) => ArgSpec.fromJson(e as Map<String, dynamic>))
          .toList(),
      returnType: TypeSpec.fromJson(json['returnType'] as Map<String, dynamic>),
      mutates: json['mutates'] as bool,
      payable: json['payable'] as bool,
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$MessageSpecToJson(MessageSpec instance) => <String, dynamic>{
      'label': instance.label,
      'selector': instance.selector,
      'args': instance.args.map((e) => e.toJson()).toList(),
      'returnType': instance.returnType.toJson(),
      'mutates': instance.mutates,
      'payable': instance.payable,
      'docs': instance.docs,
    };
