// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The preimage of the call hash could not be loaded.
  unavailablePreImage('UnavailablePreImage', 0),

  /// The call could not be decoded.
  undecodableCall('UndecodableCall', 1),

  /// The weight of the decoded call was higher than the witness.
  invalidCallWeightWitness('InvalidCallWeightWitness', 2),

  /// The call was not whitelisted.
  callIsNotWhitelisted('CallIsNotWhitelisted', 3),

  /// The call was already whitelisted; No-Op.
  callAlreadyWhitelisted('CallAlreadyWhitelisted', 4);

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
        return Error.unavailablePreImage;
      case 1:
        return Error.undecodableCall;
      case 2:
        return Error.invalidCallWeightWitness;
      case 3:
        return Error.callIsNotWhitelisted;
      case 4:
        return Error.callAlreadyWhitelisted;
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
