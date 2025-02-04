// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Error for the vesting pallet.
enum Error {
  /// The account given is not vesting.
  notVesting('NotVesting', 0),

  /// The account already has `MaxVestingSchedules` count of schedules and thus
  /// cannot add another one. Consider merging existing schedules in order to add another.
  atMaxVestingSchedules('AtMaxVestingSchedules', 1),

  /// Amount being transferred is too low to create a vesting schedule.
  amountLow('AmountLow', 2),

  /// An index was out of bounds of the vesting schedules.
  scheduleIndexOutOfBounds('ScheduleIndexOutOfBounds', 3),

  /// Failed to create a new schedule because some parameter was invalid.
  invalidScheduleParams('InvalidScheduleParams', 4);

  const Error(
    this.variantName,
    this.codecIndex,
  );

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ErrorCodec codec = $ErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Error.notVesting;
      case 1:
        return Error.atMaxVestingSchedules;
      case 2:
        return Error.amountLow;
      case 3:
        return Error.scheduleIndexOutOfBounds;
      case 4:
        return Error.invalidScheduleParams;
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
