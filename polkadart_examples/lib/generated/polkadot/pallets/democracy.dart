// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/frame_support/traits/preimages/bounded.dart' as _i4;
import '../types/pallet_democracy/pallet/call.dart' as _i15;
import '../types/pallet_democracy/types/delegations.dart' as _i12;
import '../types/pallet_democracy/types/metadata_owner.dart' as _i10;
import '../types/pallet_democracy/types/referendum_info.dart' as _i6;
import '../types/pallet_democracy/vote/prior_lock.dart' as _i13;
import '../types/pallet_democracy/vote/voting.dart' as _i7;
import '../types/pallet_democracy/vote_threshold/vote_threshold.dart' as _i8;
import '../types/polkadot_runtime/runtime_call.dart' as _i14;
import '../types/primitive_types/h256.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _publicPropCount = const _i1.StorageValue<int>(
    prefix: 'Democracy',
    storage: 'PublicPropCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i3.Tuple3<int, _i4.Bounded, _i5.AccountId32>>>
      _publicProps = const _i1
          .StorageValue<List<_i3.Tuple3<int, _i4.Bounded, _i5.AccountId32>>>(
    prefix: 'Democracy',
    storage: 'PublicProps',
    valueCodec:
        _i2.SequenceCodec<_i3.Tuple3<int, _i4.Bounded, _i5.AccountId32>>(
            _i3.Tuple3Codec<int, _i4.Bounded, _i5.AccountId32>(
      _i2.U32Codec.codec,
      _i4.Bounded.codec,
      _i5.AccountId32Codec(),
    )),
  );

  final _i1.StorageMap<int, _i3.Tuple2<List<_i5.AccountId32>, BigInt>>
      _depositOf =
      const _i1.StorageMap<int, _i3.Tuple2<List<_i5.AccountId32>, BigInt>>(
    prefix: 'Democracy',
    storage: 'DepositOf',
    valueCodec: _i3.Tuple2Codec<List<_i5.AccountId32>, BigInt>(
      _i2.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec()),
      _i2.U128Codec.codec,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<int> _referendumCount = const _i1.StorageValue<int>(
    prefix: 'Democracy',
    storage: 'ReferendumCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _lowestUnbaked = const _i1.StorageValue<int>(
    prefix: 'Democracy',
    storage: 'LowestUnbaked',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i6.ReferendumInfo> _referendumInfoOf =
      const _i1.StorageMap<int, _i6.ReferendumInfo>(
    prefix: 'Democracy',
    storage: 'ReferendumInfoOf',
    valueCodec: _i6.ReferendumInfo.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<_i5.AccountId32, _i7.Voting> _votingOf =
      const _i1.StorageMap<_i5.AccountId32, _i7.Voting>(
    prefix: 'Democracy',
    storage: 'VotingOf',
    valueCodec: _i7.Voting.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i5.AccountId32Codec()),
  );

  final _i1.StorageValue<bool> _lastTabledWasExternal =
      const _i1.StorageValue<bool>(
    prefix: 'Democracy',
    storage: 'LastTabledWasExternal',
    valueCodec: _i2.BoolCodec.codec,
  );

  final _i1.StorageValue<_i3.Tuple2<_i4.Bounded, _i8.VoteThreshold>>
      _nextExternal =
      const _i1.StorageValue<_i3.Tuple2<_i4.Bounded, _i8.VoteThreshold>>(
    prefix: 'Democracy',
    storage: 'NextExternal',
    valueCodec: _i3.Tuple2Codec<_i4.Bounded, _i8.VoteThreshold>(
      _i4.Bounded.codec,
      _i8.VoteThreshold.codec,
    ),
  );

  final _i1.StorageMap<_i9.H256, _i3.Tuple2<int, List<_i5.AccountId32>>>
      _blacklist =
      const _i1.StorageMap<_i9.H256, _i3.Tuple2<int, List<_i5.AccountId32>>>(
    prefix: 'Democracy',
    storage: 'Blacklist',
    valueCodec: _i3.Tuple2Codec<int, List<_i5.AccountId32>>(
      _i2.U32Codec.codec,
      _i2.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec()),
    ),
    hasher: _i1.StorageHasher.identity(_i9.H256Codec()),
  );

  final _i1.StorageMap<_i9.H256, bool> _cancellations =
      const _i1.StorageMap<_i9.H256, bool>(
    prefix: 'Democracy',
    storage: 'Cancellations',
    valueCodec: _i2.BoolCodec.codec,
    hasher: _i1.StorageHasher.identity(_i9.H256Codec()),
  );

  final _i1.StorageMap<_i10.MetadataOwner, _i9.H256> _metadataOf =
      const _i1.StorageMap<_i10.MetadataOwner, _i9.H256>(
    prefix: 'Democracy',
    storage: 'MetadataOf',
    valueCodec: _i9.H256Codec(),
    hasher: _i1.StorageHasher.blake2b128Concat(_i10.MetadataOwner.codec),
  );

  /// The number of (public) proposals that have been made so far.
  _i11.Future<int> publicPropCount({_i1.BlockHash? at}) async {
    final hashedKey = _publicPropCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _publicPropCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The public proposals. Unsorted. The second item is the proposal.
  _i11.Future<List<_i3.Tuple3<int, _i4.Bounded, _i5.AccountId32>>> publicProps(
      {_i1.BlockHash? at}) async {
    final hashedKey = _publicProps.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _publicProps.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Those who have locked a deposit.
  ///
  /// TWOX-NOTE: Safe, as increasing integer keys are safe.
  _i11.Future<_i3.Tuple2<List<_i5.AccountId32>, BigInt>?> depositOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _depositOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _depositOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next free referendum index, aka the number of referenda started so far.
  _i11.Future<int> referendumCount({_i1.BlockHash? at}) async {
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

  /// The lowest referendum index representing an unbaked referendum. Equal to
  /// `ReferendumCount` if there isn't a unbaked referendum.
  _i11.Future<int> lowestUnbaked({_i1.BlockHash? at}) async {
    final hashedKey = _lowestUnbaked.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lowestUnbaked.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Information concerning any given referendum.
  ///
  /// TWOX-NOTE: SAFE as indexes are not under an attacker’s control.
  _i11.Future<_i6.ReferendumInfo?> referendumInfoOf(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _referendumInfoOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _referendumInfoOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All votes for a particular voter. We store the balance for the number of votes that we
  /// have recorded. The second item is the total amount of delegations, that will be added.
  ///
  /// TWOX-NOTE: SAFE as `AccountId`s are crypto hashes anyway.
  _i11.Future<_i7.Voting> votingOf(
    _i5.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _votingOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _votingOf.decodeValue(bytes);
    }
    return _i7.Direct(
      votes: [],
      delegations: _i12.Delegations(
        votes: BigInt.zero,
        capital: BigInt.zero,
      ),
      prior: _i13.PriorLock(
        0,
        BigInt.zero,
      ),
    ); /* Default */
  }

  /// True if the last referendum tabled was submitted externally. False if it was a public
  /// proposal.
  _i11.Future<bool> lastTabledWasExternal({_i1.BlockHash? at}) async {
    final hashedKey = _lastTabledWasExternal.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastTabledWasExternal.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// The referendum to be tabled whenever it would be valid to table an external proposal.
  /// This happens when a referendum needs to be tabled and one of two conditions are met:
  /// - `LastTabledWasExternal` is `false`; or
  /// - `PublicProps` is empty.
  _i11.Future<_i3.Tuple2<_i4.Bounded, _i8.VoteThreshold>?> nextExternal(
      {_i1.BlockHash? at}) async {
    final hashedKey = _nextExternal.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextExternal.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A record of who vetoed what. Maps proposal hash to a possible existent block number
  /// (until when it may not be resubmitted) and who vetoed it.
  _i11.Future<_i3.Tuple2<int, List<_i5.AccountId32>>?> blacklist(
    _i9.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _blacklist.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _blacklist.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Record of all proposals that have been subject to emergency cancellation.
  _i11.Future<bool> cancellations(
    _i9.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _cancellations.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _cancellations.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// General information concerning any proposal or referendum.
  /// The `PreimageHash` refers to the preimage of the `Preimages` provider which can be a JSON
  /// dump or IPFS hash of a JSON file.
  ///
  /// Consider a garbage collection for a metadata of finished referendums to `unrequest` (remove)
  /// large preimages.
  _i11.Future<_i9.H256?> metadataOf(
    _i10.MetadataOwner key1, {
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
}

class Txs {
  const Txs();

  /// Propose a sensitive action to be taken.
  ///
  /// The dispatch origin of this call must be _Signed_ and the sender must
  /// have funds to cover the deposit.
  ///
  /// - `proposal_hash`: The hash of the proposal preimage.
  /// - `value`: The amount of deposit (must be at least `MinimumDeposit`).
  ///
  /// Emits `Proposed`.
  _i14.RuntimeCall propose({
    required proposal,
    required value,
  }) {
    final _call = _i15.Call.values.propose(
      proposal: proposal,
      value: value,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Signals agreement with a particular proposal.
  ///
  /// The dispatch origin of this call must be _Signed_ and the sender
  /// must have funds to cover the deposit, equal to the original deposit.
  ///
  /// - `proposal`: The index of the proposal to second.
  _i14.RuntimeCall second({required proposal}) {
    final _call = _i15.Call.values.second(proposal: proposal);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Vote in a referendum. If `vote.is_aye()`, the vote is to enact the proposal;
  /// otherwise it is a vote to keep the status quo.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `ref_index`: The index of the referendum to vote for.
  /// - `vote`: The vote configuration.
  _i14.RuntimeCall vote({
    required refIndex,
    required vote,
  }) {
    final _call = _i15.Call.values.vote(
      refIndex: refIndex,
      vote: vote,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Schedule an emergency cancellation of a referendum. Cannot happen twice to the same
  /// referendum.
  ///
  /// The dispatch origin of this call must be `CancellationOrigin`.
  ///
  /// -`ref_index`: The index of the referendum to cancel.
  ///
  /// Weight: `O(1)`.
  _i14.RuntimeCall emergencyCancel({required refIndex}) {
    final _call = _i15.Call.values.emergencyCancel(refIndex: refIndex);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Schedule a referendum to be tabled once it is legal to schedule an external
  /// referendum.
  ///
  /// The dispatch origin of this call must be `ExternalOrigin`.
  ///
  /// - `proposal_hash`: The preimage hash of the proposal.
  _i14.RuntimeCall externalPropose({required proposal}) {
    final _call = _i15.Call.values.externalPropose(proposal: proposal);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Schedule a majority-carries referendum to be tabled next once it is legal to schedule
  /// an external referendum.
  ///
  /// The dispatch of this call must be `ExternalMajorityOrigin`.
  ///
  /// - `proposal_hash`: The preimage hash of the proposal.
  ///
  /// Unlike `external_propose`, blacklisting has no effect on this and it may replace a
  /// pre-scheduled `external_propose` call.
  ///
  /// Weight: `O(1)`
  _i14.RuntimeCall externalProposeMajority({required proposal}) {
    final _call = _i15.Call.values.externalProposeMajority(proposal: proposal);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Schedule a negative-turnout-bias referendum to be tabled next once it is legal to
  /// schedule an external referendum.
  ///
  /// The dispatch of this call must be `ExternalDefaultOrigin`.
  ///
  /// - `proposal_hash`: The preimage hash of the proposal.
  ///
  /// Unlike `external_propose`, blacklisting has no effect on this and it may replace a
  /// pre-scheduled `external_propose` call.
  ///
  /// Weight: `O(1)`
  _i14.RuntimeCall externalProposeDefault({required proposal}) {
    final _call = _i15.Call.values.externalProposeDefault(proposal: proposal);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Schedule the currently externally-proposed majority-carries referendum to be tabled
  /// immediately. If there is no externally-proposed referendum currently, or if there is one
  /// but it is not a majority-carries referendum then it fails.
  ///
  /// The dispatch of this call must be `FastTrackOrigin`.
  ///
  /// - `proposal_hash`: The hash of the current external proposal.
  /// - `voting_period`: The period that is allowed for voting on this proposal. Increased to
  /// 	Must be always greater than zero.
  /// 	For `FastTrackOrigin` must be equal or greater than `FastTrackVotingPeriod`.
  /// - `delay`: The number of block after voting has ended in approval and this should be
  ///  enacted. This doesn't have a minimum amount.
  ///
  /// Emits `Started`.
  ///
  /// Weight: `O(1)`
  _i14.RuntimeCall fastTrack({
    required proposalHash,
    required votingPeriod,
    required delay,
  }) {
    final _call = _i15.Call.values.fastTrack(
      proposalHash: proposalHash,
      votingPeriod: votingPeriod,
      delay: delay,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Veto and blacklist the external proposal hash.
  ///
  /// The dispatch origin of this call must be `VetoOrigin`.
  ///
  /// - `proposal_hash`: The preimage hash of the proposal to veto and blacklist.
  ///
  /// Emits `Vetoed`.
  ///
  /// Weight: `O(V + log(V))` where V is number of `existing vetoers`
  _i14.RuntimeCall vetoExternal({required proposalHash}) {
    final _call = _i15.Call.values.vetoExternal(proposalHash: proposalHash);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Remove a referendum.
  ///
  /// The dispatch origin of this call must be _Root_.
  ///
  /// - `ref_index`: The index of the referendum to cancel.
  ///
  /// # Weight: `O(1)`.
  _i14.RuntimeCall cancelReferendum({required refIndex}) {
    final _call = _i15.Call.values.cancelReferendum(refIndex: refIndex);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Delegate the voting power (with some given conviction) of the sending account.
  ///
  /// The balance delegated is locked for as long as it's delegated, and thereafter for the
  /// time appropriate for the conviction's lock period.
  ///
  /// The dispatch origin of this call must be _Signed_, and the signing account must either:
  ///  - be delegating already; or
  ///  - have no voting activity (if there is, then it will need to be removed/consolidated
  ///    through `reap_vote` or `unvote`).
  ///
  /// - `to`: The account whose voting the `target` account's voting power will follow.
  /// - `conviction`: The conviction that will be attached to the delegated votes. When the
  ///  account is undelegated, the funds will be locked for the corresponding period.
  /// - `balance`: The amount of the account's balance to be used in delegating. This must not
  ///  be more than the account's current balance.
  ///
  /// Emits `Delegated`.
  ///
  /// Weight: `O(R)` where R is the number of referendums the voter delegating to has
  ///  voted on. Weight is charged as if maximum votes.
  _i14.RuntimeCall delegate({
    required to,
    required conviction,
    required balance,
  }) {
    final _call = _i15.Call.values.delegate(
      to: to,
      conviction: conviction,
      balance: balance,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Undelegate the voting power of the sending account.
  ///
  /// Tokens may be unlocked following once an amount of time consistent with the lock period
  /// of the conviction with which the delegation was issued.
  ///
  /// The dispatch origin of this call must be _Signed_ and the signing account must be
  /// currently delegating.
  ///
  /// Emits `Undelegated`.
  ///
  /// Weight: `O(R)` where R is the number of referendums the voter delegating to has
  ///  voted on. Weight is charged as if maximum votes.
  _i14.RuntimeCall undelegate() {
    final _call = _i15.Call.values.undelegate();
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Clears all public proposals.
  ///
  /// The dispatch origin of this call must be _Root_.
  ///
  /// Weight: `O(1)`.
  _i14.RuntimeCall clearPublicProposals() {
    final _call = _i15.Call.values.clearPublicProposals();
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Unlock tokens that have an expired lock.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `target`: The account to remove the lock on.
  ///
  /// Weight: `O(R)` with R number of vote of target.
  _i14.RuntimeCall unlock({required target}) {
    final _call = _i15.Call.values.unlock(target: target);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Remove a vote for a referendum.
  ///
  /// If:
  /// - the referendum was cancelled, or
  /// - the referendum is ongoing, or
  /// - the referendum has ended such that
  ///  - the vote of the account was in opposition to the result; or
  ///  - there was no conviction to the account's vote; or
  ///  - the account made a split vote
  /// ...then the vote is removed cleanly and a following call to `unlock` may result in more
  /// funds being available.
  ///
  /// If, however, the referendum has ended and:
  /// - it finished corresponding to the vote of the account, and
  /// - the account made a standard vote with conviction, and
  /// - the lock period of the conviction is not over
  /// ...then the lock will be aggregated into the overall account's lock, which may involve
  /// *overlocking* (where the two locks are combined into a single lock that is the maximum
  /// of both the amount locked and the time is it locked for).
  ///
  /// The dispatch origin of this call must be _Signed_, and the signer must have a vote
  /// registered for referendum `index`.
  ///
  /// - `index`: The index of referendum of the vote to be removed.
  ///
  /// Weight: `O(R + log R)` where R is the number of referenda that `target` has voted on.
  ///  Weight is calculated for the maximum number of vote.
  _i14.RuntimeCall removeVote({required index}) {
    final _call = _i15.Call.values.removeVote(index: index);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Remove a vote for a referendum.
  ///
  /// If the `target` is equal to the signer, then this function is exactly equivalent to
  /// `remove_vote`. If not equal to the signer, then the vote must have expired,
  /// either because the referendum was cancelled, because the voter lost the referendum or
  /// because the conviction period is over.
  ///
  /// The dispatch origin of this call must be _Signed_.
  ///
  /// - `target`: The account of the vote to be removed; this account must have voted for
  ///  referendum `index`.
  /// - `index`: The index of referendum of the vote to be removed.
  ///
  /// Weight: `O(R + log R)` where R is the number of referenda that `target` has voted on.
  ///  Weight is calculated for the maximum number of vote.
  _i14.RuntimeCall removeOtherVote({
    required target,
    required index,
  }) {
    final _call = _i15.Call.values.removeOtherVote(
      target: target,
      index: index,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Permanently place a proposal into the blacklist. This prevents it from ever being
  /// proposed again.
  ///
  /// If called on a queued public or external proposal, then this will result in it being
  /// removed. If the `ref_index` supplied is an active referendum with the proposal hash,
  /// then it will be cancelled.
  ///
  /// The dispatch origin of this call must be `BlacklistOrigin`.
  ///
  /// - `proposal_hash`: The proposal hash to blacklist permanently.
  /// - `ref_index`: An ongoing referendum whose hash is `proposal_hash`, which will be
  /// cancelled.
  ///
  /// Weight: `O(p)` (though as this is an high-privilege dispatch, we assume it has a
  ///  reasonable value).
  _i14.RuntimeCall blacklist({
    required proposalHash,
    maybeRefIndex,
  }) {
    final _call = _i15.Call.values.blacklist(
      proposalHash: proposalHash,
      maybeRefIndex: maybeRefIndex,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Remove a proposal.
  ///
  /// The dispatch origin of this call must be `CancelProposalOrigin`.
  ///
  /// - `prop_index`: The index of the proposal to cancel.
  ///
  /// Weight: `O(p)` where `p = PublicProps::<T>::decode_len()`
  _i14.RuntimeCall cancelProposal({required propIndex}) {
    final _call = _i15.Call.values.cancelProposal(propIndex: propIndex);
    return _i14.RuntimeCall.values.democracy(_call);
  }

  /// Set or clear a metadata of a proposal or a referendum.
  ///
  /// Parameters:
  /// - `origin`: Must correspond to the `MetadataOwner`.
  ///    - `ExternalOrigin` for an external proposal with the `SuperMajorityApprove`
  ///      threshold.
  ///    - `ExternalDefaultOrigin` for an external proposal with the `SuperMajorityAgainst`
  ///      threshold.
  ///    - `ExternalMajorityOrigin` for an external proposal with the `SimpleMajority`
  ///      threshold.
  ///    - `Signed` by a creator for a public proposal.
  ///    - `Signed` to clear a metadata for a finished referendum.
  ///    - `Root` to set a metadata for an ongoing referendum.
  /// - `owner`: an identifier of a metadata owner.
  /// - `maybe_hash`: The hash of an on-chain stored preimage. `None` to clear a metadata.
  _i14.RuntimeCall setMetadata({
    required owner,
    maybeHash,
  }) {
    final _call = _i15.Call.values.setMetadata(
      owner: owner,
      maybeHash: maybeHash,
    );
    return _i14.RuntimeCall.values.democracy(_call);
  }
}

class Constants {
  Constants();

  /// The period between a proposal being approved and enacted.
  ///
  /// It should generally be a little more than the unstake period to ensure that
  /// voting stakers have an opportunity to remove themselves from the system in the case
  /// where they are on the losing side of a vote.
  final int enactmentPeriod = 403200;

  /// How often (in blocks) new public referenda are launched.
  final int launchPeriod = 403200;

  /// How often (in blocks) to check for new votes.
  final int votingPeriod = 403200;

  /// The minimum period of vote locking.
  ///
  /// It should be no shorter than enactment period to ensure that in the case of an approval,
  /// those successful voters are locked into the consequences that their votes entail.
  final int voteLockingPeriod = 403200;

  /// The minimum amount to be used as a deposit for a public referendum proposal.
  final BigInt minimumDeposit = BigInt.from(1000000000000);

  /// Indicator for whether an emergency origin is even allowed to happen. Some chains may
  /// want to set this permanently to `false`, others may want to condition it on things such
  /// as an upgrade having happened recently.
  final bool instantAllowed = true;

  /// Minimum voting period allowed for a fast-track referendum.
  final int fastTrackVotingPeriod = 1800;

  /// Period in blocks where an external proposal may not be re-submitted after being vetoed.
  final int cooloffPeriod = 100800;

  /// The maximum number of votes for an account.
  ///
  /// Also used to compute weight, an overly big value can
  /// lead to extrinsic with very big weight: see `delegate` for instance.
  final int maxVotes = 100;

  /// The maximum number of public proposals that can exist at any time.
  final int maxProposals = 100;

  /// The maximum number of deposits a public proposal may have at any time.
  final int maxDeposits = 100;

  /// The maximum number of items which can be blacklisted.
  final int maxBlacklisted = 100;
}
