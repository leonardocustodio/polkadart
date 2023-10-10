// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/dispatch_error.dart' as _i4;
import '../../tuples_1.dart' as _i3;

/// Events type.
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

  Scheduled scheduled({
    required int when,
    required int index,
  }) {
    return Scheduled(
      when: when,
      index: index,
    );
  }

  Canceled canceled({
    required int when,
    required int index,
  }) {
    return Canceled(
      when: when,
      index: index,
    );
  }

  Dispatched dispatched({
    required _i3.Tuple2<int, int> task,
    List<int>? id,
    required _i1.Result<dynamic, _i4.DispatchError> result,
  }) {
    return Dispatched(
      task: task,
      id: id,
      result: result,
    );
  }

  CallUnavailable callUnavailable({
    required _i3.Tuple2<int, int> task,
    List<int>? id,
  }) {
    return CallUnavailable(
      task: task,
      id: id,
    );
  }

  PeriodicFailed periodicFailed({
    required _i3.Tuple2<int, int> task,
    List<int>? id,
  }) {
    return PeriodicFailed(
      task: task,
      id: id,
    );
  }

  PermanentlyOverweight permanentlyOverweight({
    required _i3.Tuple2<int, int> task,
    List<int>? id,
  }) {
    return PermanentlyOverweight(
      task: task,
      id: id,
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
        return Scheduled._decode(input);
      case 1:
        return Canceled._decode(input);
      case 2:
        return Dispatched._decode(input);
      case 3:
        return CallUnavailable._decode(input);
      case 4:
        return PeriodicFailed._decode(input);
      case 5:
        return PermanentlyOverweight._decode(input);
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
      case Scheduled:
        (value as Scheduled).encodeTo(output);
        break;
      case Canceled:
        (value as Canceled).encodeTo(output);
        break;
      case Dispatched:
        (value as Dispatched).encodeTo(output);
        break;
      case CallUnavailable:
        (value as CallUnavailable).encodeTo(output);
        break;
      case PeriodicFailed:
        (value as PeriodicFailed).encodeTo(output);
        break;
      case PermanentlyOverweight:
        (value as PermanentlyOverweight).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Scheduled:
        return (value as Scheduled)._sizeHint();
      case Canceled:
        return (value as Canceled)._sizeHint();
      case Dispatched:
        return (value as Dispatched)._sizeHint();
      case CallUnavailable:
        return (value as CallUnavailable)._sizeHint();
      case PeriodicFailed:
        return (value as PeriodicFailed)._sizeHint();
      case PermanentlyOverweight:
        return (value as PermanentlyOverweight)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Scheduled some task.
class Scheduled extends Event {
  const Scheduled({
    required this.when,
    required this.index,
  });

  factory Scheduled._decode(_i1.Input input) {
    return Scheduled(
      when: _i1.U32Codec.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::BlockNumber
  final int when;

  /// u32
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Scheduled': {
          'when': when,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(when);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      when,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Scheduled && other.when == when && other.index == index;

  @override
  int get hashCode => Object.hash(
        when,
        index,
      );
}

/// Canceled some task.
class Canceled extends Event {
  const Canceled({
    required this.when,
    required this.index,
  });

  factory Canceled._decode(_i1.Input input) {
    return Canceled(
      when: _i1.U32Codec.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::BlockNumber
  final int when;

  /// u32
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Canceled': {
          'when': when,
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(when);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      when,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Canceled && other.when == when && other.index == index;

  @override
  int get hashCode => Object.hash(
        when,
        index,
      );
}

/// Dispatched some task.
class Dispatched extends Event {
  const Dispatched({
    required this.task,
    this.id,
    required this.result,
  });

  factory Dispatched._decode(_i1.Input input) {
    return Dispatched(
      task: const _i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      ).decode(input),
      id: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
      result: const _i1.ResultCodec<dynamic, _i4.DispatchError>(
        _i1.NullCodec.codec,
        _i4.DispatchError.codec,
      ).decode(input),
    );
  }

  /// TaskAddress<T::BlockNumber>
  final _i3.Tuple2<int, int> task;

  /// Option<TaskName>
  final List<int>? id;

  /// DispatchResult
  final _i1.Result<dynamic, _i4.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Dispatched': {
          'task': [
            task.value0,
            task.value1,
          ],
          'id': id?.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        ).sizeHint(task);
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(id);
    size = size +
        const _i1.ResultCodec<dynamic, _i4.DispatchError>(
          _i1.NullCodec.codec,
          _i4.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
      task,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      id,
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
      other is Dispatched &&
          other.task == task &&
          other.id == id &&
          other.result == result;

  @override
  int get hashCode => Object.hash(
        task,
        id,
        result,
      );
}

/// The call for the provided hash was not found so the task has been aborted.
class CallUnavailable extends Event {
  const CallUnavailable({
    required this.task,
    this.id,
  });

  factory CallUnavailable._decode(_i1.Input input) {
    return CallUnavailable(
      task: const _i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      ).decode(input),
      id: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  /// TaskAddress<T::BlockNumber>
  final _i3.Tuple2<int, int> task;

  /// Option<TaskName>
  final List<int>? id;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'CallUnavailable': {
          'task': [
            task.value0,
            task.value1,
          ],
          'id': id?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        ).sizeHint(task);
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
      task,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CallUnavailable && other.task == task && other.id == id;

  @override
  int get hashCode => Object.hash(
        task,
        id,
      );
}

/// The given task was unable to be renewed since the agenda is full at that block.
class PeriodicFailed extends Event {
  const PeriodicFailed({
    required this.task,
    this.id,
  });

  factory PeriodicFailed._decode(_i1.Input input) {
    return PeriodicFailed(
      task: const _i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      ).decode(input),
      id: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  /// TaskAddress<T::BlockNumber>
  final _i3.Tuple2<int, int> task;

  /// Option<TaskName>
  final List<int>? id;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'PeriodicFailed': {
          'task': [
            task.value0,
            task.value1,
          ],
          'id': id?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        ).sizeHint(task);
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
      task,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PeriodicFailed && other.task == task && other.id == id;

  @override
  int get hashCode => Object.hash(
        task,
        id,
      );
}

/// The given task can never be executed since it is overweight.
class PermanentlyOverweight extends Event {
  const PermanentlyOverweight({
    required this.task,
    this.id,
  });

  factory PermanentlyOverweight._decode(_i1.Input input) {
    return PermanentlyOverweight(
      task: const _i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      ).decode(input),
      id: const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).decode(input),
    );
  }

  /// TaskAddress<T::BlockNumber>
  final _i3.Tuple2<int, int> task;

  /// Option<TaskName>
  final List<int>? id;

  @override
  Map<String, Map<String, List<int>?>> toJson() => {
        'PermanentlyOverweight': {
          'task': [
            task.value0,
            task.value1,
          ],
          'id': id?.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        ).sizeHint(task);
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    ).encodeTo(
      task,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8ArrayCodec(32)).encodeTo(
      id,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PermanentlyOverweight && other.task == task && other.id == id;

  @override
  int get hashCode => Object.hash(
        task,
        id,
      );
}
