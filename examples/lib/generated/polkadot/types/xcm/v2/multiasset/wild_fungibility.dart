// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum WildFungibility {
  fungible('Fungible', 0),
  nonFungible('NonFungible', 1);

  const WildFungibility(
    this.variantName,
    this.codecIndex,
  );

  factory WildFungibility.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $WildFungibilityCodec codec = $WildFungibilityCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $WildFungibilityCodec with _i1.Codec<WildFungibility> {
  const $WildFungibilityCodec();

  @override
  WildFungibility decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return WildFungibility.fungible;
      case 1:
        return WildFungibility.nonFungible;
      default:
        throw Exception('WildFungibility: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    WildFungibility value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
