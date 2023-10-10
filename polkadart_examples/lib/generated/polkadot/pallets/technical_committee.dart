// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_collective/pallet/call_2.dart' as _i8;
import '../types/pallet_collective/votes.dart' as _i5;
import '../types/polkadot_runtime/runtime_call.dart' as _i4;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_core/crypto/account_id32.dart' as _i6;
import '../types/sp_weights/weight_v2/weight.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.H256>> _proposals =
      const _i1.StorageValue<List<_i2.H256>>(
    prefix: 'TechnicalCommittee',
    storage: 'Proposals',
    valueCodec: _i3.SequenceCodec<_i2.H256>(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i4.RuntimeCall> _proposalOf =
      const _i1.StorageMap<_i2.H256, _i4.RuntimeCall>(
    prefix: 'TechnicalCommittee',
    storage: 'ProposalOf',
    valueCodec: _i4.RuntimeCall.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i5.Votes> _voting =
      const _i1.StorageMap<_i2.H256, _i5.Votes>(
    prefix: 'TechnicalCommittee',
    storage: 'Voting',
    valueCodec: _i5.Votes.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageValue<int> _proposalCount = const _i1.StorageValue<int>(
    prefix: 'TechnicalCommittee',
    storage: 'ProposalCount',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i6.AccountId32>> _members =
      const _i1.StorageValue<List<_i6.AccountId32>>(
    prefix: 'TechnicalCommittee',
    storage: 'Members',
    valueCodec: _i3.SequenceCodec<_i6.AccountId32>(_i6.AccountId32Codec()),
  );

  final _i1.StorageValue<_i6.AccountId32> _prime =
      const _i1.StorageValue<_i6.AccountId32>(
    prefix: 'TechnicalCommittee',
    storage: 'Prime',
    valueCodec: _i6.AccountId32Codec(),
  );

  /// The hashes of the active proposals.
  _i7.Future<List<_i2.H256>> proposals({_i1.BlockHash? at}) async {
    final hashedKey = _proposals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposals.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Actual proposal for a given hash, if it's current.
  _i7.Future<_i4.RuntimeCall?> proposalOf(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proposalOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Votes on a given proposal, if it is ongoing.
  _i7.Future<_i5.Votes?> voting(
    _i2.H256 key1, {
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
    return null; /* Nullable */
  }

  /// Proposals so far.
  _i7.Future<int> proposalCount({_i1.BlockHash? at}) async {
    final hashedKey = _proposalCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The current members of the collective. This is stored sorted (just by value).
  _i7.Future<List<_i6.AccountId32>> members({_i1.BlockHash? at}) async {
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

  /// The prime member that helps determine the default vote behavior in case of absentations.
  _i7.Future<_i6.AccountId32?> prime({_i1.BlockHash? at}) async {
    final hashedKey = _prime.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _prime.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Set the collective's membership.
  ///
  /// - `new_members`: The new member list. Be nice to the chain and provide it sorted.
  /// - `prime`: The prime member whose vote sets the default.
  /// - `old_count`: The upper bound for the previous number of members in storage. Used for
  ///  weight estimation.
  ///
  /// The dispatch of this call must be `SetMembersOrigin`.
  ///
  /// NOTE: Does not enforce the expected `MaxMembers` limit on the amount of members, but
  ///      the weight estimations rely on it to estimate dispatchable weight.
  ///
  /// # WARNING:
  ///
  /// The `pallet-collective` can also be managed by logic outside of the pallet through the
  /// implementation of the trait [`ChangeMembers`].
  /// Any call to `set_members` must be careful that the member set doesn't get out of sync
  /// with other logic managing the member set.
  ///
  /// ## Complexity:
  /// - `O(MP + N)` where:
  ///  - `M` old-members-count (code- and governance-bounded)
  ///  - `N` new-members-count (code- and governance-bounded)
  ///  - `P` proposals-count (code-bounded)
  _i4.RuntimeCall setMembers({
    required newMembers,
    prime,
    required oldCount,
  }) {
    final _call = _i8.Call.values.setMembers(
      newMembers: newMembers,
      prime: prime,
      oldCount: oldCount,
    );
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }

  /// Dispatch a proposal from a member using the `Member` origin.
  ///
  /// Origin must be a member of the collective.
  ///
  /// ## Complexity:
  /// - `O(B + M + P)` where:
  /// - `B` is `proposal` size in bytes (length-fee-bounded)
  /// - `M` members-count (code-bounded)
  /// - `P` complexity of dispatching `proposal`
  _i4.RuntimeCall execute({
    required proposal,
    required lengthBound,
  }) {
    final _call = _i8.Call.values.execute(
      proposal: proposal,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }

  /// Add a new proposal to either be voted on or executed directly.
  ///
  /// Requires the sender to be member.
  ///
  /// `threshold` determines whether `proposal` is executed directly (`threshold < 2`)
  /// or put up for voting.
  ///
  /// ## Complexity
  /// - `O(B + M + P1)` or `O(B + M + P2)` where:
  ///  - `B` is `proposal` size in bytes (length-fee-bounded)
  ///  - `M` is members-count (code- and governance-bounded)
  ///  - branching is influenced by `threshold` where:
  ///    - `P1` is proposal execution complexity (`threshold < 2`)
  ///    - `P2` is proposals-count (code-bounded) (`threshold >= 2`)
  _i4.RuntimeCall propose({
    required threshold,
    required proposal,
    required lengthBound,
  }) {
    final _call = _i8.Call.values.propose(
      threshold: threshold,
      proposal: proposal,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }

  /// Add an aye or nay vote for the sender to the given proposal.
  ///
  /// Requires the sender to be a member.
  ///
  /// Transaction fees will be waived if the member is voting on any particular proposal
  /// for the first time and the call is successful. Subsequent vote changes will charge a
  /// fee.
  /// ## Complexity
  /// - `O(M)` where `M` is members-count (code- and governance-bounded)
  _i4.RuntimeCall vote({
    required proposal,
    required index,
    required approve,
  }) {
    final _call = _i8.Call.values.vote(
      proposal: proposal,
      index: index,
      approve: approve,
    );
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }

  /// Disapprove a proposal, close, and remove it from the system, regardless of its current
  /// state.
  ///
  /// Must be called by the Root origin.
  ///
  /// Parameters:
  /// * `proposal_hash`: The hash of the proposal that should be disapproved.
  ///
  /// ## Complexity
  /// O(P) where P is the number of max proposals
  _i4.RuntimeCall disapproveProposal({required proposalHash}) {
    final _call =
        _i8.Call.values.disapproveProposal(proposalHash: proposalHash);
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }

  /// Close a vote that is either approved, disapproved or whose voting period has ended.
  ///
  /// May be called by any signed account in order to finish voting and close the proposal.
  ///
  /// If called before the end of the voting period it will only close the vote if it is
  /// has enough votes to be approved or disapproved.
  ///
  /// If called after the end of the voting period abstentions are counted as rejections
  /// unless there is a prime member set and the prime member cast an approval.
  ///
  /// If the close operation completes successfully with disapproval, the transaction fee will
  /// be waived. Otherwise execution of the approved operation will be charged to the caller.
  ///
  /// + `proposal_weight_bound`: The maximum amount of weight consumed by executing the closed
  /// proposal.
  /// + `length_bound`: The upper bound for the length of the proposal in storage. Checked via
  /// `storage::read` so it is `size_of::<u32>() == 4` larger than the pure length.
  ///
  /// ## Complexity
  /// - `O(B + M + P1 + P2)` where:
  ///  - `B` is `proposal` size in bytes (length-fee-bounded)
  ///  - `M` is members-count (code- and governance-bounded)
  ///  - `P1` is the complexity of `proposal` preimage.
  ///  - `P2` is proposal-count (code-bounded)
  _i4.RuntimeCall close({
    required proposalHash,
    required index,
    required proposalWeightBound,
    required lengthBound,
  }) {
    final _call = _i8.Call.values.close(
      proposalHash: proposalHash,
      index: index,
      proposalWeightBound: proposalWeightBound,
      lengthBound: lengthBound,
    );
    return _i4.RuntimeCall.values.technicalCommittee(_call);
  }
}

class Constants {
  Constants();

  /// The maximum weight of a dispatch call that can be proposed and executed.
  final _i9.Weight maxProposalWeight = _i9.Weight(
    refTime: BigInt.from(1000000000000),
    proofSize: BigInt.parse(
      '9223372036854775807',
      radix: 10,
    ),
  );
}
