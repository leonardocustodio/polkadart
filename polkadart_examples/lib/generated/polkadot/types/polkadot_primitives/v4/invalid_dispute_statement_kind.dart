// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum InvalidDisputeStatementKind {
  explicit('Explicit', 0);

  const InvalidDisputeStatementKind(
    this.variantName,
    this.codecIndex,
  );

  factory InvalidDisputeStatementKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $InvalidDisputeStatementKindCodec codec =
      $InvalidDisputeStatementKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $InvalidDisputeStatementKindCodec
    with _i1.Codec<InvalidDisputeStatementKind> {
  const $InvalidDisputeStatementKindCodec();

  @override
  InvalidDisputeStatementKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return InvalidDisputeStatementKind.explicit;
      default:
        throw Exception(
            'InvalidDisputeStatementKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    InvalidDisputeStatementKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
