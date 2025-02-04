// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i7;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../sp_arithmetic/per_things/perbill.dart' as _i3;
import '../sp_core/crypto/account_id32.dart' as _i4;
import '../tuples.dart' as _i2;
import 'commission_change_rate.dart' as _i5;
import 'commission_claim_permission.dart' as _i6;

class Commission {
  const Commission({
    this.current,
    this.max,
    this.changeRate,
    this.throttleFrom,
    this.claimPermission,
  });

  factory Commission.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Option<(Perbill, T::AccountId)>
  final _i2.Tuple2<_i3.Perbill, _i4.AccountId32>? current;

  /// Option<Perbill>
  final _i3.Perbill? max;

  /// Option<CommissionChangeRate<BlockNumberFor<T>>>
  final _i5.CommissionChangeRate? changeRate;

  /// Option<BlockNumberFor<T>>
  final int? throttleFrom;

  /// Option<CommissionClaimPermission<T::AccountId>>
  final _i6.CommissionClaimPermission? claimPermission;

  static const $CommissionCodec codec = $CommissionCodec();

  _i7.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'current': [
          current?.value0,
          current?.value1.toList(),
        ],
        'max': max,
        'changeRate': changeRate?.toJson(),
        'throttleFrom': throttleFrom,
        'claimPermission': claimPermission?.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Commission &&
          other.current == current &&
          other.max == max &&
          other.changeRate == changeRate &&
          other.throttleFrom == throttleFrom &&
          other.claimPermission == claimPermission;

  @override
  int get hashCode => Object.hash(
        current,
        max,
        changeRate,
        throttleFrom,
        claimPermission,
      );
}

class $CommissionCodec with _i1.Codec<Commission> {
  const $CommissionCodec();

  @override
  void encodeTo(
    Commission obj,
    _i1.Output output,
  ) {
    const _i1.OptionCodec<_i2.Tuple2<_i3.Perbill, _i4.AccountId32>>(
        _i2.Tuple2Codec<_i3.Perbill, _i4.AccountId32>(
      _i3.PerbillCodec(),
      _i4.AccountId32Codec(),
    )).encodeTo(
      obj.current,
      output,
    );
    const _i1.OptionCodec<_i3.Perbill>(_i3.PerbillCodec()).encodeTo(
      obj.max,
      output,
    );
    const _i1.OptionCodec<_i5.CommissionChangeRate>(
            _i5.CommissionChangeRate.codec)
        .encodeTo(
      obj.changeRate,
      output,
    );
    const _i1.OptionCodec<int>(_i1.U32Codec.codec).encodeTo(
      obj.throttleFrom,
      output,
    );
    const _i1.OptionCodec<_i6.CommissionClaimPermission>(
            _i6.CommissionClaimPermission.codec)
        .encodeTo(
      obj.claimPermission,
      output,
    );
  }

  @override
  Commission decode(_i1.Input input) {
    return Commission(
      current: const _i1.OptionCodec<_i2.Tuple2<_i3.Perbill, _i4.AccountId32>>(
          _i2.Tuple2Codec<_i3.Perbill, _i4.AccountId32>(
        _i3.PerbillCodec(),
        _i4.AccountId32Codec(),
      )).decode(input),
      max: const _i1.OptionCodec<_i3.Perbill>(_i3.PerbillCodec()).decode(input),
      changeRate: const _i1.OptionCodec<_i5.CommissionChangeRate>(
              _i5.CommissionChangeRate.codec)
          .decode(input),
      throttleFrom:
          const _i1.OptionCodec<int>(_i1.U32Codec.codec).decode(input),
      claimPermission: const _i1.OptionCodec<_i6.CommissionClaimPermission>(
              _i6.CommissionClaimPermission.codec)
          .decode(input),
    );
  }

  @override
  int sizeHint(Commission obj) {
    int size = 0;
    size = size +
        const _i1.OptionCodec<_i2.Tuple2<_i3.Perbill, _i4.AccountId32>>(
            _i2.Tuple2Codec<_i3.Perbill, _i4.AccountId32>(
          _i3.PerbillCodec(),
          _i4.AccountId32Codec(),
        )).sizeHint(obj.current);
    size = size +
        const _i1.OptionCodec<_i3.Perbill>(_i3.PerbillCodec())
            .sizeHint(obj.max);
    size = size +
        const _i1.OptionCodec<_i5.CommissionChangeRate>(
                _i5.CommissionChangeRate.codec)
            .sizeHint(obj.changeRate);
    size = size +
        const _i1.OptionCodec<int>(_i1.U32Codec.codec)
            .sizeHint(obj.throttleFrom);
    size = size +
        const _i1.OptionCodec<_i6.CommissionClaimPermission>(
                _i6.CommissionClaimPermission.codec)
            .sizeHint(obj.claimPermission);
    return size;
  }
}
