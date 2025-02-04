// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

/// The `Error` enum of this pallet.
enum Error {
  /// Preimage is too large to store on-chain.
  tooBig('TooBig', 0),

  /// Preimage has already been noted on-chain.
  alreadyNoted('AlreadyNoted', 1),

  /// The user is not authorized to perform this action.
  notAuthorized('NotAuthorized', 2),

  /// The preimage cannot be removed since it has not yet been noted.
  notNoted('NotNoted', 3),

  /// A preimage may not be removed when there are outstanding requests.
  requested('Requested', 4),

  /// The preimage request cannot be removed since no outstanding requests exist.
  notRequested('NotRequested', 5),

  /// More than `MAX_HASH_UPGRADE_BULK_COUNT` hashes were requested to be upgraded at once.
  tooMany('TooMany', 6),

  /// Too few hashes were requested to be upgraded (i.e. zero).
  tooFew('TooFew', 7),

  /// No ticket with a cost was returned by [`Config::Consideration`] to store the preimage.
  noCost('NoCost', 8);

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
        return Error.tooBig;
      case 1:
        return Error.alreadyNoted;
      case 2:
        return Error.notAuthorized;
      case 3:
        return Error.notNoted;
      case 4:
        return Error.requested;
      case 5:
        return Error.notRequested;
      case 6:
        return Error.tooMany;
      case 7:
        return Error.tooFew;
      case 8:
        return Error.noCost;
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
