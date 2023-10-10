// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum UpgradeGoAhead {
  abort('Abort', 0),
  goAhead('GoAhead', 1);

  const UpgradeGoAhead(
    this.variantName,
    this.codecIndex,
  );

  factory UpgradeGoAhead.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $UpgradeGoAheadCodec codec = $UpgradeGoAheadCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $UpgradeGoAheadCodec with _i1.Codec<UpgradeGoAhead> {
  const $UpgradeGoAheadCodec();

  @override
  UpgradeGoAhead decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UpgradeGoAhead.abort;
      case 1:
        return UpgradeGoAhead.goAhead;
      default:
        throw Exception('UpgradeGoAhead: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    UpgradeGoAhead value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
