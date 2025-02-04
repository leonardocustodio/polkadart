// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../sp_npos_elections/election_score.dart' as _i5;
import '../election_compute.dart' as _i3;
import '../phase.dart' as _i6;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  SolutionStored solutionStored({
    required _i3.ElectionCompute compute,
    _i4.AccountId32? origin,
    required bool prevEjected,
  }) {
    return SolutionStored(
      compute: compute,
      origin: origin,
      prevEjected: prevEjected,
    );
  }

  ElectionFinalized electionFinalized({
    required _i3.ElectionCompute compute,
    required _i5.ElectionScore score,
  }) {
    return ElectionFinalized(
      compute: compute,
      score: score,
    );
  }

  ElectionFailed electionFailed() {
    return ElectionFailed();
  }

  Rewarded rewarded({
    required _i4.AccountId32 account,
    required BigInt value,
  }) {
    return Rewarded(
      account: account,
      value: value,
    );
  }

  Slashed slashed({
    required _i4.AccountId32 account,
    required BigInt value,
  }) {
    return Slashed(
      account: account,
      value: value,
    );
  }

  PhaseTransitioned phaseTransitioned({
    required _i6.Phase from,
    required _i6.Phase to,
    required int round,
  }) {
    return PhaseTransitioned(
      from: from,
      to: to,
      round: round,
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
        return SolutionStored._decode(input);
      case 1:
        return ElectionFinalized._decode(input);
      case 2:
        return const ElectionFailed();
      case 3:
        return Rewarded._decode(input);
      case 4:
        return Slashed._decode(input);
      case 5:
        return PhaseTransitioned._decode(input);
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
      case SolutionStored:
        (value as SolutionStored).encodeTo(output);
        break;
      case ElectionFinalized:
        (value as ElectionFinalized).encodeTo(output);
        break;
      case ElectionFailed:
        (value as ElectionFailed).encodeTo(output);
        break;
      case Rewarded:
        (value as Rewarded).encodeTo(output);
        break;
      case Slashed:
        (value as Slashed).encodeTo(output);
        break;
      case PhaseTransitioned:
        (value as PhaseTransitioned).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case SolutionStored:
        return (value as SolutionStored)._sizeHint();
      case ElectionFinalized:
        return (value as ElectionFinalized)._sizeHint();
      case ElectionFailed:
        return 1;
      case Rewarded:
        return (value as Rewarded)._sizeHint();
      case Slashed:
        return (value as Slashed)._sizeHint();
      case PhaseTransitioned:
        return (value as PhaseTransitioned)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A solution was stored with the given compute.
///
/// The `origin` indicates the origin of the solution. If `origin` is `Some(AccountId)`,
/// the stored solution was submitted in the signed phase by a miner with the `AccountId`.
/// Otherwise, the solution was stored either during the unsigned phase or by
/// `T::ForceOrigin`. The `bool` is `true` when a previous solution was ejected to make
/// room for this one.
class SolutionStored extends Event {
  const SolutionStored({
    required this.compute,
    this.origin,
    required this.prevEjected,
  });

  factory SolutionStored._decode(_i1.Input input) {
    return SolutionStored(
      compute: _i3.ElectionCompute.codec.decode(input),
      origin: const _i1.OptionCodec<_i4.AccountId32>(_i4.AccountId32Codec())
          .decode(input),
      prevEjected: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// ElectionCompute
  final _i3.ElectionCompute compute;

  /// Option<T::AccountId>
  final _i4.AccountId32? origin;

  /// bool
  final bool prevEjected;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SolutionStored': {
          'compute': compute.toJson(),
          'origin': origin?.toList(),
          'prevEjected': prevEjected,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ElectionCompute.codec.sizeHint(compute);
    size = size +
        const _i1.OptionCodec<_i4.AccountId32>(_i4.AccountId32Codec())
            .sizeHint(origin);
    size = size + _i1.BoolCodec.codec.sizeHint(prevEjected);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i3.ElectionCompute.codec.encodeTo(
      compute,
      output,
    );
    const _i1.OptionCodec<_i4.AccountId32>(_i4.AccountId32Codec()).encodeTo(
      origin,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      prevEjected,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SolutionStored &&
          other.compute == compute &&
          other.origin == origin &&
          other.prevEjected == prevEjected;

  @override
  int get hashCode => Object.hash(
        compute,
        origin,
        prevEjected,
      );
}

/// The election has been finalized, with the given computation and score.
class ElectionFinalized extends Event {
  const ElectionFinalized({
    required this.compute,
    required this.score,
  });

  factory ElectionFinalized._decode(_i1.Input input) {
    return ElectionFinalized(
      compute: _i3.ElectionCompute.codec.decode(input),
      score: _i5.ElectionScore.codec.decode(input),
    );
  }

  /// ElectionCompute
  final _i3.ElectionCompute compute;

  /// ElectionScore
  final _i5.ElectionScore score;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ElectionFinalized': {
          'compute': compute.toJson(),
          'score': score.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.ElectionCompute.codec.sizeHint(compute);
    size = size + _i5.ElectionScore.codec.sizeHint(score);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.ElectionCompute.codec.encodeTo(
      compute,
      output,
    );
    _i5.ElectionScore.codec.encodeTo(
      score,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ElectionFinalized &&
          other.compute == compute &&
          other.score == score;

  @override
  int get hashCode => Object.hash(
        compute,
        score,
      );
}

/// An election failed.
///
/// Not much can be said about which computes failed in the process.
class ElectionFailed extends Event {
  const ElectionFailed();

  @override
  Map<String, dynamic> toJson() => {'ElectionFailed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ElectionFailed;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// An account has been rewarded for their signed submission being finalized.
class Rewarded extends Event {
  const Rewarded({
    required this.account,
    required this.value,
  });

  factory Rewarded._decode(_i1.Input input) {
    return Rewarded(
      account: const _i1.U8ArrayCodec(32).decode(input),
      value: _i1.U128Codec.codec.decode(input),
    );
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 account;

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Rewarded': {
          'account': account.toList(),
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(account);
    size = size + _i1.U128Codec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rewarded &&
          _i7.listsEqual(
            other.account,
            account,
          ) &&
          other.value == value;

  @override
  int get hashCode => Object.hash(
        account,
        value,
      );
}

/// An account has been slashed for submitting an invalid signed submission.
class Slashed extends Event {
  const Slashed({
    required this.account,
    required this.value,
  });

  factory Slashed._decode(_i1.Input input) {
    return Slashed(
      account: const _i1.U8ArrayCodec(32).decode(input),
      value: _i1.U128Codec.codec.decode(input),
    );
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 account;

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Slashed': {
          'account': account.toList(),
          'value': value,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(account);
    size = size + _i1.U128Codec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Slashed &&
          _i7.listsEqual(
            other.account,
            account,
          ) &&
          other.value == value;

  @override
  int get hashCode => Object.hash(
        account,
        value,
      );
}

/// There was a phase transition in a given round.
class PhaseTransitioned extends Event {
  const PhaseTransitioned({
    required this.from,
    required this.to,
    required this.round,
  });

  factory PhaseTransitioned._decode(_i1.Input input) {
    return PhaseTransitioned(
      from: _i6.Phase.codec.decode(input),
      to: _i6.Phase.codec.decode(input),
      round: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Phase<BlockNumberFor<T>>
  final _i6.Phase from;

  /// Phase<BlockNumberFor<T>>
  final _i6.Phase to;

  /// u32
  final int round;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PhaseTransitioned': {
          'from': from.toJson(),
          'to': to.toJson(),
          'round': round,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i6.Phase.codec.sizeHint(from);
    size = size + _i6.Phase.codec.sizeHint(to);
    size = size + _i1.U32Codec.codec.sizeHint(round);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i6.Phase.codec.encodeTo(
      from,
      output,
    );
    _i6.Phase.codec.encodeTo(
      to,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      round,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PhaseTransitioned &&
          other.from == from &&
          other.to == to &&
          other.round == round;

  @override
  int get hashCode => Object.hash(
        from,
        to,
        round,
      );
}
