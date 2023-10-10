// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum VoteThreshold {
  superMajorityApprove('SuperMajorityApprove', 0),
  superMajorityAgainst('SuperMajorityAgainst', 1),
  simpleMajority('SimpleMajority', 2);

  const VoteThreshold(
    this.variantName,
    this.codecIndex,
  );

  factory VoteThreshold.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $VoteThresholdCodec codec = $VoteThresholdCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $VoteThresholdCodec with _i1.Codec<VoteThreshold> {
  const $VoteThresholdCodec();

  @override
  VoteThreshold decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return VoteThreshold.superMajorityApprove;
      case 1:
        return VoteThreshold.superMajorityAgainst;
      case 2:
        return VoteThreshold.simpleMajority;
      default:
        throw Exception('VoteThreshold: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VoteThreshold value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
