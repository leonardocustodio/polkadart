// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum AllowedSlots {
  primarySlots('PrimarySlots', 0),
  primaryAndSecondaryPlainSlots('PrimaryAndSecondaryPlainSlots', 1),
  primaryAndSecondaryVRFSlots('PrimaryAndSecondaryVRFSlots', 2);

  const AllowedSlots(
    this.variantName,
    this.codecIndex,
  );

  factory AllowedSlots.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $AllowedSlotsCodec codec = $AllowedSlotsCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $AllowedSlotsCodec with _i1.Codec<AllowedSlots> {
  const $AllowedSlotsCodec();

  @override
  AllowedSlots decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return AllowedSlots.primarySlots;
      case 1:
        return AllowedSlots.primaryAndSecondaryPlainSlots;
      case 2:
        return AllowedSlots.primaryAndSecondaryVRFSlots;
      default:
        throw Exception('AllowedSlots: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    AllowedSlots value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
