// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Threshold must be 2 or greater.
  minimumThreshold('MinimumThreshold', 0),

  /// Call is already approved by this signatory.
  alreadyApproved('AlreadyApproved', 1),

  /// Call doesn't need any (more) approvals.
  noApprovalsNeeded('NoApprovalsNeeded', 2),

  /// There are too few signatories in the list.
  tooFewSignatories('TooFewSignatories', 3),

  /// There are too many signatories in the list.
  tooManySignatories('TooManySignatories', 4),

  /// The signatories were provided out of order; they should be ordered.
  signatoriesOutOfOrder('SignatoriesOutOfOrder', 5),

  /// The sender was contained in the other signatories; it shouldn't be.
  senderInSignatories('SenderInSignatories', 6),

  /// Multisig operation not found when attempting to cancel.
  notFound('NotFound', 7),

  /// Only the account that originally created the multisig is able to cancel it.
  notOwner('NotOwner', 8),

  /// No timepoint was given, yet the multisig operation is already underway.
  noTimepoint('NoTimepoint', 9),

  /// A different timepoint was given to the multisig operation that is underway.
  wrongTimepoint('WrongTimepoint', 10),

  /// A timepoint was given, yet no multisig operation is underway.
  unexpectedTimepoint('UnexpectedTimepoint', 11),

  /// The maximum weight information provided was too low.
  maxWeightTooLow('MaxWeightTooLow', 12),

  /// The data to be stored is already stored.
  alreadyStored('AlreadyStored', 13);

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
        return Error.minimumThreshold;
      case 1:
        return Error.alreadyApproved;
      case 2:
        return Error.noApprovalsNeeded;
      case 3:
        return Error.tooFewSignatories;
      case 4:
        return Error.tooManySignatories;
      case 5:
        return Error.signatoriesOutOfOrder;
      case 6:
        return Error.senderInSignatories;
      case 7:
        return Error.notFound;
      case 8:
        return Error.notOwner;
      case 9:
        return Error.noTimepoint;
      case 10:
        return Error.wrongTimepoint;
      case 11:
        return Error.unexpectedTimepoint;
      case 12:
        return Error.maxWeightTooLow;
      case 13:
        return Error.alreadyStored;
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
