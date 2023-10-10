// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum StatementKind {
  regular('Regular', 0),
  saft('Saft', 1);

  const StatementKind(
    this.variantName,
    this.codecIndex,
  );

  factory StatementKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $StatementKindCodec codec = $StatementKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $StatementKindCodec with _i1.Codec<StatementKind> {
  const $StatementKindCodec();

  @override
  StatementKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return StatementKind.regular;
      case 1:
        return StatementKind.saft;
      default:
        throw Exception('StatementKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    StatementKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
