// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  NewAuction newAuction({
    required BigInt duration,
    required BigInt leasePeriodIndex,
  }) {
    return NewAuction(
      duration: duration,
      leasePeriodIndex: leasePeriodIndex,
    );
  }

  Bid bid({
    required BigInt para,
    required BigInt auctionIndex,
    required BigInt firstSlot,
    required BigInt lastSlot,
    required BigInt amount,
  }) {
    return Bid(
      para: para,
      auctionIndex: auctionIndex,
      firstSlot: firstSlot,
      lastSlot: lastSlot,
      amount: amount,
    );
  }

  CancelAuction cancelAuction() {
    return CancelAuction();
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NewAuction._decode(input);
      case 1:
        return Bid._decode(input);
      case 2:
        return const CancelAuction();
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NewAuction:
        (value as NewAuction).encodeTo(output);
        break;
      case Bid:
        (value as Bid).encodeTo(output);
        break;
      case CancelAuction:
        (value as CancelAuction).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case NewAuction:
        return (value as NewAuction)._sizeHint();
      case Bid:
        return (value as Bid)._sizeHint();
      case CancelAuction:
        return 1;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Create a new auction.
///
/// This can only happen when there isn't already an auction in progress and may only be
/// called by the root origin. Accepts the `duration` of this auction and the
/// `lease_period_index` of the initial lease period of the four that are to be auctioned.
class NewAuction extends Call {
  const NewAuction({
    required this.duration,
    required this.leasePeriodIndex,
  });

  factory NewAuction._decode(_i1.Input input) {
    return NewAuction(
      duration: _i1.CompactBigIntCodec.codec.decode(input),
      leasePeriodIndex: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::BlockNumber
  final BigInt duration;

  /// LeasePeriodOf<T>
  final BigInt leasePeriodIndex;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'new_auction': {
          'duration': duration,
          'leasePeriodIndex': leasePeriodIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(duration);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(leasePeriodIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      duration,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      leasePeriodIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewAuction &&
          other.duration == duration &&
          other.leasePeriodIndex == leasePeriodIndex;

  @override
  int get hashCode => Object.hash(
        duration,
        leasePeriodIndex,
      );
}

/// Make a new bid from an account (including a parachain account) for deploying a new
/// parachain.
///
/// Multiple simultaneous bids from the same bidder are allowed only as long as all active
/// bids overlap each other (i.e. are mutually exclusive). Bids cannot be redacted.
///
/// - `sub` is the sub-bidder ID, allowing for multiple competing bids to be made by (and
/// funded by) the same account.
/// - `auction_index` is the index of the auction to bid on. Should just be the present
/// value of `AuctionCounter`.
/// - `first_slot` is the first lease period index of the range to bid on. This is the
/// absolute lease period index value, not an auction-specific offset.
/// - `last_slot` is the last lease period index of the range to bid on. This is the
/// absolute lease period index value, not an auction-specific offset.
/// - `amount` is the amount to bid to be held as deposit for the parachain should the
/// bid win. This amount is held throughout the range.
class Bid extends Call {
  const Bid({
    required this.para,
    required this.auctionIndex,
    required this.firstSlot,
    required this.lastSlot,
    required this.amount,
  });

  factory Bid._decode(_i1.Input input) {
    return Bid(
      para: _i1.CompactBigIntCodec.codec.decode(input),
      auctionIndex: _i1.CompactBigIntCodec.codec.decode(input),
      firstSlot: _i1.CompactBigIntCodec.codec.decode(input),
      lastSlot: _i1.CompactBigIntCodec.codec.decode(input),
      amount: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// ParaId
  final BigInt para;

  /// AuctionIndex
  final BigInt auctionIndex;

  /// LeasePeriodOf<T>
  final BigInt firstSlot;

  /// LeasePeriodOf<T>
  final BigInt lastSlot;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'bid': {
          'para': para,
          'auctionIndex': auctionIndex,
          'firstSlot': firstSlot,
          'lastSlot': lastSlot,
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(para);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(auctionIndex);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(firstSlot);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(lastSlot);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      para,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      auctionIndex,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      firstSlot,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      lastSlot,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Bid &&
          other.para == para &&
          other.auctionIndex == auctionIndex &&
          other.firstSlot == firstSlot &&
          other.lastSlot == lastSlot &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        para,
        auctionIndex,
        firstSlot,
        lastSlot,
        amount,
      );
}

/// Cancel an in-progress auction.
///
/// Can only be called by Root origin.
class CancelAuction extends Call {
  const CancelAuction();

  @override
  Map<String, dynamic> toJson() => {'cancel_auction': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CancelAuction;

  @override
  int get hashCode => runtimeType.hashCode;
}
