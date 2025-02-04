// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;
import '../vesting_info/vesting_info.dart' as _i4;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Vest vest() {
    return Vest();
  }

  VestOther vestOther({required _i3.MultiAddress target}) {
    return VestOther(target: target);
  }

  VestedTransfer vestedTransfer({
    required _i3.MultiAddress target,
    required _i4.VestingInfo schedule,
  }) {
    return VestedTransfer(
      target: target,
      schedule: schedule,
    );
  }

  ForceVestedTransfer forceVestedTransfer({
    required _i3.MultiAddress source,
    required _i3.MultiAddress target,
    required _i4.VestingInfo schedule,
  }) {
    return ForceVestedTransfer(
      source: source,
      target: target,
      schedule: schedule,
    );
  }

  MergeSchedules mergeSchedules({
    required int schedule1Index,
    required int schedule2Index,
  }) {
    return MergeSchedules(
      schedule1Index: schedule1Index,
      schedule2Index: schedule2Index,
    );
  }

  ForceRemoveVestingSchedule forceRemoveVestingSchedule({
    required _i3.MultiAddress target,
    required int scheduleIndex,
  }) {
    return ForceRemoveVestingSchedule(
      target: target,
      scheduleIndex: scheduleIndex,
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
        return const Vest();
      case 1:
        return VestOther._decode(input);
      case 2:
        return VestedTransfer._decode(input);
      case 3:
        return ForceVestedTransfer._decode(input);
      case 4:
        return MergeSchedules._decode(input);
      case 5:
        return ForceRemoveVestingSchedule._decode(input);
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
      case Vest:
        (value as Vest).encodeTo(output);
        break;
      case VestOther:
        (value as VestOther).encodeTo(output);
        break;
      case VestedTransfer:
        (value as VestedTransfer).encodeTo(output);
        break;
      case ForceVestedTransfer:
        (value as ForceVestedTransfer).encodeTo(output);
        break;
      case MergeSchedules:
        (value as MergeSchedules).encodeTo(output);
        break;
      case ForceRemoveVestingSchedule:
        (value as ForceRemoveVestingSchedule).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Vest:
        return 1;
      case VestOther:
        return (value as VestOther)._sizeHint();
      case VestedTransfer:
        return (value as VestedTransfer)._sizeHint();
      case ForceVestedTransfer:
        return (value as ForceVestedTransfer)._sizeHint();
      case MergeSchedules:
        return (value as MergeSchedules)._sizeHint();
      case ForceRemoveVestingSchedule:
        return (value as ForceRemoveVestingSchedule)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Unlock any vested funds of the sender account.
///
/// The dispatch origin for this call must be _Signed_ and the sender must have funds still
/// locked under this pallet.
///
/// Emits either `VestingCompleted` or `VestingUpdated`.
///
/// ## Complexity
/// - `O(1)`.
class Vest extends Call {
  const Vest();

  @override
  Map<String, dynamic> toJson() => {'vest': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Vest;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Unlock any vested funds of a `target` account.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `target`: The account whose vested funds should be unlocked. Must have funds still
/// locked under this pallet.
///
/// Emits either `VestingCompleted` or `VestingUpdated`.
///
/// ## Complexity
/// - `O(1)`.
class VestOther extends Call {
  const VestOther({required this.target});

  factory VestOther._decode(_i1.Input input) {
    return VestOther(target: _i3.MultiAddress.codec.decode(input));
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress target;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'vest_other': {'target': target.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VestOther && other.target == target;

  @override
  int get hashCode => target.hashCode;
}

/// Create a vested transfer.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `target`: The account receiving the vested funds.
/// - `schedule`: The vesting schedule attached to the transfer.
///
/// Emits `VestingCreated`.
///
/// NOTE: This will unlock all schedules through the current block.
///
/// ## Complexity
/// - `O(1)`.
class VestedTransfer extends Call {
  const VestedTransfer({
    required this.target,
    required this.schedule,
  });

  factory VestedTransfer._decode(_i1.Input input) {
    return VestedTransfer(
      target: _i3.MultiAddress.codec.decode(input),
      schedule: _i4.VestingInfo.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress target;

  /// VestingInfo<BalanceOf<T>, BlockNumberFor<T>>
  final _i4.VestingInfo schedule;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'vested_transfer': {
          'target': target.toJson(),
          'schedule': schedule.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    size = size + _i4.VestingInfo.codec.sizeHint(schedule);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i4.VestingInfo.codec.encodeTo(
      schedule,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is VestedTransfer &&
          other.target == target &&
          other.schedule == schedule;

  @override
  int get hashCode => Object.hash(
        target,
        schedule,
      );
}

/// Force a vested transfer.
///
/// The dispatch origin for this call must be _Root_.
///
/// - `source`: The account whose funds should be transferred.
/// - `target`: The account that should be transferred the vested funds.
/// - `schedule`: The vesting schedule attached to the transfer.
///
/// Emits `VestingCreated`.
///
/// NOTE: This will unlock all schedules through the current block.
///
/// ## Complexity
/// - `O(1)`.
class ForceVestedTransfer extends Call {
  const ForceVestedTransfer({
    required this.source,
    required this.target,
    required this.schedule,
  });

  factory ForceVestedTransfer._decode(_i1.Input input) {
    return ForceVestedTransfer(
      source: _i3.MultiAddress.codec.decode(input),
      target: _i3.MultiAddress.codec.decode(input),
      schedule: _i4.VestingInfo.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress source;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress target;

  /// VestingInfo<BalanceOf<T>, BlockNumberFor<T>>
  final _i4.VestingInfo schedule;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'force_vested_transfer': {
          'source': source.toJson(),
          'target': target.toJson(),
          'schedule': schedule.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(source);
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    size = size + _i4.VestingInfo.codec.sizeHint(schedule);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      source,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i4.VestingInfo.codec.encodeTo(
      schedule,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceVestedTransfer &&
          other.source == source &&
          other.target == target &&
          other.schedule == schedule;

  @override
  int get hashCode => Object.hash(
        source,
        target,
        schedule,
      );
}

/// Merge two vesting schedules together, creating a new vesting schedule that unlocks over
/// the highest possible start and end blocks. If both schedules have already started the
/// current block will be used as the schedule start; with the caveat that if one schedule
/// is finished by the current block, the other will be treated as the new merged schedule,
/// unmodified.
///
/// NOTE: If `schedule1_index == schedule2_index` this is a no-op.
/// NOTE: This will unlock all schedules through the current block prior to merging.
/// NOTE: If both schedules have ended by the current block, no new schedule will be created
/// and both will be removed.
///
/// Merged schedule attributes:
/// - `starting_block`: `MAX(schedule1.starting_block, scheduled2.starting_block,
///  current_block)`.
/// - `ending_block`: `MAX(schedule1.ending_block, schedule2.ending_block)`.
/// - `locked`: `schedule1.locked_at(current_block) + schedule2.locked_at(current_block)`.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `schedule1_index`: index of the first schedule to merge.
/// - `schedule2_index`: index of the second schedule to merge.
class MergeSchedules extends Call {
  const MergeSchedules({
    required this.schedule1Index,
    required this.schedule2Index,
  });

  factory MergeSchedules._decode(_i1.Input input) {
    return MergeSchedules(
      schedule1Index: _i1.U32Codec.codec.decode(input),
      schedule2Index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// u32
  final int schedule1Index;

  /// u32
  final int schedule2Index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'merge_schedules': {
          'schedule1Index': schedule1Index,
          'schedule2Index': schedule2Index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(schedule1Index);
    size = size + _i1.U32Codec.codec.sizeHint(schedule2Index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      schedule1Index,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      schedule2Index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MergeSchedules &&
          other.schedule1Index == schedule1Index &&
          other.schedule2Index == schedule2Index;

  @override
  int get hashCode => Object.hash(
        schedule1Index,
        schedule2Index,
      );
}

/// Force remove a vesting schedule
///
/// The dispatch origin for this call must be _Root_.
///
/// - `target`: An account that has a vesting schedule
/// - `schedule_index`: The vesting schedule index that should be removed
class ForceRemoveVestingSchedule extends Call {
  const ForceRemoveVestingSchedule({
    required this.target,
    required this.scheduleIndex,
  });

  factory ForceRemoveVestingSchedule._decode(_i1.Input input) {
    return ForceRemoveVestingSchedule(
      target: _i3.MultiAddress.codec.decode(input),
      scheduleIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// <T::Lookup as StaticLookup>::Source
  final _i3.MultiAddress target;

  /// u32
  final int scheduleIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_remove_vesting_schedule': {
          'target': target.toJson(),
          'scheduleIndex': scheduleIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(target);
    size = size + _i1.U32Codec.codec.sizeHint(scheduleIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      target,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      scheduleIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceRemoveVestingSchedule &&
          other.target == target &&
          other.scheduleIndex == scheduleIndex;

  @override
  int get hashCode => Object.hash(
        target,
        scheduleIndex,
      );
}
