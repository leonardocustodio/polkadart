// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// Error for the session pallet.
enum Error {
  /// Invalid ownership proof.
  invalidProof('InvalidProof', 0),

  /// No associated validator ID for account.
  noAssociatedValidatorId('NoAssociatedValidatorId', 1),

  /// Registered duplicate key.
  duplicatedKey('DuplicatedKey', 2),

  /// No keys are associated with this account.
  noKeys('NoKeys', 3),

  /// Key setting account is not live, so it's impossible to associate keys.
  noAccount('NoAccount', 4);

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
        return Error.invalidProof;
      case 1:
        return Error.noAssociatedValidatorId;
      case 2:
        return Error.duplicatedKey;
      case 3:
        return Error.noKeys;
      case 4:
        return Error.noAccount;
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
