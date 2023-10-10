// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i4;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../polkadot_primitives/v4/executor_params/executor_param.dart'
    as _i6;
import '../../polkadot_primitives/v4/executor_params/executor_params.dart'
    as _i3;
import '../../polkadot_primitives/vstaging/async_backing_params.dart' as _i2;

class HostConfiguration {
  const HostConfiguration({
    required this.maxCodeSize,
    required this.maxHeadDataSize,
    required this.maxUpwardQueueCount,
    required this.maxUpwardQueueSize,
    required this.maxUpwardMessageSize,
    required this.maxUpwardMessageNumPerCandidate,
    required this.hrmpMaxMessageNumPerCandidate,
    required this.validationUpgradeCooldown,
    required this.validationUpgradeDelay,
    required this.asyncBackingParams,
    required this.maxPovSize,
    required this.maxDownwardMessageSize,
    required this.hrmpMaxParachainOutboundChannels,
    required this.hrmpMaxParathreadOutboundChannels,
    required this.hrmpSenderDeposit,
    required this.hrmpRecipientDeposit,
    required this.hrmpChannelMaxCapacity,
    required this.hrmpChannelMaxTotalSize,
    required this.hrmpMaxParachainInboundChannels,
    required this.hrmpMaxParathreadInboundChannels,
    required this.hrmpChannelMaxMessageSize,
    required this.executorParams,
    required this.codeRetentionPeriod,
    required this.parathreadCores,
    required this.parathreadRetries,
    required this.groupRotationFrequency,
    required this.chainAvailabilityPeriod,
    required this.threadAvailabilityPeriod,
    required this.schedulingLookahead,
    this.maxValidatorsPerCore,
    this.maxValidators,
    required this.disputePeriod,
    required this.disputePostConclusionAcceptancePeriod,
    required this.noShowSlots,
    required this.nDelayTranches,
    required this.zerothDelayTrancheWidth,
    required this.neededApprovals,
    required this.relayVrfModuloSamples,
    required this.pvfCheckingEnabled,
    required this.pvfVotingTtl,
    required this.minimumValidationUpgradeDelay,
  });

  factory HostConfiguration.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// u32
  final int maxCodeSize;

  /// u32
  final int maxHeadDataSize;

  /// u32
  final int maxUpwardQueueCount;

  /// u32
  final int maxUpwardQueueSize;

  /// u32
  final int maxUpwardMessageSize;

  /// u32
  final int maxUpwardMessageNumPerCandidate;

  /// u32
  final int hrmpMaxMessageNumPerCandidate;

  /// BlockNumber
  final int validationUpgradeCooldown;

  /// BlockNumber
  final int validationUpgradeDelay;

  /// AsyncBackingParams
  final _i2.AsyncBackingParams asyncBackingParams;

  /// u32
  final int maxPovSize;

  /// u32
  final int maxDownwardMessageSize;

  /// u32
  final int hrmpMaxParachainOutboundChannels;

  /// u32
  final int hrmpMaxParathreadOutboundChannels;

  /// Balance
  final BigInt hrmpSenderDeposit;

  /// Balance
  final BigInt hrmpRecipientDeposit;

  /// u32
  final int hrmpChannelMaxCapacity;

  /// u32
  final int hrmpChannelMaxTotalSize;

  /// u32
  final int hrmpMaxParachainInboundChannels;

  /// u32
  final int hrmpMaxParathreadInboundChannels;

  /// u32
  final int hrmpChannelMaxMessageSize;

  /// ExecutorParams
  final _i3.ExecutorParams executorParams;

  /// BlockNumber
  final int codeRetentionPeriod;

  /// u32
  final int parathreadCores;

  /// u32
  final int parathreadRetries;

  /// BlockNumber
  final int groupRotationFrequency;

  /// BlockNumber
  final int chainAvailabilityPeriod;

  /// BlockNumber
  final int threadAvailabilityPeriod;

  /// u32
  final int schedulingLookahead;

  /// Option<u32>
  final int? maxValidatorsPerCore;

  /// Option<u32>
  final int? maxValidators;

  /// SessionIndex
  final int disputePeriod;

  /// BlockNumber
  final int disputePostConclusionAcceptancePeriod;

  /// u32
  final int noShowSlots;

  /// u32
  final int nDelayTranches;

  /// u32
  final int zerothDelayTrancheWidth;

  /// u32
  final int neededApprovals;

  /// u32
  final int relayVrfModuloSamples;

  /// bool
  final bool pvfCheckingEnabled;

  /// SessionIndex
  final int pvfVotingTtl;

  /// BlockNumber
  final int minimumValidationUpgradeDelay;

  static const $HostConfigurationCodec codec = $HostConfigurationCodec();

  _i4.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'maxCodeSize': maxCodeSize,
        'maxHeadDataSize': maxHeadDataSize,
        'maxUpwardQueueCount': maxUpwardQueueCount,
        'maxUpwardQueueSize': maxUpwardQueueSize,
        'maxUpwardMessageSize': maxUpwardMessageSize,
        'maxUpwardMessageNumPerCandidate': maxUpwardMessageNumPerCandidate,
        'hrmpMaxMessageNumPerCandidate': hrmpMaxMessageNumPerCandidate,
        'validationUpgradeCooldown': validationUpgradeCooldown,
        'validationUpgradeDelay': validationUpgradeDelay,
        'asyncBackingParams': asyncBackingParams.toJson(),
        'maxPovSize': maxPovSize,
        'maxDownwardMessageSize': maxDownwardMessageSize,
        'hrmpMaxParachainOutboundChannels': hrmpMaxParachainOutboundChannels,
        'hrmpMaxParathreadOutboundChannels': hrmpMaxParathreadOutboundChannels,
        'hrmpSenderDeposit': hrmpSenderDeposit,
        'hrmpRecipientDeposit': hrmpRecipientDeposit,
        'hrmpChannelMaxCapacity': hrmpChannelMaxCapacity,
        'hrmpChannelMaxTotalSize': hrmpChannelMaxTotalSize,
        'hrmpMaxParachainInboundChannels': hrmpMaxParachainInboundChannels,
        'hrmpMaxParathreadInboundChannels': hrmpMaxParathreadInboundChannels,
        'hrmpChannelMaxMessageSize': hrmpChannelMaxMessageSize,
        'executorParams':
            executorParams.map((value) => value.toJson()).toList(),
        'codeRetentionPeriod': codeRetentionPeriod,
        'parathreadCores': parathreadCores,
        'parathreadRetries': parathreadRetries,
        'groupRotationFrequency': groupRotationFrequency,
        'chainAvailabilityPeriod': chainAvailabilityPeriod,
        'threadAvailabilityPeriod': threadAvailabilityPeriod,
        'schedulingLookahead': schedulingLookahead,
        'maxValidatorsPerCore': maxValidatorsPerCore,
        'maxValidators': maxValidators,
        'disputePeriod': disputePeriod,
        'disputePostConclusionAcceptancePeriod':
            disputePostConclusionAcceptancePeriod,
        'noShowSlots': noShowSlots,
        'nDelayTranches': nDelayTranches,
        'zerothDelayTrancheWidth': zerothDelayTrancheWidth,
        'neededApprovals': neededApprovals,
        'relayVrfModuloSamples': relayVrfModuloSamples,
        'pvfCheckingEnabled': pvfCheckingEnabled,
        'pvfVotingTtl': pvfVotingTtl,
        'minimumValidationUpgradeDelay': minimumValidationUpgradeDelay,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is HostConfiguration &&
          other.maxCodeSize == maxCodeSize &&
          other.maxHeadDataSize == maxHeadDataSize &&
          other.maxUpwardQueueCount == maxUpwardQueueCount &&
          other.maxUpwardQueueSize == maxUpwardQueueSize &&
          other.maxUpwardMessageSize == maxUpwardMessageSize &&
          other.maxUpwardMessageNumPerCandidate ==
              maxUpwardMessageNumPerCandidate &&
          other.hrmpMaxMessageNumPerCandidate ==
              hrmpMaxMessageNumPerCandidate &&
          other.validationUpgradeCooldown == validationUpgradeCooldown &&
          other.validationUpgradeDelay == validationUpgradeDelay &&
          other.asyncBackingParams == asyncBackingParams &&
          other.maxPovSize == maxPovSize &&
          other.maxDownwardMessageSize == maxDownwardMessageSize &&
          other.hrmpMaxParachainOutboundChannels ==
              hrmpMaxParachainOutboundChannels &&
          other.hrmpMaxParathreadOutboundChannels ==
              hrmpMaxParathreadOutboundChannels &&
          other.hrmpSenderDeposit == hrmpSenderDeposit &&
          other.hrmpRecipientDeposit == hrmpRecipientDeposit &&
          other.hrmpChannelMaxCapacity == hrmpChannelMaxCapacity &&
          other.hrmpChannelMaxTotalSize == hrmpChannelMaxTotalSize &&
          other.hrmpMaxParachainInboundChannels ==
              hrmpMaxParachainInboundChannels &&
          other.hrmpMaxParathreadInboundChannels ==
              hrmpMaxParathreadInboundChannels &&
          other.hrmpChannelMaxMessageSize == hrmpChannelMaxMessageSize &&
          _i5.listsEqual(
            other.executorParams,
            executorParams,
          ) &&
          other.codeRetentionPeriod == codeRetentionPeriod &&
          other.parathreadCores == parathreadCores &&
          other.parathreadRetries == parathreadRetries &&
          other.groupRotationFrequency == groupRotationFrequency &&
          other.chainAvailabilityPeriod == chainAvailabilityPeriod &&
          other.threadAvailabilityPeriod == threadAvailabilityPeriod &&
          other.schedulingLookahead == schedulingLookahead &&
          other.maxValidatorsPerCore == maxValidatorsPerCore &&
          other.maxValidators == maxValidators &&
          other.disputePeriod == disputePeriod &&
          other.disputePostConclusionAcceptancePeriod ==
              disputePostConclusionAcceptancePeriod &&
          other.noShowSlots == noShowSlots &&
          other.nDelayTranches == nDelayTranches &&
          other.zerothDelayTrancheWidth == zerothDelayTrancheWidth &&
          other.neededApprovals == neededApprovals &&
          other.relayVrfModuloSamples == relayVrfModuloSamples &&
          other.pvfCheckingEnabled == pvfCheckingEnabled &&
          other.pvfVotingTtl == pvfVotingTtl &&
          other.minimumValidationUpgradeDelay == minimumValidationUpgradeDelay;

  @override
  int get hashCode => Object.hashAll([
        maxCodeSize,
        maxHeadDataSize,
        maxUpwardQueueCount,
        maxUpwardQueueSize,
        maxUpwardMessageSize,
        maxUpwardMessageNumPerCandidate,
        hrmpMaxMessageNumPerCandidate,
        validationUpgradeCooldown,
        validationUpgradeDelay,
        asyncBackingParams,
        maxPovSize,
        maxDownwardMessageSize,
        hrmpMaxParachainOutboundChannels,
        hrmpMaxParathreadOutboundChannels,
        hrmpSenderDeposit,
        hrmpRecipientDeposit,
        hrmpChannelMaxCapacity,
        hrmpChannelMaxTotalSize,
        hrmpMaxParachainInboundChannels,
        hrmpMaxParathreadInboundChannels,
        hrmpChannelMaxMessageSize,
        executorParams,
        codeRetentionPeriod,
        parathreadCores,
        parathreadRetries,
        groupRotationFrequency,
        chainAvailabilityPeriod,
        threadAvailabilityPeriod,
        schedulingLookahead,
        maxValidatorsPerCore,
        maxValidators,
        disputePeriod,
        disputePostConclusionAcceptancePeriod,
        noShowSlots,
        nDelayTranches,
        zerothDelayTrancheWidth,
        neededApprovals,
        relayVrfModuloSamples,
        pvfCheckingEnabled,
        pvfVotingTtl,
        minimumValidationUpgradeDelay,
      ]);
}

class $HostConfigurationCodec with _i1.Codec<HostConfiguration> {
  const $HostConfigurationCodec();

  @override
  void encodeTo(
    HostConfiguration obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxCodeSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxHeadDataSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardQueueCount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardQueueSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxUpwardMessageNumPerCandidate,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxMessageNumPerCandidate,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validationUpgradeCooldown,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.validationUpgradeDelay,
      output,
    );
    _i2.AsyncBackingParams.codec.encodeTo(
      obj.asyncBackingParams,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxPovSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.maxDownwardMessageSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxParachainOutboundChannels,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxParathreadOutboundChannels,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.hrmpSenderDeposit,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.hrmpRecipientDeposit,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpChannelMaxCapacity,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpChannelMaxTotalSize,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxParachainInboundChannels,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpMaxParathreadInboundChannels,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.hrmpChannelMaxMessageSize,
      output,
    );
    const _i1.SequenceCodec<_i6.ExecutorParam>(_i6.ExecutorParam.codec)
        .encodeTo(
      obj.executorParams,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.codeRetentionPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.parathreadCores,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.parathreadRetries,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.groupRotationFrequency,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.chainAvailabilityPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.threadAvailabilityPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.schedulingLookahead,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.maxValidatorsPerCore,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.maxValidators,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.disputePeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.disputePostConclusionAcceptancePeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.noShowSlots,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.nDelayTranches,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.zerothDelayTrancheWidth,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.neededApprovals,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.relayVrfModuloSamples,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      obj.pvfCheckingEnabled,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.pvfVotingTtl,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.minimumValidationUpgradeDelay,
      output,
    );
  }

  @override
  HostConfiguration decode(_i1.Input input) {
    return HostConfiguration(
      maxCodeSize: _i1.U32Codec.codec.decode(input),
      maxHeadDataSize: _i1.U32Codec.codec.decode(input),
      maxUpwardQueueCount: _i1.U32Codec.codec.decode(input),
      maxUpwardQueueSize: _i1.U32Codec.codec.decode(input),
      maxUpwardMessageSize: _i1.U32Codec.codec.decode(input),
      maxUpwardMessageNumPerCandidate: _i1.U32Codec.codec.decode(input),
      hrmpMaxMessageNumPerCandidate: _i1.U32Codec.codec.decode(input),
      validationUpgradeCooldown: _i1.U32Codec.codec.decode(input),
      validationUpgradeDelay: _i1.U32Codec.codec.decode(input),
      asyncBackingParams: _i2.AsyncBackingParams.codec.decode(input),
      maxPovSize: _i1.U32Codec.codec.decode(input),
      maxDownwardMessageSize: _i1.U32Codec.codec.decode(input),
      hrmpMaxParachainOutboundChannels: _i1.U32Codec.codec.decode(input),
      hrmpMaxParathreadOutboundChannels: _i1.U32Codec.codec.decode(input),
      hrmpSenderDeposit: _i1.U128Codec.codec.decode(input),
      hrmpRecipientDeposit: _i1.U128Codec.codec.decode(input),
      hrmpChannelMaxCapacity: _i1.U32Codec.codec.decode(input),
      hrmpChannelMaxTotalSize: _i1.U32Codec.codec.decode(input),
      hrmpMaxParachainInboundChannels: _i1.U32Codec.codec.decode(input),
      hrmpMaxParathreadInboundChannels: _i1.U32Codec.codec.decode(input),
      hrmpChannelMaxMessageSize: _i1.U32Codec.codec.decode(input),
      executorParams:
          const _i1.SequenceCodec<_i6.ExecutorParam>(_i6.ExecutorParam.codec)
              .decode(input),
      codeRetentionPeriod: _i1.U32Codec.codec.decode(input),
      parathreadCores: _i1.U32Codec.codec.decode(input),
      parathreadRetries: _i1.U32Codec.codec.decode(input),
      groupRotationFrequency: _i1.U32Codec.codec.decode(input),
      chainAvailabilityPeriod: _i1.U32Codec.codec.decode(input),
      threadAvailabilityPeriod: _i1.U32Codec.codec.decode(input),
      schedulingLookahead: _i1.U32Codec.codec.decode(input),
      maxValidatorsPerCore:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      maxValidators:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      disputePeriod: _i1.U32Codec.codec.decode(input),
      disputePostConclusionAcceptancePeriod: _i1.U32Codec.codec.decode(input),
      noShowSlots: _i1.U32Codec.codec.decode(input),
      nDelayTranches: _i1.U32Codec.codec.decode(input),
      zerothDelayTrancheWidth: _i1.U32Codec.codec.decode(input),
      neededApprovals: _i1.U32Codec.codec.decode(input),
      relayVrfModuloSamples: _i1.U32Codec.codec.decode(input),
      pvfCheckingEnabled: _i1.BoolCodec.codec.decode(input),
      pvfVotingTtl: _i1.U32Codec.codec.decode(input),
      minimumValidationUpgradeDelay: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(HostConfiguration obj) {
    int size = 0;
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxCodeSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxHeadDataSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardQueueCount);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardQueueSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardMessageSize);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.maxUpwardMessageNumPerCandidate);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.hrmpMaxMessageNumPerCandidate);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validationUpgradeCooldown);
    size = size + _i1.U32Codec.codec.sizeHint(obj.validationUpgradeDelay);
    size = size + _i2.AsyncBackingParams.codec.sizeHint(obj.asyncBackingParams);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxPovSize);
    size = size + _i1.U32Codec.codec.sizeHint(obj.maxDownwardMessageSize);
    size = size +
        _i1.U32Codec.codec.sizeHint(obj.hrmpMaxParachainOutboundChannels);
    size = size +
        _i1.U32Codec.codec.sizeHint(obj.hrmpMaxParathreadOutboundChannels);
    size = size + _i1.U128Codec.codec.sizeHint(obj.hrmpSenderDeposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.hrmpRecipientDeposit);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxTotalSize);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.hrmpMaxParachainInboundChannels);
    size = size +
        _i1.U32Codec.codec.sizeHint(obj.hrmpMaxParathreadInboundChannels);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxMessageSize);
    size = size + const _i3.ExecutorParamsCodec().sizeHint(obj.executorParams);
    size = size + _i1.U32Codec.codec.sizeHint(obj.codeRetentionPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.parathreadCores);
    size = size + _i1.U32Codec.codec.sizeHint(obj.parathreadRetries);
    size = size + _i1.U32Codec.codec.sizeHint(obj.groupRotationFrequency);
    size = size + _i1.U32Codec.codec.sizeHint(obj.chainAvailabilityPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.threadAvailabilityPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.schedulingLookahead);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.maxValidatorsPerCore);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.maxValidators);
    size = size + _i1.U32Codec.codec.sizeHint(obj.disputePeriod);
    size = size +
        _i1.U32Codec.codec.sizeHint(obj.disputePostConclusionAcceptancePeriod);
    size = size + _i1.U32Codec.codec.sizeHint(obj.noShowSlots);
    size = size + _i1.U32Codec.codec.sizeHint(obj.nDelayTranches);
    size = size + _i1.U32Codec.codec.sizeHint(obj.zerothDelayTrancheWidth);
    size = size + _i1.U32Codec.codec.sizeHint(obj.neededApprovals);
    size = size + _i1.U32Codec.codec.sizeHint(obj.relayVrfModuloSamples);
    size = size + _i1.BoolCodec.codec.sizeHint(obj.pvfCheckingEnabled);
    size = size + _i1.U32Codec.codec.sizeHint(obj.pvfVotingTtl);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.minimumValidationUpgradeDelay);
    return size;
  }
}
