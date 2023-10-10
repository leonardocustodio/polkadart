// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_primitives/vstaging/async_backing_params.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/polkadot_runtime_parachains/configuration/host_configuration.dart'
    as _i2;
import '../types/polkadot_runtime_parachains/configuration/pallet/call.dart'
    as _i8;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.HostConfiguration> _activeConfig =
      const _i1.StorageValue<_i2.HostConfiguration>(
    prefix: 'Configuration',
    storage: 'ActiveConfig',
    valueCodec: _i2.HostConfiguration.codec,
  );

  final _i1.StorageValue<List<_i3.Tuple2<int, _i2.HostConfiguration>>>
      _pendingConfigs =
      const _i1.StorageValue<List<_i3.Tuple2<int, _i2.HostConfiguration>>>(
    prefix: 'Configuration',
    storage: 'PendingConfigs',
    valueCodec: _i4.SequenceCodec<_i3.Tuple2<int, _i2.HostConfiguration>>(
        _i3.Tuple2Codec<int, _i2.HostConfiguration>(
      _i4.U32Codec.codec,
      _i2.HostConfiguration.codec,
    )),
  );

  final _i1.StorageValue<bool> _bypassConsistencyCheck =
      const _i1.StorageValue<bool>(
    prefix: 'Configuration',
    storage: 'BypassConsistencyCheck',
    valueCodec: _i4.BoolCodec.codec,
  );

  /// The active configuration for the current session.
  _i5.Future<_i2.HostConfiguration> activeConfig({_i1.BlockHash? at}) async {
    final hashedKey = _activeConfig.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _activeConfig.decodeValue(bytes);
    }
    return _i2.HostConfiguration(
      maxCodeSize: 0,
      maxHeadDataSize: 0,
      maxUpwardQueueCount: 0,
      maxUpwardQueueSize: 0,
      maxUpwardMessageSize: 0,
      maxUpwardMessageNumPerCandidate: 0,
      hrmpMaxMessageNumPerCandidate: 0,
      validationUpgradeCooldown: 0,
      validationUpgradeDelay: 2,
      asyncBackingParams: _i6.AsyncBackingParams(
        maxCandidateDepth: 0,
        allowedAncestryLen: 0,
      ),
      maxPovSize: 0,
      maxDownwardMessageSize: 0,
      hrmpMaxParachainOutboundChannels: 0,
      hrmpMaxParathreadOutboundChannels: 0,
      hrmpSenderDeposit: BigInt.zero,
      hrmpRecipientDeposit: BigInt.zero,
      hrmpChannelMaxCapacity: 0,
      hrmpChannelMaxTotalSize: 0,
      hrmpMaxParachainInboundChannels: 0,
      hrmpMaxParathreadInboundChannels: 0,
      hrmpChannelMaxMessageSize: 0,
      executorParams: [],
      codeRetentionPeriod: 0,
      parathreadCores: 0,
      parathreadRetries: 0,
      groupRotationFrequency: 1,
      chainAvailabilityPeriod: 1,
      threadAvailabilityPeriod: 1,
      schedulingLookahead: 0,
      maxValidatorsPerCore: null,
      maxValidators: null,
      disputePeriod: 6,
      disputePostConclusionAcceptancePeriod: 100,
      noShowSlots: 1,
      nDelayTranches: 0,
      zerothDelayTrancheWidth: 0,
      neededApprovals: 0,
      relayVrfModuloSamples: 0,
      pvfCheckingEnabled: false,
      pvfVotingTtl: 2,
      minimumValidationUpgradeDelay: 2,
    ); /* Default */
  }

  /// Pending configuration changes.
  ///
  /// This is a list of configuration changes, each with a session index at which it should
  /// be applied.
  ///
  /// The list is sorted ascending by session index. Also, this list can only contain at most
  /// 2 items: for the next session and for the `scheduled_session`.
  _i5.Future<List<_i3.Tuple2<int, _i2.HostConfiguration>>> pendingConfigs(
      {_i1.BlockHash? at}) async {
    final hashedKey = _pendingConfigs.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingConfigs.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// If this is set, then the configuration setters will bypass the consistency checks. This
  /// is meant to be used only as the last resort.
  _i5.Future<bool> bypassConsistencyCheck({_i1.BlockHash? at}) async {
    final hashedKey = _bypassConsistencyCheck.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bypassConsistencyCheck.decodeValue(bytes);
    }
    return false; /* Default */
  }
}

class Txs {
  const Txs();

  /// Set the validation upgrade cooldown.
  _i7.RuntimeCall setValidationUpgradeCooldown({required new_}) {
    final _call = _i8.Call.values.setValidationUpgradeCooldown(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the validation upgrade delay.
  _i7.RuntimeCall setValidationUpgradeDelay({required new_}) {
    final _call = _i8.Call.values.setValidationUpgradeDelay(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the acceptance period for an included candidate.
  _i7.RuntimeCall setCodeRetentionPeriod({required new_}) {
    final _call = _i8.Call.values.setCodeRetentionPeriod(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the max validation code size for incoming upgrades.
  _i7.RuntimeCall setMaxCodeSize({required new_}) {
    final _call = _i8.Call.values.setMaxCodeSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the max POV block size for incoming upgrades.
  _i7.RuntimeCall setMaxPovSize({required new_}) {
    final _call = _i8.Call.values.setMaxPovSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the max head data size for paras.
  _i7.RuntimeCall setMaxHeadDataSize({required new_}) {
    final _call = _i8.Call.values.setMaxHeadDataSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the number of parathread execution cores.
  _i7.RuntimeCall setParathreadCores({required new_}) {
    final _call = _i8.Call.values.setParathreadCores(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the number of retries for a particular parathread.
  _i7.RuntimeCall setParathreadRetries({required new_}) {
    final _call = _i8.Call.values.setParathreadRetries(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the parachain validator-group rotation frequency
  _i7.RuntimeCall setGroupRotationFrequency({required new_}) {
    final _call = _i8.Call.values.setGroupRotationFrequency(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the availability period for parachains.
  _i7.RuntimeCall setChainAvailabilityPeriod({required new_}) {
    final _call = _i8.Call.values.setChainAvailabilityPeriod(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the availability period for parathreads.
  _i7.RuntimeCall setThreadAvailabilityPeriod({required new_}) {
    final _call = _i8.Call.values.setThreadAvailabilityPeriod(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the scheduling lookahead, in expected number of blocks at peak throughput.
  _i7.RuntimeCall setSchedulingLookahead({required new_}) {
    final _call = _i8.Call.values.setSchedulingLookahead(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the maximum number of validators to assign to any core.
  _i7.RuntimeCall setMaxValidatorsPerCore({new_}) {
    final _call = _i8.Call.values.setMaxValidatorsPerCore(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the maximum number of validators to use in parachain consensus.
  _i7.RuntimeCall setMaxValidators({new_}) {
    final _call = _i8.Call.values.setMaxValidators(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the dispute period, in number of sessions to keep for disputes.
  _i7.RuntimeCall setDisputePeriod({required new_}) {
    final _call = _i8.Call.values.setDisputePeriod(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the dispute post conclusion acceptance period.
  _i7.RuntimeCall setDisputePostConclusionAcceptancePeriod({required new_}) {
    final _call =
        _i8.Call.values.setDisputePostConclusionAcceptancePeriod(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the no show slots, in number of number of consensus slots.
  /// Must be at least 1.
  _i7.RuntimeCall setNoShowSlots({required new_}) {
    final _call = _i8.Call.values.setNoShowSlots(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the total number of delay tranches.
  _i7.RuntimeCall setNDelayTranches({required new_}) {
    final _call = _i8.Call.values.setNDelayTranches(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the zeroth delay tranche width.
  _i7.RuntimeCall setZerothDelayTrancheWidth({required new_}) {
    final _call = _i8.Call.values.setZerothDelayTrancheWidth(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the number of validators needed to approve a block.
  _i7.RuntimeCall setNeededApprovals({required new_}) {
    final _call = _i8.Call.values.setNeededApprovals(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the number of samples to do of the `RelayVRFModulo` approval assignment criterion.
  _i7.RuntimeCall setRelayVrfModuloSamples({required new_}) {
    final _call = _i8.Call.values.setRelayVrfModuloSamples(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum items that can present in a upward dispatch queue at once.
  _i7.RuntimeCall setMaxUpwardQueueCount({required new_}) {
    final _call = _i8.Call.values.setMaxUpwardQueueCount(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum total size of items that can present in a upward dispatch queue at once.
  _i7.RuntimeCall setMaxUpwardQueueSize({required new_}) {
    final _call = _i8.Call.values.setMaxUpwardQueueSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the critical downward message size.
  _i7.RuntimeCall setMaxDownwardMessageSize({required new_}) {
    final _call = _i8.Call.values.setMaxDownwardMessageSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum size of an upward message that can be sent by a candidate.
  _i7.RuntimeCall setMaxUpwardMessageSize({required new_}) {
    final _call = _i8.Call.values.setMaxUpwardMessageSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of messages that a candidate can contain.
  _i7.RuntimeCall setMaxUpwardMessageNumPerCandidate({required new_}) {
    final _call =
        _i8.Call.values.setMaxUpwardMessageNumPerCandidate(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the number of sessions after which an HRMP open channel request expires.
  _i7.RuntimeCall setHrmpOpenRequestTtl({required new_}) {
    final _call = _i8.Call.values.setHrmpOpenRequestTtl(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the amount of funds that the sender should provide for opening an HRMP channel.
  _i7.RuntimeCall setHrmpSenderDeposit({required new_}) {
    final _call = _i8.Call.values.setHrmpSenderDeposit(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the amount of funds that the recipient should provide for accepting opening an HRMP
  /// channel.
  _i7.RuntimeCall setHrmpRecipientDeposit({required new_}) {
    final _call = _i8.Call.values.setHrmpRecipientDeposit(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of messages allowed in an HRMP channel at once.
  _i7.RuntimeCall setHrmpChannelMaxCapacity({required new_}) {
    final _call = _i8.Call.values.setHrmpChannelMaxCapacity(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum total size of messages in bytes allowed in an HRMP channel at once.
  _i7.RuntimeCall setHrmpChannelMaxTotalSize({required new_}) {
    final _call = _i8.Call.values.setHrmpChannelMaxTotalSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of inbound HRMP channels a parachain is allowed to accept.
  _i7.RuntimeCall setHrmpMaxParachainInboundChannels({required new_}) {
    final _call =
        _i8.Call.values.setHrmpMaxParachainInboundChannels(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of inbound HRMP channels a parathread is allowed to accept.
  _i7.RuntimeCall setHrmpMaxParathreadInboundChannels({required new_}) {
    final _call =
        _i8.Call.values.setHrmpMaxParathreadInboundChannels(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum size of a message that could ever be put into an HRMP channel.
  _i7.RuntimeCall setHrmpChannelMaxMessageSize({required new_}) {
    final _call = _i8.Call.values.setHrmpChannelMaxMessageSize(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of outbound HRMP channels a parachain is allowed to open.
  _i7.RuntimeCall setHrmpMaxParachainOutboundChannels({required new_}) {
    final _call =
        _i8.Call.values.setHrmpMaxParachainOutboundChannels(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of outbound HRMP channels a parathread is allowed to open.
  _i7.RuntimeCall setHrmpMaxParathreadOutboundChannels({required new_}) {
    final _call =
        _i8.Call.values.setHrmpMaxParathreadOutboundChannels(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the maximum number of outbound HRMP messages can be sent by a candidate.
  _i7.RuntimeCall setHrmpMaxMessageNumPerCandidate({required new_}) {
    final _call = _i8.Call.values.setHrmpMaxMessageNumPerCandidate(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Enable or disable PVF pre-checking. Consult the field documentation prior executing.
  _i7.RuntimeCall setPvfCheckingEnabled({required new_}) {
    final _call = _i8.Call.values.setPvfCheckingEnabled(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the number of session changes after which a PVF pre-checking voting is rejected.
  _i7.RuntimeCall setPvfVotingTtl({required new_}) {
    final _call = _i8.Call.values.setPvfVotingTtl(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Sets the minimum delay between announcing the upgrade block for a parachain until the
  /// upgrade taking place.
  ///
  /// See the field documentation for information and constraints for the new value.
  _i7.RuntimeCall setMinimumValidationUpgradeDelay({required new_}) {
    final _call = _i8.Call.values.setMinimumValidationUpgradeDelay(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Setting this to true will disable consistency checks for the configuration setters.
  /// Use with caution.
  _i7.RuntimeCall setBypassConsistencyCheck({required new_}) {
    final _call = _i8.Call.values.setBypassConsistencyCheck(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set the asynchronous backing parameters.
  _i7.RuntimeCall setAsyncBackingParams({required new_}) {
    final _call = _i8.Call.values.setAsyncBackingParams(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }

  /// Set PVF executor parameters.
  _i7.RuntimeCall setExecutorParams({required new_}) {
    final _call = _i8.Call.values.setExecutorParams(new_: new_);
    return _i7.RuntimeCall.values.configuration(_call);
  }
}
