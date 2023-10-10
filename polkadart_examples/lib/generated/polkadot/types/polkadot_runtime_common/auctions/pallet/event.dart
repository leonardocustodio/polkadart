// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../polkadot_parachain/primitives/id.dart' as _i4;
import '../../../sp_core/crypto/account_id32.dart' as _i3;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  AuctionStarted auctionStarted({
    required int auctionIndex,
    required int leasePeriod,
    required int ending,
  }) {
    return AuctionStarted(
      auctionIndex: auctionIndex,
      leasePeriod: leasePeriod,
      ending: ending,
    );
  }

  AuctionClosed auctionClosed({required int auctionIndex}) {
    return AuctionClosed(auctionIndex: auctionIndex);
  }

  Reserved reserved({
    required _i3.AccountId32 bidder,
    required BigInt extraReserved,
    required BigInt totalAmount,
  }) {
    return Reserved(
      bidder: bidder,
      extraReserved: extraReserved,
      totalAmount: totalAmount,
    );
  }

  Unreserved unreserved({
    required _i3.AccountId32 bidder,
    required BigInt amount,
  }) {
    return Unreserved(
      bidder: bidder,
      amount: amount,
    );
  }

  ReserveConfiscated reserveConfiscated({
    required _i4.Id paraId,
    required _i3.AccountId32 leaser,
    required BigInt amount,
  }) {
    return ReserveConfiscated(
      paraId: paraId,
      leaser: leaser,
      amount: amount,
    );
  }

  BidAccepted bidAccepted({
    required _i3.AccountId32 bidder,
    required _i4.Id paraId,
    required BigInt amount,
    required int firstSlot,
    required int lastSlot,
  }) {
    return BidAccepted(
      bidder: bidder,
      paraId: paraId,
      amount: amount,
      firstSlot: firstSlot,
      lastSlot: lastSlot,
    );
  }

  WinningOffset winningOffset({
    required int auctionIndex,
    required int blockNumber,
  }) {
    return WinningOffset(
      auctionIndex: auctionIndex,
      blockNumber: blockNumber,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AuctionStarted._decode(input);
      case 1:
        return AuctionClosed._decode(input);
      case 2:
        return Reserved._decode(input);
      case 3:
        return Unreserved._decode(input);
      case 4:
        return ReserveConfiscated._decode(input);
      case 5:
        return BidAccepted._decode(input);
      case 6:
        return WinningOffset._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case AuctionStarted:
        (value as AuctionStarted).encodeTo(output);
        break;
      case AuctionClosed:
        (value as AuctionClosed).encodeTo(output);
        break;
      case Reserved:
        (value as Reserved).encodeTo(output);
        break;
      case Unreserved:
        (value as Unreserved).encodeTo(output);
        break;
      case ReserveConfiscated:
        (value as ReserveConfiscated).encodeTo(output);
        break;
      case BidAccepted:
        (value as BidAccepted).encodeTo(output);
        break;
      case WinningOffset:
        (value as WinningOffset).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case AuctionStarted:
        return (value as AuctionStarted)._sizeHint();
      case AuctionClosed:
        return (value as AuctionClosed)._sizeHint();
      case Reserved:
        return (value as Reserved)._sizeHint();
      case Unreserved:
        return (value as Unreserved)._sizeHint();
      case ReserveConfiscated:
        return (value as ReserveConfiscated)._sizeHint();
      case BidAccepted:
        return (value as BidAccepted)._sizeHint();
      case WinningOffset:
        return (value as WinningOffset)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// An auction started. Provides its index and the block number where it will begin to
/// close and the first lease period of the quadruplet that is auctioned.
class AuctionStarted extends Event {
  const AuctionStarted({
    required this.auctionIndex,
    required this.leasePeriod,
    required this.ending,
  });

  factory AuctionStarted._decode(_i1.Input input) {
    return AuctionStarted(
      auctionIndex: _i1.U32Codec.codec.decode(input),
      leasePeriod: _i1.U32Codec.codec.decode(input),
      ending: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AuctionIndex
  final int auctionIndex;

  /// LeasePeriodOf<T>
  final int leasePeriod;

  /// T::BlockNumber
  final int ending;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AuctionStarted': {
          'auctionIndex': auctionIndex,
          'leasePeriod': leasePeriod,
          'ending': ending,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(auctionIndex);
    size = size + _i1.U32Codec.codec.sizeHint(leasePeriod);
    size = size + _i1.U32Codec.codec.sizeHint(ending);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      auctionIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      leasePeriod,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      ending,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AuctionStarted &&
          other.auctionIndex == auctionIndex &&
          other.leasePeriod == leasePeriod &&
          other.ending == ending;

  @override
  int get hashCode => Object.hash(
        auctionIndex,
        leasePeriod,
        ending,
      );
}

/// An auction ended. All funds become unreserved.
class AuctionClosed extends Event {
  const AuctionClosed({required this.auctionIndex});

  factory AuctionClosed._decode(_i1.Input input) {
    return AuctionClosed(auctionIndex: _i1.U32Codec.codec.decode(input));
  }

  /// AuctionIndex
  final int auctionIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AuctionClosed': {'auctionIndex': auctionIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(auctionIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      auctionIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AuctionClosed && other.auctionIndex == auctionIndex;

  @override
  int get hashCode => auctionIndex.hashCode;
}

/// Funds were reserved for a winning bid. First balance is the extra amount reserved.
/// Second is the total.
class Reserved extends Event {
  const Reserved({
    required this.bidder,
    required this.extraReserved,
    required this.totalAmount,
  });

  factory Reserved._decode(_i1.Input input) {
    return Reserved(
      bidder: const _i1.U8ArrayCodec(32).decode(input),
      extraReserved: _i1.U128Codec.codec.decode(input),
      totalAmount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 bidder;

  /// BalanceOf<T>
  final BigInt extraReserved;

  /// BalanceOf<T>
  final BigInt totalAmount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Reserved': {
          'bidder': bidder.toList(),
          'extraReserved': extraReserved,
          'totalAmount': totalAmount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(bidder);
    size = size + _i1.U128Codec.codec.sizeHint(extraReserved);
    size = size + _i1.U128Codec.codec.sizeHint(totalAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      bidder,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      extraReserved,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      totalAmount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Reserved &&
          _i5.listsEqual(
            other.bidder,
            bidder,
          ) &&
          other.extraReserved == extraReserved &&
          other.totalAmount == totalAmount;

  @override
  int get hashCode => Object.hash(
        bidder,
        extraReserved,
        totalAmount,
      );
}

/// Funds were unreserved since bidder is no longer active. `[bidder, amount]`
class Unreserved extends Event {
  const Unreserved({
    required this.bidder,
    required this.amount,
  });

  factory Unreserved._decode(_i1.Input input) {
    return Unreserved(
      bidder: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 bidder;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Unreserved': {
          'bidder': bidder.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(bidder);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      bidder,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is Unreserved &&
          _i5.listsEqual(
            other.bidder,
            bidder,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        bidder,
        amount,
      );
}

/// Someone attempted to lease the same slot twice for a parachain. The amount is held in reserve
/// but no parachain slot has been leased.
class ReserveConfiscated extends Event {
  const ReserveConfiscated({
    required this.paraId,
    required this.leaser,
    required this.amount,
  });

  factory ReserveConfiscated._decode(_i1.Input input) {
    return ReserveConfiscated(
      paraId: _i1.U32Codec.codec.decode(input),
      leaser: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i4.Id paraId;

  /// T::AccountId
  final _i3.AccountId32 leaser;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ReserveConfiscated': {
          'paraId': paraId,
          'leaser': leaser.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.IdCodec().sizeHint(paraId);
    size = size + const _i3.AccountId32Codec().sizeHint(leaser);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      leaser,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is ReserveConfiscated &&
          other.paraId == paraId &&
          _i5.listsEqual(
            other.leaser,
            leaser,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        paraId,
        leaser,
        amount,
      );
}

/// A new bid has been accepted as the current winner.
class BidAccepted extends Event {
  const BidAccepted({
    required this.bidder,
    required this.paraId,
    required this.amount,
    required this.firstSlot,
    required this.lastSlot,
  });

  factory BidAccepted._decode(_i1.Input input) {
    return BidAccepted(
      bidder: const _i1.U8ArrayCodec(32).decode(input),
      paraId: _i1.U32Codec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      firstSlot: _i1.U32Codec.codec.decode(input),
      lastSlot: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 bidder;

  /// ParaId
  final _i4.Id paraId;

  /// BalanceOf<T>
  final BigInt amount;

  /// LeasePeriodOf<T>
  final int firstSlot;

  /// LeasePeriodOf<T>
  final int lastSlot;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'BidAccepted': {
          'bidder': bidder.toList(),
          'paraId': paraId,
          'amount': amount,
          'firstSlot': firstSlot,
          'lastSlot': lastSlot,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(bidder);
    size = size + const _i4.IdCodec().sizeHint(paraId);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size + _i1.U32Codec.codec.sizeHint(firstSlot);
    size = size + _i1.U32Codec.codec.sizeHint(lastSlot);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      bidder,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      firstSlot,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      lastSlot,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BidAccepted &&
          _i5.listsEqual(
            other.bidder,
            bidder,
          ) &&
          other.paraId == paraId &&
          other.amount == amount &&
          other.firstSlot == firstSlot &&
          other.lastSlot == lastSlot;

  @override
  int get hashCode => Object.hash(
        bidder,
        paraId,
        amount,
        firstSlot,
        lastSlot,
      );
}

/// The winning offset was chosen for an auction. This will map into the `Winning` storage map.
class WinningOffset extends Event {
  const WinningOffset({
    required this.auctionIndex,
    required this.blockNumber,
  });

  factory WinningOffset._decode(_i1.Input input) {
    return WinningOffset(
      auctionIndex: _i1.U32Codec.codec.decode(input),
      blockNumber: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AuctionIndex
  final int auctionIndex;

  /// T::BlockNumber
  final int blockNumber;

  @override
  Map<String, Map<String, int>> toJson() => {
        'WinningOffset': {
          'auctionIndex': auctionIndex,
          'blockNumber': blockNumber,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(auctionIndex);
    size = size + _i1.U32Codec.codec.sizeHint(blockNumber);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      auctionIndex,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      blockNumber,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WinningOffset &&
          other.auctionIndex == auctionIndex &&
          other.blockNumber == blockNumber;

  @override
  int get hashCode => Object.hash(
        auctionIndex,
        blockNumber,
      );
}
