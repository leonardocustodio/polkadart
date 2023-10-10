// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

enum DefensiveError {
  notEnoughSpaceInUnbondPool('NotEnoughSpaceInUnbondPool', 0),
  poolNotFound('PoolNotFound', 1),
  rewardPoolNotFound('RewardPoolNotFound', 2),
  subPoolsNotFound('SubPoolsNotFound', 3),
  bondedStashKilledPrematurely('BondedStashKilledPrematurely', 4);

  const DefensiveError(
    this.variantName,
    this.codecIndex,
  );

  factory DefensiveError.decode(_i1.Input input) {
    return codec.decode(input);
  }

  final String variantName;

  final int codecIndex;

  static const $DefensiveErrorCodec codec = $DefensiveErrorCodec();

  String toJson() => variantName;
  _i2.Uint8List encode() {
    return codec.encode(this);
  }
}

class $DefensiveErrorCodec with _i1.Codec<DefensiveError> {
  const $DefensiveErrorCodec();

  @override
  DefensiveError decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return DefensiveError.notEnoughSpaceInUnbondPool;
      case 1:
        return DefensiveError.poolNotFound;
      case 2:
        return DefensiveError.rewardPoolNotFound;
      case 3:
        return DefensiveError.subPoolsNotFound;
      case 4:
        return DefensiveError.bondedStashKilledPrematurely;
      default:
        throw Exception('DefensiveError: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    DefensiveError value,
    _i1.Output output,
  ) {
    _i1.U8Codec.codec.encodeTo(
      value.codecIndex,
      output,
    );
  }
}
