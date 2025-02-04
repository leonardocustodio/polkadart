// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum Origin {
  stakingAdmin('StakingAdmin', 0),
  treasurer('Treasurer', 1),
  fellowshipAdmin('FellowshipAdmin', 2),
  generalAdmin('GeneralAdmin', 3),
  auctionAdmin('AuctionAdmin', 4),
  leaseAdmin('LeaseAdmin', 5),
  referendumCanceller('ReferendumCanceller', 6),
  referendumKiller('ReferendumKiller', 7),
  smallTipper('SmallTipper', 8),
  bigTipper('BigTipper', 9),
  smallSpender('SmallSpender', 10),
  mediumSpender('MediumSpender', 11),
  bigSpender('BigSpender', 12),
  whitelistedCaller('WhitelistedCaller', 13),
  wishForChange('WishForChange', 14);

  const Origin(
    this.variantName,
    this.codecIndex,
  );

  factory Origin.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $OriginCodec codec = $OriginCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $OriginCodec with _i1.Codec<Origin> {
  const $OriginCodec();

  @override
  Origin decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Origin.stakingAdmin;
      case 1:
        return Origin.treasurer;
      case 2:
        return Origin.fellowshipAdmin;
      case 3:
        return Origin.generalAdmin;
      case 4:
        return Origin.auctionAdmin;
      case 5:
        return Origin.leaseAdmin;
      case 6:
        return Origin.referendumCanceller;
      case 7:
        return Origin.referendumKiller;
      case 8:
        return Origin.smallTipper;
      case 9:
        return Origin.bigTipper;
      case 10:
        return Origin.smallSpender;
      case 11:
        return Origin.mediumSpender;
      case 12:
        return Origin.bigSpender;
      case 13:
        return Origin.whitelistedCaller;
      case 14:
        return Origin.wishForChange;
      default:
        throw Exception('Origin: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Origin value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
