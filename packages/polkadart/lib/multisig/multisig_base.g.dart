// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multisig_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultisigResponse _$MultisigResponseFromJson(Map<String, dynamic> json) =>
    MultisigResponse(
      multisigAccount: MultisigAccount.fromJson(
        json['multisigAccount'] as Map<String, dynamic>,
      ),
      callData: const Uint8ListConverter().fromJson(
        json['callData'] as List<int>,
      ),
    );

Map<String, dynamic> _$MultisigResponseToJson(MultisigResponse instance) =>
    <String, dynamic>{
      'multisigAccount': MultisigAccount.toJsonMethod(instance.multisigAccount),
      'callData': const Uint8ListConverter().toJson(instance.callData),
    };

MultisigAccount _$MultisigAccountFromJson(Map<String, dynamic> json) =>
    MultisigAccount._(
      threshold: (json['threshold'] as num).toInt(),
      publicKeys: const Uint8ListListConverter().fromJson(
        json['publicKeys'] as List,
      ),
      multisigPubkey: const Uint8ListConverter().fromJson(
        json['multisigPubkey'] as List<int>,
      ),
    );

Map<String, dynamic> _$MultisigAccountToJson(
  MultisigAccount instance,
) => <String, dynamic>{
  'threshold': instance.threshold,
  'publicKeys': const Uint8ListListConverter().toJson(instance.publicKeys),
  'multisigPubkey': const Uint8ListConverter().toJson(instance.multisigPubkey),
};
