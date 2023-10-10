// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

///
///			Custom [dispatch errors](https://docs.substrate.io/main-docs/build/events-errors/)
///			of this pallet.
///
enum Error {
  /// The reason given is just too big.
  reasonTooBig('ReasonTooBig', 0),

  /// The tip was already found/started.
  alreadyKnown('AlreadyKnown', 1),

  /// The tip hash is unknown.
  unknownTip('UnknownTip', 2),

  /// The account attempting to retract the tip is not the finder of the tip.
  notFinder('NotFinder', 3),

  /// The tip cannot be claimed/closed because there are not enough tippers yet.
  stillOpen('StillOpen', 4),

  /// The tip cannot be claimed/closed because it's still in the countdown period.
  premature('Premature', 5);

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
        return Error.reasonTooBig;
      case 1:
        return Error.alreadyKnown;
      case 2:
        return Error.unknownTip;
      case 3:
        return Error.notFinder;
      case 4:
        return Error.stillOpen;
      case 5:
        return Error.premature;
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
