// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum PvfExecKind {
  backing('Backing', 0),
  approval('Approval', 1);

  const PvfExecKind(
    this.variantName,
    this.codecIndex,
  );

  factory PvfExecKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $PvfExecKindCodec codec = $PvfExecKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $PvfExecKindCodec with _i1.Codec<PvfExecKind> {
  const $PvfExecKindCodec();

  @override
  PvfExecKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PvfExecKind.backing;
      case 1:
        return PvfExecKind.approval;
      default:
        throw Exception('PvfExecKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PvfExecKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
