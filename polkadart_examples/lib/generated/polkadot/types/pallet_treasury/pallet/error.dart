// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Error for the treasury pallet.
enum Error {
  /// Proposer's balance is too low.
  insufficientProposersBalance('InsufficientProposersBalance', 0),

  /// No proposal or bounty at that index.
  invalidIndex('InvalidIndex', 1),

  /// Too many approvals in the queue.
  tooManyApprovals('TooManyApprovals', 2),

  /// The spend origin is valid but the amount it is allowed to spend is lower than the
  /// amount to be spent.
  insufficientPermission('InsufficientPermission', 3),

  /// Proposal has not been approved.
  proposalNotApproved('ProposalNotApproved', 4);

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
        return Error.insufficientProposersBalance;
      case 1:
        return Error.invalidIndex;
      case 2:
        return Error.tooManyApprovals;
      case 3:
        return Error.insufficientPermission;
      case 4:
        return Error.proposalNotApproved;
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
