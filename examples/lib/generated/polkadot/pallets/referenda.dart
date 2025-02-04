// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/frame_support/traits/preimages/bounded.dart' as _i10;
import '../types/frame_support/traits/schedule/dispatch_time.dart' as _i11;
import '../types/pallet_referenda/pallet/call.dart' as _i12;
import '../types/pallet_referenda/types/curve.dart' as _i14;
import '../types/pallet_referenda/types/referendum_info.dart' as _i3;
import '../types/pallet_referenda/types/track_info.dart' as _i13;
import '../types/polkadot_runtime/origin_caller.dart' as _i9;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/primitive_types/h256.dart' as _i5;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _referendumCount = const _i1.StorageValue<int>(
    prefix: 'Referenda',
    storage: 'ReferendumCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i3.ReferendumInfo> _referendumInfoFor =
      const _i1.StorageMap<int, _i3.ReferendumInfo>(
    prefix: 'Referenda',
    storage: 'ReferendumInfoFor',
    valueCodec: _i3.ReferendumInfo.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, List<_i4.Tuple2<int, BigInt>>> _trackQueue =
      const _i1.StorageMap<int, List<_i4.Tuple2<int, BigInt>>>(
    prefix: 'Referenda',
    storage: 'TrackQueue',
    valueCodec:
        _i2.SequenceCodec<_i4.Tuple2<int, BigInt>>(_i4.Tuple2Codec<int, BigInt>(
      _i2.U32Codec.codec,
      _i2.U128Codec.codec,
    )),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U16Codec.codec),
  );

  final _i1.StorageMap<int, int> _decidingCount =
      const _i1.StorageMap<int, int>(
    prefix: 'Referenda',
    storage: 'DecidingCount',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U16Codec.codec),
  );

  final _i1.StorageMap<int, _i5.H256> _metadataOf =
      const _i1.StorageMap<int, _i5.H256>(
    prefix: 'Referenda',
    storage: 'MetadataOf',
    valueCodec: _i5.H256Codec(),
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U32Codec.codec),
  );

  /// The next free referendum index, aka the number of referenda started so far.
  _i6.Future<int> referendumCount({_i1.BlockHash? at}) async {
    final hashedKey = _referendumCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _referendumCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Information concerning any given referendum.
  _i6.Future<_i3.ReferendumInfo?> referendumInfoFor(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _referendumInfoFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _referendumInfoFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The sorted list of referenda ready to be decided but not yet being decided, ordered by
  /// conviction-weighted approvals.
  ///
  /// This should be empty if `DecidingCount` is less than `TrackInfo::max_deciding`.
  _i6.Future<List<_i4.Tuple2<int, BigInt>>> trackQueue(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _trackQueue.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _trackQueue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The number of referenda being decided currently.
  _i6.Future<int> decidingCount(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _decidingCount.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _decidingCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The metadata is a general information concerning the referendum.
  /// The `Hash` refers to the preimage of the `Preimages` provider which can be a JSON
  /// dump or IPFS hash of a JSON file.
  ///
  /// Consider a garbage collection for a metadata of finished referendums to `unrequest` (remove)
  /// large preimages.
  _i6.Future<_i5.H256?> metadataOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _metadataOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _metadataOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `referendumCount`.
  _i7.Uint8List referendumCountKey() {
    final hashedKey = _referendumCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `referendumInfoFor`.
  _i7.Uint8List referendumInfoForKey(int key1) {
    final hashedKey = _referendumInfoFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `trackQueue`.
  _i7.Uint8List trackQueueKey(int key1) {
    final hashedKey = _trackQueue.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `decidingCount`.
  _i7.Uint8List decidingCountKey(int key1) {
    final hashedKey = _decidingCount.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `metadataOf`.
  _i7.Uint8List metadataOfKey(int key1) {
    final hashedKey = _metadataOf.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `referendumInfoFor`.
  _i7.Uint8List referendumInfoForMapPrefix() {
    final hashedKey = _referendumInfoFor.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `trackQueue`.
  _i7.Uint8List trackQueueMapPrefix() {
    final hashedKey = _trackQueue.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `decidingCount`.
  _i7.Uint8List decidingCountMapPrefix() {
    final hashedKey = _decidingCount.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `metadataOf`.
  _i7.Uint8List metadataOfMapPrefix() {
    final hashedKey = _metadataOf.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Propose a referendum on a privileged action.
  ///
  /// - `origin`: must be `SubmitOrigin` and the account must have `SubmissionDeposit` funds
  ///  available.
  /// - `proposal_origin`: The origin from which the proposal should be executed.
  /// - `proposal`: The proposal.
  /// - `enactment_moment`: The moment that the proposal should be enacted.
  ///
  /// Emits `Submitted`.
  _i8.RuntimeCall submit({
    required _i9.OriginCaller proposalOrigin,
    required _i10.Bounded proposal,
    required _i11.DispatchTime enactmentMoment,
  }) {
    final _call = _i12.Call.values.submit(
      proposalOrigin: proposalOrigin,
      proposal: proposal,
      enactmentMoment: enactmentMoment,
    );
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Post the Decision Deposit for a referendum.
  ///
  /// - `origin`: must be `Signed` and the account must have funds available for the
  ///  referendum's track's Decision Deposit.
  /// - `index`: The index of the submitted referendum whose Decision Deposit is yet to be
  ///  posted.
  ///
  /// Emits `DecisionDepositPlaced`.
  _i8.RuntimeCall placeDecisionDeposit({required int index}) {
    final _call = _i12.Call.values.placeDecisionDeposit(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Refund the Decision Deposit for a closed referendum back to the depositor.
  ///
  /// - `origin`: must be `Signed` or `Root`.
  /// - `index`: The index of a closed referendum whose Decision Deposit has not yet been
  ///  refunded.
  ///
  /// Emits `DecisionDepositRefunded`.
  _i8.RuntimeCall refundDecisionDeposit({required int index}) {
    final _call = _i12.Call.values.refundDecisionDeposit(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Cancel an ongoing referendum.
  ///
  /// - `origin`: must be the `CancelOrigin`.
  /// - `index`: The index of the referendum to be cancelled.
  ///
  /// Emits `Cancelled`.
  _i8.RuntimeCall cancel({required int index}) {
    final _call = _i12.Call.values.cancel(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Cancel an ongoing referendum and slash the deposits.
  ///
  /// - `origin`: must be the `KillOrigin`.
  /// - `index`: The index of the referendum to be cancelled.
  ///
  /// Emits `Killed` and `DepositSlashed`.
  _i8.RuntimeCall kill({required int index}) {
    final _call = _i12.Call.values.kill(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Advance a referendum onto its next logical state. Only used internally.
  ///
  /// - `origin`: must be `Root`.
  /// - `index`: the referendum to be advanced.
  _i8.RuntimeCall nudgeReferendum({required int index}) {
    final _call = _i12.Call.values.nudgeReferendum(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Advance a track onto its next logical state. Only used internally.
  ///
  /// - `origin`: must be `Root`.
  /// - `track`: the track to be advanced.
  ///
  /// Action item for when there is now one fewer referendum in the deciding phase and the
  /// `DecidingCount` is not yet updated. This means that we should either:
  /// - begin deciding another referendum (and leave `DecidingCount` alone); or
  /// - decrement `DecidingCount`.
  _i8.RuntimeCall oneFewerDeciding({required int track}) {
    final _call = _i12.Call.values.oneFewerDeciding(track: track);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Refund the Submission Deposit for a closed referendum back to the depositor.
  ///
  /// - `origin`: must be `Signed` or `Root`.
  /// - `index`: The index of a closed referendum whose Submission Deposit has not yet been
  ///  refunded.
  ///
  /// Emits `SubmissionDepositRefunded`.
  _i8.RuntimeCall refundSubmissionDeposit({required int index}) {
    final _call = _i12.Call.values.refundSubmissionDeposit(index: index);
    return _i8.RuntimeCall.values.referenda(_call);
  }

  /// Set or clear metadata of a referendum.
  ///
  /// Parameters:
  /// - `origin`: Must be `Signed` by a creator of a referendum or by anyone to clear a
  ///  metadata of a finished referendum.
  /// - `index`:  The index of a referendum to set or clear metadata for.
  /// - `maybe_hash`: The hash of an on-chain stored preimage. `None` to clear a metadata.
  _i8.RuntimeCall setMetadata({
    required int index,
    _i5.H256? maybeHash,
  }) {
    final _call = _i12.Call.values.setMetadata(
      index: index,
      maybeHash: maybeHash,
    );
    return _i8.RuntimeCall.values.referenda(_call);
  }
}

class Constants {
  Constants();

  /// The minimum amount to be used as a deposit for a public referendum proposal.
  final BigInt submissionDeposit = BigInt.from(10000000000);

  /// Maximum size of the referendum queue for a single track.
  final int maxQueued = 100;

  /// The number of blocks after submission that a referendum must begin being decided by.
  /// Once this passes, then anyone may cancel the referendum.
  final int undecidingTimeout = 201600;

  /// Quantization level for the referendum wakeup scheduler. A higher number will result in
  /// fewer storage reads/writes needed for smaller voters, but also result in delays to the
  /// automatic referendum status changes. Explicit servicing instructions are unaffected.
  final int alarmInterval = 1;

  /// Information concerning the different referendum tracks.
  final List<_i4.Tuple2<int, _i13.TrackInfo>> tracks = [
    _i4.Tuple2<int, _i13.TrackInfo>(
      0,
      _i13.TrackInfo(
        name: 'root',
        maxDeciding: 1,
        decisionDeposit: BigInt.from(1000000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 14400,
        minEnactmentPeriod: 14400,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(222222224),
          xOffset: BigInt.from(333333335),
          yOffset: BigInt.from(333333332),
        ),
        minSupport: const _i14.LinearDecreasing(
          length: 1000000000,
          floor: 0,
          ceil: 500000000,
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      1,
      _i13.TrackInfo(
        name: 'whitelisted_caller',
        maxDeciding: 100,
        decisionDeposit: BigInt.from(100000000000000),
        preparePeriod: 300,
        decisionPeriod: 403200,
        confirmPeriod: 100,
        minEnactmentPeriod: 100,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(270899180),
          xOffset: BigInt.from(389830523),
          yOffset: BigInt.from(305084738),
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(8650766),
          xOffset: BigInt.from(18867926),
          yOffset: BigInt.from(41509433),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      2,
      _i13.TrackInfo(
        name: 'wish_for_change',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(200000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 14400,
        minEnactmentPeriod: 100,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(222222224),
          xOffset: BigInt.from(333333335),
          yOffset: BigInt.from(333333332),
        ),
        minSupport: const _i14.LinearDecreasing(
          length: 1000000000,
          floor: 0,
          ceil: 500000000,
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      10,
      _i13.TrackInfo(
        name: 'staking_admin',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(50000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      11,
      _i13.TrackInfo(
        name: 'treasurer',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(10000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 100800,
        minEnactmentPeriod: 14400,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(222222224),
          xOffset: BigInt.from(333333335),
          yOffset: BigInt.from(333333332),
        ),
        minSupport: const _i14.LinearDecreasing(
          length: 1000000000,
          floor: 0,
          ceil: 500000000,
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      12,
      _i13.TrackInfo(
        name: 'lease_admin',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(50000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      13,
      _i13.TrackInfo(
        name: 'fellowship_admin',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(50000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      14,
      _i13.TrackInfo(
        name: 'general_admin',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(50000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(222222224),
          xOffset: BigInt.from(333333335),
          yOffset: BigInt.from(333333332),
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(49586777),
          xOffset: BigInt.from(90909091),
          yOffset: BigInt.from(-45454546),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      15,
      _i13.TrackInfo(
        name: 'auction_admin',
        maxDeciding: 10,
        decisionDeposit: BigInt.from(50000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: _i14.Reciprocal(
          factor: BigInt.from(222222224),
          xOffset: BigInt.from(333333335),
          yOffset: BigInt.from(333333332),
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(49586777),
          xOffset: BigInt.from(90909091),
          yOffset: BigInt.from(-45454546),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      20,
      _i13.TrackInfo(
        name: 'referendum_canceller',
        maxDeciding: 1000,
        decisionDeposit: BigInt.from(100000000000000),
        preparePeriod: 1200,
        decisionPeriod: 100800,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      21,
      _i13.TrackInfo(
        name: 'referendum_killer',
        maxDeciding: 1000,
        decisionDeposit: BigInt.from(500000000000000),
        preparePeriod: 1200,
        decisionPeriod: 403200,
        confirmPeriod: 1800,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      30,
      _i13.TrackInfo(
        name: 'small_tipper',
        maxDeciding: 200,
        decisionDeposit: BigInt.from(10000000000),
        preparePeriod: 10,
        decisionPeriod: 100800,
        confirmPeriod: 100,
        minEnactmentPeriod: 10,
        minApproval: const _i14.LinearDecreasing(
          length: 357142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(1620729),
          xOffset: BigInt.from(3231018),
          yOffset: BigInt.from(-1615509),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      31,
      _i13.TrackInfo(
        name: 'big_tipper',
        maxDeciding: 100,
        decisionDeposit: BigInt.from(100000000000),
        preparePeriod: 100,
        decisionPeriod: 100800,
        confirmPeriod: 600,
        minEnactmentPeriod: 100,
        minApproval: const _i14.LinearDecreasing(
          length: 357142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(4149097),
          xOffset: BigInt.from(8230453),
          yOffset: BigInt.from(-4115227),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      32,
      _i13.TrackInfo(
        name: 'small_spender',
        maxDeciding: 50,
        decisionDeposit: BigInt.from(1000000000000),
        preparePeriod: 2400,
        decisionPeriod: 403200,
        confirmPeriod: 28800,
        minEnactmentPeriod: 14400,
        minApproval: const _i14.LinearDecreasing(
          length: 607142857,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(7892829),
          xOffset: BigInt.from(15544040),
          yOffset: BigInt.from(-7772020),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      33,
      _i13.TrackInfo(
        name: 'medium_spender',
        maxDeciding: 50,
        decisionDeposit: BigInt.from(2000000000000),
        preparePeriod: 2400,
        decisionPeriod: 403200,
        confirmPeriod: 57600,
        minEnactmentPeriod: 14400,
        minApproval: const _i14.LinearDecreasing(
          length: 821428571,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(14377233),
          xOffset: BigInt.from(27972031),
          yOffset: BigInt.from(-13986016),
        ),
      ),
    ),
    _i4.Tuple2<int, _i13.TrackInfo>(
      34,
      _i13.TrackInfo(
        name: 'big_spender',
        maxDeciding: 50,
        decisionDeposit: BigInt.from(4000000000000),
        preparePeriod: 2400,
        decisionPeriod: 403200,
        confirmPeriod: 100800,
        minEnactmentPeriod: 14400,
        minApproval: const _i14.LinearDecreasing(
          length: 1000000000,
          floor: 500000000,
          ceil: 1000000000,
        ),
        minSupport: _i14.Reciprocal(
          factor: BigInt.from(28326977),
          xOffset: BigInt.from(53763445),
          yOffset: BigInt.from(-26881723),
        ),
      ),
    ),
  ];
}
