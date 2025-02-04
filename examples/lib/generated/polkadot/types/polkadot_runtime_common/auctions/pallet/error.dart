// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// This auction is already in progress.
  auctionInProgress('AuctionInProgress', 0),

  /// The lease period is in the past.
  leasePeriodInPast('LeasePeriodInPast', 1),

  /// Para is not registered
  paraNotRegistered('ParaNotRegistered', 2),

  /// Not a current auction.
  notCurrentAuction('NotCurrentAuction', 3),

  /// Not an auction.
  notAuction('NotAuction', 4),

  /// Auction has already ended.
  auctionEnded('AuctionEnded', 5),

  /// The para is already leased out for part of this range.
  alreadyLeasedOut('AlreadyLeasedOut', 6);

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
        return Error.auctionInProgress;
      case 1:
        return Error.leasePeriodInPast;
      case 2:
        return Error.paraNotRegistered;
      case 3:
        return Error.notCurrentAuction;
      case 4:
        return Error.notAuction;
      case 5:
        return Error.auctionEnded;
      case 6:
        return Error.alreadyLeasedOut;
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
