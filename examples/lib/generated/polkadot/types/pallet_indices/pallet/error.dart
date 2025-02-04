// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The index was not already assigned.
  notAssigned('NotAssigned', 0),

  /// The index is assigned to another account.
  notOwner('NotOwner', 1),

  /// The index was not available.
  inUse('InUse', 2),

  /// The source and destination accounts are identical.
  notTransfer('NotTransfer', 3),

  /// The index is permanent and may not be freed/changed.
  permanent('Permanent', 4);

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
        return Error.notAssigned;
      case 1:
        return Error.notOwner;
      case 2:
        return Error.inUse;
      case 3:
        return Error.notTransfer;
      case 4:
        return Error.permanent;
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
