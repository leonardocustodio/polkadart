// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The ID is not registered.
  notRegistered('NotRegistered', 0),

  /// The ID is already registered.
  alreadyRegistered('AlreadyRegistered', 1),

  /// The caller is not the owner of this Id.
  notOwner('NotOwner', 2),

  /// Invalid para code size.
  codeTooLarge('CodeTooLarge', 3),

  /// Invalid para head data size.
  headDataTooLarge('HeadDataTooLarge', 4),

  /// Para is not a Parachain.
  notParachain('NotParachain', 5),

  /// Para is not a Parathread (on-demand parachain).
  notParathread('NotParathread', 6),

  /// Cannot deregister para
  cannotDeregister('CannotDeregister', 7),

  /// Cannot schedule downgrade of lease holding parachain to on-demand parachain
  cannotDowngrade('CannotDowngrade', 8),

  /// Cannot schedule upgrade of on-demand parachain to lease holding parachain
  cannotUpgrade('CannotUpgrade', 9),

  /// Para is locked from manipulation by the manager. Must use parachain or relay chain
  /// governance.
  paraLocked('ParaLocked', 10),

  /// The ID given for registration has not been reserved.
  notReserved('NotReserved', 11),

  /// The validation code is invalid.
  invalidCode('InvalidCode', 12),

  /// Cannot perform a parachain slot / lifecycle swap. Check that the state of both paras
  /// are correct for the swap to work.
  cannotSwap('CannotSwap', 13);

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
        return Error.notRegistered;
      case 1:
        return Error.alreadyRegistered;
      case 2:
        return Error.notOwner;
      case 3:
        return Error.codeTooLarge;
      case 4:
        return Error.headDataTooLarge;
      case 5:
        return Error.notParachain;
      case 6:
        return Error.notParathread;
      case 7:
        return Error.cannotDeregister;
      case 8:
        return Error.cannotDowngrade;
      case 9:
        return Error.cannotUpgrade;
      case 10:
        return Error.paraLocked;
      case 11:
        return Error.notReserved;
      case 12:
        return Error.invalidCode;
      case 13:
        return Error.cannotSwap;
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
