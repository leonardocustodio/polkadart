// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum PvfPrepTimeoutKind {
  precheck('Precheck', 0),
  lenient('Lenient', 1);

  const PvfPrepTimeoutKind(
    this.variantName,
    this.codecIndex,
  );

  factory PvfPrepTimeoutKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $PvfPrepTimeoutKindCodec codec = $PvfPrepTimeoutKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $PvfPrepTimeoutKindCodec with _i1.Codec<PvfPrepTimeoutKind> {
  const $PvfPrepTimeoutKindCodec();

  @override
  PvfPrepTimeoutKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PvfPrepTimeoutKind.precheck;
      case 1:
        return PvfPrepTimeoutKind.lenient;
      default:
        throw Exception('PvfPrepTimeoutKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PvfPrepTimeoutKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
