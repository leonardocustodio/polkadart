// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../../polkadot_primitives/v4/executor_params/executor_param.dart'
    as _i5;
import '../../../polkadot_primitives/v4/executor_params/executor_params.dart'
    as _i4;
import '../../../polkadot_primitives/vstaging/async_backing_params.dart' as _i3;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  SetValidationUpgradeCooldown setValidationUpgradeCooldown(
      {required int new_}) {
    return SetValidationUpgradeCooldown(new_: new_);
  }

  SetValidationUpgradeDelay setValidationUpgradeDelay({required int new_}) {
    return SetValidationUpgradeDelay(new_: new_);
  }

  SetCodeRetentionPeriod setCodeRetentionPeriod({required int new_}) {
    return SetCodeRetentionPeriod(new_: new_);
  }

  SetMaxCodeSize setMaxCodeSize({required int new_}) {
    return SetMaxCodeSize(new_: new_);
  }

  SetMaxPovSize setMaxPovSize({required int new_}) {
    return SetMaxPovSize(new_: new_);
  }

  SetMaxHeadDataSize setMaxHeadDataSize({required int new_}) {
    return SetMaxHeadDataSize(new_: new_);
  }

  SetParathreadCores setParathreadCores({required int new_}) {
    return SetParathreadCores(new_: new_);
  }

  SetParathreadRetries setParathreadRetries({required int new_}) {
    return SetParathreadRetries(new_: new_);
  }

  SetGroupRotationFrequency setGroupRotationFrequency({required int new_}) {
    return SetGroupRotationFrequency(new_: new_);
  }

  SetChainAvailabilityPeriod setChainAvailabilityPeriod({required int new_}) {
    return SetChainAvailabilityPeriod(new_: new_);
  }

  SetThreadAvailabilityPeriod setThreadAvailabilityPeriod({required int new_}) {
    return SetThreadAvailabilityPeriod(new_: new_);
  }

  SetSchedulingLookahead setSchedulingLookahead({required int new_}) {
    return SetSchedulingLookahead(new_: new_);
  }

  SetMaxValidatorsPerCore setMaxValidatorsPerCore({int? new_}) {
    return SetMaxValidatorsPerCore(new_: new_);
  }

  SetMaxValidators setMaxValidators({int? new_}) {
    return SetMaxValidators(new_: new_);
  }

  SetDisputePeriod setDisputePeriod({required int new_}) {
    return SetDisputePeriod(new_: new_);
  }

  SetDisputePostConclusionAcceptancePeriod
      setDisputePostConclusionAcceptancePeriod({required int new_}) {
    return SetDisputePostConclusionAcceptancePeriod(new_: new_);
  }

  SetNoShowSlots setNoShowSlots({required int new_}) {
    return SetNoShowSlots(new_: new_);
  }

  SetNDelayTranches setNDelayTranches({required int new_}) {
    return SetNDelayTranches(new_: new_);
  }

  SetZerothDelayTrancheWidth setZerothDelayTrancheWidth({required int new_}) {
    return SetZerothDelayTrancheWidth(new_: new_);
  }

  SetNeededApprovals setNeededApprovals({required int new_}) {
    return SetNeededApprovals(new_: new_);
  }

  SetRelayVrfModuloSamples setRelayVrfModuloSamples({required int new_}) {
    return SetRelayVrfModuloSamples(new_: new_);
  }

  SetMaxUpwardQueueCount setMaxUpwardQueueCount({required int new_}) {
    return SetMaxUpwardQueueCount(new_: new_);
  }

  SetMaxUpwardQueueSize setMaxUpwardQueueSize({required int new_}) {
    return SetMaxUpwardQueueSize(new_: new_);
  }

  SetMaxDownwardMessageSize setMaxDownwardMessageSize({required int new_}) {
    return SetMaxDownwardMessageSize(new_: new_);
  }

  SetMaxUpwardMessageSize setMaxUpwardMessageSize({required int new_}) {
    return SetMaxUpwardMessageSize(new_: new_);
  }

  SetMaxUpwardMessageNumPerCandidate setMaxUpwardMessageNumPerCandidate(
      {required int new_}) {
    return SetMaxUpwardMessageNumPerCandidate(new_: new_);
  }

  SetHrmpOpenRequestTtl setHrmpOpenRequestTtl({required int new_}) {
    return SetHrmpOpenRequestTtl(new_: new_);
  }

  SetHrmpSenderDeposit setHrmpSenderDeposit({required BigInt new_}) {
    return SetHrmpSenderDeposit(new_: new_);
  }

  SetHrmpRecipientDeposit setHrmpRecipientDeposit({required BigInt new_}) {
    return SetHrmpRecipientDeposit(new_: new_);
  }

  SetHrmpChannelMaxCapacity setHrmpChannelMaxCapacity({required int new_}) {
    return SetHrmpChannelMaxCapacity(new_: new_);
  }

  SetHrmpChannelMaxTotalSize setHrmpChannelMaxTotalSize({required int new_}) {
    return SetHrmpChannelMaxTotalSize(new_: new_);
  }

  SetHrmpMaxParachainInboundChannels setHrmpMaxParachainInboundChannels(
      {required int new_}) {
    return SetHrmpMaxParachainInboundChannels(new_: new_);
  }

  SetHrmpMaxParathreadInboundChannels setHrmpMaxParathreadInboundChannels(
      {required int new_}) {
    return SetHrmpMaxParathreadInboundChannels(new_: new_);
  }

  SetHrmpChannelMaxMessageSize setHrmpChannelMaxMessageSize(
      {required int new_}) {
    return SetHrmpChannelMaxMessageSize(new_: new_);
  }

  SetHrmpMaxParachainOutboundChannels setHrmpMaxParachainOutboundChannels(
      {required int new_}) {
    return SetHrmpMaxParachainOutboundChannels(new_: new_);
  }

  SetHrmpMaxParathreadOutboundChannels setHrmpMaxParathreadOutboundChannels(
      {required int new_}) {
    return SetHrmpMaxParathreadOutboundChannels(new_: new_);
  }

  SetHrmpMaxMessageNumPerCandidate setHrmpMaxMessageNumPerCandidate(
      {required int new_}) {
    return SetHrmpMaxMessageNumPerCandidate(new_: new_);
  }

  SetPvfCheckingEnabled setPvfCheckingEnabled({required bool new_}) {
    return SetPvfCheckingEnabled(new_: new_);
  }

  SetPvfVotingTtl setPvfVotingTtl({required int new_}) {
    return SetPvfVotingTtl(new_: new_);
  }

  SetMinimumValidationUpgradeDelay setMinimumValidationUpgradeDelay(
      {required int new_}) {
    return SetMinimumValidationUpgradeDelay(new_: new_);
  }

  SetBypassConsistencyCheck setBypassConsistencyCheck({required bool new_}) {
    return SetBypassConsistencyCheck(new_: new_);
  }

  SetAsyncBackingParams setAsyncBackingParams(
      {required _i3.AsyncBackingParams new_}) {
    return SetAsyncBackingParams(new_: new_);
  }

  SetExecutorParams setExecutorParams({required _i4.ExecutorParams new_}) {
    return SetExecutorParams(new_: new_);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetValidationUpgradeCooldown._decode(input);
      case 1:
        return SetValidationUpgradeDelay._decode(input);
      case 2:
        return SetCodeRetentionPeriod._decode(input);
      case 3:
        return SetMaxCodeSize._decode(input);
      case 4:
        return SetMaxPovSize._decode(input);
      case 5:
        return SetMaxHeadDataSize._decode(input);
      case 6:
        return SetParathreadCores._decode(input);
      case 7:
        return SetParathreadRetries._decode(input);
      case 8:
        return SetGroupRotationFrequency._decode(input);
      case 9:
        return SetChainAvailabilityPeriod._decode(input);
      case 10:
        return SetThreadAvailabilityPeriod._decode(input);
      case 11:
        return SetSchedulingLookahead._decode(input);
      case 12:
        return SetMaxValidatorsPerCore._decode(input);
      case 13:
        return SetMaxValidators._decode(input);
      case 14:
        return SetDisputePeriod._decode(input);
      case 15:
        return SetDisputePostConclusionAcceptancePeriod._decode(input);
      case 18:
        return SetNoShowSlots._decode(input);
      case 19:
        return SetNDelayTranches._decode(input);
      case 20:
        return SetZerothDelayTrancheWidth._decode(input);
      case 21:
        return SetNeededApprovals._decode(input);
      case 22:
        return SetRelayVrfModuloSamples._decode(input);
      case 23:
        return SetMaxUpwardQueueCount._decode(input);
      case 24:
        return SetMaxUpwardQueueSize._decode(input);
      case 25:
        return SetMaxDownwardMessageSize._decode(input);
      case 27:
        return SetMaxUpwardMessageSize._decode(input);
      case 28:
        return SetMaxUpwardMessageNumPerCandidate._decode(input);
      case 29:
        return SetHrmpOpenRequestTtl._decode(input);
      case 30:
        return SetHrmpSenderDeposit._decode(input);
      case 31:
        return SetHrmpRecipientDeposit._decode(input);
      case 32:
        return SetHrmpChannelMaxCapacity._decode(input);
      case 33:
        return SetHrmpChannelMaxTotalSize._decode(input);
      case 34:
        return SetHrmpMaxParachainInboundChannels._decode(input);
      case 35:
        return SetHrmpMaxParathreadInboundChannels._decode(input);
      case 36:
        return SetHrmpChannelMaxMessageSize._decode(input);
      case 37:
        return SetHrmpMaxParachainOutboundChannels._decode(input);
      case 38:
        return SetHrmpMaxParathreadOutboundChannels._decode(input);
      case 39:
        return SetHrmpMaxMessageNumPerCandidate._decode(input);
      case 41:
        return SetPvfCheckingEnabled._decode(input);
      case 42:
        return SetPvfVotingTtl._decode(input);
      case 43:
        return SetMinimumValidationUpgradeDelay._decode(input);
      case 44:
        return SetBypassConsistencyCheck._decode(input);
      case 45:
        return SetAsyncBackingParams._decode(input);
      case 46:
        return SetExecutorParams._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetValidationUpgradeCooldown:
        (value as SetValidationUpgradeCooldown).encodeTo(output);
        break;
      case SetValidationUpgradeDelay:
        (value as SetValidationUpgradeDelay).encodeTo(output);
        break;
      case SetCodeRetentionPeriod:
        (value as SetCodeRetentionPeriod).encodeTo(output);
        break;
      case SetMaxCodeSize:
        (value as SetMaxCodeSize).encodeTo(output);
        break;
      case SetMaxPovSize:
        (value as SetMaxPovSize).encodeTo(output);
        break;
      case SetMaxHeadDataSize:
        (value as SetMaxHeadDataSize).encodeTo(output);
        break;
      case SetParathreadCores:
        (value as SetParathreadCores).encodeTo(output);
        break;
      case SetParathreadRetries:
        (value as SetParathreadRetries).encodeTo(output);
        break;
      case SetGroupRotationFrequency:
        (value as SetGroupRotationFrequency).encodeTo(output);
        break;
      case SetChainAvailabilityPeriod:
        (value as SetChainAvailabilityPeriod).encodeTo(output);
        break;
      case SetThreadAvailabilityPeriod:
        (value as SetThreadAvailabilityPeriod).encodeTo(output);
        break;
      case SetSchedulingLookahead:
        (value as SetSchedulingLookahead).encodeTo(output);
        break;
      case SetMaxValidatorsPerCore:
        (value as SetMaxValidatorsPerCore).encodeTo(output);
        break;
      case SetMaxValidators:
        (value as SetMaxValidators).encodeTo(output);
        break;
      case SetDisputePeriod:
        (value as SetDisputePeriod).encodeTo(output);
        break;
      case SetDisputePostConclusionAcceptancePeriod:
        (value as SetDisputePostConclusionAcceptancePeriod).encodeTo(output);
        break;
      case SetNoShowSlots:
        (value as SetNoShowSlots).encodeTo(output);
        break;
      case SetNDelayTranches:
        (value as SetNDelayTranches).encodeTo(output);
        break;
      case SetZerothDelayTrancheWidth:
        (value as SetZerothDelayTrancheWidth).encodeTo(output);
        break;
      case SetNeededApprovals:
        (value as SetNeededApprovals).encodeTo(output);
        break;
      case SetRelayVrfModuloSamples:
        (value as SetRelayVrfModuloSamples).encodeTo(output);
        break;
      case SetMaxUpwardQueueCount:
        (value as SetMaxUpwardQueueCount).encodeTo(output);
        break;
      case SetMaxUpwardQueueSize:
        (value as SetMaxUpwardQueueSize).encodeTo(output);
        break;
      case SetMaxDownwardMessageSize:
        (value as SetMaxDownwardMessageSize).encodeTo(output);
        break;
      case SetMaxUpwardMessageSize:
        (value as SetMaxUpwardMessageSize).encodeTo(output);
        break;
      case SetMaxUpwardMessageNumPerCandidate:
        (value as SetMaxUpwardMessageNumPerCandidate).encodeTo(output);
        break;
      case SetHrmpOpenRequestTtl:
        (value as SetHrmpOpenRequestTtl).encodeTo(output);
        break;
      case SetHrmpSenderDeposit:
        (value as SetHrmpSenderDeposit).encodeTo(output);
        break;
      case SetHrmpRecipientDeposit:
        (value as SetHrmpRecipientDeposit).encodeTo(output);
        break;
      case SetHrmpChannelMaxCapacity:
        (value as SetHrmpChannelMaxCapacity).encodeTo(output);
        break;
      case SetHrmpChannelMaxTotalSize:
        (value as SetHrmpChannelMaxTotalSize).encodeTo(output);
        break;
      case SetHrmpMaxParachainInboundChannels:
        (value as SetHrmpMaxParachainInboundChannels).encodeTo(output);
        break;
      case SetHrmpMaxParathreadInboundChannels:
        (value as SetHrmpMaxParathreadInboundChannels).encodeTo(output);
        break;
      case SetHrmpChannelMaxMessageSize:
        (value as SetHrmpChannelMaxMessageSize).encodeTo(output);
        break;
      case SetHrmpMaxParachainOutboundChannels:
        (value as SetHrmpMaxParachainOutboundChannels).encodeTo(output);
        break;
      case SetHrmpMaxParathreadOutboundChannels:
        (value as SetHrmpMaxParathreadOutboundChannels).encodeTo(output);
        break;
      case SetHrmpMaxMessageNumPerCandidate:
        (value as SetHrmpMaxMessageNumPerCandidate).encodeTo(output);
        break;
      case SetPvfCheckingEnabled:
        (value as SetPvfCheckingEnabled).encodeTo(output);
        break;
      case SetPvfVotingTtl:
        (value as SetPvfVotingTtl).encodeTo(output);
        break;
      case SetMinimumValidationUpgradeDelay:
        (value as SetMinimumValidationUpgradeDelay).encodeTo(output);
        break;
      case SetBypassConsistencyCheck:
        (value as SetBypassConsistencyCheck).encodeTo(output);
        break;
      case SetAsyncBackingParams:
        (value as SetAsyncBackingParams).encodeTo(output);
        break;
      case SetExecutorParams:
        (value as SetExecutorParams).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetValidationUpgradeCooldown:
        return (value as SetValidationUpgradeCooldown)._sizeHint();
      case SetValidationUpgradeDelay:
        return (value as SetValidationUpgradeDelay)._sizeHint();
      case SetCodeRetentionPeriod:
        return (value as SetCodeRetentionPeriod)._sizeHint();
      case SetMaxCodeSize:
        return (value as SetMaxCodeSize)._sizeHint();
      case SetMaxPovSize:
        return (value as SetMaxPovSize)._sizeHint();
      case SetMaxHeadDataSize:
        return (value as SetMaxHeadDataSize)._sizeHint();
      case SetParathreadCores:
        return (value as SetParathreadCores)._sizeHint();
      case SetParathreadRetries:
        return (value as SetParathreadRetries)._sizeHint();
      case SetGroupRotationFrequency:
        return (value as SetGroupRotationFrequency)._sizeHint();
      case SetChainAvailabilityPeriod:
        return (value as SetChainAvailabilityPeriod)._sizeHint();
      case SetThreadAvailabilityPeriod:
        return (value as SetThreadAvailabilityPeriod)._sizeHint();
      case SetSchedulingLookahead:
        return (value as SetSchedulingLookahead)._sizeHint();
      case SetMaxValidatorsPerCore:
        return (value as SetMaxValidatorsPerCore)._sizeHint();
      case SetMaxValidators:
        return (value as SetMaxValidators)._sizeHint();
      case SetDisputePeriod:
        return (value as SetDisputePeriod)._sizeHint();
      case SetDisputePostConclusionAcceptancePeriod:
        return (value as SetDisputePostConclusionAcceptancePeriod)._sizeHint();
      case SetNoShowSlots:
        return (value as SetNoShowSlots)._sizeHint();
      case SetNDelayTranches:
        return (value as SetNDelayTranches)._sizeHint();
      case SetZerothDelayTrancheWidth:
        return (value as SetZerothDelayTrancheWidth)._sizeHint();
      case SetNeededApprovals:
        return (value as SetNeededApprovals)._sizeHint();
      case SetRelayVrfModuloSamples:
        return (value as SetRelayVrfModuloSamples)._sizeHint();
      case SetMaxUpwardQueueCount:
        return (value as SetMaxUpwardQueueCount)._sizeHint();
      case SetMaxUpwardQueueSize:
        return (value as SetMaxUpwardQueueSize)._sizeHint();
      case SetMaxDownwardMessageSize:
        return (value as SetMaxDownwardMessageSize)._sizeHint();
      case SetMaxUpwardMessageSize:
        return (value as SetMaxUpwardMessageSize)._sizeHint();
      case SetMaxUpwardMessageNumPerCandidate:
        return (value as SetMaxUpwardMessageNumPerCandidate)._sizeHint();
      case SetHrmpOpenRequestTtl:
        return (value as SetHrmpOpenRequestTtl)._sizeHint();
      case SetHrmpSenderDeposit:
        return (value as SetHrmpSenderDeposit)._sizeHint();
      case SetHrmpRecipientDeposit:
        return (value as SetHrmpRecipientDeposit)._sizeHint();
      case SetHrmpChannelMaxCapacity:
        return (value as SetHrmpChannelMaxCapacity)._sizeHint();
      case SetHrmpChannelMaxTotalSize:
        return (value as SetHrmpChannelMaxTotalSize)._sizeHint();
      case SetHrmpMaxParachainInboundChannels:
        return (value as SetHrmpMaxParachainInboundChannels)._sizeHint();
      case SetHrmpMaxParathreadInboundChannels:
        return (value as SetHrmpMaxParathreadInboundChannels)._sizeHint();
      case SetHrmpChannelMaxMessageSize:
        return (value as SetHrmpChannelMaxMessageSize)._sizeHint();
      case SetHrmpMaxParachainOutboundChannels:
        return (value as SetHrmpMaxParachainOutboundChannels)._sizeHint();
      case SetHrmpMaxParathreadOutboundChannels:
        return (value as SetHrmpMaxParathreadOutboundChannels)._sizeHint();
      case SetHrmpMaxMessageNumPerCandidate:
        return (value as SetHrmpMaxMessageNumPerCandidate)._sizeHint();
      case SetPvfCheckingEnabled:
        return (value as SetPvfCheckingEnabled)._sizeHint();
      case SetPvfVotingTtl:
        return (value as SetPvfVotingTtl)._sizeHint();
      case SetMinimumValidationUpgradeDelay:
        return (value as SetMinimumValidationUpgradeDelay)._sizeHint();
      case SetBypassConsistencyCheck:
        return (value as SetBypassConsistencyCheck)._sizeHint();
      case SetAsyncBackingParams:
        return (value as SetAsyncBackingParams)._sizeHint();
      case SetExecutorParams:
        return (value as SetExecutorParams)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Set the validation upgrade cooldown.
class SetValidationUpgradeCooldown extends Call {
  const SetValidationUpgradeCooldown({required this.new_});

  factory SetValidationUpgradeCooldown._decode(_i1.Input input) {
    return SetValidationUpgradeCooldown(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_validation_upgrade_cooldown': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetValidationUpgradeCooldown && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the validation upgrade delay.
class SetValidationUpgradeDelay extends Call {
  const SetValidationUpgradeDelay({required this.new_});

  factory SetValidationUpgradeDelay._decode(_i1.Input input) {
    return SetValidationUpgradeDelay(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_validation_upgrade_delay': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetValidationUpgradeDelay && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the acceptance period for an included candidate.
class SetCodeRetentionPeriod extends Call {
  const SetCodeRetentionPeriod({required this.new_});

  factory SetCodeRetentionPeriod._decode(_i1.Input input) {
    return SetCodeRetentionPeriod(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_code_retention_period': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCodeRetentionPeriod && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the max validation code size for incoming upgrades.
class SetMaxCodeSize extends Call {
  const SetMaxCodeSize({required this.new_});

  factory SetMaxCodeSize._decode(_i1.Input input) {
    return SetMaxCodeSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_code_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxCodeSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the max POV block size for incoming upgrades.
class SetMaxPovSize extends Call {
  const SetMaxPovSize({required this.new_});

  factory SetMaxPovSize._decode(_i1.Input input) {
    return SetMaxPovSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_pov_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxPovSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the max head data size for paras.
class SetMaxHeadDataSize extends Call {
  const SetMaxHeadDataSize({required this.new_});

  factory SetMaxHeadDataSize._decode(_i1.Input input) {
    return SetMaxHeadDataSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_head_data_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxHeadDataSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the number of parathread execution cores.
class SetParathreadCores extends Call {
  const SetParathreadCores({required this.new_});

  factory SetParathreadCores._decode(_i1.Input input) {
    return SetParathreadCores(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_parathread_cores': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetParathreadCores && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the number of retries for a particular parathread.
class SetParathreadRetries extends Call {
  const SetParathreadRetries({required this.new_});

  factory SetParathreadRetries._decode(_i1.Input input) {
    return SetParathreadRetries(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_parathread_retries': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetParathreadRetries && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the parachain validator-group rotation frequency
class SetGroupRotationFrequency extends Call {
  const SetGroupRotationFrequency({required this.new_});

  factory SetGroupRotationFrequency._decode(_i1.Input input) {
    return SetGroupRotationFrequency(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_group_rotation_frequency': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetGroupRotationFrequency && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the availability period for parachains.
class SetChainAvailabilityPeriod extends Call {
  const SetChainAvailabilityPeriod({required this.new_});

  factory SetChainAvailabilityPeriod._decode(_i1.Input input) {
    return SetChainAvailabilityPeriod(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_chain_availability_period': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetChainAvailabilityPeriod && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the availability period for parathreads.
class SetThreadAvailabilityPeriod extends Call {
  const SetThreadAvailabilityPeriod({required this.new_});

  factory SetThreadAvailabilityPeriod._decode(_i1.Input input) {
    return SetThreadAvailabilityPeriod(new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_thread_availability_period': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetThreadAvailabilityPeriod && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the scheduling lookahead, in expected number of blocks at peak throughput.
class SetSchedulingLookahead extends Call {
  const SetSchedulingLookahead({required this.new_});

  factory SetSchedulingLookahead._decode(_i1.Input input) {
    return SetSchedulingLookahead(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_scheduling_lookahead': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetSchedulingLookahead && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the maximum number of validators to assign to any core.
class SetMaxValidatorsPerCore extends Call {
  const SetMaxValidatorsPerCore({this.new_});

  factory SetMaxValidatorsPerCore._decode(_i1.Input input) {
    return SetMaxValidatorsPerCore(
        new_: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<u32>
  final int? new_;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'set_max_validators_per_core': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxValidatorsPerCore && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the maximum number of validators to use in parachain consensus.
class SetMaxValidators extends Call {
  const SetMaxValidators({this.new_});

  factory SetMaxValidators._decode(_i1.Input input) {
    return SetMaxValidators(
        new_: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input));
  }

  /// Option<u32>
  final int? new_;

  @override
  Map<String, Map<String, int?>> toJson() => {
        'set_max_validators': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxValidators && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the dispute period, in number of sessions to keep for disputes.
class SetDisputePeriod extends Call {
  const SetDisputePeriod({required this.new_});

  factory SetDisputePeriod._decode(_i1.Input input) {
    return SetDisputePeriod(new_: _i1.U32Codec.codec.decode(input));
  }

  /// SessionIndex
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_dispute_period': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetDisputePeriod && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the dispute post conclusion acceptance period.
class SetDisputePostConclusionAcceptancePeriod extends Call {
  const SetDisputePostConclusionAcceptancePeriod({required this.new_});

  factory SetDisputePostConclusionAcceptancePeriod._decode(_i1.Input input) {
    return SetDisputePostConclusionAcceptancePeriod(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_dispute_post_conclusion_acceptance_period': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetDisputePostConclusionAcceptancePeriod && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the no show slots, in number of number of consensus slots.
/// Must be at least 1.
class SetNoShowSlots extends Call {
  const SetNoShowSlots({required this.new_});

  factory SetNoShowSlots._decode(_i1.Input input) {
    return SetNoShowSlots(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_no_show_slots': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetNoShowSlots && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the total number of delay tranches.
class SetNDelayTranches extends Call {
  const SetNDelayTranches({required this.new_});

  factory SetNDelayTranches._decode(_i1.Input input) {
    return SetNDelayTranches(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_n_delay_tranches': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetNDelayTranches && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the zeroth delay tranche width.
class SetZerothDelayTrancheWidth extends Call {
  const SetZerothDelayTrancheWidth({required this.new_});

  factory SetZerothDelayTrancheWidth._decode(_i1.Input input) {
    return SetZerothDelayTrancheWidth(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_zeroth_delay_tranche_width': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetZerothDelayTrancheWidth && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the number of validators needed to approve a block.
class SetNeededApprovals extends Call {
  const SetNeededApprovals({required this.new_});

  factory SetNeededApprovals._decode(_i1.Input input) {
    return SetNeededApprovals(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_needed_approvals': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetNeededApprovals && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the number of samples to do of the `RelayVRFModulo` approval assignment criterion.
class SetRelayVrfModuloSamples extends Call {
  const SetRelayVrfModuloSamples({required this.new_});

  factory SetRelayVrfModuloSamples._decode(_i1.Input input) {
    return SetRelayVrfModuloSamples(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_relay_vrf_modulo_samples': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetRelayVrfModuloSamples && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum items that can present in a upward dispatch queue at once.
class SetMaxUpwardQueueCount extends Call {
  const SetMaxUpwardQueueCount({required this.new_});

  factory SetMaxUpwardQueueCount._decode(_i1.Input input) {
    return SetMaxUpwardQueueCount(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_upward_queue_count': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxUpwardQueueCount && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum total size of items that can present in a upward dispatch queue at once.
class SetMaxUpwardQueueSize extends Call {
  const SetMaxUpwardQueueSize({required this.new_});

  factory SetMaxUpwardQueueSize._decode(_i1.Input input) {
    return SetMaxUpwardQueueSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_upward_queue_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxUpwardQueueSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the critical downward message size.
class SetMaxDownwardMessageSize extends Call {
  const SetMaxDownwardMessageSize({required this.new_});

  factory SetMaxDownwardMessageSize._decode(_i1.Input input) {
    return SetMaxDownwardMessageSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_downward_message_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxDownwardMessageSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum size of an upward message that can be sent by a candidate.
class SetMaxUpwardMessageSize extends Call {
  const SetMaxUpwardMessageSize({required this.new_});

  factory SetMaxUpwardMessageSize._decode(_i1.Input input) {
    return SetMaxUpwardMessageSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_upward_message_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxUpwardMessageSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of messages that a candidate can contain.
class SetMaxUpwardMessageNumPerCandidate extends Call {
  const SetMaxUpwardMessageNumPerCandidate({required this.new_});

  factory SetMaxUpwardMessageNumPerCandidate._decode(_i1.Input input) {
    return SetMaxUpwardMessageNumPerCandidate(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_max_upward_message_num_per_candidate': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMaxUpwardMessageNumPerCandidate && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the number of sessions after which an HRMP open channel request expires.
class SetHrmpOpenRequestTtl extends Call {
  const SetHrmpOpenRequestTtl({required this.new_});

  factory SetHrmpOpenRequestTtl._decode(_i1.Input input) {
    return SetHrmpOpenRequestTtl(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_open_request_ttl': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpOpenRequestTtl && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the amount of funds that the sender should provide for opening an HRMP channel.
class SetHrmpSenderDeposit extends Call {
  const SetHrmpSenderDeposit({required this.new_});

  factory SetHrmpSenderDeposit._decode(_i1.Input input) {
    return SetHrmpSenderDeposit(new_: _i1.U128Codec.codec.decode(input));
  }

  /// Balance
  final BigInt new_;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_hrmp_sender_deposit': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpSenderDeposit && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the amount of funds that the recipient should provide for accepting opening an HRMP
/// channel.
class SetHrmpRecipientDeposit extends Call {
  const SetHrmpRecipientDeposit({required this.new_});

  factory SetHrmpRecipientDeposit._decode(_i1.Input input) {
    return SetHrmpRecipientDeposit(new_: _i1.U128Codec.codec.decode(input));
  }

  /// Balance
  final BigInt new_;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_hrmp_recipient_deposit': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpRecipientDeposit && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of messages allowed in an HRMP channel at once.
class SetHrmpChannelMaxCapacity extends Call {
  const SetHrmpChannelMaxCapacity({required this.new_});

  factory SetHrmpChannelMaxCapacity._decode(_i1.Input input) {
    return SetHrmpChannelMaxCapacity(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_channel_max_capacity': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpChannelMaxCapacity && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum total size of messages in bytes allowed in an HRMP channel at once.
class SetHrmpChannelMaxTotalSize extends Call {
  const SetHrmpChannelMaxTotalSize({required this.new_});

  factory SetHrmpChannelMaxTotalSize._decode(_i1.Input input) {
    return SetHrmpChannelMaxTotalSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_channel_max_total_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpChannelMaxTotalSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of inbound HRMP channels a parachain is allowed to accept.
class SetHrmpMaxParachainInboundChannels extends Call {
  const SetHrmpMaxParachainInboundChannels({required this.new_});

  factory SetHrmpMaxParachainInboundChannels._decode(_i1.Input input) {
    return SetHrmpMaxParachainInboundChannels(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_max_parachain_inbound_channels': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpMaxParachainInboundChannels && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of inbound HRMP channels a parathread is allowed to accept.
class SetHrmpMaxParathreadInboundChannels extends Call {
  const SetHrmpMaxParathreadInboundChannels({required this.new_});

  factory SetHrmpMaxParathreadInboundChannels._decode(_i1.Input input) {
    return SetHrmpMaxParathreadInboundChannels(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_max_parathread_inbound_channels': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpMaxParathreadInboundChannels && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum size of a message that could ever be put into an HRMP channel.
class SetHrmpChannelMaxMessageSize extends Call {
  const SetHrmpChannelMaxMessageSize({required this.new_});

  factory SetHrmpChannelMaxMessageSize._decode(_i1.Input input) {
    return SetHrmpChannelMaxMessageSize(new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_channel_max_message_size': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      36,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpChannelMaxMessageSize && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of outbound HRMP channels a parachain is allowed to open.
class SetHrmpMaxParachainOutboundChannels extends Call {
  const SetHrmpMaxParachainOutboundChannels({required this.new_});

  factory SetHrmpMaxParachainOutboundChannels._decode(_i1.Input input) {
    return SetHrmpMaxParachainOutboundChannels(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_max_parachain_outbound_channels': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      37,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpMaxParachainOutboundChannels && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of outbound HRMP channels a parathread is allowed to open.
class SetHrmpMaxParathreadOutboundChannels extends Call {
  const SetHrmpMaxParathreadOutboundChannels({required this.new_});

  factory SetHrmpMaxParathreadOutboundChannels._decode(_i1.Input input) {
    return SetHrmpMaxParathreadOutboundChannels(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_max_parathread_outbound_channels': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      38,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpMaxParathreadOutboundChannels && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the maximum number of outbound HRMP messages can be sent by a candidate.
class SetHrmpMaxMessageNumPerCandidate extends Call {
  const SetHrmpMaxMessageNumPerCandidate({required this.new_});

  factory SetHrmpMaxMessageNumPerCandidate._decode(_i1.Input input) {
    return SetHrmpMaxMessageNumPerCandidate(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_hrmp_max_message_num_per_candidate': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      39,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetHrmpMaxMessageNumPerCandidate && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Enable or disable PVF pre-checking. Consult the field documentation prior executing.
class SetPvfCheckingEnabled extends Call {
  const SetPvfCheckingEnabled({required this.new_});

  factory SetPvfCheckingEnabled._decode(_i1.Input input) {
    return SetPvfCheckingEnabled(new_: _i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool new_;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'set_pvf_checking_enabled': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      41,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetPvfCheckingEnabled && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the number of session changes after which a PVF pre-checking voting is rejected.
class SetPvfVotingTtl extends Call {
  const SetPvfVotingTtl({required this.new_});

  factory SetPvfVotingTtl._decode(_i1.Input input) {
    return SetPvfVotingTtl(new_: _i1.U32Codec.codec.decode(input));
  }

  /// SessionIndex
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_pvf_voting_ttl': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      42,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetPvfVotingTtl && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Sets the minimum delay between announcing the upgrade block for a parachain until the
/// upgrade taking place.
///
/// See the field documentation for information and constraints for the new value.
class SetMinimumValidationUpgradeDelay extends Call {
  const SetMinimumValidationUpgradeDelay({required this.new_});

  factory SetMinimumValidationUpgradeDelay._decode(_i1.Input input) {
    return SetMinimumValidationUpgradeDelay(
        new_: _i1.U32Codec.codec.decode(input));
  }

  /// T::BlockNumber
  final int new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_minimum_validation_upgrade_delay': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      43,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMinimumValidationUpgradeDelay && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Setting this to true will disable consistency checks for the configuration setters.
/// Use with caution.
class SetBypassConsistencyCheck extends Call {
  const SetBypassConsistencyCheck({required this.new_});

  factory SetBypassConsistencyCheck._decode(_i1.Input input) {
    return SetBypassConsistencyCheck(new_: _i1.BoolCodec.codec.decode(input));
  }

  /// bool
  final bool new_;

  @override
  Map<String, Map<String, bool>> toJson() => {
        'set_bypass_consistency_check': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.BoolCodec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      44,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetBypassConsistencyCheck && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set the asynchronous backing parameters.
class SetAsyncBackingParams extends Call {
  const SetAsyncBackingParams({required this.new_});

  factory SetAsyncBackingParams._decode(_i1.Input input) {
    return SetAsyncBackingParams(
        new_: _i3.AsyncBackingParams.codec.decode(input));
  }

  /// AsyncBackingParams
  final _i3.AsyncBackingParams new_;

  @override
  Map<String, Map<String, Map<String, int>>> toJson() => {
        'set_async_backing_params': {'new': new_.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.AsyncBackingParams.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      45,
      output,
    );
    _i3.AsyncBackingParams.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetAsyncBackingParams && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Set PVF executor parameters.
class SetExecutorParams extends Call {
  const SetExecutorParams({required this.new_});

  factory SetExecutorParams._decode(_i1.Input input) {
    return SetExecutorParams(
        new_:
            const _i1.SequenceCodec<_i5.ExecutorParam>(_i5.ExecutorParam.codec)
                .decode(input));
  }

  /// ExecutorParams
  final _i4.ExecutorParams new_;

  @override
  Map<String, Map<String, List<Map<String, dynamic>>>> toJson() => {
        'set_executor_params': {
          'new': new_.map((value) => value.toJson()).toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.ExecutorParamsCodec().sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      46,
      output,
    );
    const _i1.SequenceCodec<_i5.ExecutorParam>(_i5.ExecutorParam.codec)
        .encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetExecutorParams &&
          _i6.listsEqual(
            other.new_,
            new_,
          );

  @override
  int get hashCode => new_.hashCode;
}
