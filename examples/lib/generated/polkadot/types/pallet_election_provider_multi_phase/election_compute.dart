// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ElectionCompute {
  onChain('OnChain', 0),
  signed('Signed', 1),
  unsigned('Unsigned', 2),
  fallback('Fallback', 3),
  emergency('Emergency', 4);

  const ElectionCompute(
    this.variantName,
    this.codecIndex,
  );

  factory ElectionCompute.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ElectionComputeCodec codec = $ElectionComputeCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ElectionComputeCodec with _i1.Codec<ElectionCompute> {
  const $ElectionComputeCodec();

  @override
  ElectionCompute decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ElectionCompute.onChain;
      case 1:
        return ElectionCompute.signed;
      case 2:
        return ElectionCompute.unsigned;
      case 3:
        return ElectionCompute.fallback;
      case 4:
        return ElectionCompute.emergency;
      default:
        throw Exception('ElectionCompute: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ElectionCompute value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
