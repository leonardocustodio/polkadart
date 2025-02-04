// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum UpgradeStrategy {
  setGoAheadSignal('SetGoAheadSignal', 0),
  applyAtExpectedBlock('ApplyAtExpectedBlock', 1);

  const UpgradeStrategy(
    this.variantName,
    this.codecIndex,
  );

  factory UpgradeStrategy.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $UpgradeStrategyCodec codec = $UpgradeStrategyCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $UpgradeStrategyCodec with _i1.Codec<UpgradeStrategy> {
  const $UpgradeStrategyCodec();

  @override
  UpgradeStrategy decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return UpgradeStrategy.setGoAheadSignal;
      case 1:
        return UpgradeStrategy.applyAtExpectedBlock;
      default:
        throw Exception('UpgradeStrategy: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    UpgradeStrategy value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
