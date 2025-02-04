// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

class ElectionScore {
  const ElectionScore({
    required this.minimalStake,
    required this.sumStake,
    required this.sumStakeSquared,
  });

  factory ElectionScore.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// ExtendedBalance
  final BigInt minimalStake;

  /// ExtendedBalance
  final BigInt sumStake;

  /// ExtendedBalance
  final BigInt sumStakeSquared;

  static const $ElectionScoreCodec codec = $ElectionScoreCodec();

  _i2.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, BigInt> toJson() => {
        'minimalStake': minimalStake,
        'sumStake': sumStake,
        'sumStakeSquared': sumStakeSquared,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ElectionScore &&
          other.minimalStake == minimalStake &&
          other.sumStake == sumStake &&
          other.sumStakeSquared == sumStakeSquared;

  @override
  int get hashCode => Object.hash(
        minimalStake,
        sumStake,
        sumStakeSquared,
      );
}

class $ElectionScoreCodec with _i1.Codec<ElectionScore> {
  const $ElectionScoreCodec();

  @override
  void encodeTo(
    ElectionScore obj,
    _i1.Output output,
  ) {
    _i1.U128Codec.codec.encodeTo(
      obj.minimalStake,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.sumStake,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.sumStakeSquared,
      output,
    );
  }

  @override
  ElectionScore decode(_i1.Input input) {
    return ElectionScore(
      minimalStake: _i1.U128Codec.codec.decode(input),
      sumStake: _i1.U128Codec.codec.decode(input),
      sumStakeSquared: _i1.U128Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(ElectionScore obj) {
    int size = 0;
    size = size + _i1.U128Codec.codec.sizeHint(obj.minimalStake);
    size = size + _i1.U128Codec.codec.sizeHint(obj.sumStake);
    size = size + _i1.U128Codec.codec.sizeHint(obj.sumStakeSquared);
    return size;
  }
}
