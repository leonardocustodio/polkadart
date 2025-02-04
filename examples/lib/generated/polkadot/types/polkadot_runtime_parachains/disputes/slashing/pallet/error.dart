// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// The key ownership proof is invalid.
  invalidKeyOwnershipProof('InvalidKeyOwnershipProof', 0),

  /// The session index is too old or invalid.
  invalidSessionIndex('InvalidSessionIndex', 1),

  /// The candidate hash is invalid.
  invalidCandidateHash('InvalidCandidateHash', 2),

  /// There is no pending slash for the given validator index and time
  /// slot.
  invalidValidatorIndex('InvalidValidatorIndex', 3),

  /// The validator index does not match the validator id.
  validatorIndexIdMismatch('ValidatorIndexIdMismatch', 4),

  /// The given slashing report is valid but already previously reported.
  duplicateSlashingReport('DuplicateSlashingReport', 5);

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
        return Error.invalidKeyOwnershipProof;
      case 1:
        return Error.invalidSessionIndex;
      case 2:
        return Error.invalidCandidateHash;
      case 3:
        return Error.invalidValidatorIndex;
      case 4:
        return Error.validatorIndexIdMismatch;
      case 5:
        return Error.duplicateSlashingReport;
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
