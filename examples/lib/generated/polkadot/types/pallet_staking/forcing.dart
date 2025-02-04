// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Forcing {
  notForcing('NotForcing', 0),
  forceNew('ForceNew', 1),
  forceNone('ForceNone', 2),
  forceAlways('ForceAlways', 3);

  const Forcing(
    this.variantName,
    this.codecIndex,
  );

  factory Forcing.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ForcingCodec codec = $ForcingCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ForcingCodec with _i1.Codec<Forcing> {
  const $ForcingCodec();

  @override
  Forcing decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Forcing.notForcing;
      case 1:
        return Forcing.forceNew;
      case 2:
        return Forcing.forceNone;
      case 3:
        return Forcing.forceAlways;
      default:
        throw Exception('Forcing: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Forcing value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
