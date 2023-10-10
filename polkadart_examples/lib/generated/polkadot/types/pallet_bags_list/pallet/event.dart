// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  Rebagged rebagged({
    required _i3.AccountId32 who,
    required BigInt from,
    required BigInt to,
  }) {
    return Rebagged(
      who: who,
      from: from,
      to: to,
    );
  }

  ScoreUpdated scoreUpdated({
    required _i3.AccountId32 who,
    required BigInt newScore,
  }) {
    return ScoreUpdated(
      who: who,
      newScore: newScore,
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
        return Rebagged._decode(input);
      case 1:
        return ScoreUpdated._decode(input);
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
      case Rebagged:
        (value as Rebagged).encodeTo(output);
        break;
      case ScoreUpdated:
        (value as ScoreUpdated).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Rebagged:
        return (value as Rebagged)._sizeHint();
      case ScoreUpdated:
        return (value as ScoreUpdated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Moved an account from one bag to another.
class Rebagged extends Event {
  const Rebagged({
    required this.who,
    required this.from,
    required this.to,
  });

  factory Rebagged._decode(_i1.Input input) {
    return Rebagged(
      who: const _i1.U8ArrayCodec(32).decode(input),
      from: _i1.U64Codec.codec.decode(input),
      to: _i1.U64Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::Score
  final BigInt from;

  /// T::Score
  final BigInt to;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Rebagged': {
          'who': who.toList(),
          'from': from,
          'to': to,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U64Codec.codec.sizeHint(from);
    size = size + _i1.U64Codec.codec.sizeHint(to);
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
    _i1.U64Codec.codec.encodeTo(
      from,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      to,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rebagged &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.from == from &&
          other.to == to;

  @override
  int get hashCode => Object.hash(
        who,
        from,
        to,
      );
}

/// Updated the score of some account to the given amount.
class ScoreUpdated extends Event {
  const ScoreUpdated({
    required this.who,
    required this.newScore,
  });

  factory ScoreUpdated._decode(_i1.Input input) {
    return ScoreUpdated(
      who: const _i1.U8ArrayCodec(32).decode(input),
      newScore: _i1.U64Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// T::Score
  final BigInt newScore;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ScoreUpdated': {
          'who': who.toList(),
          'newScore': newScore,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U64Codec.codec.sizeHint(newScore);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U64Codec.codec.encodeTo(
      newScore,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScoreUpdated &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.newScore == newScore;

  @override
  int get hashCode => Object.hash(
        who,
        newScore,
      );
}
