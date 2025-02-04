// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Para is not registered in our system.
  notRegistered('NotRegistered', 0),

  /// Para cannot be onboarded because it is already tracked by our system.
  cannotOnboard('CannotOnboard', 1),

  /// Para cannot be offboarded at this time.
  cannotOffboard('CannotOffboard', 2),

  /// Para cannot be upgraded to a lease holding parachain.
  cannotUpgrade('CannotUpgrade', 3),

  /// Para cannot be downgraded to an on-demand parachain.
  cannotDowngrade('CannotDowngrade', 4),

  /// The statement for PVF pre-checking is stale.
  pvfCheckStatementStale('PvfCheckStatementStale', 5),

  /// The statement for PVF pre-checking is for a future session.
  pvfCheckStatementFuture('PvfCheckStatementFuture', 6),

  /// Claimed validator index is out of bounds.
  pvfCheckValidatorIndexOutOfBounds('PvfCheckValidatorIndexOutOfBounds', 7),

  /// The signature for the PVF pre-checking is invalid.
  pvfCheckInvalidSignature('PvfCheckInvalidSignature', 8),

  /// The given validator already has cast a vote.
  pvfCheckDoubleVote('PvfCheckDoubleVote', 9),

  /// The given PVF does not exist at the moment of process a vote.
  pvfCheckSubjectInvalid('PvfCheckSubjectInvalid', 10),

  /// Parachain cannot currently schedule a code upgrade.
  cannotUpgradeCode('CannotUpgradeCode', 11),

  /// Invalid validation code size.
  invalidCode('InvalidCode', 12);

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
        return Error.notRegistered;
      case 1:
        return Error.cannotOnboard;
      case 2:
        return Error.cannotOffboard;
      case 3:
        return Error.cannotUpgrade;
      case 4:
        return Error.cannotDowngrade;
      case 5:
        return Error.pvfCheckStatementStale;
      case 6:
        return Error.pvfCheckStatementFuture;
      case 7:
        return Error.pvfCheckValidatorIndexOutOfBounds;
      case 8:
        return Error.pvfCheckInvalidSignature;
      case 9:
        return Error.pvfCheckDoubleVote;
      case 10:
        return Error.pvfCheckSubjectInvalid;
      case 11:
        return Error.cannotUpgradeCode;
      case 12:
        return Error.invalidCode;
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
