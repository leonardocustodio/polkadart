// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registry_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistryItem _$RegistryItemFromJson(Map<String, dynamic> json) =>
    RegistryItem(prefix: (json['prefix'] as num).toInt(), network: json['network'] as String);

Map<String, dynamic> _$RegistryItemToJson(RegistryItem instance) => <String, dynamic>{
  'prefix': instance.prefix,
  'network': instance.network,
};
