// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../sp_runtime/dispatch_error.dart' as _i4;

/// The events of this pallet.
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

  Unstaked unstaked({
    required _i3.AccountId32 stash,
    required _i1.Result<dynamic, _i4.DispatchError> result,
  }) {
    return Unstaked(
      stash: stash,
      result: result,
    );
  }

  Slashed slashed({
    required _i3.AccountId32 stash,
    required BigInt amount,
  }) {
    return Slashed(
      stash: stash,
      amount: amount,
    );
  }

  InternalError internalError() {
    return InternalError();
  }

  BatchChecked batchChecked({required List<int> eras}) {
    return BatchChecked(eras: eras);
  }

  BatchFinished batchFinished({required int size}) {
    return BatchFinished(size: size);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Unstaked._decode(input);
      case 1:
        return Slashed._decode(input);
      case 2:
        return const InternalError();
      case 3:
        return BatchChecked._decode(input);
      case 4:
        return BatchFinished._decode(input);
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
      case Unstaked:
        (value as Unstaked).encodeTo(output);
        break;
      case Slashed:
        (value as Slashed).encodeTo(output);
        break;
      case InternalError:
        (value as InternalError).encodeTo(output);
        break;
      case BatchChecked:
        (value as BatchChecked).encodeTo(output);
        break;
      case BatchFinished:
        (value as BatchFinished).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Unstaked:
        return (value as Unstaked)._sizeHint();
      case Slashed:
        return (value as Slashed)._sizeHint();
      case InternalError:
        return 1;
      case BatchChecked:
        return (value as BatchChecked)._sizeHint();
      case BatchFinished:
        return (value as BatchFinished)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A staker was unstaked.
class Unstaked extends Event {
  const Unstaked({
    required this.stash,
    required this.result,
  });

  factory Unstaked._decode(_i1.Input input) {
    return Unstaked(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      result: const _i1.ResultCodec<dynamic, _i4.DispatchError>(
        _i1.NullCodec.codec,
        _i4.DispatchError.codec,
      ).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// DispatchResult
  final _i1.Result<dynamic, _i4.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Unstaked': {
          'stash': stash.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size +
        const _i1.ResultCodec<dynamic, _i4.DispatchError>(
          _i1.NullCodec.codec,
          _i4.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
    const _i1.ResultCodec<dynamic, _i4.DispatchError>(
      _i1.NullCodec.codec,
      _i4.DispatchError.codec,
    ).encodeTo(
      result,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unstaked &&
          _i5.listsEqual(
            other.stash,
            stash,
          ) &&
          other.result == result;

  @override
  int get hashCode => Object.hash(
        stash,
        result,
      );
}

/// A staker was slashed for requesting fast-unstake whilst being exposed.
class Slashed extends Event {
  const Slashed({
    required this.stash,
    required this.amount,
  });

  factory Slashed._decode(_i1.Input input) {
    return Slashed(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Slashed': {
          'stash': stash.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
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
      other is Slashed &&
          _i5.listsEqual(
            other.stash,
            stash,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        stash,
        amount,
      );
}

/// An internal error happened. Operations will be paused now.
class InternalError extends Event {
  const InternalError();

  @override
  Map<String, dynamic> toJson() => {'InternalError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InternalError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A batch was partially checked for the given eras, but the process did not finish.
class BatchChecked extends Event {
  const BatchChecked({required this.eras});

  factory BatchChecked._decode(_i1.Input input) {
    return BatchChecked(eras: _i1.U32SequenceCodec.codec.decode(input));
  }

  /// Vec<EraIndex>
  final List<int> eras;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'BatchChecked': {'eras': eras}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32SequenceCodec.codec.sizeHint(eras);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      eras,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BatchChecked &&
          _i5.listsEqual(
            other.eras,
            eras,
          );

  @override
  int get hashCode => eras.hashCode;
}

/// A batch of a given size was terminated.
///
/// This is always follows by a number of `Unstaked` or `Slashed` events, marking the end
/// of the batch. A new batch will be created upon next block.
class BatchFinished extends Event {
  const BatchFinished({required this.size});

  factory BatchFinished._decode(_i1.Input input) {
    return BatchFinished(size: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int size;

  @override
  Map<String, Map<String, int>> toJson() => {
        'BatchFinished': {'size': size}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(this.size);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      size,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BatchFinished && other.size == size;

  @override
  int get hashCode => size.hashCode;
}
