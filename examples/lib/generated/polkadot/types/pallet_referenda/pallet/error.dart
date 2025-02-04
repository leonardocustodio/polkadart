// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Referendum is not ongoing.
  notOngoing('NotOngoing', 0),

  /// Referendum's decision deposit is already paid.
  hasDeposit('HasDeposit', 1),

  /// The track identifier given was invalid.
  badTrack('BadTrack', 2),

  /// There are already a full complement of referenda in progress for this track.
  full('Full', 3),

  /// The queue of the track is empty.
  queueEmpty('QueueEmpty', 4),

  /// The referendum index provided is invalid in this context.
  badReferendum('BadReferendum', 5),

  /// There was nothing to do in the advancement.
  nothingToDo('NothingToDo', 6),

  /// No track exists for the proposal origin.
  noTrack('NoTrack', 7),

  /// Any deposit cannot be refunded until after the decision is over.
  unfinished('Unfinished', 8),

  /// The deposit refunder is not the depositor.
  noPermission('NoPermission', 9),

  /// The deposit cannot be refunded since none was made.
  noDeposit('NoDeposit', 10),

  /// The referendum status is invalid for this operation.
  badStatus('BadStatus', 11),

  /// The preimage does not exist.
  preimageNotExist('PreimageNotExist', 12),

  /// The preimage is stored with a different length than the one provided.
  preimageStoredWithDifferentLength('PreimageStoredWithDifferentLength', 13);

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
        return Error.notOngoing;
      case 1:
        return Error.hasDeposit;
      case 2:
        return Error.badTrack;
      case 3:
        return Error.full;
      case 4:
        return Error.queueEmpty;
      case 5:
        return Error.badReferendum;
      case 6:
        return Error.nothingToDo;
      case 7:
        return Error.noTrack;
      case 8:
        return Error.unfinished;
      case 9:
        return Error.noPermission;
      case 10:
        return Error.noDeposit;
      case 11:
        return Error.badStatus;
      case 12:
        return Error.preimageNotExist;
      case 13:
        return Error.preimageStoredWithDifferentLength;
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
