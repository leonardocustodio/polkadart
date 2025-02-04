// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i3;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_arithmetic/per_things/perbill.dart' as _i2;

class CommissionChangeRate {
  const CommissionChangeRate({
    required this.maxIncrease,
    required this.minDelay,
  });

  factory CommissionChangeRate.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Perbill
  final _i2.Perbill maxIncrease;

  /// BlockNumber
  final int minDelay;

  static const $CommissionChangeRateCodec codec = $CommissionChangeRateCodec();

  _i3.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, int> toJson() => {
        'maxIncrease': maxIncrease,
        'minDelay': minDelay,
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CommissionChangeRate &&
          other.maxIncrease == maxIncrease &&
          other.minDelay == minDelay;

  @override
  int get hashCode => Object.hash(
        maxIncrease,
        minDelay,
      );
}

class $CommissionChangeRateCodec with _i1.Codec<CommissionChangeRate> {
  const $CommissionChangeRateCodec();

  @override
  void encodeTo(
    CommissionChangeRate obj,
    _i1.Output output,
  ) {
    _i1.U32Codec.codec.encodeTo(
      obj.maxIncrease,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.minDelay,
      output,
    );
  }

  @override
  CommissionChangeRate decode(_i1.Input input) {
    return CommissionChangeRate(
      maxIncrease: _i1.U32Codec.codec.decode(input),
      minDelay: _i1.U32Codec.codec.decode(input),
    );
  }

  @override
  int sizeHint(CommissionChangeRate obj) {
    int size = 0;
    size = size + const _i2.PerbillCodec().sizeHint(obj.maxIncrease);
    size = size + _i1.U32Codec.codec.sizeHint(obj.minDelay);
    return size;
  }
}
