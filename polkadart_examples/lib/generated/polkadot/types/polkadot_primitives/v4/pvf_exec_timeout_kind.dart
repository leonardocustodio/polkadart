// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum PvfExecTimeoutKind {
  backing('Backing', 0),
  approval('Approval', 1);

  const PvfExecTimeoutKind(
    this.variantName,
    this.codecIndex,
  );

  factory PvfExecTimeoutKind.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $PvfExecTimeoutKindCodec codec = $PvfExecTimeoutKindCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $PvfExecTimeoutKindCodec with _i1.Codec<PvfExecTimeoutKind> {
  const $PvfExecTimeoutKindCodec();

  @override
  PvfExecTimeoutKind decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return PvfExecTimeoutKind.backing;
      case 1:
        return PvfExecTimeoutKind.approval;
      default:
        throw Exception('PvfExecTimeoutKind: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PvfExecTimeoutKind value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
