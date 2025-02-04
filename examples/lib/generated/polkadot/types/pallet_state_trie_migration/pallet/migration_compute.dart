// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum MigrationCompute {
  signed('Signed', 0),
  auto('Auto', 1);

  const MigrationCompute(
    this.variantName,
    this.codecIndex,
  );

  factory MigrationCompute.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $MigrationComputeCodec codec = $MigrationComputeCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $MigrationComputeCodec with _i1.Codec<MigrationCompute> {
  const $MigrationComputeCodec();

  @override
  MigrationCompute decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return MigrationCompute.signed;
      case 1:
        return MigrationCompute.auto;
      default:
        throw Exception('MigrationCompute: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    MigrationCompute value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
