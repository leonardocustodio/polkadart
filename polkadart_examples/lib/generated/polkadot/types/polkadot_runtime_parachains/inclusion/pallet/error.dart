// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Validator indices are out of order or contains duplicates.
  unsortedOrDuplicateValidatorIndices('UnsortedOrDuplicateValidatorIndices', 0),

  /// Dispute statement sets are out of order or contain duplicates.
  unsortedOrDuplicateDisputeStatementSet(
      'UnsortedOrDuplicateDisputeStatementSet', 1),

  /// Backed candidates are out of order (core index) or contain duplicates.
  unsortedOrDuplicateBackedCandidates('UnsortedOrDuplicateBackedCandidates', 2),

  /// A different relay parent was provided compared to the on-chain stored one.
  unexpectedRelayParent('UnexpectedRelayParent', 3),

  /// Availability bitfield has unexpected size.
  wrongBitfieldSize('WrongBitfieldSize', 4),

  /// Bitfield consists of zeros only.
  bitfieldAllZeros('BitfieldAllZeros', 5),

  /// Multiple bitfields submitted by same validator or validators out of order by index.
  bitfieldDuplicateOrUnordered('BitfieldDuplicateOrUnordered', 6),

  /// Validator index out of bounds.
  validatorIndexOutOfBounds('ValidatorIndexOutOfBounds', 7),

  /// Invalid signature
  invalidBitfieldSignature('InvalidBitfieldSignature', 8),

  /// Candidate submitted but para not scheduled.
  unscheduledCandidate('UnscheduledCandidate', 9),

  /// Candidate scheduled despite pending candidate already existing for the para.
  candidateScheduledBeforeParaFree('CandidateScheduledBeforeParaFree', 10),

  /// Candidate included with the wrong collator.
  wrongCollator('WrongCollator', 11),

  /// Scheduled cores out of order.
  scheduledOutOfOrder('ScheduledOutOfOrder', 12),

  /// Head data exceeds the configured maximum.
  headDataTooLarge('HeadDataTooLarge', 13),

  /// Code upgrade prematurely.
  prematureCodeUpgrade('PrematureCodeUpgrade', 14),

  /// Output code is too large
  newCodeTooLarge('NewCodeTooLarge', 15),

  /// Candidate not in parent context.
  candidateNotInParentContext('CandidateNotInParentContext', 16),

  /// Invalid group index in core assignment.
  invalidGroupIndex('InvalidGroupIndex', 17),

  /// Insufficient (non-majority) backing.
  insufficientBacking('InsufficientBacking', 18),

  /// Invalid (bad signature, unknown validator, etc.) backing.
  invalidBacking('InvalidBacking', 19),

  /// Collator did not sign PoV.
  notCollatorSigned('NotCollatorSigned', 20),

  /// The validation data hash does not match expected.
  validationDataHashMismatch('ValidationDataHashMismatch', 21),

  /// The downward message queue is not processed correctly.
  incorrectDownwardMessageHandling('IncorrectDownwardMessageHandling', 22),

  /// At least one upward message sent does not pass the acceptance criteria.
  invalidUpwardMessages('InvalidUpwardMessages', 23),

  /// The candidate didn't follow the rules of HRMP watermark advancement.
  hrmpWatermarkMishandling('HrmpWatermarkMishandling', 24),

  /// The HRMP messages sent by the candidate is not valid.
  invalidOutboundHrmp('InvalidOutboundHrmp', 25),

  /// The validation code hash of the candidate is not valid.
  invalidValidationCodeHash('InvalidValidationCodeHash', 26),

  /// The `para_head` hash in the candidate descriptor doesn't match the hash of the actual para head in the
  /// commitments.
  paraHeadMismatch('ParaHeadMismatch', 27),

  /// A bitfield that references a freed core,
  /// either intentionally or as part of a concluded
  /// invalid dispute.
  bitfieldReferencesFreedCore('BitfieldReferencesFreedCore', 28);

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
        return Error.unsortedOrDuplicateValidatorIndices;
      case 1:
        return Error.unsortedOrDuplicateDisputeStatementSet;
      case 2:
        return Error.unsortedOrDuplicateBackedCandidates;
      case 3:
        return Error.unexpectedRelayParent;
      case 4:
        return Error.wrongBitfieldSize;
      case 5:
        return Error.bitfieldAllZeros;
      case 6:
        return Error.bitfieldDuplicateOrUnordered;
      case 7:
        return Error.validatorIndexOutOfBounds;
      case 8:
        return Error.invalidBitfieldSignature;
      case 9:
        return Error.unscheduledCandidate;
      case 10:
        return Error.candidateScheduledBeforeParaFree;
      case 11:
        return Error.wrongCollator;
      case 12:
        return Error.scheduledOutOfOrder;
      case 13:
        return Error.headDataTooLarge;
      case 14:
        return Error.prematureCodeUpgrade;
      case 15:
        return Error.newCodeTooLarge;
      case 16:
        return Error.candidateNotInParentContext;
      case 17:
        return Error.invalidGroupIndex;
      case 18:
        return Error.insufficientBacking;
      case 19:
        return Error.invalidBacking;
      case 20:
        return Error.notCollatorSigned;
      case 21:
        return Error.validationDataHashMismatch;
      case 22:
        return Error.incorrectDownwardMessageHandling;
      case 23:
        return Error.invalidUpwardMessages;
      case 24:
        return Error.hrmpWatermarkMishandling;
      case 25:
        return Error.invalidOutboundHrmp;
      case 26:
        return Error.invalidValidationCodeHash;
      case 27:
        return Error.paraHeadMismatch;
      case 28:
        return Error.bitfieldReferencesFreedCore;
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
