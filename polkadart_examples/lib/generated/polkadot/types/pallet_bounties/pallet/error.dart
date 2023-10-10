// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Proposer's balance is too low.
  insufficientProposersBalance('InsufficientProposersBalance', 0),

  /// No proposal or bounty at that index.
  invalidIndex('InvalidIndex', 1),

  /// The reason given is just too big.
  reasonTooBig('ReasonTooBig', 2),

  /// The bounty status is unexpected.
  unexpectedStatus('UnexpectedStatus', 3),

  /// Require bounty curator.
  requireCurator('RequireCurator', 4),

  /// Invalid bounty value.
  invalidValue('InvalidValue', 5),

  /// Invalid bounty fee.
  invalidFee('InvalidFee', 6),

  /// A bounty payout is pending.
  /// To cancel the bounty, you must unassign and slash the curator.
  pendingPayout('PendingPayout', 7),

  /// The bounties cannot be claimed/closed because it's still in the countdown period.
  premature('Premature', 8),

  /// The bounty cannot be closed because it has active child bounties.
  hasActiveChildBounty('HasActiveChildBounty', 9),

  /// Too many approvals are already queued.
  tooManyQueued('TooManyQueued', 10);

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
        return Error.reasonTooBig;
      case 3:
        return Error.unexpectedStatus;
      case 4:
        return Error.requireCurator;
      case 5:
        return Error.invalidValue;
      case 6:
        return Error.invalidFee;
      case 7:
        return Error.pendingPayout;
      case 8:
        return Error.premature;
      case 9:
        return Error.hasActiveChildBounty;
      case 10:
        return Error.tooManyQueued;
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
