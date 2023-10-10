// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/polkadot_parachain/primitives/id.dart' as _i6;
import '../types/polkadot_primitives/v4/core_occupied.dart' as _i5;
import '../types/polkadot_primitives/v4/validator_index.dart' as _i2;
import '../types/polkadot_runtime_parachains/scheduler/core_assignment.dart'
    as _i7;
import '../types/polkadot_runtime_parachains/scheduler/parathread_claim_queue.dart'
    as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<List<_i2.ValidatorIndex>>> _validatorGroups =
      const _i1.StorageValue<List<List<_i2.ValidatorIndex>>>(
    prefix: 'ParaScheduler',
    storage: 'ValidatorGroups',
    valueCodec: _i3.SequenceCodec<List<_i2.ValidatorIndex>>(
        _i3.SequenceCodec<_i2.ValidatorIndex>(_i2.ValidatorIndexCodec())),
  );

  final _i1.StorageValue<_i4.ParathreadClaimQueue> _parathreadQueue =
      const _i1.StorageValue<_i4.ParathreadClaimQueue>(
    prefix: 'ParaScheduler',
    storage: 'ParathreadQueue',
    valueCodec: _i4.ParathreadClaimQueue.codec,
  );

  final _i1.StorageValue<List<_i5.CoreOccupied?>> _availabilityCores =
      const _i1.StorageValue<List<_i5.CoreOccupied?>>(
    prefix: 'ParaScheduler',
    storage: 'AvailabilityCores',
    valueCodec: _i3.SequenceCodec<_i5.CoreOccupied?>(
        _i3.OptionCodec<_i5.CoreOccupied>(_i5.CoreOccupied.codec)),
  );

  final _i1.StorageValue<List<_i6.Id>> _parathreadClaimIndex =
      const _i1.StorageValue<List<_i6.Id>>(
    prefix: 'ParaScheduler',
    storage: 'ParathreadClaimIndex',
    valueCodec: _i3.SequenceCodec<_i6.Id>(_i6.IdCodec()),
  );

  final _i1.StorageValue<int> _sessionStartBlock = const _i1.StorageValue<int>(
    prefix: 'ParaScheduler',
    storage: 'SessionStartBlock',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i7.CoreAssignment>> _scheduled =
      const _i1.StorageValue<List<_i7.CoreAssignment>>(
    prefix: 'ParaScheduler',
    storage: 'Scheduled',
    valueCodec: _i3.SequenceCodec<_i7.CoreAssignment>(_i7.CoreAssignment.codec),
  );

  /// All the validator groups. One for each core. Indices are into `ActiveValidators` - not the
  /// broader set of Polkadot validators, but instead just the subset used for parachains during
  /// this session.
  ///
  /// Bound: The number of cores is the sum of the numbers of parachains and parathread multiplexers.
  /// Reasonably, 100-1000. The dominant factor is the number of validators: safe upper bound at 10k.
  _i8.Future<List<List<_i2.ValidatorIndex>>> validatorGroups(
      {_i1.BlockHash? at}) async {
    final hashedKey = _validatorGroups.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validatorGroups.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// A queue of upcoming claims and which core they should be mapped onto.
  ///
  /// The number of queued claims is bounded at the `scheduling_lookahead`
  /// multiplied by the number of parathread multiplexer cores. Reasonably, 10 * 50 = 500.
  _i8.Future<_i4.ParathreadClaimQueue> parathreadQueue(
      {_i1.BlockHash? at}) async {
    final hashedKey = _parathreadQueue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parathreadQueue.decodeValue(bytes);
    }
    return _i4.ParathreadClaimQueue(
      queue: [],
      nextCoreOffset: 0,
    ); /* Default */
  }

  /// One entry for each availability core. Entries are `None` if the core is not currently occupied. Can be
  /// temporarily `Some` if scheduled but not occupied.
  /// The i'th parachain belongs to the i'th core, with the remaining cores all being
  /// parathread-multiplexers.
  ///
  /// Bounded by the maximum of either of these two values:
  ///   * The number of parachains and parathread multiplexers
  ///   * The number of validators divided by `configuration.max_validators_per_core`.
  _i8.Future<List<_i5.CoreOccupied?>> availabilityCores(
      {_i1.BlockHash? at}) async {
    final hashedKey = _availabilityCores.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _availabilityCores.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// An index used to ensure that only one claim on a parathread exists in the queue or is
  /// currently being handled by an occupied core.
  ///
  /// Bounded by the number of parathread cores and scheduling lookahead. Reasonably, 10 * 50 = 500.
  _i8.Future<List<_i6.Id>> parathreadClaimIndex({_i1.BlockHash? at}) async {
    final hashedKey = _parathreadClaimIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parathreadClaimIndex.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The block number where the session start occurred. Used to track how many group rotations have occurred.
  ///
  /// Note that in the context of parachains modules the session change is signaled during
  /// the block and enacted at the end of the block (at the finalization stage, to be exact).
  /// Thus for all intents and purposes the effect of the session change is observed at the
  /// block following the session change, block number of which we save in this storage value.
  _i8.Future<int> sessionStartBlock({_i1.BlockHash? at}) async {
    final hashedKey = _sessionStartBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _sessionStartBlock.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Currently scheduled cores - free but up to be occupied.
  ///
  /// Bounded by the number of cores: one for each parachain and parathread multiplexer.
  ///
  /// The value contained here will not be valid after the end of a block. Runtime APIs should be used to determine scheduled cores/
  /// for the upcoming block.
  _i8.Future<List<_i7.CoreAssignment>> scheduled({_i1.BlockHash? at}) async {
    final hashedKey = _scheduled.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _scheduled.decodeValue(bytes);
    }
    return []; /* Default */
  }
}
