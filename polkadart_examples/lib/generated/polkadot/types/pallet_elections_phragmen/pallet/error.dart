// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Cannot vote when no candidates or members exist.
  unableToVote('UnableToVote', 0),

  /// Must vote for at least one candidate.
  noVotes('NoVotes', 1),

  /// Cannot vote more than candidates.
  tooManyVotes('TooManyVotes', 2),

  /// Cannot vote more than maximum allowed.
  maximumVotesExceeded('MaximumVotesExceeded', 3),

  /// Cannot vote with stake less than minimum balance.
  lowBalance('LowBalance', 4),

  /// Voter can not pay voting bond.
  unableToPayBond('UnableToPayBond', 5),

  /// Must be a voter.
  mustBeVoter('MustBeVoter', 6),

  /// Duplicated candidate submission.
  duplicatedCandidate('DuplicatedCandidate', 7),

  /// Too many candidates have been created.
  tooManyCandidates('TooManyCandidates', 8),

  /// Member cannot re-submit candidacy.
  memberSubmit('MemberSubmit', 9),

  /// Runner cannot re-submit candidacy.
  runnerUpSubmit('RunnerUpSubmit', 10),

  /// Candidate does not have enough funds.
  insufficientCandidateFunds('InsufficientCandidateFunds', 11),

  /// Not a member.
  notMember('NotMember', 12),

  /// The provided count of number of candidates is incorrect.
  invalidWitnessData('InvalidWitnessData', 13),

  /// The provided count of number of votes is incorrect.
  invalidVoteCount('InvalidVoteCount', 14),

  /// The renouncing origin presented a wrong `Renouncing` parameter.
  invalidRenouncing('InvalidRenouncing', 15),

  /// Prediction regarding replacement after member removal is wrong.
  invalidReplacement('InvalidReplacement', 16);

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
        return Error.unableToVote;
      case 1:
        return Error.noVotes;
      case 2:
        return Error.tooManyVotes;
      case 3:
        return Error.maximumVotesExceeded;
      case 4:
        return Error.lowBalance;
      case 5:
        return Error.unableToPayBond;
      case 6:
        return Error.mustBeVoter;
      case 7:
        return Error.duplicatedCandidate;
      case 8:
        return Error.tooManyCandidates;
      case 9:
        return Error.memberSubmit;
      case 10:
        return Error.runnerUpSubmit;
      case 11:
        return Error.insufficientCandidateFunds;
      case 12:
        return Error.notMember;
      case 13:
        return Error.invalidWitnessData;
      case 14:
        return Error.invalidVoteCount;
      case 15:
        return Error.invalidRenouncing;
      case 16:
        return Error.invalidReplacement;
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
