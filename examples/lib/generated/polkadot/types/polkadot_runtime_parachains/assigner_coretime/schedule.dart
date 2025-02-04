// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../pallet_broker/coretime_interface/core_assignment.dart' as _i3;
import '../../tuples.dart' as _i2;
import 'parts_of57600.dart' as _i4;

class Schedule {
  const Schedule({
    required this.assignments,
    this.endHint,
    this.nextSchedule,
  });

  factory Schedule.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<(CoreAssignment, PartsOf57600)>
  final List<_i2.Tuple2<_i3.CoreAssignment, _i4.PartsOf57600>> assignments;

  /// Option<N>
  final int? endHint;

  /// Option<N>
  final int? nextSchedule;

  static const $ScheduleCodec codec = $ScheduleCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'assignments': assignments
            .map((value) => [
                  value.value0.toJson(),
                  value.value1,
                ])
            .toList(),
        'endHint': endHint,
        'nextSchedule': nextSchedule,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Schedule &&
          _i6.listsEqual(
            other.assignments,
            assignments,
          ) &&
          other.endHint == endHint &&
          other.nextSchedule == nextSchedule;

  @override
  int get hashCode => Object.hash(
        assignments,
        endHint,
        nextSchedule,
      );
}

class $ScheduleCodec with _i1.Codec<Schedule> {
  const $ScheduleCodec();

  @override
  void encodeTo(
    Schedule obj,
    _i1.Output output,
  ) {
    const _i1.SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.PartsOf57600>>(
        _i2.Tuple2Codec<_i3.CoreAssignment, _i4.PartsOf57600>(
      _i3.CoreAssignment.codec,
      _i4.PartsOf57600Codec(),
    )).encodeTo(
      obj.assignments,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.endHint,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.nextSchedule,
      output,
    );
  }

  @override
  Schedule decode(_i1.Input input) {
    return Schedule(
      assignments: const _i1
          .SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.PartsOf57600>>(
          _i2.Tuple2Codec<_i3.CoreAssignment, _i4.PartsOf57600>(
        _i3.CoreAssignment.codec,
        _i4.PartsOf57600Codec(),
      )).decode(input),
      endHint: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      nextSchedule:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  @override
  int sizeHint(Schedule obj) {
    int size = 0;
    size = size +
        const _i1
            .SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.PartsOf57600>>(
            _i2.Tuple2Codec<_i3.CoreAssignment, _i4.PartsOf57600>(
          _i3.CoreAssignment.codec,
          _i4.PartsOf57600Codec(),
        )).sizeHint(obj.assignments);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.endHint);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.nextSchedule);
    return size;
  }
}
