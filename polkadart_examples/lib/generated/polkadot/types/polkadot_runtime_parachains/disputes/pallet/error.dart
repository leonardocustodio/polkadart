// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Duplicate dispute statement sets provided.
  duplicateDisputeStatementSets('DuplicateDisputeStatementSets', 0),

  /// Ancient dispute statement provided.
  ancientDisputeStatement('AncientDisputeStatement', 1),

  /// Validator index on statement is out of bounds for session.
  validatorIndexOutOfBounds('ValidatorIndexOutOfBounds', 2),

  /// Invalid signature on statement.
  invalidSignature('InvalidSignature', 3),

  /// Validator vote submitted more than once to dispute.
  duplicateStatement('DuplicateStatement', 4),

  /// A dispute where there are only votes on one side.
  singleSidedDispute('SingleSidedDispute', 5),

  /// A dispute vote from a malicious backer.
  maliciousBacker('MaliciousBacker', 6),

  /// No backing votes were provides along dispute statements.
  missingBackingVotes('MissingBackingVotes', 7),

  /// Unconfirmed dispute statement sets provided.
  unconfirmedDispute('UnconfirmedDispute', 8);

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
        return Error.duplicateDisputeStatementSets;
      case 1:
        return Error.ancientDisputeStatement;
      case 2:
        return Error.validatorIndexOutOfBounds;
      case 3:
        return Error.invalidSignature;
      case 4:
        return Error.duplicateStatement;
      case 5:
        return Error.singleSidedDispute;
      case 6:
        return Error.maliciousBacker;
      case 7:
        return Error.missingBackingVotes;
      case 8:
        return Error.unconfirmedDispute;
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
