// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum DisputeLocation {
  local('Local', 0),
  remote('Remote', 1);

  const DisputeLocation(
    this.variantName,
    this.codecIndex,
  );

  factory DisputeLocation.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $DisputeLocationCodec codec = $DisputeLocationCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $DisputeLocationCodec with _i1.Codec<DisputeLocation> {
  const $DisputeLocationCodec();

  @override
  DisputeLocation decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DisputeLocation.local;
      case 1:
        return DisputeLocation.remote;
      default:
        throw Exception('DisputeLocation: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DisputeLocation value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
