// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum FreezeReason {
  poolMinBalance('PoolMinBalance', 0);

  const FreezeReason(
    this.variantName,
    this.codecIndex,
  );

  factory FreezeReason.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $FreezeReasonCodec codec = $FreezeReasonCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $FreezeReasonCodec with _i1.Codec<FreezeReason> {
  const $FreezeReasonCodec();

  @override
  FreezeReason decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return FreezeReason.poolMinBalance;
      default:
        throw Exception('FreezeReason: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    FreezeReason value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
