// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// The provided Controller account was not found.
  ///
  /// This means that the given account is not bonded.
  notController('NotController', 0),

  /// The bonded account has already been queued.
  alreadyQueued('AlreadyQueued', 1),

  /// The bonded account has active unlocking chunks.
  notFullyBonded('NotFullyBonded', 2),

  /// The provided un-staker is not in the `Queue`.
  notQueued('NotQueued', 3),

  /// The provided un-staker is already in Head, and cannot deregister.
  alreadyHead('AlreadyHead', 4),

  /// The call is not allowed at this point because the pallet is not active.
  callNotAllowed('CallNotAllowed', 5);

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
        return Error.notController;
      case 1:
        return Error.alreadyQueued;
      case 2:
        return Error.notFullyBonded;
      case 3:
        return Error.notQueued;
      case 4:
        return Error.alreadyHead;
      case 5:
        return Error.callNotAllowed;
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
