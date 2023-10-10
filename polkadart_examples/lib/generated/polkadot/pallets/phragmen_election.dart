// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_elections_phragmen/pallet/call.dart' as _i9;
import '../types/pallet_elections_phragmen/seat_holder.dart' as _i2;
import '../types/pallet_elections_phragmen/voter.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.SeatHolder>> _members =
      const _i1.StorageValue<List<_i2.SeatHolder>>(
    prefix: 'PhragmenElection',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i2.SeatHolder>(_i2.SeatHolder.codec),
  );

  final _i1.StorageValue<List<_i2.SeatHolder>> _runnersUp =
      const _i1.StorageValue<List<_i2.SeatHolder>>(
    prefix: 'PhragmenElection',
    storage: 'RunnersUp',
    valueCodec: _i3.SequenceCodec<_i2.SeatHolder>(_i2.SeatHolder.codec),
  );

  final _i1.StorageValue<List<_i4.Tuple2<_i5.AccountId32, BigInt>>>
      _candidates =
      const _i1.StorageValue<List<_i4.Tuple2<_i5.AccountId32, BigInt>>>(
    prefix: 'PhragmenElection',
    storage: 'Candidates',
    valueCodec: _i3.SequenceCodec<_i4.Tuple2<_i5.AccountId32, BigInt>>(
        _i4.Tuple2Codec<_i5.AccountId32, BigInt>(
      _i5.AccountId32Codec(),
      _i3.U128Codec.codec,
    )),
  );

  final _i1.StorageValue<int> _electionRounds = const _i1.StorageValue<int>(
    prefix: 'PhragmenElection',
    storage: 'ElectionRounds',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageMap<_i5.AccountId32, _i6.Voter> _voting =
      const _i1.StorageMap<_i5.AccountId32, _i6.Voter>(
    prefix: 'PhragmenElection',
    storage: 'Voting',
    valueCodec: _i6.Voter.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.AccountId32Codec()),
  );

  /// The current elected members.
  ///
  /// Invariant: Always sorted based on account id.
  _i7.Future<List<_i2.SeatHolder>> members({_i1.BlockHash? at}) async {
    final hashedKey = _members.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _members.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current reserved runners-up.
  ///
  /// Invariant: Always sorted based on rank (worse to best). Upon removal of a member, the
  /// last (i.e. _best_) runner-up will be replaced.
  _i7.Future<List<_i2.SeatHolder>> runnersUp({_i1.BlockHash? at}) async {
    final hashedKey = _runnersUp.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _runnersUp.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The present candidate list. A current member or runner-up can never enter this vector
  /// and is always implicitly assumed to be a candidate.
  ///
  /// Second element is the deposit.
  ///
  /// Invariant: Always sorted based on account id.
  _i7.Future<List<_i4.Tuple2<_i5.AccountId32, BigInt>>> candidates(
      {_i1.BlockHash? at}) async {
    final hashedKey = _candidates.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _candidates.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The total number of vote rounds that have happened, excluding the upcoming one.
  _i7.Future<int> electionRounds({_i1.BlockHash? at}) async {
    final hashedKey = _electionRounds.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _electionRounds.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Votes and locked stake of a particular voter.
  ///
  /// TWOX-NOTE: SAFE as `AccountId` is a crypto hash.
  _i7.Future<_i6.Voter> voting(
    _i5.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _voting.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _voting.decodeValue(bytes);
    }
    return _i6.Voter(
      votes: [],
      stake: BigInt.zero,
      deposit: BigInt.zero,
    ); /* Default */
  }
}

class Txs {
  const Txs();

  /// Vote for a set of candidates for the upcoming round of election. This can be called to
  /// set the initial votes, or update already existing votes.
  ///
  /// Upon initial voting, `value` units of `who`'s balance is locked and a deposit amount is
  /// reserved. The deposit is based on the number of votes and can be updated over time.
  ///
  /// The `votes` should:
  ///  - not be empty.
  ///  - be less than the number of possible candidates. Note that all current members and
  ///    runners-up are also automatically candidates for the next round.
  ///
  /// If `value` is more than `who`'s free balance, then the maximum of the two is used.
  ///
  /// The dispatch origin of this call must be signed.
  ///
  /// ### Warning
  ///
  /// It is the responsibility of the caller to **NOT** place all of their balance into the
  /// lock and keep some for further operations.
  _i8.RuntimeCall vote({
    required votes,
    required value,
  }) {
    final _call = _i9.Call.values.vote(
      votes: votes,
      value: value,
    );
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }

  /// Remove `origin` as a voter.
  ///
  /// This removes the lock and returns the deposit.
  ///
  /// The dispatch origin of this call must be signed and be a voter.
  _i8.RuntimeCall removeVoter() {
    final _call = _i9.Call.values.removeVoter();
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }

  /// Submit oneself for candidacy. A fixed amount of deposit is recorded.
  ///
  /// All candidates are wiped at the end of the term. They either become a member/runner-up,
  /// or leave the system while their deposit is slashed.
  ///
  /// The dispatch origin of this call must be signed.
  ///
  /// ### Warning
  ///
  /// Even if a candidate ends up being a member, they must call [`Call::renounce_candidacy`]
  /// to get their deposit back. Losing the spot in an election will always lead to a slash.
  ///
  /// The number of current candidates must be provided as witness data.
  /// ## Complexity
  /// O(C + log(C)) where C is candidate_count.
  _i8.RuntimeCall submitCandidacy({required candidateCount}) {
    final _call =
        _i9.Call.values.submitCandidacy(candidateCount: candidateCount);
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }

  /// Renounce one's intention to be a candidate for the next election round. 3 potential
  /// outcomes exist:
  ///
  /// - `origin` is a candidate and not elected in any set. In this case, the deposit is
  ///  unreserved, returned and origin is removed as a candidate.
  /// - `origin` is a current runner-up. In this case, the deposit is unreserved, returned and
  ///  origin is removed as a runner-up.
  /// - `origin` is a current member. In this case, the deposit is unreserved and origin is
  ///  removed as a member, consequently not being a candidate for the next round anymore.
  ///  Similar to [`remove_member`](Self::remove_member), if replacement runners exists, they
  ///  are immediately used. If the prime is renouncing, then no prime will exist until the
  ///  next round.
  ///
  /// The dispatch origin of this call must be signed, and have one of the above roles.
  /// The type of renouncing must be provided as witness data.
  ///
  /// ## Complexity
  ///  - Renouncing::Candidate(count): O(count + log(count))
  ///  - Renouncing::Member: O(1)
  ///  - Renouncing::RunnerUp: O(1)
  _i8.RuntimeCall renounceCandidacy({required renouncing}) {
    final _call = _i9.Call.values.renounceCandidacy(renouncing: renouncing);
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }

  /// Remove a particular member from the set. This is effective immediately and the bond of
  /// the outgoing member is slashed.
  ///
  /// If a runner-up is available, then the best runner-up will be removed and replaces the
  /// outgoing member. Otherwise, if `rerun_election` is `true`, a new phragmen election is
  /// started, else, nothing happens.
  ///
  /// If `slash_bond` is set to true, the bond of the member being removed is slashed. Else,
  /// it is returned.
  ///
  /// The dispatch origin of this call must be root.
  ///
  /// Note that this does not affect the designated block number of the next election.
  ///
  /// ## Complexity
  /// - Check details of remove_and_replace_member() and do_phragmen().
  _i8.RuntimeCall removeMember({
    required who,
    required slashBond,
    required rerunElection,
  }) {
    final _call = _i9.Call.values.removeMember(
      who: who,
      slashBond: slashBond,
      rerunElection: rerunElection,
    );
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }

  /// Clean all voters who are defunct (i.e. they do not serve any purpose at all). The
  /// deposit of the removed voters are returned.
  ///
  /// This is an root function to be used only for cleaning the state.
  ///
  /// The dispatch origin of this call must be root.
  ///
  /// ## Complexity
  /// - Check is_defunct_voter() details.
  _i8.RuntimeCall cleanDefunctVoters({
    required numVoters,
    required numDefunct,
  }) {
    final _call = _i9.Call.values.cleanDefunctVoters(
      numVoters: numVoters,
      numDefunct: numDefunct,
    );
    return _i8.RuntimeCall.values.phragmenElection(_call);
  }
}

class Constants {
  Constants();

  /// Identifier for the elections-phragmen pallet's lock
  final List<int> palletId = const <int>[
    112,
    104,
    114,
    101,
    108,
    101,
    99,
    116,
  ];

  /// How much should be locked up in order to submit one's candidacy.
  final BigInt candidacyBond = BigInt.from(1000000000000);

  /// Base deposit associated with voting.
  ///
  /// This should be sensibly high to economically ensure the pallet cannot be attacked by
  /// creating a gigantic number of votes.
  final BigInt votingBondBase = BigInt.from(200640000000);

  /// The amount of bond that need to be locked for each vote (32 bytes).
  final BigInt votingBondFactor = BigInt.from(320000000);

  /// Number of members to elect.
  final int desiredMembers = 13;

  /// Number of runners_up to keep.
  final int desiredRunnersUp = 20;

  /// How long each seat is kept. This defines the next block number at which an election
  /// round will happen. If set to zero, no elections are ever triggered and the module will
  /// be in passive mode.
  final int termDuration = 100800;

  /// The maximum number of candidates in a phragmen election.
  ///
  /// Warning: This impacts the size of the election which is run onchain. Chose wisely, and
  /// consider how it will impact `T::WeightInfo::election_phragmen`.
  ///
  /// When this limit is reached no more candidates are accepted in the election.
  final int maxCandidates = 1000;

  /// The maximum number of voters to allow in a phragmen election.
  ///
  /// Warning: This impacts the size of the election which is run onchain. Chose wisely, and
  /// consider how it will impact `T::WeightInfo::election_phragmen`.
  ///
  /// When the limit is reached the new voters are ignored.
  final int maxVoters = 10000;

  /// Maximum numbers of votes per voter.
  ///
  /// Warning: This impacts the size of the election which is run onchain. Chose wisely, and
  /// consider how it will impact `T::WeightInfo::election_phragmen`.
  final int maxVotesPerVoter = 16;
}
