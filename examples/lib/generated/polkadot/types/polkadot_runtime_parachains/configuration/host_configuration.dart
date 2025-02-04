// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../polkadot_primitives/v7/approval_voting_params.dart' as _i4;
import '../../polkadot_primitives/v7/async_backing/async_backing_params.dart'
    as _i2;
import '../../polkadot_primitives/v7/executor_params/executor_param.dart'
    as _i8;
import '../../polkadot_primitives/v7/executor_params/executor_params.dart'
    as _i3;
import '../../polkadot_primitives/vstaging/scheduler_params.dart' as _i5;

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
    required this.hrmpSenderDeposit,
    required this.hrmpRecipientDeposit,
    required this.hrmpChannelMaxCapacity,
    required this.hrmpChannelMaxTotalSize,
    required this.hrmpMaxParachainInboundChannels,
    required this.hrmpChannelMaxMessageSize,
    required this.executorParams,
    required this.codeRetentionPeriod,
    this.maxValidators,
    required this.disputePeriod,
    required this.disputePostConclusionAcceptancePeriod,
    required this.noShowSlots,
    required this.nDelayTranches,
    required this.zerothDelayTrancheWidth,
    required this.neededApprovals,
    required this.relayVrfModuloSamples,
    required this.pvfVotingTtl,
    required this.minimumValidationUpgradeDelay,
    required this.minimumBackingVotes,
    required this.nodeFeatures,
    required this.approvalVotingParams,
    required this.schedulerParams,
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
  final int hrmpChannelMaxMessageSize;

  /// ExecutorParams
  final _i3.ExecutorParams executorParams;

  /// BlockNumber
  final int codeRetentionPeriod;

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

  /// SessionIndex
  final int pvfVotingTtl;

  /// BlockNumber
  final int minimumValidationUpgradeDelay;

  /// u32
  final int minimumBackingVotes;

  /// NodeFeatures
  final _i1.BitArray nodeFeatures;

  /// ApprovalVotingParams
  final _i4.ApprovalVotingParams approvalVotingParams;

  /// SchedulerParams<BlockNumber>
  final _i5.SchedulerParams schedulerParams;

  static const $HostConfigurationCodec codec = $HostConfigurationCodec();

  _i6.Uint8List encode() {
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
        'hrmpSenderDeposit': hrmpSenderDeposit,
        'hrmpRecipientDeposit': hrmpRecipientDeposit,
        'hrmpChannelMaxCapacity': hrmpChannelMaxCapacity,
        'hrmpChannelMaxTotalSize': hrmpChannelMaxTotalSize,
        'hrmpMaxParachainInboundChannels': hrmpMaxParachainInboundChannels,
        'hrmpChannelMaxMessageSize': hrmpChannelMaxMessageSize,
        'executorParams':
            executorParams.map((value) => value.toJson()).toList(),
        'codeRetentionPeriod': codeRetentionPeriod,
        'maxValidators': maxValidators,
        'disputePeriod': disputePeriod,
        'disputePostConclusionAcceptancePeriod':
            disputePostConclusionAcceptancePeriod,
        'noShowSlots': noShowSlots,
        'nDelayTranches': nDelayTranches,
        'zerothDelayTrancheWidth': zerothDelayTrancheWidth,
        'neededApprovals': neededApprovals,
        'relayVrfModuloSamples': relayVrfModuloSamples,
        'pvfVotingTtl': pvfVotingTtl,
        'minimumValidationUpgradeDelay': minimumValidationUpgradeDelay,
        'minimumBackingVotes': minimumBackingVotes,
        'nodeFeatures': nodeFeatures.toJson(),
        'approvalVotingParams': approvalVotingParams.toJson(),
        'schedulerParams': schedulerParams.toJson(),
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
          other.hrmpSenderDeposit == hrmpSenderDeposit &&
          other.hrmpRecipientDeposit == hrmpRecipientDeposit &&
          other.hrmpChannelMaxCapacity == hrmpChannelMaxCapacity &&
          other.hrmpChannelMaxTotalSize == hrmpChannelMaxTotalSize &&
          other.hrmpMaxParachainInboundChannels ==
              hrmpMaxParachainInboundChannels &&
          other.hrmpChannelMaxMessageSize == hrmpChannelMaxMessageSize &&
          _i7.listsEqual(
            other.executorParams,
            executorParams,
          ) &&
          other.codeRetentionPeriod == codeRetentionPeriod &&
          other.maxValidators == maxValidators &&
          other.disputePeriod == disputePeriod &&
          other.disputePostConclusionAcceptancePeriod ==
              disputePostConclusionAcceptancePeriod &&
          other.noShowSlots == noShowSlots &&
          other.nDelayTranches == nDelayTranches &&
          other.zerothDelayTrancheWidth == zerothDelayTrancheWidth &&
          other.neededApprovals == neededApprovals &&
          other.relayVrfModuloSamples == relayVrfModuloSamples &&
          other.pvfVotingTtl == pvfVotingTtl &&
          other.minimumValidationUpgradeDelay ==
              minimumValidationUpgradeDelay &&
          other.minimumBackingVotes == minimumBackingVotes &&
          other.nodeFeatures == nodeFeatures &&
          other.approvalVotingParams == approvalVotingParams &&
          other.schedulerParams == schedulerParams;

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
        hrmpSenderDeposit,
        hrmpRecipientDeposit,
        hrmpChannelMaxCapacity,
        hrmpChannelMaxTotalSize,
        hrmpMaxParachainInboundChannels,
        hrmpChannelMaxMessageSize,
        executorParams,
        codeRetentionPeriod,
        maxValidators,
        disputePeriod,
        disputePostConclusionAcceptancePeriod,
        noShowSlots,
        nDelayTranches,
        zerothDelayTrancheWidth,
        neededApprovals,
        relayVrfModuloSamples,
        pvfVotingTtl,
        minimumValidationUpgradeDelay,
        minimumBackingVotes,
        nodeFeatures,
        approvalVotingParams,
        schedulerParams,
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
      obj.hrmpChannelMaxMessageSize,
      output,
    );
    const _i1.SequenceCodec<_i8.ExecutorParam>(_i8.ExecutorParam.codec)
        .encodeTo(
      obj.executorParams,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.codeRetentionPeriod,
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
    _i1.U32Codec.codec.encodeTo(
      obj.pvfVotingTtl,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.minimumValidationUpgradeDelay,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.minimumBackingVotes,
      output,
    );
    const _i1.BitSequenceCodec(
      _i1.BitStore.U8,
      _i1.BitOrder.LSB,
    ).encodeTo(
      obj.nodeFeatures,
      output,
    );
    _i4.ApprovalVotingParams.codec.encodeTo(
      obj.approvalVotingParams,
      output,
    );
    _i5.SchedulerParams.codec.encodeTo(
      obj.schedulerParams,
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
      hrmpSenderDeposit: _i1.U128Codec.codec.decode(input),
      hrmpRecipientDeposit: _i1.U128Codec.codec.decode(input),
      hrmpChannelMaxCapacity: _i1.U32Codec.codec.decode(input),
      hrmpChannelMaxTotalSize: _i1.U32Codec.codec.decode(input),
      hrmpMaxParachainInboundChannels: _i1.U32Codec.codec.decode(input),
      hrmpChannelMaxMessageSize: _i1.U32Codec.codec.decode(input),
      executorParams:
          const _i1.SequenceCodec<_i8.ExecutorParam>(_i8.ExecutorParam.codec)
              .decode(input),
      codeRetentionPeriod: _i1.U32Codec.codec.decode(input),
      maxValidators:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      disputePeriod: _i1.U32Codec.codec.decode(input),
      disputePostConclusionAcceptancePeriod: _i1.U32Codec.codec.decode(input),
      noShowSlots: _i1.U32Codec.codec.decode(input),
      nDelayTranches: _i1.U32Codec.codec.decode(input),
      zerothDelayTrancheWidth: _i1.U32Codec.codec.decode(input),
      neededApprovals: _i1.U32Codec.codec.decode(input),
      relayVrfModuloSamples: _i1.U32Codec.codec.decode(input),
      pvfVotingTtl: _i1.U32Codec.codec.decode(input),
      minimumValidationUpgradeDelay: _i1.U32Codec.codec.decode(input),
      minimumBackingVotes: _i1.U32Codec.codec.decode(input),
      nodeFeatures: const _i1.BitSequenceCodec(
        _i1.BitStore.U8,
        _i1.BitOrder.LSB,
      ).decode(input),
      approvalVotingParams: _i4.ApprovalVotingParams.codec.decode(input),
      schedulerParams: _i5.SchedulerParams.codec.decode(input),
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
    size = size + _i1.U128Codec.codec.sizeHint(obj.hrmpSenderDeposit);
    size = size + _i1.U128Codec.codec.sizeHint(obj.hrmpRecipientDeposit);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxCapacity);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxTotalSize);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.hrmpMaxParachainInboundChannels);
    size = size + _i1.U32Codec.codec.sizeHint(obj.hrmpChannelMaxMessageSize);
    size = size + const _i3.ExecutorParamsCodec().sizeHint(obj.executorParams);
    size = size + _i1.U32Codec.codec.sizeHint(obj.codeRetentionPeriod);
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
    size = size + _i1.U32Codec.codec.sizeHint(obj.pvfVotingTtl);
    size =
        size + _i1.U32Codec.codec.sizeHint(obj.minimumValidationUpgradeDelay);
    size = size + _i1.U32Codec.codec.sizeHint(obj.minimumBackingVotes);
    size = size +
        const _i1.BitSequenceCodec(
          _i1.BitStore.U8,
          _i1.BitOrder.LSB,
        ).sizeHint(obj.nodeFeatures);
    size = size +
        _i4.ApprovalVotingParams.codec.sizeHint(obj.approvalVotingParams);
    size = size + _i5.SchedulerParams.codec.sizeHint(obj.schedulerParams);
    return size;
  }
}
