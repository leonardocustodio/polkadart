// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h256.dart' as _i3;
import '../../sp_core/crypto/account_id32.dart' as _i4;

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

  NewTip newTip({required _i3.H256 tipHash}) {
    return NewTip(tipHash: tipHash);
  }

  TipClosing tipClosing({required _i3.H256 tipHash}) {
    return TipClosing(tipHash: tipHash);
  }

  TipClosed tipClosed({
    required _i3.H256 tipHash,
    required _i4.AccountId32 who,
    required BigInt payout,
  }) {
    return TipClosed(
      tipHash: tipHash,
      who: who,
      payout: payout,
    );
  }

  TipRetracted tipRetracted({required _i3.H256 tipHash}) {
    return TipRetracted(tipHash: tipHash);
  }

  TipSlashed tipSlashed({
    required _i3.H256 tipHash,
    required _i4.AccountId32 finder,
    required BigInt deposit,
  }) {
    return TipSlashed(
      tipHash: tipHash,
      finder: finder,
      deposit: deposit,
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
        return NewTip._decode(input);
      case 1:
        return TipClosing._decode(input);
      case 2:
        return TipClosed._decode(input);
      case 3:
        return TipRetracted._decode(input);
      case 4:
        return TipSlashed._decode(input);
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
      case NewTip:
        (value as NewTip).encodeTo(output);
        break;
      case TipClosing:
        (value as TipClosing).encodeTo(output);
        break;
      case TipClosed:
        (value as TipClosed).encodeTo(output);
        break;
      case TipRetracted:
        (value as TipRetracted).encodeTo(output);
        break;
      case TipSlashed:
        (value as TipSlashed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewTip:
        return (value as NewTip)._sizeHint();
      case TipClosing:
        return (value as TipClosing)._sizeHint();
      case TipClosed:
        return (value as TipClosed)._sizeHint();
      case TipRetracted:
        return (value as TipRetracted)._sizeHint();
      case TipSlashed:
        return (value as TipSlashed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new tip suggestion has been opened.
class NewTip extends Event {
  const NewTip({required this.tipHash});

  factory NewTip._decode(_i1.Input input) {
    return NewTip(tipHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 tipHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'NewTip': {'tipHash': tipHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(tipHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      tipHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewTip &&
          _i5.listsEqual(
            other.tipHash,
            tipHash,
          );

  @override
  int get hashCode => tipHash.hashCode;
}

/// A tip suggestion has reached threshold and is closing.
class TipClosing extends Event {
  const TipClosing({required this.tipHash});

  factory TipClosing._decode(_i1.Input input) {
    return TipClosing(tipHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 tipHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'TipClosing': {'tipHash': tipHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(tipHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      tipHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipClosing &&
          _i5.listsEqual(
            other.tipHash,
            tipHash,
          );

  @override
  int get hashCode => tipHash.hashCode;
}

/// A tip suggestion has been closed.
class TipClosed extends Event {
  const TipClosed({
    required this.tipHash,
    required this.who,
    required this.payout,
  });

  factory TipClosed._decode(_i1.Input input) {
    return TipClosed(
      tipHash: const _i1.U8ArrayCodec(32).decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      payout: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::Hash
  final _i3.H256 tipHash;

  /// T::AccountId
  final _i4.AccountId32 who;

  /// BalanceOf<T, I>
  final BigInt payout;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TipClosed': {
          'tipHash': tipHash.toList(),
          'who': who.toList(),
          'payout': payout,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(tipHash);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(payout);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      tipHash,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      payout,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipClosed &&
          _i5.listsEqual(
            other.tipHash,
            tipHash,
          ) &&
          _i5.listsEqual(
            other.who,
            who,
          ) &&
          other.payout == payout;

  @override
  int get hashCode => Object.hash(
        tipHash,
        who,
        payout,
      );
}

/// A tip suggestion has been retracted.
class TipRetracted extends Event {
  const TipRetracted({required this.tipHash});

  factory TipRetracted._decode(_i1.Input input) {
    return TipRetracted(tipHash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i3.H256 tipHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'TipRetracted': {'tipHash': tipHash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(tipHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      tipHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipRetracted &&
          _i5.listsEqual(
            other.tipHash,
            tipHash,
          );

  @override
  int get hashCode => tipHash.hashCode;
}

/// A tip suggestion has been slashed.
class TipSlashed extends Event {
  const TipSlashed({
    required this.tipHash,
    required this.finder,
    required this.deposit,
  });

  factory TipSlashed._decode(_i1.Input input) {
    return TipSlashed(
      tipHash: const _i1.U8ArrayCodec(32).decode(input),
      finder: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::Hash
  final _i3.H256 tipHash;

  /// T::AccountId
  final _i4.AccountId32 finder;

  /// BalanceOf<T, I>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TipSlashed': {
          'tipHash': tipHash.toList(),
          'finder': finder.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.H256Codec().sizeHint(tipHash);
    size = size + const _i4.AccountId32Codec().sizeHint(finder);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      tipHash,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      finder,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipSlashed &&
          _i5.listsEqual(
            other.tipHash,
            tipHash,
          ) &&
          _i5.listsEqual(
            other.finder,
            finder,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        tipHash,
        finder,
        deposit,
      );
}
