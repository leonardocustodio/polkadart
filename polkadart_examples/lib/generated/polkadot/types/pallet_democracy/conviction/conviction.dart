// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Conviction {
  none('None', 0),
  locked1x('Locked1x', 1),
  locked2x('Locked2x', 2),
  locked3x('Locked3x', 3),
  locked4x('Locked4x', 4),
  locked5x('Locked5x', 5),
  locked6x('Locked6x', 6);

  const Conviction(
    this.variantName,
    this.codecIndex,
  );

  factory Conviction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ConvictionCodec codec = $ConvictionCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ConvictionCodec with _i1.Codec<Conviction> {
  const $ConvictionCodec();

  @override
  Conviction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Conviction.none;
      case 1:
        return Conviction.locked1x;
      case 2:
        return Conviction.locked2x;
      case 3:
        return Conviction.locked3x;
      case 4:
        return Conviction.locked4x;
      case 5:
        return Conviction.locked5x;
      case 6:
        return Conviction.locked6x;
      default:
        throw Exception('Conviction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Conviction value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
