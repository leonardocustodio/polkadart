// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i5;
import '../renouncing.dart' as _i4;

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

  Vote vote({
    required List<_i3.AccountId32> votes,
    required BigInt value,
  }) {
    return Vote(
      votes: votes,
      value: value,
    );
  }

  RemoveVoter removeVoter() {
    return RemoveVoter();
  }

  SubmitCandidacy submitCandidacy({required BigInt candidateCount}) {
    return SubmitCandidacy(candidateCount: candidateCount);
  }

  RenounceCandidacy renounceCandidacy({required _i4.Renouncing renouncing}) {
    return RenounceCandidacy(renouncing: renouncing);
  }

  RemoveMember removeMember({
    required _i5.MultiAddress who,
    required bool slashBond,
    required bool rerunElection,
  }) {
    return RemoveMember(
      who: who,
      slashBond: slashBond,
      rerunElection: rerunElection,
    );
  }

  CleanDefunctVoters cleanDefunctVoters({
    required int numVoters,
    required int numDefunct,
  }) {
    return CleanDefunctVoters(
      numVoters: numVoters,
      numDefunct: numDefunct,
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
        return Vote._decode(input);
      case 1:
        return const RemoveVoter();
      case 2:
        return SubmitCandidacy._decode(input);
      case 3:
        return RenounceCandidacy._decode(input);
      case 4:
        return RemoveMember._decode(input);
      case 5:
        return CleanDefunctVoters._decode(input);
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
      case Vote:
        (value as Vote).encodeTo(output);
        break;
      case RemoveVoter:
        (value as RemoveVoter).encodeTo(output);
        break;
      case SubmitCandidacy:
        (value as SubmitCandidacy).encodeTo(output);
        break;
      case RenounceCandidacy:
        (value as RenounceCandidacy).encodeTo(output);
        break;
      case RemoveMember:
        (value as RemoveMember).encodeTo(output);
        break;
      case CleanDefunctVoters:
        (value as CleanDefunctVoters).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Vote:
        return (value as Vote)._sizeHint();
      case RemoveVoter:
        return 1;
      case SubmitCandidacy:
        return (value as SubmitCandidacy)._sizeHint();
      case RenounceCandidacy:
        return (value as RenounceCandidacy)._sizeHint();
      case RemoveMember:
        return (value as RemoveMember)._sizeHint();
      case CleanDefunctVoters:
        return (value as CleanDefunctVoters)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

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
class Vote extends Call {
  const Vote({
    required this.votes,
    required this.value,
  });

  factory Vote._decode(_i1.Input input) {
    return Vote(
      votes: const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
          .decode(input),
      value: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> votes;

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'vote': {
          'votes': votes.map((value) => value.toList()).toList(),
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(votes);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      votes,
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
      other is Vote &&
          _i6.listsEqual(
            other.votes,
            votes,
          ) &&
          other.value == value;

  @override
  int get hashCode => Object.hash(
        votes,
        value,
      );
}

/// Remove `origin` as a voter.
///
/// This removes the lock and returns the deposit.
///
/// The dispatch origin of this call must be signed and be a voter.
class RemoveVoter extends Call {
  const RemoveVoter();

  @override
  Map<String, dynamic> toJson() => {'remove_voter': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RemoveVoter;

  @override
  int get hashCode => runtimeType.hashCode;
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
class SubmitCandidacy extends Call {
  const SubmitCandidacy({required this.candidateCount});

  factory SubmitCandidacy._decode(_i1.Input input) {
    return SubmitCandidacy(
        candidateCount: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt candidateCount;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'submit_candidacy': {'candidateCount': candidateCount}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(candidateCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      candidateCount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubmitCandidacy && other.candidateCount == candidateCount;

  @override
  int get hashCode => candidateCount.hashCode;
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
class RenounceCandidacy extends Call {
  const RenounceCandidacy({required this.renouncing});

  factory RenounceCandidacy._decode(_i1.Input input) {
    return RenounceCandidacy(renouncing: _i4.Renouncing.codec.decode(input));
  }

  /// Renouncing
  final _i4.Renouncing renouncing;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'renounce_candidacy': {'renouncing': renouncing.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.Renouncing.codec.sizeHint(renouncing);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.Renouncing.codec.encodeTo(
      renouncing,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RenounceCandidacy && other.renouncing == renouncing;

  @override
  int get hashCode => renouncing.hashCode;
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
class RemoveMember extends Call {
  const RemoveMember({
    required this.who,
    required this.slashBond,
    required this.rerunElection,
  });

  factory RemoveMember._decode(_i1.Input input) {
    return RemoveMember(
      who: _i5.MultiAddress.codec.decode(input),
      slashBond: _i1.BoolCodec.codec.decode(input),
      rerunElection: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i5.MultiAddress who;

  /// bool
  final bool slashBond;

  /// bool
  final bool rerunElection;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'remove_member': {
          'who': who.toJson(),
          'slashBond': slashBond,
          'rerunElection': rerunElection,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.MultiAddress.codec.sizeHint(who);
    size = size + _i1.BoolCodec.codec.sizeHint(slashBond);
    size = size + _i1.BoolCodec.codec.sizeHint(rerunElection);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i5.MultiAddress.codec.encodeTo(
      who,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      slashBond,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      rerunElection,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RemoveMember &&
          other.who == who &&
          other.slashBond == slashBond &&
          other.rerunElection == rerunElection;

  @override
  int get hashCode => Object.hash(
        who,
        slashBond,
        rerunElection,
      );
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
class CleanDefunctVoters extends Call {
  const CleanDefunctVoters({
    required this.numVoters,
    required this.numDefunct,
  });

  factory CleanDefunctVoters._decode(_i1.Input input) {
    return CleanDefunctVoters(
      numVoters: _i1.U32Codec.codec.decode(input),
      numDefunct: _i1.U32Codec.codec.decode(input),
    );
  }

  /// u32
  final int numVoters;

  /// u32
  final int numDefunct;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clean_defunct_voters': {
          'numVoters': numVoters,
          'numDefunct': numDefunct,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(numVoters);
    size = size + _i1.U32Codec.codec.sizeHint(numDefunct);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numVoters,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numDefunct,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CleanDefunctVoters &&
          other.numVoters == numVoters &&
          other.numDefunct == numDefunct;

  @override
  int get hashCode => Object.hash(
        numVoters,
        numDefunct,
      );
}
