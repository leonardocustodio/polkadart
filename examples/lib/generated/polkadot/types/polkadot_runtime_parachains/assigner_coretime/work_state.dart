// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i6;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../pallet_broker/coretime_interface/core_assignment.dart' as _i3;
import '../../tuples.dart' as _i2;
import 'assignment_state.dart' as _i4;
import 'parts_of57600.dart' as _i5;

class WorkState {
  const WorkState({
    required this.assignments,
    this.endHint,
    required this.pos,
    required this.step,
  });

  factory WorkState.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Vec<(CoreAssignment, AssignmentState)>
  final List<_i2.Tuple2<_i3.CoreAssignment, _i4.AssignmentState>> assignments;

  /// Option<N>
  final int? endHint;

  /// u16
  final int pos;

  /// PartsOf57600
  final _i5.PartsOf57600 step;

  static const $WorkStateCodec codec = $WorkStateCodec();

  _i6.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'assignments': assignments
            .map((value) => [
                  value.value0.toJson(),
                  value.value1.toJson(),
                ])
            .toList(),
        'endHint': endHint,
        'pos': pos,
        'step': step,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WorkState &&
          _i7.listsEqual(
            other.assignments,
            assignments,
          ) &&
          other.endHint == endHint &&
          other.pos == pos &&
          other.step == step;

  @override
  int get hashCode => Object.hash(
        assignments,
        endHint,
        pos,
        step,
      );
}

class $WorkStateCodec with _i1.Codec<WorkState> {
  const $WorkStateCodec();

  @override
  void encodeTo(
    WorkState obj,
    _i1.Output output,
  ) {
    const _i1
        .SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.AssignmentState>>(
        _i2.Tuple2Codec<_i3.CoreAssignment, _i4.AssignmentState>(
      _i3.CoreAssignment.codec,
      _i4.AssignmentState.codec,
    )).encodeTo(
      obj.assignments,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.endHint,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.pos,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      obj.step,
      output,
    );
  }

  @override
  WorkState decode(_i1.Input input) {
    return WorkState(
      assignments: const _i1
          .SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.AssignmentState>>(
          _i2.Tuple2Codec<_i3.CoreAssignment, _i4.AssignmentState>(
        _i3.CoreAssignment.codec,
        _i4.AssignmentState.codec,
      )).decode(input),
      endHint: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      pos: _i1.U16Codec.codec.decode(input),
      step: _i1.U16Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(WorkState obj) {
    int size = 0;
    size = size +
        const _i1
            .SequenceCodec<_i2.Tuple2<_i3.CoreAssignment, _i4.AssignmentState>>(
            _i2.Tuple2Codec<_i3.CoreAssignment, _i4.AssignmentState>(
          _i3.CoreAssignment.codec,
          _i4.AssignmentState.codec,
        )).sizeHint(obj.assignments);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(obj.endHint);
    size = size + _i1.U16Codec.codec.sizeHint(obj.pos);
    size = size + const _i5.PartsOf57600Codec().sizeHint(obj.step);
    return size;
  }
}
