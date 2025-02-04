// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i10;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_conviction_voting/conviction/conviction.dart' as _i15;
import '../types/pallet_conviction_voting/pallet/call.dart' as _i13;
import '../types/pallet_conviction_voting/types/delegations.dart' as _i8;
import '../types/pallet_conviction_voting/vote/account_vote.dart' as _i12;
import '../types/pallet_conviction_voting/vote/casting.dart' as _i7;
import '../types/pallet_conviction_voting/vote/prior_lock.dart' as _i9;
import '../types/pallet_conviction_voting/vote/voting.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i11;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i14;
import '../types/tuples.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.AccountId32, int, _i3.Voting> _votingFor =
      const _i1.StorageDoubleMap<_i2.AccountId32, int, _i3.Voting>(
    prefix: 'ConvictionVoting',
    storage: 'VotingFor',
    valueCodec: _i3.Voting.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i4.U16Codec.codec),
  );

  final _i1.StorageMap<_i2.AccountId32, List<_i5.Tuple2<int, BigInt>>>
      _classLocksFor =
      const _i1.StorageMap<_i2.AccountId32, List<_i5.Tuple2<int, BigInt>>>(
    prefix: 'ConvictionVoting',
    storage: 'ClassLocksFor',
    valueCodec:
        _i4.SequenceCodec<_i5.Tuple2<int, BigInt>>(_i5.Tuple2Codec<int, BigInt>(
      _i4.U16Codec.codec,
      _i4.U128Codec.codec,
    )),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  /// All voting for a particular voter in a particular voting class. We store the balance for the
  /// number of votes that we have recorded.
  _i6.Future<_i3.Voting> votingFor(
    _i2.AccountId32 key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _votingFor.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _votingFor.decodeValue(bytes);
    }
    return _i3.Casting(_i7.Casting(
      votes: [],
      delegations: _i8.Delegations(
        votes: BigInt.zero,
        capital: BigInt.zero,
      ),
      prior: _i9.PriorLock(
        0,
        BigInt.zero,
      ),
    )); /* Default */
  }

  /// The voting classes which have a non-zero lock requirement and the lock amounts which they
  /// require. The actual amount locked on behalf of this pallet should always be the maximum of
  /// this list.
  _i6.Future<List<_i5.Tuple2<int, BigInt>>> classLocksFor(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _classLocksFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _classLocksFor.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `votingFor`.
  _i10.Uint8List votingForKey(
    _i2.AccountId32 key1,
    int key2,
  ) {
    final hashedKey = _votingFor.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `classLocksFor`.
  _i10.Uint8List classLocksForKey(_i2.AccountId32 key1) {
    final hashedKey = _classLocksFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `votingFor`.
  _i10.Uint8List votingForMapPrefix(_i2.AccountId32 key1) {
    final hashedKey = _votingFor.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `classLocksFor`.
  _i10.Uint8List classLocksForMapPrefix() {
    final hashedKey = _classLocksFor.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Vote in a poll. If `vote.is_aye()`, the vote is to enact the proposal;
  /// otherwise it is a vote to keep the status quo.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `poll_index`: The index of the poll to vote for.
  /// - `vote`: The vote configuration.
  ///
  /// Weight: `O(R)` where R is the number of polls the voter has voted on.
  _i11.RuntimeCall vote({
    required BigInt pollIndex,
    required _i12.AccountVote vote,
  }) {
    final _call = _i13.Call.values.vote(
      pollIndex: pollIndex,
      vote: vote,
    );
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }

  /// Delegate the voting power (with some given conviction) of the sending account for a
  /// particular class of polls.
  ///
  /// The balance delegated is locked for as long as it's delegated, and thereafter for the
  /// time appropriate for the conviction's lock period.
  ///
  /// The dispatch origin of this call must be _Signed_, and the signing account must either:
  ///  - be delegating already; or
  ///  - have no voting activity (if there is, then it will need to be removed through
  ///    `remove_vote`).
  ///
  /// - `to`: The account whose voting the `target` account's voting power will follow.
  /// - `class`: The class of polls to delegate. To delegate multiple classes, multiple calls
  ///  to this function are required.
  /// - `conviction`: The conviction that will be attached to the delegated votes. When the
  ///  account is undelegated, the funds will be locked for the corresponding period.
  /// - `balance`: The amount of the account's balance to be used in delegating. This must not
  ///  be more than the account's current balance.
  ///
  /// Emits `Delegated`.
  ///
  /// Weight: `O(R)` where R is the number of polls the voter delegating to has
  ///  voted on. Weight is initially charged as if maximum votes, but is refunded later.
  _i11.RuntimeCall delegate({
    required int class_,
    required _i14.MultiAddress to,
    required _i15.Conviction conviction,
    required BigInt balance,
  }) {
    final _call = _i13.Call.values.delegate(
      class_: class_,
      to: to,
      conviction: conviction,
      balance: balance,
    );
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }

  /// Undelegate the voting power of the sending account for a particular class of polls.
  ///
  /// Tokens may be unlocked following once an amount of time consistent with the lock period
  /// of the conviction with which the delegation was issued has passed.
  ///
  /// The dispatch origin of this call must be _Signed_ and the signing account must be
  /// currently delegating.
  ///
  /// - `class`: The class of polls to remove the delegation from.
  ///
  /// Emits `Undelegated`.
  ///
  /// Weight: `O(R)` where R is the number of polls the voter delegating to has
  ///  voted on. Weight is initially charged as if maximum votes, but is refunded later.
  _i11.RuntimeCall undelegate({required int class_}) {
    final _call = _i13.Call.values.undelegate(class_: class_);
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }

  /// Remove the lock caused by prior voting/delegating which has expired within a particular
  /// class.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `class`: The class of polls to unlock.
  /// - `target`: The account to remove the lock on.
  ///
  /// Weight: `O(R)` with R number of vote of target.
  _i11.RuntimeCall unlock({
    required int class_,
    required _i14.MultiAddress target,
  }) {
    final _call = _i13.Call.values.unlock(
      class_: class_,
      target: target,
    );
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }

  /// Remove a vote for a poll.
  ///
  /// If:
  /// - the poll was cancelled, or
  /// - the poll is ongoing, or
  /// - the poll has ended such that
  ///  - the vote of the account was in opposition to the result; or
  ///  - there was no conviction to the account's vote; or
  ///  - the account made a split vote
  /// ...then the vote is removed cleanly and a following call to `unlock` may result in more
  /// funds being available.
  ///
  /// If, however, the poll has ended and:
  /// - it finished corresponding to the vote of the account, and
  /// - the account made a standard vote with conviction, and
  /// - the lock period of the conviction is not over
  /// ...then the lock will be aggregated into the overall account's lock, which may involve
  /// *overlocking* (where the two locks are combined into a single lock that is the maximum
  /// of both the amount locked and the time is it locked for).
  ///
  /// The dispatch origin of this call must be _Signed_, and the signer must have a vote
  /// registered for poll `index`.
  ///
  /// - `index`: The index of poll of the vote to be removed.
  /// - `class`: Optional parameter, if given it indicates the class of the poll. For polls
  ///  which have finished or are cancelled, this must be `Some`.
  ///
  /// Weight: `O(R + log R)` where R is the number of polls that `target` has voted on.
  ///  Weight is calculated for the maximum number of vote.
  _i11.RuntimeCall removeVote({
    int? class_,
    required int index,
  }) {
    final _call = _i13.Call.values.removeVote(
      class_: class_,
      index: index,
    );
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }

  /// Remove a vote for a poll.
  ///
  /// If the `target` is equal to the signer, then this function is exactly equivalent to
  /// `remove_vote`. If not equal to the signer, then the vote must have expired,
  /// either because the poll was cancelled, because the voter lost the poll or
  /// because the conviction period is over.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `target`: The account of the vote to be removed; this account must have voted for poll
  ///  `index`.
  /// - `index`: The index of poll of the vote to be removed.
  /// - `class`: The class of the poll.
  ///
  /// Weight: `O(R + log R)` where R is the number of polls that `target` has voted on.
  ///  Weight is calculated for the maximum number of vote.
  _i11.RuntimeCall removeOtherVote({
    required _i14.MultiAddress target,
    required int class_,
    required int index,
  }) {
    final _call = _i13.Call.values.removeOtherVote(
      target: target,
      class_: class_,
      index: index,
    );
    return _i11.RuntimeCall.values.convictionVoting(_call);
  }
}

class Constants {
  Constants();

  /// The maximum number of concurrent votes an account may have.
  ///
  /// Also used to compute weight, an overly large value can lead to extrinsics with large
  /// weight estimation: see `delegate` for instance.
  final int maxVotes = 512;

  /// The minimum period of vote locking.
  ///
  /// It should be no shorter than enactment period to ensure that in the case of an approval,
  /// those successful voters are locked into the consequences that their votes entail.
  final int voteLockingPeriod = 100800;
}
