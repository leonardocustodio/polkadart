// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_spec.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventSpec _$EventSpecFromJson(Map<String, dynamic> json) => EventSpec(
      label: json['label'] as String,
      typeId: (json['typeId'] as num).toInt(),
      amountIndexed: (json['amountIndexed'] as num).toInt(),
      signatureTopic: json['signatureTopic'] as String?,
      docs: (json['docs'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$EventSpecToJson(EventSpec instance) => <String, dynamic>{
      'label': instance.label,
      'typeId': instance.typeId,
      'amountIndexed': instance.amountIndexed,
      'signatureTopic': instance.signatureTopic,
      'docs': instance.docs,
    };
