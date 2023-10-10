// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../sp_core/crypto/account_id32.dart' as _i3;
import '../ethereum_address.dart' as _i4;

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

  Claimed claimed({
    required _i3.AccountId32 who,
    required _i4.EthereumAddress ethereumAddress,
    required BigInt amount,
  }) {
    return Claimed(
      who: who,
      ethereumAddress: ethereumAddress,
      amount: amount,
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
        return Claimed._decode(input);
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
      case Claimed:
        (value as Claimed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Claimed:
        return (value as Claimed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Someone claimed some DOTs.
class Claimed extends Event {
  const Claimed({
    required this.who,
    required this.ethereumAddress,
    required this.amount,
  });

  factory Claimed._decode(_i1.Input input) {
    return Claimed(
      who: const _i1.U8ArrayCodec(32).decode(input),
      ethereumAddress: const _i1.U8ArrayCodec(20).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// EthereumAddress
  final _i4.EthereumAddress ethereumAddress;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Claimed': {
          'who': who.toList(),
          'ethereumAddress': ethereumAddress.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + const _i4.EthereumAddressCodec().sizeHint(ethereumAddress);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    const _i1.U8ArrayCodec(20).encodeTo(
      ethereumAddress,
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
      other is Claimed &&
          _i5.listsEqual(
            other.who,
            who,
          ) &&
          _i5.listsEqual(
            other.ethereumAddress,
            ethereumAddress,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        ethereumAddress,
        amount,
      );
}
