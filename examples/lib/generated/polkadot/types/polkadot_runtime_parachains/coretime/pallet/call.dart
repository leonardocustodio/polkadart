// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../../pallet_broker/coretime_interface/core_assignment.dart' as _i4;
import '../../../tuples.dart' as _i3;
import '../../assigner_coretime/parts_of57600.dart' as _i5;

/// Contains a variant per dispatchable extrinsic that this pallet has.
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

  RequestCoreCount requestCoreCount({required int count}) {
    return RequestCoreCount(count: count);
  }

  RequestRevenueAt requestRevenueAt({required int when}) {
    return RequestRevenueAt(when: when);
  }

  AssignCore assignCore({
    required int core,
    required int begin,
    required List<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>> assignment,
    int? endHint,
  }) {
    return AssignCore(
      core: core,
      begin: begin,
      assignment: assignment,
      endHint: endHint,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 1:
        return RequestCoreCount._decode(input);
      case 2:
        return RequestRevenueAt._decode(input);
      case 4:
        return AssignCore._decode(input);
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
      case RequestCoreCount:
        (value as RequestCoreCount).encodeTo(output);
        break;
      case RequestRevenueAt:
        (value as RequestRevenueAt).encodeTo(output);
        break;
      case AssignCore:
        (value as AssignCore).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case RequestCoreCount:
        return (value as RequestCoreCount)._sizeHint();
      case RequestRevenueAt:
        return (value as RequestRevenueAt)._sizeHint();
      case AssignCore:
        return (value as AssignCore)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Request the configuration to be updated with the specified number of cores. Warning:
/// Since this only schedules a configuration update, it takes two sessions to come into
/// effect.
///
/// - `origin`: Root or the Coretime Chain
/// - `count`: total number of cores
class RequestCoreCount extends Call {
  const RequestCoreCount({required this.count});

  factory RequestCoreCount._decode(_i1.Input input) {
    return RequestCoreCount(count: _i1.U16Codec.codec.decode(input));
  }

  /// u16
  final int count;

  @override
  Map<String, Map<String, int>> toJson() => {
        'request_core_count': {'count': count}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(count);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      count,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RequestCoreCount && other.count == count;

  @override
  int get hashCode => count.hashCode;
}

/// Request to claim the instantaneous coretime sales revenue starting from the block it was
/// last claimed until and up to the block specified. The claimed amount value is sent back
/// to the Coretime chain in a `notify_revenue` message. At the same time, the amount is
/// teleported to the Coretime chain.
class RequestRevenueAt extends Call {
  const RequestRevenueAt({required this.when});

  factory RequestRevenueAt._decode(_i1.Input input) {
    return RequestRevenueAt(when: _i1.U32Codec.codec.decode(input));
  }

  /// BlockNumber
  final int when;

  @override
  Map<String, Map<String, int>> toJson() => {
        'request_revenue_at': {'when': when}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(when);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      when,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RequestRevenueAt && other.when == when;

  @override
  int get hashCode => when.hashCode;
}

/// Receive instructions from the `ExternalBrokerOrigin`, detailing how a specific core is
/// to be used.
///
/// Parameters:
/// -`origin`: The `ExternalBrokerOrigin`, assumed to be the coretime chain.
/// -`core`: The core that should be scheduled.
/// -`begin`: The starting blockheight of the instruction.
/// -`assignment`: How the blockspace should be utilised.
/// -`end_hint`: An optional hint as to when this particular set of instructions will end.
class AssignCore extends Call {
  const AssignCore({
    required this.core,
    required this.begin,
    required this.assignment,
    this.endHint,
  });

  factory AssignCore._decode(_i1.Input input) {
    return AssignCore(
      core: _i1.U16Codec.codec.decode(input),
      begin: _i1.U32Codec.codec.decode(input),
      assignment: const _i1
          .SequenceCodec<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>>(
          _i3.Tuple2Codec<_i4.CoreAssignment, _i5.PartsOf57600>(
        _i4.CoreAssignment.codec,
        _i5.PartsOf57600Codec(),
      )).decode(input),
      endHint: const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
    );
  }

  /// BrokerCoreIndex
  final int core;

  /// BlockNumberFor<T>
  final int begin;

  /// Vec<(CoreAssignment, PartsOf57600)>
  final List<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>> assignment;

  /// Option<BlockNumberFor<T>>
  final int? endHint;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'assign_core': {
          'core': core,
          'begin': begin,
          'assignment': assignment
              .map((value) => [
                    value.value0.toJson(),
                    value.value1,
                  ])
              .toList(),
          'endHint': endHint,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(core);
    size = size + _i1.U32Codec.codec.sizeHint(begin);
    size = size +
        const _i1
            .SequenceCodec<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>>(
            _i3.Tuple2Codec<_i4.CoreAssignment, _i5.PartsOf57600>(
          _i4.CoreAssignment.codec,
          _i5.PartsOf57600Codec(),
        )).sizeHint(assignment);
    size =
        size + const _i1.OptionCodec<int>(_i1.U32Codec.codec).sizeHint(endHint);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      core,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      begin,
      output,
    );
    const _i1.SequenceCodec<_i3.Tuple2<_i4.CoreAssignment, _i5.PartsOf57600>>(
        _i3.Tuple2Codec<_i4.CoreAssignment, _i5.PartsOf57600>(
      _i4.CoreAssignment.codec,
      _i5.PartsOf57600Codec(),
    )).encodeTo(
      assignment,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      endHint,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssignCore &&
          other.core == core &&
          other.begin == begin &&
          _i6.listsEqual(
            other.assignment,
            assignment,
          ) &&
          other.endHint == endHint;

  @override
  int get hashCode => Object.hash(
        core,
        begin,
        assignment,
        endHint,
      );
}
