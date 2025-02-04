// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

/// The `Event` enum of this pallet
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

  VestingUpdated vestingUpdated({
    required _i3.AccountId32 account,
    required BigInt unvested,
  }) {
    return VestingUpdated(
      account: account,
      unvested: unvested,
    );
  }

  VestingCompleted vestingCompleted({required _i3.AccountId32 account}) {
    return VestingCompleted(account: account);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return VestingUpdated._decode(input);
      case 1:
        return VestingCompleted._decode(input);
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
      case VestingUpdated:
        (value as VestingUpdated).encodeTo(output);
        break;
      case VestingCompleted:
        (value as VestingCompleted).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case VestingUpdated:
        return (value as VestingUpdated)._sizeHint();
      case VestingCompleted:
        return (value as VestingCompleted)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The amount vested has been updated. This could indicate a change in funds available.
/// The balance given is the amount which is left unvested (and thus locked).
class VestingUpdated extends Event {
  const VestingUpdated({
    required this.account,
    required this.unvested,
  });

  factory VestingUpdated._decode(_i1.Input input) {
    return VestingUpdated(
      account: const _i1.U8ArrayCodec(32).decode(input),
      unvested: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 account;

  /// BalanceOf<T>
  final BigInt unvested;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'VestingUpdated': {
          'account': account.toList(),
          'unvested': unvested,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(account);
    size = size + _i1.U128Codec.codec.sizeHint(unvested);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      unvested,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VestingUpdated &&
          _i4.listsEqual(
            other.account,
            account,
          ) &&
          other.unvested == unvested;

  @override
  int get hashCode => Object.hash(
        account,
        unvested,
      );
}

/// An \[account\] has become fully vested.
class VestingCompleted extends Event {
  const VestingCompleted({required this.account});

  factory VestingCompleted._decode(_i1.Input input) {
    return VestingCompleted(account: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 account;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'VestingCompleted': {'account': account.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(account);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VestingCompleted &&
          _i4.listsEqual(
            other.account,
            account,
          );

  @override
  int get hashCode => account.hashCode;
}
