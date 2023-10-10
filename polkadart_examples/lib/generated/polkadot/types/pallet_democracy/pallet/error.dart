// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Value too low
  valueLow('ValueLow', 0),

  /// Proposal does not exist
  proposalMissing('ProposalMissing', 1),

  /// Cannot cancel the same proposal twice
  alreadyCanceled('AlreadyCanceled', 2),

  /// Proposal already made
  duplicateProposal('DuplicateProposal', 3),

  /// Proposal still blacklisted
  proposalBlacklisted('ProposalBlacklisted', 4),

  /// Next external proposal not simple majority
  notSimpleMajority('NotSimpleMajority', 5),

  /// Invalid hash
  invalidHash('InvalidHash', 6),

  /// No external proposal
  noProposal('NoProposal', 7),

  /// Identity may not veto a proposal twice
  alreadyVetoed('AlreadyVetoed', 8),

  /// Vote given for invalid referendum
  referendumInvalid('ReferendumInvalid', 9),

  /// No proposals waiting
  noneWaiting('NoneWaiting', 10),

  /// The given account did not vote on the referendum.
  notVoter('NotVoter', 11),

  /// The actor has no permission to conduct the action.
  noPermission('NoPermission', 12),

  /// The account is already delegating.
  alreadyDelegating('AlreadyDelegating', 13),

  /// Too high a balance was provided that the account cannot afford.
  insufficientFunds('InsufficientFunds', 14),

  /// The account is not currently delegating.
  notDelegating('NotDelegating', 15),

  /// The account currently has votes attached to it and the operation cannot succeed until
  /// these are removed, either through `unvote` or `reap_vote`.
  votesExist('VotesExist', 16),

  /// The instant referendum origin is currently disallowed.
  instantNotAllowed('InstantNotAllowed', 17),

  /// Delegation to oneself makes no sense.
  nonsense('Nonsense', 18),

  /// Invalid upper bound.
  wrongUpperBound('WrongUpperBound', 19),

  /// Maximum number of votes reached.
  maxVotesReached('MaxVotesReached', 20),

  /// Maximum number of items reached.
  tooMany('TooMany', 21),

  /// Voting period too low
  votingPeriodLow('VotingPeriodLow', 22),

  /// The preimage does not exist.
  preimageNotExist('PreimageNotExist', 23);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.valueLow;
      case 1:
        return Error.proposalMissing;
      case 2:
        return Error.alreadyCanceled;
      case 3:
        return Error.duplicateProposal;
      case 4:
        return Error.proposalBlacklisted;
      case 5:
        return Error.notSimpleMajority;
      case 6:
        return Error.invalidHash;
      case 7:
        return Error.noProposal;
      case 8:
        return Error.alreadyVetoed;
      case 9:
        return Error.referendumInvalid;
      case 10:
        return Error.noneWaiting;
      case 11:
        return Error.notVoter;
      case 12:
        return Error.noPermission;
      case 13:
        return Error.alreadyDelegating;
      case 14:
        return Error.insufficientFunds;
      case 15:
        return Error.notDelegating;
      case 16:
        return Error.votesExist;
      case 17:
        return Error.instantNotAllowed;
      case 18:
        return Error.nonsense;
      case 19:
        return Error.wrongUpperBound;
      case 20:
        return Error.maxVotesReached;
      case 21:
        return Error.tooMany;
      case 22:
        return Error.votingPeriodLow;
      case 23:
        return Error.preimageNotExist;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
