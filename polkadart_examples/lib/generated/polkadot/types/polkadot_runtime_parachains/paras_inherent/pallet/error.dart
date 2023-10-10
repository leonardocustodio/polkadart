// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// Inclusion inherent called more than once per block.
  tooManyInclusionInherents('TooManyInclusionInherents', 0),

  /// The hash of the submitted parent header doesn't correspond to the saved block hash of
  /// the parent.
  invalidParentHeader('InvalidParentHeader', 1),

  /// Disputed candidate that was concluded invalid.
  candidateConcludedInvalid('CandidateConcludedInvalid', 2),

  /// The data given to the inherent will result in an overweight block.
  inherentOverweight('InherentOverweight', 3),

  /// The ordering of dispute statements was invalid.
  disputeStatementsUnsortedOrDuplicates(
      'DisputeStatementsUnsortedOrDuplicates', 4),

  /// A dispute statement was invalid.
  disputeInvalid('DisputeInvalid', 5);

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
        return Error.tooManyInclusionInherents;
      case 1:
        return Error.invalidParentHeader;
      case 2:
        return Error.candidateConcludedInvalid;
      case 3:
        return Error.inherentOverweight;
      case 4:
        return Error.disputeStatementsUnsortedOrDuplicates;
      case 5:
        return Error.disputeInvalid;
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
