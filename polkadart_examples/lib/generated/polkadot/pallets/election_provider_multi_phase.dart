// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_election_provider_multi_phase/pallet/call.dart' as _i12;
import '../types/pallet_election_provider_multi_phase/phase.dart' as _i3;
import '../types/pallet_election_provider_multi_phase/ready_solution.dart'
    as _i4;
import '../types/pallet_election_provider_multi_phase/round_snapshot.dart'
    as _i5;
import '../types/pallet_election_provider_multi_phase/signed/signed_submission.dart'
    as _i9;
import '../types/pallet_election_provider_multi_phase/solution_or_snapshot_size.dart'
    as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i11;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i13;
import '../types/sp_npos_elections/election_score.dart' as _i8;
import '../types/sp_weights/weight_v2/weight.dart' as _i14;
import '../types/tuples.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _round = const _i1.StorageValue<int>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'Round',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i3.Phase> _currentPhase =
      const _i1.StorageValue<_i3.Phase>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'CurrentPhase',
    valueCodec: _i3.Phase.codec,
  );

  final _i1.StorageValue<_i4.ReadySolution> _queuedSolution =
      const _i1.StorageValue<_i4.ReadySolution>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'QueuedSolution',
    valueCodec: _i4.ReadySolution.codec,
  );

  final _i1.StorageValue<_i5.RoundSnapshot> _snapshot =
      const _i1.StorageValue<_i5.RoundSnapshot>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'Snapshot',
    valueCodec: _i5.RoundSnapshot.codec,
  );

  final _i1.StorageValue<int> _desiredTargets = const _i1.StorageValue<int>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'DesiredTargets',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i6.SolutionOrSnapshotSize> _snapshotMetadata =
      const _i1.StorageValue<_i6.SolutionOrSnapshotSize>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'SnapshotMetadata',
    valueCodec: _i6.SolutionOrSnapshotSize.codec,
  );

  final _i1.StorageValue<int> _signedSubmissionNextIndex =
      const _i1.StorageValue<int>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'SignedSubmissionNextIndex',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i7.Tuple3<_i8.ElectionScore, int, int>>>
      _signedSubmissionIndices =
      const _i1.StorageValue<List<_i7.Tuple3<_i8.ElectionScore, int, int>>>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'SignedSubmissionIndices',
    valueCodec: _i2.SequenceCodec<_i7.Tuple3<_i8.ElectionScore, int, int>>(
        _i7.Tuple3Codec<_i8.ElectionScore, int, int>(
      _i8.ElectionScore.codec,
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1.StorageMap<int, _i9.SignedSubmission> _signedSubmissionsMap =
      const _i1.StorageMap<int, _i9.SignedSubmission>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'SignedSubmissionsMap',
    valueCodec: _i9.SignedSubmission.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<_i8.ElectionScore> _minimumUntrustedScore =
      const _i1.StorageValue<_i8.ElectionScore>(
    prefix: 'ElectionProviderMultiPhase',
    storage: 'MinimumUntrustedScore',
    valueCodec: _i8.ElectionScore.codec,
  );

  /// Internal counter for the number of rounds.
  ///
  /// This is useful for de-duplication of transactions submitted to the pool, and general
  /// diagnostics of the pallet.
  ///
  /// This is merely incremented once per every time that an upstream `elect` is called.
  _i10.Future<int> round({_i1.BlockHash? at}) async {
    final hashedKey = _round.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _round.decodeValue(bytes);
    }
    return 1; /* Default */
  }

  /// Current phase.
  _i10.Future<_i3.Phase> currentPhase({_i1.BlockHash? at}) async {
    final hashedKey = _currentPhase.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentPhase.decodeValue(bytes);
    }
    return _i3.Off(); /* Default */
  }

  /// Current best solution, signed or unsigned, queued to be returned upon `elect`.
  ///
  /// Always sorted by score.
  _i10.Future<_i4.ReadySolution?> queuedSolution({_i1.BlockHash? at}) async {
    final hashedKey = _queuedSolution.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queuedSolution.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Snapshot data of the round.
  ///
  /// This is created at the beginning of the signed phase and cleared upon calling `elect`.
  _i10.Future<_i5.RoundSnapshot?> snapshot({_i1.BlockHash? at}) async {
    final hashedKey = _snapshot.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _snapshot.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Desired number of targets to elect for this round.
  ///
  /// Only exists when [`Snapshot`] is present.
  _i10.Future<int?> desiredTargets({_i1.BlockHash? at}) async {
    final hashedKey = _desiredTargets.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _desiredTargets.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The metadata of the [`RoundSnapshot`]
  ///
  /// Only exists when [`Snapshot`] is present.
  _i10.Future<_i6.SolutionOrSnapshotSize?> snapshotMetadata(
      {_i1.BlockHash? at}) async {
    final hashedKey = _snapshotMetadata.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _snapshotMetadata.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next index to be assigned to an incoming signed submission.
  ///
  /// Every accepted submission is assigned a unique index; that index is bound to that particular
  /// submission for the duration of the election. On election finalization, the next index is
  /// reset to 0.
  ///
  /// We can't just use `SignedSubmissionIndices.len()`, because that's a bounded set; past its
  /// capacity, it will simply saturate. We can't just iterate over `SignedSubmissionsMap`,
  /// because iteration is slow. Instead, we store the value here.
  _i10.Future<int> signedSubmissionNextIndex({_i1.BlockHash? at}) async {
    final hashedKey = _signedSubmissionNextIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signedSubmissionNextIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// A sorted, bounded vector of `(score, block_number, index)`, where each `index` points to a
  /// value in `SignedSubmissions`.
  ///
  /// We never need to process more than a single signed submission at a time. Signed submissions
  /// can be quite large, so we're willing to pay the cost of multiple database accesses to access
  /// them one at a time instead of reading and decoding all of them at once.
  _i10.Future<List<_i7.Tuple3<_i8.ElectionScore, int, int>>>
      signedSubmissionIndices({_i1.BlockHash? at}) async {
    final hashedKey = _signedSubmissionIndices.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signedSubmissionIndices.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Unchecked, signed solutions.
  ///
  /// Together with `SubmissionIndices`, this stores a bounded set of `SignedSubmissions` while
  /// allowing us to keep only a single one in memory at a time.
  ///
  /// Twox note: the key of the map is an auto-incrementing index which users cannot inspect or
  /// affect; we shouldn't need a cryptographically secure hasher.
  _i10.Future<_i9.SignedSubmission?> signedSubmissionsMap(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _signedSubmissionsMap.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signedSubmissionsMap.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The minimum score that each 'untrusted' solution must attain in order to be considered
  /// feasible.
  ///
  /// Can be set via `set_minimum_untrusted_score`.
  _i10.Future<_i8.ElectionScore?> minimumUntrustedScore(
      {_i1.BlockHash? at}) async {
    final hashedKey = _minimumUntrustedScore.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minimumUntrustedScore.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Submit a solution for the unsigned phase.
  ///
  /// The dispatch origin fo this call must be __none__.
  ///
  /// This submission is checked on the fly. Moreover, this unsigned solution is only
  /// validated when submitted to the pool from the **local** node. Effectively, this means
  /// that only active validators can submit this transaction when authoring a block (similar
  /// to an inherent).
  ///
  /// To prevent any incorrect solution (and thus wasted time/weight), this transaction will
  /// panic if the solution submitted by the validator is invalid in any way, effectively
  /// putting their authoring reward at risk.
  ///
  /// No deposit or reward is associated with this submission.
  _i11.RuntimeCall submitUnsigned({
    required rawSolution,
    required witness,
  }) {
    final _call = _i12.Call.values.submitUnsigned(
      rawSolution: rawSolution,
      witness: witness,
    );
    return _i11.RuntimeCall.values.electionProviderMultiPhase(_call);
  }

  /// Set a new value for `MinimumUntrustedScore`.
  ///
  /// Dispatch origin must be aligned with `T::ForceOrigin`.
  ///
  /// This check can be turned off by setting the value to `None`.
  _i11.RuntimeCall setMinimumUntrustedScore({maybeNextScore}) {
    final _call = _i12.Call.values
        .setMinimumUntrustedScore(maybeNextScore: maybeNextScore);
    return _i11.RuntimeCall.values.electionProviderMultiPhase(_call);
  }

  /// Set a solution in the queue, to be handed out to the client of this pallet in the next
  /// call to `ElectionProvider::elect`.
  ///
  /// This can only be set by `T::ForceOrigin`, and only when the phase is `Emergency`.
  ///
  /// The solution is not checked for any feasibility and is assumed to be trustworthy, as any
  /// feasibility check itself can in principle cause the election process to fail (due to
  /// memory/weight constrains).
  _i11.RuntimeCall setEmergencyElectionResult({required supports}) {
    final _call =
        _i12.Call.values.setEmergencyElectionResult(supports: supports);
    return _i11.RuntimeCall.values.electionProviderMultiPhase(_call);
  }

  /// Submit a solution for the signed phase.
  ///
  /// The dispatch origin fo this call must be __signed__.
  ///
  /// The solution is potentially queued, based on the claimed score and processed at the end
  /// of the signed phase.
  ///
  /// A deposit is reserved and recorded for the solution. Based on the outcome, the solution
  /// might be rewarded, slashed, or get all or a part of the deposit back.
  _i11.RuntimeCall submit({required rawSolution}) {
    final _call = _i12.Call.values.submit(rawSolution: rawSolution);
    return _i11.RuntimeCall.values.electionProviderMultiPhase(_call);
  }

  /// Trigger the governance fallback.
  ///
  /// This can only be called when [`Phase::Emergency`] is enabled, as an alternative to
  /// calling [`Call::set_emergency_election_result`].
  _i11.RuntimeCall governanceFallback({
    maybeMaxVoters,
    maybeMaxTargets,
  }) {
    final _call = _i12.Call.values.governanceFallback(
      maybeMaxVoters: maybeMaxVoters,
      maybeMaxTargets: maybeMaxTargets,
    );
    return _i11.RuntimeCall.values.electionProviderMultiPhase(_call);
  }
}

class Constants {
  Constants();

  /// Duration of the unsigned phase.
  final int unsignedPhase = 600;

  /// Duration of the signed phase.
  final int signedPhase = 600;

  /// The minimum amount of improvement to the solution score that defines a solution as
  /// "better" in the Signed phase.
  final _i13.Perbill betterSignedThreshold = 0;

  /// The minimum amount of improvement to the solution score that defines a solution as
  /// "better" in the Unsigned phase.
  final _i13.Perbill betterUnsignedThreshold = 500000;

  /// The repeat threshold of the offchain worker.
  ///
  /// For example, if it is 5, that means that at least 5 blocks will elapse between attempts
  /// to submit the worker's solution.
  final int offchainRepeat = 18;

  /// The priority of the unsigned transaction submitted in the unsigned-phase
  final BigInt minerTxPriority = BigInt.parse(
    '16602069666338596453',
    radix: 10,
  );

  /// Maximum number of signed submissions that can be queued.
  ///
  /// It is best to avoid adjusting this during an election, as it impacts downstream data
  /// structures. In particular, `SignedSubmissionIndices<T>` is bounded on this value. If you
  /// update this value during an election, you _must_ ensure that
  /// `SignedSubmissionIndices.len()` is less than or equal to the new value. Otherwise,
  /// attempts to submit new solutions may cause a runtime panic.
  final int signedMaxSubmissions = 16;

  /// Maximum weight of a signed solution.
  ///
  /// If [`Config::MinerConfig`] is being implemented to submit signed solutions (outside of
  /// this pallet), then [`MinerConfig::solution_weight`] is used to compare against
  /// this value.
  final _i14.Weight signedMaxWeight = _i14.Weight(
    refTime: BigInt.from(1469540941000),
    proofSize: BigInt.parse(
      '13650590614545068195',
      radix: 10,
    ),
  );

  /// The maximum amount of unchecked solutions to refund the call fee for.
  final int signedMaxRefunds = 4;

  /// Base reward for a signed solution
  final BigInt signedRewardBase = BigInt.from(10000000000);

  /// Base deposit for a signed solution.
  final BigInt signedDepositBase = BigInt.from(400000000000);

  /// Per-byte deposit for a signed solution.
  final BigInt signedDepositByte = BigInt.from(97656);

  /// Per-weight deposit for a signed solution.
  final BigInt signedDepositWeight = BigInt.zero;

  /// The maximum number of electing voters to put in the snapshot. At the moment, snapshots
  /// are only over a single block, but once multi-block elections are introduced they will
  /// take place over multiple blocks.
  final int maxElectingVoters = 22500;

  /// The maximum number of electable targets to put in the snapshot.
  final int maxElectableTargets = 65535;

  /// The maximum number of winners that can be elected by this `ElectionProvider`
  /// implementation.
  ///
  /// Note: This must always be greater or equal to `T::DataProvider::desired_targets()`.
  final int maxWinners = 1200;

  final int minerMaxLength = 3538944;

  final _i14.Weight minerMaxWeight = _i14.Weight(
    refTime: BigInt.from(1469540941000),
    proofSize: BigInt.parse(
      '13650590614545068195',
      radix: 10,
    ),
  );

  final int minerMaxVotesPerVoter = 16;

  final int minerMaxWinners = 1200;
}
