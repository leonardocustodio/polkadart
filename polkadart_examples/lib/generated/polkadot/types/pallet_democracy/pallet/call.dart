// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i9;

import '../../frame_support/traits/preimages/bounded.dart' as _i3;
import '../../primitive_types/h256.dart' as _i5;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i6;
import '../conviction/conviction.dart' as _i7;
import '../types/metadata_owner.dart' as _i8;
import '../vote/account_vote.dart' as _i4;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Propose propose({
    required _i3.Bounded proposal,
    required BigInt value,
  }) {
    return Propose(
      proposal: proposal,
      value: value,
    );
  }

  Second second({required BigInt proposal}) {
    return Second(proposal: proposal);
  }

  Vote vote({
    required BigInt refIndex,
    required _i4.AccountVote vote,
  }) {
    return Vote(
      refIndex: refIndex,
      vote: vote,
    );
  }

  EmergencyCancel emergencyCancel({required int refIndex}) {
    return EmergencyCancel(refIndex: refIndex);
  }

  ExternalPropose externalPropose({required _i3.Bounded proposal}) {
    return ExternalPropose(proposal: proposal);
  }

  ExternalProposeMajority externalProposeMajority(
      {required _i3.Bounded proposal}) {
    return ExternalProposeMajority(proposal: proposal);
  }

  ExternalProposeDefault externalProposeDefault(
      {required _i3.Bounded proposal}) {
    return ExternalProposeDefault(proposal: proposal);
  }

  FastTrack fastTrack({
    required _i5.H256 proposalHash,
    required int votingPeriod,
    required int delay,
  }) {
    return FastTrack(
      proposalHash: proposalHash,
      votingPeriod: votingPeriod,
      delay: delay,
    );
  }

  VetoExternal vetoExternal({required _i5.H256 proposalHash}) {
    return VetoExternal(proposalHash: proposalHash);
  }

  CancelReferendum cancelReferendum({required BigInt refIndex}) {
    return CancelReferendum(refIndex: refIndex);
  }

  Delegate delegate({
    required _i6.MultiAddress to,
    required _i7.Conviction conviction,
    required BigInt balance,
  }) {
    return Delegate(
      to: to,
      conviction: conviction,
      balance: balance,
    );
  }

  Undelegate undelegate() {
    return Undelegate();
  }

  ClearPublicProposals clearPublicProposals() {
    return ClearPublicProposals();
  }

  Unlock unlock({required _i6.MultiAddress target}) {
    return Unlock(target: target);
  }

  RemoveVote removeVote({required int index}) {
    return RemoveVote(index: index);
  }

  RemoveOtherVote removeOtherVote({
    required _i6.MultiAddress target,
    required int index,
  }) {
    return RemoveOtherVote(
      target: target,
      index: index,
    );
  }

  Blacklist blacklist({
    required _i5.H256 proposalHash,
    int? maybeRefIndex,
  }) {
    return Blacklist(
      proposalHash: proposalHash,
      maybeRefIndex: maybeRefIndex,
    );
  }

  CancelProposal cancelProposal({required BigInt propIndex}) {
    return CancelProposal(propIndex: propIndex);
  }

  SetMetadata setMetadata({
    required _i8.MetadataOwner owner,
    _i5.H256? maybeHash,
  }) {
    return SetMetadata(
      owner: owner,
      maybeHash: maybeHash,
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
        return Propose._decode(input);
      case 1:
        return Second._decode(input);
      case 2:
        return Vote._decode(input);
      case 3:
        return EmergencyCancel._decode(input);
      case 4:
        return ExternalPropose._decode(input);
      case 5:
        return ExternalProposeMajority._decode(input);
      case 6:
        return ExternalProposeDefault._decode(input);
      case 7:
        return FastTrack._decode(input);
      case 8:
        return VetoExternal._decode(input);
      case 9:
        return CancelReferendum._decode(input);
      case 10:
        return Delegate._decode(input);
      case 11:
        return const Undelegate();
      case 12:
        return const ClearPublicProposals();
      case 13:
        return Unlock._decode(input);
      case 14:
        return RemoveVote._decode(input);
      case 15:
        return RemoveOtherVote._decode(input);
      case 16:
        return Blacklist._decode(input);
      case 17:
        return CancelProposal._decode(input);
      case 18:
        return SetMetadata._decode(input);
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
      case Propose:
        (value as Propose).encodeTo(output);
        break;
      case Second:
        (value as Second).encodeTo(output);
        break;
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case EmergencyCancel:
        (value as EmergencyCancel).encodeTo(output);
        break;
      case ExternalPropose:
        (value as ExternalPropose).encodeTo(output);
        break;
      case ExternalProposeMajority:
        (value as ExternalProposeMajority).encodeTo(output);
        break;
      case ExternalProposeDefault:
        (value as ExternalProposeDefault).encodeTo(output);
        break;
      case FastTrack:
        (value as FastTrack).encodeTo(output);
        break;
      case VetoExternal:
        (value as VetoExternal).encodeTo(output);
        break;
      case CancelReferendum:
        (value as CancelReferendum).encodeTo(output);
        break;
      case Delegate:
        (value as Delegate).encodeTo(output);
        break;
      case Undelegate:
        (value as Undelegate).encodeTo(output);
        break;
      case ClearPublicProposals:
        (value as ClearPublicProposals).encodeTo(output);
        break;
      case Unlock:
        (value as Unlock).encodeTo(output);
        break;
      case RemoveVote:
        (value as RemoveVote).encodeTo(output);
        break;
      case RemoveOtherVote:
        (value as RemoveOtherVote).encodeTo(output);
        break;
      case Blacklist:
        (value as Blacklist).encodeTo(output);
        break;
      case CancelProposal:
        (value as CancelProposal).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Propose:
        return (value as Propose)._sizeHint();
      case Second:
        return (value as Second)._sizeHint();
      case Vote:
        return (value as Vote)._sizeHint();
      case EmergencyCancel:
        return (value as EmergencyCancel)._sizeHint();
      case ExternalPropose:
        return (value as ExternalPropose)._sizeHint();
      case ExternalProposeMajority:
        return (value as ExternalProposeMajority)._sizeHint();
      case ExternalProposeDefault:
        return (value as ExternalProposeDefault)._sizeHint();
      case FastTrack:
        return (value as FastTrack)._sizeHint();
      case VetoExternal:
        return (value as VetoExternal)._sizeHint();
      case CancelReferendum:
        return (value as CancelReferendum)._sizeHint();
      case Delegate:
        return (value as Delegate)._sizeHint();
      case Undelegate:
        return 1;
      case ClearPublicProposals:
        return 1;
      case Unlock:
        return (value as Unlock)._sizeHint();
      case RemoveVote:
        return (value as RemoveVote)._sizeHint();
      case RemoveOtherVote:
        return (value as RemoveOtherVote)._sizeHint();
      case Blacklist:
        return (value as Blacklist)._sizeHint();
      case CancelProposal:
        return (value as CancelProposal)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Propose a sensitive action to be taken.
///
/// The dispatch origin of this call must be _Signed_ and the sender must
/// have funds to cover the deposit.
///
/// - `proposal_hash`: The hash of the proposal preimage.
/// - `value`: The amount of deposit (must be at least `MinimumDeposit`).
///
/// Emits `Proposed`.
class Propose extends Call {
  const Propose({
    required this.proposal,
    required this.value,
  });

  factory Propose._decode(_i1.Input input) {
    return Propose(
      proposal: _i3.Bounded.codec.decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// BoundedCallOf<T>
  final _i3.Bounded proposal;

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'propose': {
          'proposal': proposal.toJson(),
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Bounded.codec.sizeHint(proposal);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Propose && other.proposal == proposal && other.value == value;

  @override
  int get hashCode => Object.hash(
        proposal,
        value,
      );
}

/// Signals agreement with a particular proposal.
///
/// The dispatch origin of this call must be _Signed_ and the sender
/// must have funds to cover the deposit, equal to the original deposit.
///
/// - `proposal`: The index of the proposal to second.
class Second extends Call {
  const Second({required this.proposal});

  factory Second._decode(_i1.Input input) {
    return Second(proposal: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// PropIndex
  final BigInt proposal;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'second': {'proposal': proposal}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(proposal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      proposal,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Second && other.proposal == proposal;

  @override
  int get hashCode => proposal.hashCode;
}

/// Vote in a referendum. If `vote.is_aye()`, the vote is to enact the proposal;
/// otherwise it is a vote to keep the status quo.
///
/// The dispatch origin of this call must be _Signed_.
///
/// - `ref_index`: The index of the referendum to vote for.
/// - `vote`: The vote configuration.
class Vote extends Call {
  const Vote({
    required this.refIndex,
    required this.vote,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      refIndex: _i1.CompactBigIntCodec.codec.decode(input),
      vote: _i4.AccountVote.codec.decode(input),
    );
  }

  /// ReferendumIndex
  final BigInt refIndex;

  /// AccountVote<BalanceOf<T>>
  final _i4.AccountVote vote;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'refIndex': refIndex,
          'vote': vote.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(refIndex);
    size = size + _i4.AccountVote.codec.sizeHint(vote);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      refIndex,
      output,
    );
    _i4.AccountVote.codec.encodeTo(
      vote,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Vote && other.refIndex == refIndex && other.vote == vote;

  @override
  int get hashCode => Object.hash(
        refIndex,
        vote,
      );
}

/// Schedule an emergency cancellation of a referendum. Cannot happen twice to the same
/// referendum.
///
/// The dispatch origin of this call must be `CancellationOrigin`.
///
/// -`ref_index`: The index of the referendum to cancel.
///
/// Weight: `O(1)`.
class EmergencyCancel extends Call {
  const EmergencyCancel({required this.refIndex});

  factory EmergencyCancel._decode(_i1.Input input) {
    return EmergencyCancel(refIndex: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int refIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'emergency_cancel': {'refIndex': refIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(refIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      refIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EmergencyCancel && other.refIndex == refIndex;

  @override
  int get hashCode => refIndex.hashCode;
}

/// Schedule a referendum to be tabled once it is legal to schedule an external
/// referendum.
///
/// The dispatch origin of this call must be `ExternalOrigin`.
///
/// - `proposal_hash`: The preimage hash of the proposal.
class ExternalPropose extends Call {
  const ExternalPropose({required this.proposal});

  factory ExternalPropose._decode(_i1.Input input) {
    return ExternalPropose(proposal: _i3.Bounded.codec.decode(input));
  }

  /// BoundedCallOf<T>
  final _i3.Bounded proposal;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'external_propose': {'proposal': proposal.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Bounded.codec.sizeHint(proposal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExternalPropose && other.proposal == proposal;

  @override
  int get hashCode => proposal.hashCode;
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
class ExternalProposeMajority extends Call {
  const ExternalProposeMajority({required this.proposal});

  factory ExternalProposeMajority._decode(_i1.Input input) {
    return ExternalProposeMajority(proposal: _i3.Bounded.codec.decode(input));
  }

  /// BoundedCallOf<T>
  final _i3.Bounded proposal;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'external_propose_majority': {'proposal': proposal.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Bounded.codec.sizeHint(proposal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExternalProposeMajority && other.proposal == proposal;

  @override
  int get hashCode => proposal.hashCode;
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
class ExternalProposeDefault extends Call {
  const ExternalProposeDefault({required this.proposal});

  factory ExternalProposeDefault._decode(_i1.Input input) {
    return ExternalProposeDefault(proposal: _i3.Bounded.codec.decode(input));
  }

  /// BoundedCallOf<T>
  final _i3.Bounded proposal;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'external_propose_default': {'proposal': proposal.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.Bounded.codec.sizeHint(proposal);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ExternalProposeDefault && other.proposal == proposal;

  @override
  int get hashCode => proposal.hashCode;
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
class FastTrack extends Call {
  const FastTrack({
    required this.proposalHash,
    required this.votingPeriod,
    required this.delay,
  });

  factory FastTrack._decode(_i1.Input input) {
    return FastTrack(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      votingPeriod: _i1.U32Codec.codec.decode(input),
      delay: _i1.U32Codec.codec.decode(input),
    );
  }

  /// H256
  final _i5.H256 proposalHash;

  /// T::BlockNumber
  final int votingPeriod;

  /// T::BlockNumber
  final int delay;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'fast_track': {
          'proposalHash': proposalHash.toList(),
          'votingPeriod': votingPeriod,
          'delay': delay,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    size = size + _i1.U32Codec.codec.sizeHint(votingPeriod);
    size = size + _i1.U32Codec.codec.sizeHint(delay);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      votingPeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      delay,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is FastTrack &&
          _i9.listsEqual(
            other.proposalHash,
            proposalHash,
          ) &&
          other.votingPeriod == votingPeriod &&
          other.delay == delay;

  @override
  int get hashCode => Object.hash(
        proposalHash,
        votingPeriod,
        delay,
      );
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
class VetoExternal extends Call {
  const VetoExternal({required this.proposalHash});

  factory VetoExternal._decode(_i1.Input input) {
    return VetoExternal(proposalHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// H256
  final _i5.H256 proposalHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'veto_external': {'proposalHash': proposalHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
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
      other is VetoExternal &&
          _i9.listsEqual(
            other.proposalHash,
            proposalHash,
          );

  @override
  int get hashCode => proposalHash.hashCode;
}

/// Remove a referendum.
///
/// The dispatch origin of this call must be _Root_.
///
/// - `ref_index`: The index of the referendum to cancel.
///
/// # Weight: `O(1)`.
class CancelReferendum extends Call {
  const CancelReferendum({required this.refIndex});

  factory CancelReferendum._decode(_i1.Input input) {
    return CancelReferendum(
        refIndex: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// ReferendumIndex
  final BigInt refIndex;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'cancel_referendum': {'refIndex': refIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(refIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      refIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelReferendum && other.refIndex == refIndex;

  @override
  int get hashCode => refIndex.hashCode;
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
class Delegate extends Call {
  const Delegate({
    required this.to,
    required this.conviction,
    required this.balance,
  });

  factory Delegate._decode(_i1.Input input) {
    return Delegate(
      to: _i6.MultiAddress.codec.decode(input),
      conviction: _i7.Conviction.codec.decode(input),
      balance: _i1.U128Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i6.MultiAddress to;

  /// Conviction
  final _i7.Conviction conviction;

  /// BalanceOf<T>
  final BigInt balance;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'delegate': {
          'to': to.toJson(),
          'conviction': conviction.toJson(),
          'balance': balance,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.MultiAddress.codec.sizeHint(to);
    size = size + _i7.Conviction.codec.sizeHint(conviction);
    size = size + _i1.U128Codec.codec.sizeHint(balance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i6.MultiAddress.codec.encodeTo(
      to,
      output,
    );
    _i7.Conviction.codec.encodeTo(
      conviction,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      balance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Delegate &&
          other.to == to &&
          other.conviction == conviction &&
          other.balance == balance;

  @override
  int get hashCode => Object.hash(
        to,
        conviction,
        balance,
      );
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
class Undelegate extends Call {
  const Undelegate();

  @override
  Map<String, dynamic> toJson() => {'undelegate': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Undelegate;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Clears all public proposals.
///
/// The dispatch origin of this call must be _Root_.
///
/// Weight: `O(1)`.
class ClearPublicProposals extends Call {
  const ClearPublicProposals();

  @override
  Map<String, dynamic> toJson() => {'clear_public_proposals': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClearPublicProposals;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Unlock tokens that have an expired lock.
///
/// The dispatch origin of this call must be _Signed_.
///
/// - `target`: The account to remove the lock on.
///
/// Weight: `O(R)` with R number of vote of target.
class Unlock extends Call {
  const Unlock({required this.target});

  factory Unlock._decode(_i1.Input input) {
    return Unlock(target: _i6.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i6.MultiAddress target;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'unlock': {'target': target.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.MultiAddress.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i6.MultiAddress.codec.encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unlock && other.target == target;

  @override
  int get hashCode => target.hashCode;
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
class RemoveVote extends Call {
  const RemoveVote({required this.index});

  factory RemoveVote._decode(_i1.Input input) {
    return RemoveVote(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'remove_vote': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveVote && other.index == index;

  @override
  int get hashCode => index.hashCode;
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
class RemoveOtherVote extends Call {
  const RemoveOtherVote({
    required this.target,
    required this.index,
  });

  factory RemoveOtherVote._decode(_i1.Input input) {
    return RemoveOtherVote(
      target: _i6.MultiAddress.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i6.MultiAddress target;

  /// ReferendumIndex
  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_other_vote': {
          'target': target.toJson(),
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.MultiAddress.codec.sizeHint(target);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i6.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveOtherVote &&
          other.target == target &&
          other.index == index;

  @override
  int get hashCode => Object.hash(
        target,
        index,
      );
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
class Blacklist extends Call {
  const Blacklist({
    required this.proposalHash,
    this.maybeRefIndex,
  });

  factory Blacklist._decode(_i1.Input input) {
    return Blacklist(
      proposalHash: const _i1.U8ArrayCodec(32).decode(input),
      maybeRefIndex:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// H256
  final _i5.H256 proposalHash;

  /// Option<ReferendumIndex>
  final int? maybeRefIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'blacklist': {
          'proposalHash': proposalHash.toList(),
          'maybeRefIndex': maybeRefIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.H256Codec().sizeHint(proposalHash);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(maybeRefIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      proposalHash,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      maybeRefIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Blacklist &&
          _i9.listsEqual(
            other.proposalHash,
            proposalHash,
          ) &&
          other.maybeRefIndex == maybeRefIndex;

  @override
  int get hashCode => Object.hash(
        proposalHash,
        maybeRefIndex,
      );
}

/// Remove a proposal.
///
/// The dispatch origin of this call must be `CancelProposalOrigin`.
///
/// - `prop_index`: The index of the proposal to cancel.
///
/// Weight: `O(p)` where `p = PublicProps::<T>::decode_len()`
class CancelProposal extends Call {
  const CancelProposal({required this.propIndex});

  factory CancelProposal._decode(_i1.Input input) {
    return CancelProposal(
        propIndex: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// PropIndex
  final BigInt propIndex;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'cancel_proposal': {'propIndex': propIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(propIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      propIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelProposal && other.propIndex == propIndex;

  @override
  int get hashCode => propIndex.hashCode;
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
class SetMetadata extends Call {
  const SetMetadata({
    required this.owner,
    this.maybeHash,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
      owner: _i8.MetadataOwner.codec.decode(input),
      maybeHash: const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).decode(input),
    );
  }

  /// MetadataOwner
  final _i8.MetadataOwner owner;

  /// Option<PreimageHash>
  final _i5.H256? maybeHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_metadata': {
          'owner': owner.toJson(),
          'maybeHash': maybeHash?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.MetadataOwner.codec.sizeHint(owner);
    size = size +
        const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).sizeHint(maybeHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i8.MetadataOwner.codec.encodeTo(
      owner,
      output,
    );
    const _i1.OptionCodec<_i5.H256>(_i5.H256Codec()).encodeTo(
      maybeHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMetadata &&
          other.owner == owner &&
          other.maybeHash == maybeHash;

  @override
  int get hashCode => Object.hash(
        owner,
        maybeHash,
      );
}
