// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_arithmetic/fixed_point/fixed_u128.dart' as _i2;

class RewardPool {
  const RewardPool({
    required this.lastRecordedRewardCounter,
    required this.lastRecordedTotalPayouts,
    required this.totalRewardsClaimed,
    required this.totalCommissionPending,
    required this.totalCommissionClaimed,
  });

  factory RewardPool.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// T::RewardCounter
  final _i2.FixedU128 lastRecordedRewardCounter;

  /// BalanceOf<T>
  final BigInt lastRecordedTotalPayouts;

  /// BalanceOf<T>
  final BigInt totalRewardsClaimed;

  /// BalanceOf<T>
  final BigInt totalCommissionPending;

  /// BalanceOf<T>
  final BigInt totalCommissionClaimed;

  static const $RewardPoolCodec codec = $RewardPoolCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'lastRecordedRewardCounter': lastRecordedRewardCounter,
        'lastRecordedTotalPayouts': lastRecordedTotalPayouts,
        'totalRewardsClaimed': totalRewardsClaimed,
        'totalCommissionPending': totalCommissionPending,
        'totalCommissionClaimed': totalCommissionClaimed,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RewardPool &&
          other.lastRecordedRewardCounter == lastRecordedRewardCounter &&
          other.lastRecordedTotalPayouts == lastRecordedTotalPayouts &&
          other.totalRewardsClaimed == totalRewardsClaimed &&
          other.totalCommissionPending == totalCommissionPending &&
          other.totalCommissionClaimed == totalCommissionClaimed;

  @override
  int get hashCode => Object.hash(
        lastRecordedRewardCounter,
        lastRecordedTotalPayouts,
        totalRewardsClaimed,
        totalCommissionPending,
        totalCommissionClaimed,
      );
}

class $RewardPoolCodec with _i1.Codec<RewardPool> {
  const $RewardPoolCodec();

  @override
  void encodeTo(
    RewardPool obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.lastRecordedRewardCounter,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.lastRecordedTotalPayouts,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.totalRewardsClaimed,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.totalCommissionPending,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.totalCommissionClaimed,
      output,
    );
  }

  @override
  RewardPool decode(_i1.Input input) {
    return RewardPool(
      lastRecordedRewardCounter: _i1.U128Codec.codec.decode(input),
      lastRecordedTotalPayouts: _i1.U128Codec.codec.decode(input),
      totalRewardsClaimed: _i1.U128Codec.codec.decode(input),
      totalCommissionPending: _i1.U128Codec.codec.decode(input),
      totalCommissionClaimed: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(RewardPool obj) {
    int size = 0;
    size = size +
        const _i2.FixedU128Codec().sizeHint(obj.lastRecordedRewardCounter);
    size = size + _i1.U128Codec.codec.sizeHint(obj.lastRecordedTotalPayouts);
    size = size + _i1.U128Codec.codec.sizeHint(obj.totalRewardsClaimed);
    size = size + _i1.U128Codec.codec.sizeHint(obj.totalCommissionPending);
    size = size + _i1.U128Codec.codec.sizeHint(obj.totalCommissionClaimed);
    return size;
  }
}
