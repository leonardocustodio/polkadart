// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum DisputeResult {
  valid('Valid', 0),
  invalid('Invalid', 1);

  const DisputeResult(
    this.variantName,
    this.codecIndex,
  );

  factory DisputeResult.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $DisputeResultCodec codec = $DisputeResultCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $DisputeResultCodec with _i1.Codec<DisputeResult> {
  const $DisputeResultCodec();

  @override
  DisputeResult decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DisputeResult.valid;
      case 1:
        return DisputeResult.invalid;
      default:
        throw Exception('DisputeResult: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DisputeResult value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
