// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Invalid Ethereum signature.
  invalidEthereumSignature('InvalidEthereumSignature', 0),

  /// Ethereum address has no claim.
  signerHasNoClaim('SignerHasNoClaim', 1),

  /// Account ID sending transaction has no claim.
  senderHasNoClaim('SenderHasNoClaim', 2),

  /// There's not enough in the pot to pay out some unvested amount. Generally implies a logic
  /// error.
  potUnderflow('PotUnderflow', 3),

  /// A needed statement was not included.
  invalidStatement('InvalidStatement', 4),

  /// The account already has a vested balance.
  vestedBalanceExists('VestedBalanceExists', 5);

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
        return Error.invalidEthereumSignature;
      case 1:
        return Error.signerHasNoClaim;
      case 2:
        return Error.senderHasNoClaim;
      case 3:
        return Error.potUnderflow;
      case 4:
        return Error.invalidStatement;
      case 5:
        return Error.vestedBalanceExists;
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
