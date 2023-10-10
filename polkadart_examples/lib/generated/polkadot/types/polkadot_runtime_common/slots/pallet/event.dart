// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../polkadot_parachain/primitives/id.dart' as _i3;
import '../../../sp_core/crypto/account_id32.dart' as _i4;

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

  NewLeasePeriod newLeasePeriod({required int leasePeriod}) {
    return NewLeasePeriod(leasePeriod: leasePeriod);
  }

  Leased leased({
    required _i3.Id paraId,
    required _i4.AccountId32 leaser,
    required int periodBegin,
    required int periodCount,
    required BigInt extraReserved,
    required BigInt totalAmount,
  }) {
    return Leased(
      paraId: paraId,
      leaser: leaser,
      periodBegin: periodBegin,
      periodCount: periodCount,
      extraReserved: extraReserved,
      totalAmount: totalAmount,
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
        return NewLeasePeriod._decode(input);
      case 1:
        return Leased._decode(input);
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
      case NewLeasePeriod:
        (value as NewLeasePeriod).encodeTo(output);
        break;
      case Leased:
        (value as Leased).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewLeasePeriod:
        return (value as NewLeasePeriod)._sizeHint();
      case Leased:
        return (value as Leased)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new `[lease_period]` is beginning.
class NewLeasePeriod extends Event {
  const NewLeasePeriod({required this.leasePeriod});

  factory NewLeasePeriod._decode(_i1.Input input) {
    return NewLeasePeriod(leasePeriod: _i1.U32Codec.codec.decode(input));
  }

  /// LeasePeriodOf<T>
  final int leasePeriod;

  @override
  Map<String, Map<String, int>> toJson() => {
        'NewLeasePeriod': {'leasePeriod': leasePeriod}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(leasePeriod);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      leasePeriod,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewLeasePeriod && other.leasePeriod == leasePeriod;

  @override
  int get hashCode => leasePeriod.hashCode;
}

/// A para has won the right to a continuous set of lease periods as a parachain.
/// First balance is any extra amount reserved on top of the para's existing deposit.
/// Second balance is the total amount reserved.
class Leased extends Event {
  const Leased({
    required this.paraId,
    required this.leaser,
    required this.periodBegin,
    required this.periodCount,
    required this.extraReserved,
    required this.totalAmount,
  });

  factory Leased._decode(_i1.Input input) {
    return Leased(
      paraId: _i1.U32Codec.codec.decode(input),
      leaser: const _i1.U8ArrayCodec(32).decode(input),
      periodBegin: _i1.U32Codec.codec.decode(input),
      periodCount: _i1.U32Codec.codec.decode(input),
      extraReserved: _i1.U128Codec.codec.decode(input),
      totalAmount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// T::AccountId
  final _i4.AccountId32 leaser;

  /// LeasePeriodOf<T>
  final int periodBegin;

  /// LeasePeriodOf<T>
  final int periodCount;

  /// BalanceOf<T>
  final BigInt extraReserved;

  /// BalanceOf<T>
  final BigInt totalAmount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Leased': {
          'paraId': paraId,
          'leaser': leaser.toList(),
          'periodBegin': periodBegin,
          'periodCount': periodCount,
          'extraReserved': extraReserved,
          'totalAmount': totalAmount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + const _i4.AccountId32Codec().sizeHint(leaser);
    size = size + _i1.U32Codec.codec.sizeHint(periodBegin);
    size = size + _i1.U32Codec.codec.sizeHint(periodCount);
    size = size + _i1.U128Codec.codec.sizeHint(extraReserved);
    size = size + _i1.U128Codec.codec.sizeHint(totalAmount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
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
    _i1.U32Codec.codec.encodeTo(
      periodBegin,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      periodCount,
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
      other is Leased &&
          other.paraId == paraId &&
          _i5.listsEqual(
            other.leaser,
            leaser,
          ) &&
          other.periodBegin == periodBegin &&
          other.periodCount == periodCount &&
          other.extraReserved == extraReserved &&
          other.totalAmount == totalAmount;

  @override
  int get hashCode => Object.hash(
        paraId,
        leaser,
        periodBegin,
        periodCount,
        extraReserved,
        totalAmount,
      );
}
