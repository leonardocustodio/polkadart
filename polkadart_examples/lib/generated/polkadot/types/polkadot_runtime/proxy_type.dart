// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum ProxyType {
  any('Any', 0),
  nonTransfer('NonTransfer', 1),
  governance('Governance', 2),
  staking('Staking', 3),
  identityJudgement('IdentityJudgement', 5),
  cancelProxy('CancelProxy', 6),
  auction('Auction', 7),
  nominationPools('NominationPools', 8);

  const ProxyType(
    this.variantName,
    this.codecIndex,
  );

  factory ProxyType.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $ProxyTypeCodec codec = $ProxyTypeCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $ProxyTypeCodec with _i1.Codec<ProxyType> {
  const $ProxyTypeCodec();

  @override
  ProxyType decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ProxyType.any;
      case 1:
        return ProxyType.nonTransfer;
      case 2:
        return ProxyType.governance;
      case 3:
        return ProxyType.staking;
      case 5:
        return ProxyType.identityJudgement;
      case 6:
        return ProxyType.cancelProxy;
      case 7:
        return ProxyType.auction;
      case 8:
        return ProxyType.nominationPools;
      default:
        throw Exception('ProxyType: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ProxyType value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
