// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Error of the pallet that can be returned in response to dispatches.
enum Error {
  /// Submission was too early.
  preDispatchEarlySubmission('PreDispatchEarlySubmission', 0),

  /// Wrong number of winners presented.
  preDispatchWrongWinnerCount('PreDispatchWrongWinnerCount', 1),

  /// Submission was too weak, score-wise.
  preDispatchWeakSubmission('PreDispatchWeakSubmission', 2),

  /// The queue was full, and the solution was not better than any of the existing ones.
  signedQueueFull('SignedQueueFull', 3),

  /// The origin failed to pay the deposit.
  signedCannotPayDeposit('SignedCannotPayDeposit', 4),

  /// Witness data to dispatchable is invalid.
  signedInvalidWitness('SignedInvalidWitness', 5),

  /// The signed submission consumes too much weight
  signedTooMuchWeight('SignedTooMuchWeight', 6),

  /// OCW submitted solution for wrong round
  ocwCallWrongEra('OcwCallWrongEra', 7),

  /// Snapshot metadata should exist but didn't.
  missingSnapshotMetadata('MissingSnapshotMetadata', 8),

  /// `Self::insert_submission` returned an invalid index.
  invalidSubmissionIndex('InvalidSubmissionIndex', 9),

  /// The call is not allowed at this point.
  callNotAllowed('CallNotAllowed', 10),

  /// The fallback failed
  fallbackFailed('FallbackFailed', 11),

  /// Some bound not met
  boundNotMet('BoundNotMet', 12),

  /// Submitted solution has too many winners
  tooManyWinners('TooManyWinners', 13),

  /// Submission was prepared for a different round.
  preDispatchDifferentRound('PreDispatchDifferentRound', 14);

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
        return Error.preDispatchEarlySubmission;
      case 1:
        return Error.preDispatchWrongWinnerCount;
      case 2:
        return Error.preDispatchWeakSubmission;
      case 3:
        return Error.signedQueueFull;
      case 4:
        return Error.signedCannotPayDeposit;
      case 5:
        return Error.signedInvalidWitness;
      case 6:
        return Error.signedTooMuchWeight;
      case 7:
        return Error.ocwCallWrongEra;
      case 8:
        return Error.missingSnapshotMetadata;
      case 9:
        return Error.invalidSubmissionIndex;
      case 10:
        return Error.callNotAllowed;
      case 11:
        return Error.fallbackFailed;
      case 12:
        return Error.boundNotMet;
      case 13:
        return Error.tooManyWinners;
      case 14:
        return Error.preDispatchDifferentRound;
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
