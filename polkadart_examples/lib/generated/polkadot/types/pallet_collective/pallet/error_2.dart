// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Account is not a member
  notMember('NotMember', 0),

  /// Duplicate proposals not allowed
  duplicateProposal('DuplicateProposal', 1),

  /// Proposal must exist
  proposalMissing('ProposalMissing', 2),

  /// Mismatched index
  wrongIndex('WrongIndex', 3),

  /// Duplicate vote ignored
  duplicateVote('DuplicateVote', 4),

  /// Members are already initialized!
  alreadyInitialized('AlreadyInitialized', 5),

  /// The close call was made too early, before the end of the voting.
  tooEarly('TooEarly', 6),

  /// There can only be a maximum of `MaxProposals` active proposals.
  tooManyProposals('TooManyProposals', 7),

  /// The given weight bound for the proposal was too low.
  wrongProposalWeight('WrongProposalWeight', 8),

  /// The given length bound for the proposal was too low.
  wrongProposalLength('WrongProposalLength', 9);

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
        return Error.notMember;
      case 1:
        return Error.duplicateProposal;
      case 2:
        return Error.proposalMissing;
      case 3:
        return Error.wrongIndex;
      case 4:
        return Error.duplicateVote;
      case 5:
        return Error.alreadyInitialized;
      case 6:
        return Error.tooEarly;
      case 7:
        return Error.tooManyProposals;
      case 8:
        return Error.wrongProposalWeight;
      case 9:
        return Error.wrongProposalLength;
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
