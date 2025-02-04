// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_scheduler/pallet/call.dart' as _i9;
import '../types/pallet_scheduler/retry_config.dart' as _i5;
import '../types/pallet_scheduler/scheduled.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/sp_weights/weight_v2/weight.dart' as _i10;
import '../types/tuples_1.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _incompleteSince = const _i1.StorageValue<int>(
    prefix: 'Scheduler',
    storage: 'IncompleteSince',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, List<_i3.Scheduled?>> _agenda =
      const _i1.StorageMap<int, List<_i3.Scheduled?>>(
    prefix: 'Scheduler',
    storage: 'Agenda',
    valueCodec: _i2.SequenceCodec<_i3.Scheduled?>(
        _i2.OptionCodec<_i3.Scheduled>(_i3.Scheduled.codec)),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<_i4.Tuple2<int, int>, _i5.RetryConfig> _retries =
      const _i1.StorageMap<_i4.Tuple2<int, int>, _i5.RetryConfig>(
    prefix: 'Scheduler',
    storage: 'Retries',
    valueCodec: _i5.RetryConfig.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<List<int>, _i4.Tuple2<int, int>> _lookup =
      const _i1.StorageMap<List<int>, _i4.Tuple2<int, int>>(
    prefix: 'Scheduler',
    storage: 'Lookup',
    valueCodec: _i4.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U8ArrayCodec(32)),
  );

  _i6.Future<int?> incompleteSince({_i1.BlockHash? at}) async {
    final hashedKey = _incompleteSince.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _incompleteSince.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Items to be executed, indexed by the block number that they should be executed on.
  _i6.Future<List<_i3.Scheduled?>> agenda(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _agenda.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _agenda.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Retry configurations for items to be executed, indexed by task address.
  _i6.Future<_i5.RetryConfig?> retries(
    _i4.Tuple2<int, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _retries.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _retries.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Lookup from a name to the block number and index of the task.
  ///
  /// For v3 -> v4 the previously unbounded identities are Blake2-256 hashed to form the v4
  /// identities.
  _i6.Future<_i4.Tuple2<int, int>?> lookup(
    List<int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _lookup.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lookup.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `incompleteSince`.
  _i7.Uint8List incompleteSinceKey() {
    final hashedKey = _incompleteSince.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `agenda`.
  _i7.Uint8List agendaKey(int key1) {
    final hashedKey = _agenda.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `retries`.
  _i7.Uint8List retriesKey(_i4.Tuple2<int, int> key1) {
    final hashedKey = _retries.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `lookup`.
  _i7.Uint8List lookupKey(List<int> key1) {
    final hashedKey = _lookup.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `agenda`.
  _i7.Uint8List agendaMapPrefix() {
    final hashedKey = _agenda.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `retries`.
  _i7.Uint8List retriesMapPrefix() {
    final hashedKey = _retries.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `lookup`.
  _i7.Uint8List lookupMapPrefix() {
    final hashedKey = _lookup.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Anonymously schedule a task.
  _i8.RuntimeCall schedule({
    required int when,
    _i4.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i8.RuntimeCall call,
  }) {
    final _call = _i9.Call.values.schedule(
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Cancel an anonymously scheduled task.
  _i8.RuntimeCall cancel({
    required int when,
    required int index,
  }) {
    final _call = _i9.Call.values.cancel(
      when: when,
      index: index,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Schedule a named task.
  _i8.RuntimeCall scheduleNamed({
    required List<int> id,
    required int when,
    _i4.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i8.RuntimeCall call,
  }) {
    final _call = _i9.Call.values.scheduleNamed(
      id: id,
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Cancel a named scheduled task.
  _i8.RuntimeCall cancelNamed({required List<int> id}) {
    final _call = _i9.Call.values.cancelNamed(id: id);
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Anonymously schedule a task after a delay.
  _i8.RuntimeCall scheduleAfter({
    required int after,
    _i4.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i8.RuntimeCall call,
  }) {
    final _call = _i9.Call.values.scheduleAfter(
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Schedule a named task after a delay.
  _i8.RuntimeCall scheduleNamedAfter({
    required List<int> id,
    required int after,
    _i4.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i8.RuntimeCall call,
  }) {
    final _call = _i9.Call.values.scheduleNamedAfter(
      id: id,
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Set a retry configuration for a task so that, in case its scheduled run fails, it will
  /// be retried after `period` blocks, for a total amount of `retries` retries or until it
  /// succeeds.
  ///
  /// Tasks which need to be scheduled for a retry are still subject to weight metering and
  /// agenda space, same as a regular task. If a periodic task fails, it will be scheduled
  /// normally while the task is retrying.
  ///
  /// Tasks scheduled as a result of a retry for a periodic task are unnamed, non-periodic
  /// clones of the original task. Their retry configuration will be derived from the
  /// original task's configuration, but will have a lower value for `remaining` than the
  /// original `total_retries`.
  _i8.RuntimeCall setRetry({
    required _i4.Tuple2<int, int> task,
    required int retries,
    required int period,
  }) {
    final _call = _i9.Call.values.setRetry(
      task: task,
      retries: retries,
      period: period,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Set a retry configuration for a named task so that, in case its scheduled run fails, it
  /// will be retried after `period` blocks, for a total amount of `retries` retries or until
  /// it succeeds.
  ///
  /// Tasks which need to be scheduled for a retry are still subject to weight metering and
  /// agenda space, same as a regular task. If a periodic task fails, it will be scheduled
  /// normally while the task is retrying.
  ///
  /// Tasks scheduled as a result of a retry for a periodic task are unnamed, non-periodic
  /// clones of the original task. Their retry configuration will be derived from the
  /// original task's configuration, but will have a lower value for `remaining` than the
  /// original `total_retries`.
  _i8.RuntimeCall setRetryNamed({
    required List<int> id,
    required int retries,
    required int period,
  }) {
    final _call = _i9.Call.values.setRetryNamed(
      id: id,
      retries: retries,
      period: period,
    );
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Removes the retry configuration of a task.
  _i8.RuntimeCall cancelRetry({required _i4.Tuple2<int, int> task}) {
    final _call = _i9.Call.values.cancelRetry(task: task);
    return _i8.RuntimeCall.values.scheduler(_call);
  }

  /// Cancel the retry configuration of a named task.
  _i8.RuntimeCall cancelRetryNamed({required List<int> id}) {
    final _call = _i9.Call.values.cancelRetryNamed(id: id);
    return _i8.RuntimeCall.values.scheduler(_call);
  }
}

class Constants {
  Constants();

  /// The maximum weight that may be scheduled per block for any dispatchables.
  final _i10.Weight maximumWeight = _i10.Weight(
    refTime: BigInt.from(1600000000000),
    proofSize: BigInt.parse(
      '14757395258967641292',
      radix: 10,
    ),
  );

  /// The maximum number of scheduled calls in the queue for a single block.
  ///
  /// NOTE:
  /// + Dependent pallets' benchmarks might require a higher limit for the setting. Set a
  /// higher limit under `runtime-benchmarks` feature.
  final int maxScheduledPerBlock = 50;
}
