// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// An equivocation proof provided as part of an equivocation report is invalid.
  invalidEquivocationProof('InvalidEquivocationProof', 0),

  /// A key ownership proof provided as part of an equivocation report is invalid.
  invalidKeyOwnershipProof('InvalidKeyOwnershipProof', 1),

  /// A given equivocation report is valid but already previously reported.
  duplicateOffenceReport('DuplicateOffenceReport', 2),

  /// Submitted configuration is invalid.
  invalidConfiguration('InvalidConfiguration', 3);

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
        return Error.invalidEquivocationProof;
      case 1:
        return Error.invalidKeyOwnershipProof;
      case 2:
        return Error.duplicateOffenceReport;
      case 3:
        return Error.invalidConfiguration;
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
