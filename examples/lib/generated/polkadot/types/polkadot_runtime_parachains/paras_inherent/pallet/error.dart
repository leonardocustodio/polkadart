// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Inclusion inherent called more than once per block.
  tooManyInclusionInherents('TooManyInclusionInherents', 0),

  /// The hash of the submitted parent header doesn't correspond to the saved block hash of
  /// the parent.
  invalidParentHeader('InvalidParentHeader', 1),

  /// The data given to the inherent will result in an overweight block.
  inherentOverweight('InherentOverweight', 2),

  /// A candidate was filtered during inherent execution. This should have only been done
  /// during creation.
  candidatesFilteredDuringExecution('CandidatesFilteredDuringExecution', 3),

  /// Too many candidates supplied.
  unscheduledCandidate('UnscheduledCandidate', 4);

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
        return Error.inherentOverweight;
      case 3:
        return Error.candidatesFilteredDuringExecution;
      case 4:
        return Error.unscheduledCandidate;
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
