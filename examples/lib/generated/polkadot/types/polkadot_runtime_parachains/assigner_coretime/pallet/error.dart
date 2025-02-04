// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  assignmentsEmpty('AssignmentsEmpty', 0),

  /// Assignments together exceeded 57600.
  overScheduled('OverScheduled', 1),

  /// Assignments together less than 57600
  underScheduled('UnderScheduled', 2),

  /// assign_core is only allowed to append new assignments at the end of already existing
  /// ones.
  disallowedInsert('DisallowedInsert', 3),

  /// Tried to insert a schedule for the same core and block number as an existing schedule
  duplicateInsert('DuplicateInsert', 4),

  /// Tried to add an unsorted set of assignments
  assignmentsNotSorted('AssignmentsNotSorted', 5);

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
        return Error.assignmentsEmpty;
      case 1:
        return Error.overScheduled;
      case 2:
        return Error.underScheduled;
      case 3:
        return Error.disallowedInsert;
      case 4:
        return Error.duplicateInsert;
      case 5:
        return Error.assignmentsNotSorted;
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
