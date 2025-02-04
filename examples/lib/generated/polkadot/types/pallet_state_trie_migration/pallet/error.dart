// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Max signed limits not respected.
  maxSignedLimits('MaxSignedLimits', 0),

  /// A key was longer than the configured maximum.
  ///
  /// This means that the migration halted at the current [`Progress`] and
  /// can be resumed with a larger [`crate::Config::MaxKeyLen`] value.
  /// Retrying with the same [`crate::Config::MaxKeyLen`] value will not work.
  /// The value should only be increased to avoid a storage migration for the currently
  /// stored [`crate::Progress::LastKey`].
  keyTooLong('KeyTooLong', 1),

  /// submitter does not have enough funds.
  notEnoughFunds('NotEnoughFunds', 2),

  /// Bad witness data provided.
  badWitness('BadWitness', 3),

  /// Signed migration is not allowed because the maximum limit is not set yet.
  signedMigrationNotAllowed('SignedMigrationNotAllowed', 4),

  /// Bad child root provided.
  badChildRoot('BadChildRoot', 5);

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
        return Error.maxSignedLimits;
      case 1:
        return Error.keyTooLong;
      case 2:
        return Error.notEnoughFunds;
      case 3:
        return Error.badWitness;
      case 4:
        return Error.signedMigrationNotAllowed;
      case 5:
        return Error.badChildRoot;
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
