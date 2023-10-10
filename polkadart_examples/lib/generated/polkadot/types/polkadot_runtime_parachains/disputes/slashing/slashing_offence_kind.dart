// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum SlashingOffenceKind {
  forInvalid('ForInvalid', 0),
  againstValid('AgainstValid', 1);

  const SlashingOffenceKind(
    this.variantName,
    this.codecIndex,
  );

  factory SlashingOffenceKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $SlashingOffenceKindCodec codec = $SlashingOffenceKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $SlashingOffenceKindCodec with _i1.Codec<SlashingOffenceKind> {
  const $SlashingOffenceKindCodec();

  @override
  SlashingOffenceKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return SlashingOffenceKind.forInvalid;
      case 1:
        return SlashingOffenceKind.againstValid;
      default:
        throw Exception('SlashingOffenceKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    SlashingOffenceKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
