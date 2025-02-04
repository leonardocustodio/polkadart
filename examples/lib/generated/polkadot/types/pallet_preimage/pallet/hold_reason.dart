// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum HoldReason {
  preimage('Preimage', 0);

  const HoldReason(
    this.variantName,
    this.codecIndex,
  );

  factory HoldReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $HoldReasonCodec codec = $HoldReasonCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $HoldReasonCodec with _i1.Codec<HoldReason> {
  const $HoldReasonCodec();

  @override
  HoldReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return HoldReason.preimage;
      default:
        throw Exception('HoldReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    HoldReason value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
