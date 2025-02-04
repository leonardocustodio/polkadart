// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum UpgradeRestriction {
  present('Present', 0);

  const UpgradeRestriction(
    this.variantName,
    this.codecIndex,
  );

  factory UpgradeRestriction.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $UpgradeRestrictionCodec codec = $UpgradeRestrictionCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $UpgradeRestrictionCodec with _i1.Codec<UpgradeRestriction> {
  const $UpgradeRestrictionCodec();

  @override
  UpgradeRestriction decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UpgradeRestriction.present;
      default:
        throw Exception('UpgradeRestriction: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    UpgradeRestriction value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
