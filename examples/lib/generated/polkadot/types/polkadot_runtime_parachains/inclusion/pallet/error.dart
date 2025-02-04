// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Validator index out of bounds.
  validatorIndexOutOfBounds('ValidatorIndexOutOfBounds', 0),

  /// Candidate submitted but para not scheduled.
  unscheduledCandidate('UnscheduledCandidate', 1),

  /// Head data exceeds the configured maximum.
  headDataTooLarge('HeadDataTooLarge', 2),

  /// Code upgrade prematurely.
  prematureCodeUpgrade('PrematureCodeUpgrade', 3),

  /// Output code is too large
  newCodeTooLarge('NewCodeTooLarge', 4),

  /// The candidate's relay-parent was not allowed. Either it was
  /// not recent enough or it didn't advance based on the last parachain block.
  disallowedRelayParent('DisallowedRelayParent', 5),

  /// Failed to compute group index for the core: either it's out of bounds
  /// or the relay parent doesn't belong to the current session.
  invalidAssignment('InvalidAssignment', 6),

  /// Invalid group index in core assignment.
  invalidGroupIndex('InvalidGroupIndex', 7),

  /// Insufficient (non-majority) backing.
  insufficientBacking('InsufficientBacking', 8),

  /// Invalid (bad signature, unknown validator, etc.) backing.
  invalidBacking('InvalidBacking', 9),

  /// Collator did not sign PoV.
  notCollatorSigned('NotCollatorSigned', 10),

  /// The validation data hash does not match expected.
  validationDataHashMismatch('ValidationDataHashMismatch', 11),

  /// The downward message queue is not processed correctly.
  incorrectDownwardMessageHandling('IncorrectDownwardMessageHandling', 12),

  /// At least one upward message sent does not pass the acceptance criteria.
  invalidUpwardMessages('InvalidUpwardMessages', 13),

  /// The candidate didn't follow the rules of HRMP watermark advancement.
  hrmpWatermarkMishandling('HrmpWatermarkMishandling', 14),

  /// The HRMP messages sent by the candidate is not valid.
  invalidOutboundHrmp('InvalidOutboundHrmp', 15),

  /// The validation code hash of the candidate is not valid.
  invalidValidationCodeHash('InvalidValidationCodeHash', 16),

  /// The `para_head` hash in the candidate descriptor doesn't match the hash of the actual
  /// para head in the commitments.
  paraHeadMismatch('ParaHeadMismatch', 17);

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
        return Error.validatorIndexOutOfBounds;
      case 1:
        return Error.unscheduledCandidate;
      case 2:
        return Error.headDataTooLarge;
      case 3:
        return Error.prematureCodeUpgrade;
      case 4:
        return Error.newCodeTooLarge;
      case 5:
        return Error.disallowedRelayParent;
      case 6:
        return Error.invalidAssignment;
      case 7:
        return Error.invalidGroupIndex;
      case 8:
        return Error.insufficientBacking;
      case 9:
        return Error.invalidBacking;
      case 10:
        return Error.notCollatorSigned;
      case 11:
        return Error.validationDataHashMismatch;
      case 12:
        return Error.incorrectDownwardMessageHandling;
      case 13:
        return Error.invalidUpwardMessages;
      case 14:
        return Error.hrmpWatermarkMishandling;
      case 15:
        return Error.invalidOutboundHrmp;
      case 16:
        return Error.invalidValidationCodeHash;
      case 17:
        return Error.paraHeadMismatch;
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
