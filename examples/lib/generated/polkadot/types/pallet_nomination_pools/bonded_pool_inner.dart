// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i5;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'commission.dart' as _i2;
import 'pool_roles.dart' as _i3;
import 'pool_state.dart' as _i4;

class BondedPoolInner {
  const BondedPoolInner({
    required this.commission,
    required this.memberCounter,
    required this.points,
    required this.roles,
    required this.state,
  });

  factory BondedPoolInner.decode(_i1.Input input) {
    return codec.decode(input);
  }

  /// Commission<T>
  final _i2.Commission commission;

  /// u32
  final int memberCounter;

  /// BalanceOf<T>
  final BigInt points;

  /// PoolRoles<T::AccountId>
  final _i3.PoolRoles roles;

  /// PoolState
  final _i4.PoolState state;

  static const $BondedPoolInnerCodec codec = $BondedPoolInnerCodec();

  _i5.Uint8List encode() {
    return codec.encode(this);
  }

  Map<String, dynamic> toJson() => {
        'commission': commission.toJson(),
        'memberCounter': memberCounter,
        'points': points,
        'roles': roles.toJson(),
        'state': state.toJson(),
      };

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BondedPoolInner &&
          other.commission == commission &&
          other.memberCounter == memberCounter &&
          other.points == points &&
          other.roles == roles &&
          other.state == state;

  @override
  int get hashCode => Object.hash(
        commission,
        memberCounter,
        points,
        roles,
        state,
      );
}

class $BondedPoolInnerCodec with _i1.Codec<BondedPoolInner> {
  const $BondedPoolInnerCodec();

  @override
  void encodeTo(
    BondedPoolInner obj,
    _i1.Output output,
  ) {
    _i2.Commission.codec.encodeTo(
      obj.commission,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      obj.memberCounter,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      obj.points,
      output,
    );
    _i3.PoolRoles.codec.encodeTo(
      obj.roles,
      output,
    );
    _i4.PoolState.codec.encodeTo(
      obj.state,
      output,
    );
  }

  @override
  BondedPoolInner decode(_i1.Input input) {
    return BondedPoolInner(
      commission: _i2.Commission.codec.decode(input),
      memberCounter: _i1.U32Codec.codec.decode(input),
      points: _i1.U128Codec.codec.decode(input),
      roles: _i3.PoolRoles.codec.decode(input),
      state: _i4.PoolState.codec.decode(input),
    );
  }

  @override
  int sizeHint(BondedPoolInner obj) {
    int size = 0;
    size = size + _i2.Commission.codec.sizeHint(obj.commission);
    size = size + _i1.U32Codec.codec.sizeHint(obj.memberCounter);
    size = size + _i1.U128Codec.codec.sizeHint(obj.points);
    size = size + _i3.PoolRoles.codec.sizeHint(obj.roles);
    size = size + _i4.PoolState.codec.sizeHint(obj.state);
    return size;
  }
}
