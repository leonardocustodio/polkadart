// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Not a controller account.
  notController('NotController', 0),

  /// Not a stash account.
  notStash('NotStash', 1),

  /// Stash is already bonded.
  alreadyBonded('AlreadyBonded', 2),

  /// Controller is already paired.
  alreadyPaired('AlreadyPaired', 3),

  /// Targets cannot be empty.
  emptyTargets('EmptyTargets', 4),

  /// Duplicate index.
  duplicateIndex('DuplicateIndex', 5),

  /// Slash record index out of bounds.
  invalidSlashIndex('InvalidSlashIndex', 6),

  /// Cannot have a validator or nominator role, with value less than the minimum defined by
  /// governance (see `MinValidatorBond` and `MinNominatorBond`). If unbonding is the
  /// intention, `chill` first to remove one's role as validator/nominator.
  insufficientBond('InsufficientBond', 7),

  /// Can not schedule more unlock chunks.
  noMoreChunks('NoMoreChunks', 8),

  /// Can not rebond without unlocking chunks.
  noUnlockChunk('NoUnlockChunk', 9),

  /// Attempting to target a stash that still has funds.
  fundedTarget('FundedTarget', 10),

  /// Invalid era to reward.
  invalidEraToReward('InvalidEraToReward', 11),

  /// Invalid number of nominations.
  invalidNumberOfNominations('InvalidNumberOfNominations', 12),

  /// Items are not sorted and unique.
  notSortedAndUnique('NotSortedAndUnique', 13),

  /// Rewards for this era have already been claimed for this validator.
  alreadyClaimed('AlreadyClaimed', 14),

  /// No nominators exist on this page.
  invalidPage('InvalidPage', 15),

  /// Incorrect previous history depth input provided.
  incorrectHistoryDepth('IncorrectHistoryDepth', 16),

  /// Incorrect number of slashing spans provided.
  incorrectSlashingSpans('IncorrectSlashingSpans', 17),

  /// Internal state has become somehow corrupted and the operation cannot continue.
  badState('BadState', 18),

  /// Too many nomination targets supplied.
  tooManyTargets('TooManyTargets', 19),

  /// A nomination target was supplied that was blocked or otherwise not a validator.
  badTarget('BadTarget', 20),

  /// The user has enough bond and thus cannot be chilled forcefully by an external person.
  cannotChillOther('CannotChillOther', 21),

  /// There are too many nominators in the system. Governance needs to adjust the staking
  /// settings to keep things safe for the runtime.
  tooManyNominators('TooManyNominators', 22),

  /// There are too many validator candidates in the system. Governance needs to adjust the
  /// staking settings to keep things safe for the runtime.
  tooManyValidators('TooManyValidators', 23),

  /// Commission is too low. Must be at least `MinCommission`.
  commissionTooLow('CommissionTooLow', 24),

  /// Some bound is not met.
  boundNotMet('BoundNotMet', 25),

  /// Used when attempting to use deprecated controller account logic.
  controllerDeprecated('ControllerDeprecated', 26),

  /// Cannot reset a ledger.
  cannotRestoreLedger('CannotRestoreLedger', 27),

  /// Provided reward destination is not allowed.
  rewardDestinationRestricted('RewardDestinationRestricted', 28),

  /// Not enough funds available to withdraw.
  notEnoughFunds('NotEnoughFunds', 29),

  /// Operation not allowed for virtual stakers.
  virtualStakerNotAllowed('VirtualStakerNotAllowed', 30);

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
        return Error.notController;
      case 1:
        return Error.notStash;
      case 2:
        return Error.alreadyBonded;
      case 3:
        return Error.alreadyPaired;
      case 4:
        return Error.emptyTargets;
      case 5:
        return Error.duplicateIndex;
      case 6:
        return Error.invalidSlashIndex;
      case 7:
        return Error.insufficientBond;
      case 8:
        return Error.noMoreChunks;
      case 9:
        return Error.noUnlockChunk;
      case 10:
        return Error.fundedTarget;
      case 11:
        return Error.invalidEraToReward;
      case 12:
        return Error.invalidNumberOfNominations;
      case 13:
        return Error.notSortedAndUnique;
      case 14:
        return Error.alreadyClaimed;
      case 15:
        return Error.invalidPage;
      case 16:
        return Error.incorrectHistoryDepth;
      case 17:
        return Error.incorrectSlashingSpans;
      case 18:
        return Error.badState;
      case 19:
        return Error.tooManyTargets;
      case 20:
        return Error.badTarget;
      case 21:
        return Error.cannotChillOther;
      case 22:
        return Error.tooManyNominators;
      case 23:
        return Error.tooManyValidators;
      case 24:
        return Error.commissionTooLow;
      case 25:
        return Error.boundNotMet;
      case 26:
        return Error.controllerDeprecated;
      case 27:
        return Error.cannotRestoreLedger;
      case 28:
        return Error.rewardDestinationRestricted;
      case 29:
        return Error.notEnoughFunds;
      case 30:
        return Error.virtualStakerNotAllowed;
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
