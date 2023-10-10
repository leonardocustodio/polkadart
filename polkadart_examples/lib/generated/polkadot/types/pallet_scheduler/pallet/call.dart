// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../polkadot_runtime/runtime_call.dart' as _i4;
import '../../tuples_1.dart' as _i3;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  Schedule schedule({
    required int when,
    _i3.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i4.RuntimeCall call,
  }) {
    return Schedule(
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
  }

  Cancel cancel({
    required int when,
    required int index,
  }) {
    return Cancel(
      when: when,
      index: index,
    );
  }

  ScheduleNamed scheduleNamed({
    required List<int> id,
    required int when,
    _i3.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i4.RuntimeCall call,
  }) {
    return ScheduleNamed(
      id: id,
      when: when,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
  }

  CancelNamed cancelNamed({required List<int> id}) {
    return CancelNamed(id: id);
  }

  ScheduleAfter scheduleAfter({
    required int after,
    _i3.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i4.RuntimeCall call,
  }) {
    return ScheduleAfter(
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
  }

  ScheduleNamedAfter scheduleNamedAfter({
    required List<int> id,
    required int after,
    _i3.Tuple2<int, int>? maybePeriodic,
    required int priority,
    required _i4.RuntimeCall call,
  }) {
    return ScheduleNamedAfter(
      id: id,
      after: after,
      maybePeriodic: maybePeriodic,
      priority: priority,
      call: call,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Schedule._decode(input);
      case 1:
        return Cancel._decode(input);
      case 2:
        return ScheduleNamed._decode(input);
      case 3:
        return CancelNamed._decode(input);
      case 4:
        return ScheduleAfter._decode(input);
      case 5:
        return ScheduleNamedAfter._decode(input);
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
      case Schedule:
        (value as Schedule).encodeTo(output);
        break;
      case Cancel:
        (value as Cancel).encodeTo(output);
        break;
      case ScheduleNamed:
        (value as ScheduleNamed).encodeTo(output);
        break;
      case CancelNamed:
        (value as CancelNamed).encodeTo(output);
        break;
      case ScheduleAfter:
        (value as ScheduleAfter).encodeTo(output);
        break;
      case ScheduleNamedAfter:
        (value as ScheduleNamedAfter).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Schedule:
        return (value as Schedule)._sizeHint();
      case Cancel:
        return (value as Cancel)._sizeHint();
      case ScheduleNamed:
        return (value as ScheduleNamed)._sizeHint();
      case CancelNamed:
        return (value as CancelNamed)._sizeHint();
      case ScheduleAfter:
        return (value as ScheduleAfter)._sizeHint();
      case ScheduleNamedAfter:
        return (value as ScheduleNamedAfter)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Anonymously schedule a task.
class Schedule extends Call {
  const Schedule({
    required this.when,
    this.maybePeriodic,
    required this.priority,
    required this.call,
  });

  factory Schedule._decode(_i1.Input input) {
    return Schedule(
      when: _i1.U32Codec.codec.decode(input),
      maybePeriodic:
          const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      priority: _i1.U8Codec.codec.decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
    );
  }

  /// T::BlockNumber
  final int when;

  /// Option<schedule::Period<T::BlockNumber>>
  final _i3.Tuple2<int, int>? maybePeriodic;

  /// schedule::Priority
  final int priority;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'schedule': {
          'when': when,
          'maybePeriodic': [
            maybePeriodic?.value0,
            maybePeriodic?.value1,
          ],
          'priority': priority,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(when);
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(maybePeriodic);
    size = size + _i1.U8Codec.codec.sizeHint(priority);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
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
    const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      maybePeriodic,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      priority,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Schedule &&
          other.when == when &&
          other.maybePeriodic == maybePeriodic &&
          other.priority == priority &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        when,
        maybePeriodic,
        priority,
        call,
      );
}

/// Cancel an anonymously scheduled task.
class Cancel extends Call {
  const Cancel({
    required this.when,
    required this.index,
  });

  factory Cancel._decode(_i1.Input input) {
    return Cancel(
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
        'cancel': {
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
      other is Cancel && other.when == when && other.index == index;

  @override
  int get hashCode => Object.hash(
        when,
        index,
      );
}

/// Schedule a named task.
class ScheduleNamed extends Call {
  const ScheduleNamed({
    required this.id,
    required this.when,
    this.maybePeriodic,
    required this.priority,
    required this.call,
  });

  factory ScheduleNamed._decode(_i1.Input input) {
    return ScheduleNamed(
      id: const _i1.U8ArrayCodec(32).decode(input),
      when: _i1.U32Codec.codec.decode(input),
      maybePeriodic:
          const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      priority: _i1.U8Codec.codec.decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
    );
  }

  /// TaskName
  final List<int> id;

  /// T::BlockNumber
  final int when;

  /// Option<schedule::Period<T::BlockNumber>>
  final _i3.Tuple2<int, int>? maybePeriodic;

  /// schedule::Priority
  final int priority;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'schedule_named': {
          'id': id.toList(),
          'when': when,
          'maybePeriodic': [
            maybePeriodic?.value0,
            maybePeriodic?.value1,
          ],
          'priority': priority,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(id);
    size = size + _i1.U32Codec.codec.sizeHint(when);
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(maybePeriodic);
    size = size + _i1.U8Codec.codec.sizeHint(priority);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      id,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      when,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      maybePeriodic,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      priority,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScheduleNamed &&
          _i5.listsEqual(
            other.id,
            id,
          ) &&
          other.when == when &&
          other.maybePeriodic == maybePeriodic &&
          other.priority == priority &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        id,
        when,
        maybePeriodic,
        priority,
        call,
      );
}

/// Cancel a named scheduled task.
class CancelNamed extends Call {
  const CancelNamed({required this.id});

  factory CancelNamed._decode(_i1.Input input) {
    return CancelNamed(id: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// TaskName
  final List<int> id;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'cancel_named': {'id': id.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(id);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is CancelNamed &&
          _i5.listsEqual(
            other.id,
            id,
          );

  @override
  int get hashCode => id.hashCode;
}

/// Anonymously schedule a task after a delay.
class ScheduleAfter extends Call {
  const ScheduleAfter({
    required this.after,
    this.maybePeriodic,
    required this.priority,
    required this.call,
  });

  factory ScheduleAfter._decode(_i1.Input input) {
    return ScheduleAfter(
      after: _i1.U32Codec.codec.decode(input),
      maybePeriodic:
          const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      priority: _i1.U8Codec.codec.decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
    );
  }

  /// T::BlockNumber
  final int after;

  /// Option<schedule::Period<T::BlockNumber>>
  final _i3.Tuple2<int, int>? maybePeriodic;

  /// schedule::Priority
  final int priority;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'schedule_after': {
          'after': after,
          'maybePeriodic': [
            maybePeriodic?.value0,
            maybePeriodic?.value1,
          ],
          'priority': priority,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(after);
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(maybePeriodic);
    size = size + _i1.U8Codec.codec.sizeHint(priority);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      after,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      maybePeriodic,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      priority,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScheduleAfter &&
          other.after == after &&
          other.maybePeriodic == maybePeriodic &&
          other.priority == priority &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        after,
        maybePeriodic,
        priority,
        call,
      );
}

/// Schedule a named task after a delay.
class ScheduleNamedAfter extends Call {
  const ScheduleNamedAfter({
    required this.id,
    required this.after,
    this.maybePeriodic,
    required this.priority,
    required this.call,
  });

  factory ScheduleNamedAfter._decode(_i1.Input input) {
    return ScheduleNamedAfter(
      id: const _i1.U8ArrayCodec(32).decode(input),
      after: _i1.U32Codec.codec.decode(input),
      maybePeriodic:
          const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
        _i1.U32Codec.codec,
        _i1.U32Codec.codec,
      )).decode(input),
      priority: _i1.U8Codec.codec.decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
    );
  }

  /// TaskName
  final List<int> id;

  /// T::BlockNumber
  final int after;

  /// Option<schedule::Period<T::BlockNumber>>
  final _i3.Tuple2<int, int>? maybePeriodic;

  /// schedule::Priority
  final int priority;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'schedule_named_after': {
          'id': id.toList(),
          'after': after,
          'maybePeriodic': [
            maybePeriodic?.value0,
            maybePeriodic?.value1,
          ],
          'priority': priority,
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i1.U8ArrayCodec(32).sizeHint(id);
    size = size + _i1.U32Codec.codec.sizeHint(after);
    size = size +
        const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
          _i1.U32Codec.codec,
          _i1.U32Codec.codec,
        )).sizeHint(maybePeriodic);
    size = size + _i1.U8Codec.codec.sizeHint(priority);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      id,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      after,
      output,
    );
    const _i1.OptionCodec<_i3.Tuple2<int, int>>(_i3.Tuple2Codec<int, int>(
      _i1.U32Codec.codec,
      _i1.U32Codec.codec,
    )).encodeTo(
      maybePeriodic,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      priority,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScheduleNamedAfter &&
          _i5.listsEqual(
            other.id,
            id,
          ) &&
          other.after == after &&
          other.maybePeriodic == maybePeriodic &&
          other.priority == priority &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        id,
        after,
        maybePeriodic,
        priority,
        call,
      );
}
