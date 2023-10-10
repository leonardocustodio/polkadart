// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../polkadot_runtime/runtime_call.dart' as _i4;
import '../../primitive_types/h256.dart' as _i5;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../sp_weights/weight_v2/weight.dart' as _i6;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  SetMembers setMembers({
    required List<_i3.AccountId32> newMembers,
    _i3.AccountId32? prime,
    required int oldCount,
  }) {
    return SetMembers(
      newMembers: newMembers,
      prime: prime,
      oldCount: oldCount,
    );
  }

  Execute execute({
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return Execute(
      proposal: proposal,
      lengthBound: lengthBound,
    );
  }

  Propose propose({
    required BigInt threshold,
    required _i4.RuntimeCall proposal,
    required BigInt lengthBound,
  }) {
    return Propose(
      threshold: threshold,
      proposal: proposal,
      lengthBound: lengthBound,
    );
  }

  Vote vote({
    required _i5.H256 proposal,
    required BigInt index,
    required bool approve,
  }) {
    return Vote(
      proposal: proposal,
      index: index,
      approve: approve,
    );
  }

  DisapproveProposal disapproveProposal({required _i5.H256 proposalHash}) {
    return DisapproveProposal(proposalHash: proposalHash);
  }

  Close close({
    required _i5.H256 proposalHash,
    required BigInt index,
    required _i6.Weight proposalWeightBound,
    required BigInt lengthBound,
  }) {
    return Close(
      proposalHash: proposalHash,
      index: index,
      proposalWeightBound: proposalWeightBound,
      lengthBound: lengthBound,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SetMembers._decode(input);
      case 1:
        return Execute._decode(input);
      case 2:
        return Propose._decode(input);
      case 3:
        return Vote._decode(input);
      case 5:
        return DisapproveProposal._decode(input);
      case 6:
        return Close._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case SetMembers:
        (value as SetMembers).encodeTo(output);
        break;
      case Execute:
        (value as Execute).encodeTo(output);
        break;
      case Propose:
        (value as Propose).encodeTo(output);
        break;
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case DisapproveProposal:
        (value as DisapproveProposal).encodeTo(output);
        break;
      case Close:
        (value as Close).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case SetMembers:
        return (value as SetMembers)._sizeHint();
      case Execute:
        return (value as Execute)._sizeHint();
      case Propose:
        return (value as Propose)._sizeHint();
      case Vote:
        return (value as Vote)._sizeHint();
      case DisapproveProposal:
        return (value as DisapproveProposal)._sizeHint();
      case Close:
        return (value as Close)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

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
class SetMembers extends Call {
  const SetMembers({
    required this.newMembers,
    this.prime,
    required this.oldCount,
  });

  factory SetMembers._decode(_i1.Input input) {
    return SetMembers(
      newMembers:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
      prime: const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec())
          .decode(input),
      oldCount: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> newMembers;

  /// Option<T::AccountId>
  final _i3.AccountId32? prime;

  /// MemberCount
  final int oldCount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_members': {
          'newMembers': newMembers.map((value) => value.toList()).toList(),
          'prime': prime?.toList(),
          'oldCount': oldCount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(newMembers);
    size = size +
        const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(prime);
    size = size + _i1.U32Codec.codec.sizeHint(oldCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      newMembers,
      output,
    );
    const _i1.OptionCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      prime,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      oldCount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMembers &&
          _i7.listsEqual(
            other.newMembers,
            newMembers,
          ) &&
          other.prime == prime &&
          other.oldCount == oldCount;

  @override
  int get hashCode => Object.hash(
        newMembers,
        prime,
        oldCount,
      );
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
class Execute extends Call {
  const Execute({
    required this.proposal,
    required this.lengthBound,
  });

  factory Execute._decode(_i1.Input input) {
    return Execute(
      proposal: _i4.RuntimeCall.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// Box<<T as Config<I>>::Proposal>
  final _i4.RuntimeCall proposal;

  /// u32
  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'execute': {
          'proposal': proposal.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.RuntimeCall.codec.sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Execute &&
          other.proposal == proposal &&
          other.lengthBound == lengthBound;

  @override
  int get hashCode => Object.hash(
        proposal,
        lengthBound,
      );
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
class Propose extends Call {
  const Propose({
    required this.threshold,
    required this.proposal,
    required this.lengthBound,
  });

  factory Propose._decode(_i1.Input input) {
    return Propose(
      threshold: _i1.CompactBigIntCodec.codec.decode(input),
      proposal: _i4.RuntimeCall.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// MemberCount
  final BigInt threshold;

  /// Box<<T as Config<I>>::Proposal>
  final _i4.RuntimeCall proposal;

  /// u32
  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose': {
          'threshold': threshold,
          'proposal': proposal.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(threshold);
    size = size + _i4.RuntimeCall.codec.sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      threshold,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Propose &&
          other.threshold == threshold &&
          other.proposal == proposal &&
          other.lengthBound == lengthBound;

  @override
  int get hashCode => Object.hash(
        threshold,
        proposal,
        lengthBound,
      );
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
class Vote extends Call {
  const Vote({
    required this.proposal,
    required this.index,
    required this.approve,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      proposal: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
      approve: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// T::Hash
  final _i5.H256 proposal;

  /// ProposalIndex
  final BigInt index;

  /// bool
  final bool approve;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'proposal': proposal.toList(),
          'index': index,
          'approve': approve,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i1.BoolCodec.codec.sizeHint(approve);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      approve,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Vote &&
          _i7.listsEqual(
            other.proposal,
            proposal,
          ) &&
          other.index == index &&
          other.approve == approve;

  @override
  int get hashCode => Object.hash(
        proposal,
        index,
        approve,
      );
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
class DisapproveProposal extends Call {
  const DisapproveProposal({required this.proposalHash});

  factory DisapproveProposal._decode(_i1.Input input) {
    return DisapproveProposal(
        proposalHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i5.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'disapprove_proposal': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DisapproveProposal &&
          _i7.listsEqual(
            other.proposalHash,
            proposalHash,
          );

  @override
  int get hashCode => proposalHash.hashCode;
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
class Close extends Call {
  const Close({
    required this.proposalHash,
    required this.index,
    required this.proposalWeightBound,
    required this.lengthBound,
  });

  factory Close._decode(_i1.Input input) {
    return Close(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      index: _i1.CompactBigIntCodec.codec.decode(input),
      proposalWeightBound: _i6.Weight.codec.decode(input),
      lengthBound: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::Hash
  final _i5.H256 proposalHash;

  /// ProposalIndex
  final BigInt index;

  /// Weight
  final _i6.Weight proposalWeightBound;

  /// u32
  final BigInt lengthBound;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'close': {
          'proposalHash': proposalHash.toList(),
          'index': index,
          'proposalWeightBound': proposalWeightBound.toJson(),
          'lengthBound': lengthBound,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(index);
    size = size + _i6.Weight.codec.sizeHint(proposalWeightBound);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lengthBound);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      index,
      output,
    );
    _i6.Weight.codec.encodeTo(
      proposalWeightBound,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lengthBound,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Close &&
          _i7.listsEqual(
            other.proposalHash,
            proposalHash,
          ) &&
          other.index == index &&
          other.proposalWeightBound == proposalWeightBound &&
          other.lengthBound == lengthBound;

  @override
  int get hashCode => Object.hash(
        proposalHash,
        index,
        proposalWeightBound,
        lengthBound,
      );
}
