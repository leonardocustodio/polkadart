// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The desired destination was unreachable, generally because there is a no way of routing
  /// to it.
  unreachable('Unreachable', 0),

  /// There was some other issue (i.e. not to do with routing) in sending the message.
  /// Perhaps a lack of space for buffering the message.
  sendFailure('SendFailure', 1),

  /// The message execution fails the filter.
  filtered('Filtered', 2),

  /// The message's weight could not be determined.
  unweighableMessage('UnweighableMessage', 3),

  /// The destination `Location` provided cannot be inverted.
  destinationNotInvertible('DestinationNotInvertible', 4),

  /// The assets to be sent are empty.
  empty('Empty', 5),

  /// Could not re-anchor the assets to declare the fees for the destination chain.
  cannotReanchor('CannotReanchor', 6),

  /// Too many assets have been attempted for transfer.
  tooManyAssets('TooManyAssets', 7),

  /// Origin is invalid for sending.
  invalidOrigin('InvalidOrigin', 8),

  /// The version of the `Versioned` value used is not able to be interpreted.
  badVersion('BadVersion', 9),

  /// The given location could not be used (e.g. because it cannot be expressed in the
  /// desired version of XCM).
  badLocation('BadLocation', 10),

  /// The referenced subscription could not be found.
  noSubscription('NoSubscription', 11),

  /// The location is invalid since it already has a subscription from us.
  alreadySubscribed('AlreadySubscribed', 12),

  /// Could not check-out the assets for teleportation to the destination chain.
  cannotCheckOutTeleport('CannotCheckOutTeleport', 13),

  /// The owner does not own (all) of the asset that they wish to do the operation on.
  lowBalance('LowBalance', 14),

  /// The asset owner has too many locks on the asset.
  tooManyLocks('TooManyLocks', 15),

  /// The given account is not an identifiable sovereign account for any location.
  accountNotSovereign('AccountNotSovereign', 16),

  /// The operation required fees to be paid which the initiator could not meet.
  feesNotMet('FeesNotMet', 17),

  /// A remote lock with the corresponding data could not be found.
  lockNotFound('LockNotFound', 18),

  /// The unlock operation cannot succeed because there are still consumers of the lock.
  inUse('InUse', 19),

  /// Invalid asset, reserve chain could not be determined for it.
  invalidAssetUnknownReserve('InvalidAssetUnknownReserve', 21),

  /// Invalid asset, do not support remote asset reserves with different fees reserves.
  invalidAssetUnsupportedReserve('InvalidAssetUnsupportedReserve', 22),

  /// Too many assets with different reserve locations have been attempted for transfer.
  tooManyReserves('TooManyReserves', 23),

  /// Local XCM execution incomplete.
  localExecutionIncomplete('LocalExecutionIncomplete', 24);

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
        return Error.unreachable;
      case 1:
        return Error.sendFailure;
      case 2:
        return Error.filtered;
      case 3:
        return Error.unweighableMessage;
      case 4:
        return Error.destinationNotInvertible;
      case 5:
        return Error.empty;
      case 6:
        return Error.cannotReanchor;
      case 7:
        return Error.tooManyAssets;
      case 8:
        return Error.invalidOrigin;
      case 9:
        return Error.badVersion;
      case 10:
        return Error.badLocation;
      case 11:
        return Error.noSubscription;
      case 12:
        return Error.alreadySubscribed;
      case 13:
        return Error.cannotCheckOutTeleport;
      case 14:
        return Error.lowBalance;
      case 15:
        return Error.tooManyLocks;
      case 16:
        return Error.accountNotSovereign;
      case 17:
        return Error.feesNotMet;
      case 18:
        return Error.lockNotFound;
      case 19:
        return Error.inUse;
      case 21:
        return Error.invalidAssetUnknownReserve;
      case 22:
        return Error.invalidAssetUnsupportedReserve;
      case 23:
        return Error.tooManyReserves;
      case 24:
        return Error.localExecutionIncomplete;
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
