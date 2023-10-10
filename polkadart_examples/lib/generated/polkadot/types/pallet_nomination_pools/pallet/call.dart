// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i15;

import '../../sp_arithmetic/per_things/perbill.dart' as _i13;
import '../../sp_core/crypto/account_id32.dart' as _i5;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i4;
import '../../tuples.dart' as _i12;
import '../bond_extra.dart' as _i3;
import '../claim_permission.dart' as _i11;
import '../commission_change_rate.dart' as _i14;
import '../config_op_1.dart' as _i7;
import '../config_op_2.dart' as _i8;
import '../config_op_3.dart' as _i9;
import '../config_op_4.dart' as _i10;
import '../pool_state.dart' as _i6;

/// Contains one variant per dispatchable that can be called by an extrinsic.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Join join({
    required BigInt amount,
    required int poolId,
  }) {
    return Join(
      amount: amount,
      poolId: poolId,
    );
  }

  BondExtra bondExtra({required _i3.BondExtra extra}) {
    return BondExtra(extra: extra);
  }

  ClaimPayout claimPayout() {
    return ClaimPayout();
  }

  Unbond unbond({
    required _i4.MultiAddress memberAccount,
    required BigInt unbondingPoints,
  }) {
    return Unbond(
      memberAccount: memberAccount,
      unbondingPoints: unbondingPoints,
    );
  }

  PoolWithdrawUnbonded poolWithdrawUnbonded({
    required int poolId,
    required int numSlashingSpans,
  }) {
    return PoolWithdrawUnbonded(
      poolId: poolId,
      numSlashingSpans: numSlashingSpans,
    );
  }

  WithdrawUnbonded withdrawUnbonded({
    required _i4.MultiAddress memberAccount,
    required int numSlashingSpans,
  }) {
    return WithdrawUnbonded(
      memberAccount: memberAccount,
      numSlashingSpans: numSlashingSpans,
    );
  }

  Create create({
    required BigInt amount,
    required _i4.MultiAddress root,
    required _i4.MultiAddress nominator,
    required _i4.MultiAddress bouncer,
  }) {
    return Create(
      amount: amount,
      root: root,
      nominator: nominator,
      bouncer: bouncer,
    );
  }

  CreateWithPoolId createWithPoolId({
    required BigInt amount,
    required _i4.MultiAddress root,
    required _i4.MultiAddress nominator,
    required _i4.MultiAddress bouncer,
    required int poolId,
  }) {
    return CreateWithPoolId(
      amount: amount,
      root: root,
      nominator: nominator,
      bouncer: bouncer,
      poolId: poolId,
    );
  }

  Nominate nominate({
    required int poolId,
    required List<_i5.AccountId32> validators,
  }) {
    return Nominate(
      poolId: poolId,
      validators: validators,
    );
  }

  SetState setState({
    required int poolId,
    required _i6.PoolState state,
  }) {
    return SetState(
      poolId: poolId,
      state: state,
    );
  }

  SetMetadata setMetadata({
    required int poolId,
    required List<int> metadata,
  }) {
    return SetMetadata(
      poolId: poolId,
      metadata: metadata,
    );
  }

  SetConfigs setConfigs({
    required _i7.ConfigOp minJoinBond,
    required _i7.ConfigOp minCreateBond,
    required _i8.ConfigOp maxPools,
    required _i8.ConfigOp maxMembers,
    required _i8.ConfigOp maxMembersPerPool,
    required _i9.ConfigOp globalMaxCommission,
  }) {
    return SetConfigs(
      minJoinBond: minJoinBond,
      minCreateBond: minCreateBond,
      maxPools: maxPools,
      maxMembers: maxMembers,
      maxMembersPerPool: maxMembersPerPool,
      globalMaxCommission: globalMaxCommission,
    );
  }

  UpdateRoles updateRoles({
    required int poolId,
    required _i10.ConfigOp newRoot,
    required _i10.ConfigOp newNominator,
    required _i10.ConfigOp newBouncer,
  }) {
    return UpdateRoles(
      poolId: poolId,
      newRoot: newRoot,
      newNominator: newNominator,
      newBouncer: newBouncer,
    );
  }

  Chill chill({required int poolId}) {
    return Chill(poolId: poolId);
  }

  BondExtraOther bondExtraOther({
    required _i4.MultiAddress member,
    required _i3.BondExtra extra,
  }) {
    return BondExtraOther(
      member: member,
      extra: extra,
    );
  }

  SetClaimPermission setClaimPermission(
      {required _i11.ClaimPermission permission}) {
    return SetClaimPermission(permission: permission);
  }

  ClaimPayoutOther claimPayoutOther({required _i5.AccountId32 other}) {
    return ClaimPayoutOther(other: other);
  }

  SetCommission setCommission({
    required int poolId,
    _i12.Tuple2<_i13.Perbill, _i5.AccountId32>? newCommission,
  }) {
    return SetCommission(
      poolId: poolId,
      newCommission: newCommission,
    );
  }

  SetCommissionMax setCommissionMax({
    required int poolId,
    required _i13.Perbill maxCommission,
  }) {
    return SetCommissionMax(
      poolId: poolId,
      maxCommission: maxCommission,
    );
  }

  SetCommissionChangeRate setCommissionChangeRate({
    required int poolId,
    required _i14.CommissionChangeRate changeRate,
  }) {
    return SetCommissionChangeRate(
      poolId: poolId,
      changeRate: changeRate,
    );
  }

  ClaimCommission claimCommission({required int poolId}) {
    return ClaimCommission(poolId: poolId);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Join._decode(input);
      case 1:
        return BondExtra._decode(input);
      case 2:
        return const ClaimPayout();
      case 3:
        return Unbond._decode(input);
      case 4:
        return PoolWithdrawUnbonded._decode(input);
      case 5:
        return WithdrawUnbonded._decode(input);
      case 6:
        return Create._decode(input);
      case 7:
        return CreateWithPoolId._decode(input);
      case 8:
        return Nominate._decode(input);
      case 9:
        return SetState._decode(input);
      case 10:
        return SetMetadata._decode(input);
      case 11:
        return SetConfigs._decode(input);
      case 12:
        return UpdateRoles._decode(input);
      case 13:
        return Chill._decode(input);
      case 14:
        return BondExtraOther._decode(input);
      case 15:
        return SetClaimPermission._decode(input);
      case 16:
        return ClaimPayoutOther._decode(input);
      case 17:
        return SetCommission._decode(input);
      case 18:
        return SetCommissionMax._decode(input);
      case 19:
        return SetCommissionChangeRate._decode(input);
      case 20:
        return ClaimCommission._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Join:
        (value as Join).encodeTo(output);
        break;
      case BondExtra:
        (value as BondExtra).encodeTo(output);
        break;
      case ClaimPayout:
        (value as ClaimPayout).encodeTo(output);
        break;
      case Unbond:
        (value as Unbond).encodeTo(output);
        break;
      case PoolWithdrawUnbonded:
        (value as PoolWithdrawUnbonded).encodeTo(output);
        break;
      case WithdrawUnbonded:
        (value as WithdrawUnbonded).encodeTo(output);
        break;
      case Create:
        (value as Create).encodeTo(output);
        break;
      case CreateWithPoolId:
        (value as CreateWithPoolId).encodeTo(output);
        break;
      case Nominate:
        (value as Nominate).encodeTo(output);
        break;
      case SetState:
        (value as SetState).encodeTo(output);
        break;
      case SetMetadata:
        (value as SetMetadata).encodeTo(output);
        break;
      case SetConfigs:
        (value as SetConfigs).encodeTo(output);
        break;
      case UpdateRoles:
        (value as UpdateRoles).encodeTo(output);
        break;
      case Chill:
        (value as Chill).encodeTo(output);
        break;
      case BondExtraOther:
        (value as BondExtraOther).encodeTo(output);
        break;
      case SetClaimPermission:
        (value as SetClaimPermission).encodeTo(output);
        break;
      case ClaimPayoutOther:
        (value as ClaimPayoutOther).encodeTo(output);
        break;
      case SetCommission:
        (value as SetCommission).encodeTo(output);
        break;
      case SetCommissionMax:
        (value as SetCommissionMax).encodeTo(output);
        break;
      case SetCommissionChangeRate:
        (value as SetCommissionChangeRate).encodeTo(output);
        break;
      case ClaimCommission:
        (value as ClaimCommission).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Join:
        return (value as Join)._sizeHint();
      case BondExtra:
        return (value as BondExtra)._sizeHint();
      case ClaimPayout:
        return 1;
      case Unbond:
        return (value as Unbond)._sizeHint();
      case PoolWithdrawUnbonded:
        return (value as PoolWithdrawUnbonded)._sizeHint();
      case WithdrawUnbonded:
        return (value as WithdrawUnbonded)._sizeHint();
      case Create:
        return (value as Create)._sizeHint();
      case CreateWithPoolId:
        return (value as CreateWithPoolId)._sizeHint();
      case Nominate:
        return (value as Nominate)._sizeHint();
      case SetState:
        return (value as SetState)._sizeHint();
      case SetMetadata:
        return (value as SetMetadata)._sizeHint();
      case SetConfigs:
        return (value as SetConfigs)._sizeHint();
      case UpdateRoles:
        return (value as UpdateRoles)._sizeHint();
      case Chill:
        return (value as Chill)._sizeHint();
      case BondExtraOther:
        return (value as BondExtraOther)._sizeHint();
      case SetClaimPermission:
        return (value as SetClaimPermission)._sizeHint();
      case ClaimPayoutOther:
        return (value as ClaimPayoutOther)._sizeHint();
      case SetCommission:
        return (value as SetCommission)._sizeHint();
      case SetCommissionMax:
        return (value as SetCommissionMax)._sizeHint();
      case SetCommissionChangeRate:
        return (value as SetCommissionChangeRate)._sizeHint();
      case ClaimCommission:
        return (value as ClaimCommission)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Stake funds with a pool. The amount to bond is transferred from the member to the
/// pools account and immediately increases the pools bond.
///
/// # Note
///
/// * An account can only be a member of a single pool.
/// * An account cannot join the same pool multiple times.
/// * This call will *not* dust the member account, so the member must have at least
///  `existential deposit + amount` in their account.
/// * Only a pool with [`PoolState::Open`] can be joined
class Join extends Call {
  const Join({
    required this.amount,
    required this.poolId,
  });

  factory Join._decode(_i1.Input input) {
    return Join(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      poolId: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt amount;

  /// PoolId
  final int poolId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'join': {
          'amount': amount,
          'poolId': poolId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Join && other.amount == amount && other.poolId == poolId;

  @override
  int get hashCode => Object.hash(
        amount,
        poolId,
      );
}

/// Bond `extra` more funds from `origin` into the pool to which they already belong.
///
/// Additional funds can come from either the free balance of the account, of from the
/// accumulated rewards, see [`BondExtra`].
///
/// Bonding extra funds implies an automatic payout of all pending rewards as well.
/// See `bond_extra_other` to bond pending rewards of `other` members.
class BondExtra extends Call {
  const BondExtra({required this.extra});

  factory BondExtra._decode(_i1.Input input) {
    return BondExtra(extra: _i3.BondExtra.codec.decode(input));
  }

  /// BondExtra<BalanceOf<T>>
  final _i3.BondExtra extra;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'bond_extra': {'extra': extra.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.BondExtra.codec.sizeHint(extra);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.BondExtra.codec.encodeTo(
      extra,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BondExtra && other.extra == extra;

  @override
  int get hashCode => extra.hashCode;
}

/// A bonded member can use this to claim their payout based on the rewards that the pool
/// has accumulated since their last claimed payout (OR since joining if this is their first
/// time claiming rewards). The payout will be transferred to the member's account.
///
/// The member will earn rewards pro rata based on the members stake vs the sum of the
/// members in the pools stake. Rewards do not "expire".
///
/// See `claim_payout_other` to caim rewards on bahalf of some `other` pool member.
class ClaimPayout extends Call {
  const ClaimPayout();

  @override
  Map<String, dynamic> toJson() => {'claim_payout': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ClaimPayout;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Unbond up to `unbonding_points` of the `member_account`'s funds from the pool. It
/// implicitly collects the rewards one last time, since not doing so would mean some
/// rewards would be forfeited.
///
/// Under certain conditions, this call can be dispatched permissionlessly (i.e. by any
/// account).
///
/// # Conditions for a permissionless dispatch.
///
/// * The pool is blocked and the caller is either the root or bouncer. This is refereed to
///  as a kick.
/// * The pool is destroying and the member is not the depositor.
/// * The pool is destroying, the member is the depositor and no other members are in the
///  pool.
///
/// ## Conditions for permissioned dispatch (i.e. the caller is also the
/// `member_account`):
///
/// * The caller is not the depositor.
/// * The caller is the depositor, the pool is destroying and no other members are in the
///  pool.
///
/// # Note
///
/// If there are too many unlocking chunks to unbond with the pool account,
/// [`Call::pool_withdraw_unbonded`] can be called to try and minimize unlocking chunks.
/// The [`StakingInterface::unbond`] will implicitly call [`Call::pool_withdraw_unbonded`]
/// to try to free chunks if necessary (ie. if unbound was called and no unlocking chunks
/// are available). However, it may not be possible to release the current unlocking chunks,
/// in which case, the result of this call will likely be the `NoMoreChunks` error from the
/// staking system.
class Unbond extends Call {
  const Unbond({
    required this.memberAccount,
    required this.unbondingPoints,
  });

  factory Unbond._decode(_i1.Input input) {
    return Unbond(
      memberAccount: _i4.MultiAddress.codec.decode(input),
      unbondingPoints: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress memberAccount;

  /// BalanceOf<T>
  final BigInt unbondingPoints;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'unbond': {
          'memberAccount': memberAccount.toJson(),
          'unbondingPoints': unbondingPoints,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiAddress.codec.sizeHint(memberAccount);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(unbondingPoints);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      memberAccount,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      unbondingPoints,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unbond &&
          other.memberAccount == memberAccount &&
          other.unbondingPoints == unbondingPoints;

  @override
  int get hashCode => Object.hash(
        memberAccount,
        unbondingPoints,
      );
}

/// Call `withdraw_unbonded` for the pools account. This call can be made by any account.
///
/// This is useful if their are too many unlocking chunks to call `unbond`, and some
/// can be cleared by withdrawing. In the case there are too many unlocking chunks, the user
/// would probably see an error like `NoMoreChunks` emitted from the staking system when
/// they attempt to unbond.
class PoolWithdrawUnbonded extends Call {
  const PoolWithdrawUnbonded({
    required this.poolId,
    required this.numSlashingSpans,
  });

  factory PoolWithdrawUnbonded._decode(_i1.Input input) {
    return PoolWithdrawUnbonded(
      poolId: _i1.U32Codec.codec.decode(input),
      numSlashingSpans: _i1.U32Codec.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// u32
  final int numSlashingSpans;

  @override
  Map<String, Map<String, int>> toJson() => {
        'pool_withdraw_unbonded': {
          'poolId': poolId,
          'numSlashingSpans': numSlashingSpans,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + _i1.U32Codec.codec.sizeHint(numSlashingSpans);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numSlashingSpans,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PoolWithdrawUnbonded &&
          other.poolId == poolId &&
          other.numSlashingSpans == numSlashingSpans;

  @override
  int get hashCode => Object.hash(
        poolId,
        numSlashingSpans,
      );
}

/// Withdraw unbonded funds from `member_account`. If no bonded funds can be unbonded, an
/// error is returned.
///
/// Under certain conditions, this call can be dispatched permissionlessly (i.e. by any
/// account).
///
/// # Conditions for a permissionless dispatch
///
/// * The pool is in destroy mode and the target is not the depositor.
/// * The target is the depositor and they are the only member in the sub pools.
/// * The pool is blocked and the caller is either the root or bouncer.
///
/// # Conditions for permissioned dispatch
///
/// * The caller is the target and they are not the depositor.
///
/// # Note
///
/// If the target is the depositor, the pool will be destroyed.
class WithdrawUnbonded extends Call {
  const WithdrawUnbonded({
    required this.memberAccount,
    required this.numSlashingSpans,
  });

  factory WithdrawUnbonded._decode(_i1.Input input) {
    return WithdrawUnbonded(
      memberAccount: _i4.MultiAddress.codec.decode(input),
      numSlashingSpans: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress memberAccount;

  /// u32
  final int numSlashingSpans;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'withdraw_unbonded': {
          'memberAccount': memberAccount.toJson(),
          'numSlashingSpans': numSlashingSpans,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiAddress.codec.sizeHint(memberAccount);
    size = size + _i1.U32Codec.codec.sizeHint(numSlashingSpans);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      memberAccount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numSlashingSpans,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WithdrawUnbonded &&
          other.memberAccount == memberAccount &&
          other.numSlashingSpans == numSlashingSpans;

  @override
  int get hashCode => Object.hash(
        memberAccount,
        numSlashingSpans,
      );
}

/// Create a new delegation pool.
///
/// # Arguments
///
/// * `amount` - The amount of funds to delegate to the pool. This also acts of a sort of
///  deposit since the pools creator cannot fully unbond funds until the pool is being
///  destroyed.
/// * `index` - A disambiguation index for creating the account. Likely only useful when
///  creating multiple pools in the same extrinsic.
/// * `root` - The account to set as [`PoolRoles::root`].
/// * `nominator` - The account to set as the [`PoolRoles::nominator`].
/// * `bouncer` - The account to set as the [`PoolRoles::bouncer`].
///
/// # Note
///
/// In addition to `amount`, the caller will transfer the existential deposit; so the caller
/// needs at have at least `amount + existential_deposit` transferrable.
class Create extends Call {
  const Create({
    required this.amount,
    required this.root,
    required this.nominator,
    required this.bouncer,
  });

  factory Create._decode(_i1.Input input) {
    return Create(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      root: _i4.MultiAddress.codec.decode(input),
      nominator: _i4.MultiAddress.codec.decode(input),
      bouncer: _i4.MultiAddress.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt amount;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress root;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress nominator;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress bouncer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create': {
          'amount': amount,
          'root': root.toJson(),
          'nominator': nominator.toJson(),
          'bouncer': bouncer.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i4.MultiAddress.codec.sizeHint(root);
    size = size + _i4.MultiAddress.codec.sizeHint(nominator);
    size = size + _i4.MultiAddress.codec.sizeHint(bouncer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      root,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      nominator,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      bouncer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Create &&
          other.amount == amount &&
          other.root == root &&
          other.nominator == nominator &&
          other.bouncer == bouncer;

  @override
  int get hashCode => Object.hash(
        amount,
        root,
        nominator,
        bouncer,
      );
}

/// Create a new delegation pool with a previously used pool id
///
/// # Arguments
///
/// same as `create` with the inclusion of
/// * `pool_id` - `A valid PoolId.
class CreateWithPoolId extends Call {
  const CreateWithPoolId({
    required this.amount,
    required this.root,
    required this.nominator,
    required this.bouncer,
    required this.poolId,
  });

  factory CreateWithPoolId._decode(_i1.Input input) {
    return CreateWithPoolId(
      amount: _i1.CompactBigIntCodec.codec.decode(input),
      root: _i4.MultiAddress.codec.decode(input),
      nominator: _i4.MultiAddress.codec.decode(input),
      bouncer: _i4.MultiAddress.codec.decode(input),
      poolId: _i1.U32Codec.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt amount;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress root;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress nominator;

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress bouncer;

  /// PoolId
  final int poolId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'create_with_pool_id': {
          'amount': amount,
          'root': root.toJson(),
          'nominator': nominator.toJson(),
          'bouncer': bouncer.toJson(),
          'poolId': poolId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(amount);
    size = size + _i4.MultiAddress.codec.sizeHint(root);
    size = size + _i4.MultiAddress.codec.sizeHint(nominator);
    size = size + _i4.MultiAddress.codec.sizeHint(bouncer);
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      amount,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      root,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      nominator,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      bouncer,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CreateWithPoolId &&
          other.amount == amount &&
          other.root == root &&
          other.nominator == nominator &&
          other.bouncer == bouncer &&
          other.poolId == poolId;

  @override
  int get hashCode => Object.hash(
        amount,
        root,
        nominator,
        bouncer,
        poolId,
      );
}

/// Nominate on behalf of the pool.
///
/// The dispatch origin of this call must be signed by the pool nominator or the pool
/// root role.
///
/// This directly forward the call to the staking pallet, on behalf of the pool bonded
/// account.
class Nominate extends Call {
  const Nominate({
    required this.poolId,
    required this.validators,
  });

  factory Nominate._decode(_i1.Input input) {
    return Nominate(
      poolId: _i1.U32Codec.codec.decode(input),
      validators:
          const _i1.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec())
              .decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// Vec<T::AccountId>
  final List<_i5.AccountId32> validators;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'nominate': {
          'poolId': poolId,
          'validators': validators.map((value) => value.toList()).toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size +
        const _i1.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec())
            .sizeHint(validators);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    const _i1.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec()).encodeTo(
      validators,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Nominate &&
          other.poolId == poolId &&
          _i15.listsEqual(
            other.validators,
            validators,
          );

  @override
  int get hashCode => Object.hash(
        poolId,
        validators,
      );
}

/// Set a new state for the pool.
///
/// If a pool is already in the `Destroying` state, then under no condition can its state
/// change again.
///
/// The dispatch origin of this call must be either:
///
/// 1. signed by the bouncer, or the root role of the pool,
/// 2. if the pool conditions to be open are NOT met (as described by `ok_to_be_open`), and
///   then the state of the pool can be permissionlessly changed to `Destroying`.
class SetState extends Call {
  const SetState({
    required this.poolId,
    required this.state,
  });

  factory SetState._decode(_i1.Input input) {
    return SetState(
      poolId: _i1.U32Codec.codec.decode(input),
      state: _i6.PoolState.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// PoolState
  final _i6.PoolState state;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_state': {
          'poolId': poolId,
          'state': state.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + _i6.PoolState.codec.sizeHint(state);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i6.PoolState.codec.encodeTo(
      state,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetState && other.poolId == poolId && other.state == state;

  @override
  int get hashCode => Object.hash(
        poolId,
        state,
      );
}

/// Set a new metadata for the pool.
///
/// The dispatch origin of this call must be signed by the bouncer, or the root role of the
/// pool.
class SetMetadata extends Call {
  const SetMetadata({
    required this.poolId,
    required this.metadata,
  });

  factory SetMetadata._decode(_i1.Input input) {
    return SetMetadata(
      poolId: _i1.U32Codec.codec.decode(input),
      metadata: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// Vec<u8>
  final List<int> metadata;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_metadata': {
          'poolId': poolId,
          'metadata': metadata,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(metadata);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      metadata,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMetadata &&
          other.poolId == poolId &&
          _i15.listsEqual(
            other.metadata,
            metadata,
          );

  @override
  int get hashCode => Object.hash(
        poolId,
        metadata,
      );
}

/// Update configurations for the nomination pools. The origin for this call must be
/// Root.
///
/// # Arguments
///
/// * `min_join_bond` - Set [`MinJoinBond`].
/// * `min_create_bond` - Set [`MinCreateBond`].
/// * `max_pools` - Set [`MaxPools`].
/// * `max_members` - Set [`MaxPoolMembers`].
/// * `max_members_per_pool` - Set [`MaxPoolMembersPerPool`].
/// * `global_max_commission` - Set [`GlobalMaxCommission`].
class SetConfigs extends Call {
  const SetConfigs({
    required this.minJoinBond,
    required this.minCreateBond,
    required this.maxPools,
    required this.maxMembers,
    required this.maxMembersPerPool,
    required this.globalMaxCommission,
  });

  factory SetConfigs._decode(_i1.Input input) {
    return SetConfigs(
      minJoinBond: _i7.ConfigOp.codec.decode(input),
      minCreateBond: _i7.ConfigOp.codec.decode(input),
      maxPools: _i8.ConfigOp.codec.decode(input),
      maxMembers: _i8.ConfigOp.codec.decode(input),
      maxMembersPerPool: _i8.ConfigOp.codec.decode(input),
      globalMaxCommission: _i9.ConfigOp.codec.decode(input),
    );
  }

  /// ConfigOp<BalanceOf<T>>
  final _i7.ConfigOp minJoinBond;

  /// ConfigOp<BalanceOf<T>>
  final _i7.ConfigOp minCreateBond;

  /// ConfigOp<u32>
  final _i8.ConfigOp maxPools;

  /// ConfigOp<u32>
  final _i8.ConfigOp maxMembers;

  /// ConfigOp<u32>
  final _i8.ConfigOp maxMembersPerPool;

  /// ConfigOp<Perbill>
  final _i9.ConfigOp globalMaxCommission;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_configs': {
          'minJoinBond': minJoinBond.toJson(),
          'minCreateBond': minCreateBond.toJson(),
          'maxPools': maxPools.toJson(),
          'maxMembers': maxMembers.toJson(),
          'maxMembersPerPool': maxMembersPerPool.toJson(),
          'globalMaxCommission': globalMaxCommission.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.ConfigOp.codec.sizeHint(minJoinBond);
    size = size + _i7.ConfigOp.codec.sizeHint(minCreateBond);
    size = size + _i8.ConfigOp.codec.sizeHint(maxPools);
    size = size + _i8.ConfigOp.codec.sizeHint(maxMembers);
    size = size + _i8.ConfigOp.codec.sizeHint(maxMembersPerPool);
    size = size + _i9.ConfigOp.codec.sizeHint(globalMaxCommission);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i7.ConfigOp.codec.encodeTo(
      minJoinBond,
      output,
    );
    _i7.ConfigOp.codec.encodeTo(
      minCreateBond,
      output,
    );
    _i8.ConfigOp.codec.encodeTo(
      maxPools,
      output,
    );
    _i8.ConfigOp.codec.encodeTo(
      maxMembers,
      output,
    );
    _i8.ConfigOp.codec.encodeTo(
      maxMembersPerPool,
      output,
    );
    _i9.ConfigOp.codec.encodeTo(
      globalMaxCommission,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetConfigs &&
          other.minJoinBond == minJoinBond &&
          other.minCreateBond == minCreateBond &&
          other.maxPools == maxPools &&
          other.maxMembers == maxMembers &&
          other.maxMembersPerPool == maxMembersPerPool &&
          other.globalMaxCommission == globalMaxCommission;

  @override
  int get hashCode => Object.hash(
        minJoinBond,
        minCreateBond,
        maxPools,
        maxMembers,
        maxMembersPerPool,
        globalMaxCommission,
      );
}

/// Update the roles of the pool.
///
/// The root is the only entity that can change any of the roles, including itself,
/// excluding the depositor, who can never change.
///
/// It emits an event, notifying UIs of the role change. This event is quite relevant to
/// most pool members and they should be informed of changes to pool roles.
class UpdateRoles extends Call {
  const UpdateRoles({
    required this.poolId,
    required this.newRoot,
    required this.newNominator,
    required this.newBouncer,
  });

  factory UpdateRoles._decode(_i1.Input input) {
    return UpdateRoles(
      poolId: _i1.U32Codec.codec.decode(input),
      newRoot: _i10.ConfigOp.codec.decode(input),
      newNominator: _i10.ConfigOp.codec.decode(input),
      newBouncer: _i10.ConfigOp.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// ConfigOp<T::AccountId>
  final _i10.ConfigOp newRoot;

  /// ConfigOp<T::AccountId>
  final _i10.ConfigOp newNominator;

  /// ConfigOp<T::AccountId>
  final _i10.ConfigOp newBouncer;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'update_roles': {
          'poolId': poolId,
          'newRoot': newRoot.toJson(),
          'newNominator': newNominator.toJson(),
          'newBouncer': newBouncer.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + _i10.ConfigOp.codec.sizeHint(newRoot);
    size = size + _i10.ConfigOp.codec.sizeHint(newNominator);
    size = size + _i10.ConfigOp.codec.sizeHint(newBouncer);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i10.ConfigOp.codec.encodeTo(
      newRoot,
      output,
    );
    _i10.ConfigOp.codec.encodeTo(
      newNominator,
      output,
    );
    _i10.ConfigOp.codec.encodeTo(
      newBouncer,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdateRoles &&
          other.poolId == poolId &&
          other.newRoot == newRoot &&
          other.newNominator == newNominator &&
          other.newBouncer == newBouncer;

  @override
  int get hashCode => Object.hash(
        poolId,
        newRoot,
        newNominator,
        newBouncer,
      );
}

/// Chill on behalf of the pool.
///
/// The dispatch origin of this call must be signed by the pool nominator or the pool
/// root role, same as [`Pallet::nominate`].
///
/// This directly forward the call to the staking pallet, on behalf of the pool bonded
/// account.
class Chill extends Call {
  const Chill({required this.poolId});

  factory Chill._decode(_i1.Input input) {
    return Chill(poolId: _i1.U32Codec.codec.decode(input));
  }

  /// PoolId
  final int poolId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'chill': {'poolId': poolId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Chill && other.poolId == poolId;

  @override
  int get hashCode => poolId.hashCode;
}

/// `origin` bonds funds from `extra` for some pool member `member` into their respective
/// pools.
///
/// `origin` can bond extra funds from free balance or pending rewards when `origin ==
/// other`.
///
/// In the case of `origin != other`, `origin` can only bond extra pending rewards of
/// `other` members assuming set_claim_permission for the given member is
/// `PermissionlessAll` or `PermissionlessCompound`.
class BondExtraOther extends Call {
  const BondExtraOther({
    required this.member,
    required this.extra,
  });

  factory BondExtraOther._decode(_i1.Input input) {
    return BondExtraOther(
      member: _i4.MultiAddress.codec.decode(input),
      extra: _i3.BondExtra.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i4.MultiAddress member;

  /// BondExtra<BalanceOf<T>>
  final _i3.BondExtra extra;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'bond_extra_other': {
          'member': member.toJson(),
          'extra': extra.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.MultiAddress.codec.sizeHint(member);
    size = size + _i3.BondExtra.codec.sizeHint(extra);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i4.MultiAddress.codec.encodeTo(
      member,
      output,
    );
    _i3.BondExtra.codec.encodeTo(
      extra,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BondExtraOther && other.member == member && other.extra == extra;

  @override
  int get hashCode => Object.hash(
        member,
        extra,
      );
}

/// Allows a pool member to set a claim permission to allow or disallow permissionless
/// bonding and withdrawing.
///
/// By default, this is `Permissioned`, which implies only the pool member themselves can
/// claim their pending rewards. If a pool member wishes so, they can set this to
/// `PermissionlessAll` to allow any account to claim their rewards and bond extra to the
/// pool.
///
/// # Arguments
///
/// * `origin` - Member of a pool.
/// * `actor` - Account to claim reward. // improve this
class SetClaimPermission extends Call {
  const SetClaimPermission({required this.permission});

  factory SetClaimPermission._decode(_i1.Input input) {
    return SetClaimPermission(
        permission: _i11.ClaimPermission.codec.decode(input));
  }

  /// ClaimPermission
  final _i11.ClaimPermission permission;

  @override
  Map<String, Map<String, String>> toJson() => {
        'set_claim_permission': {'permission': permission.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i11.ClaimPermission.codec.sizeHint(permission);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i11.ClaimPermission.codec.encodeTo(
      permission,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetClaimPermission && other.permission == permission;

  @override
  int get hashCode => permission.hashCode;
}

/// `origin` can claim payouts on some pool member `other`'s behalf.
///
/// Pool member `other` must have a `PermissionlessAll` or `PermissionlessWithdraw` in order
/// for this call to be successful.
class ClaimPayoutOther extends Call {
  const ClaimPayoutOther({required this.other});

  factory ClaimPayoutOther._decode(_i1.Input input) {
    return ClaimPayoutOther(other: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i5.AccountId32 other;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'claim_payout_other': {'other': other.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i5.AccountId32Codec().sizeHint(other);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      other,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimPayoutOther &&
          _i15.listsEqual(
            other.other,
            this.other,
          );

  @override
  int get hashCode => other.hashCode;
}

/// Set the commission of a pool.
/// Both a commission percentage and a commission payee must be provided in the `current`
/// tuple. Where a `current` of `None` is provided, any current commission will be removed.
///
/// - If a `None` is supplied to `new_commission`, existing commission will be removed.
class SetCommission extends Call {
  const SetCommission({
    required this.poolId,
    this.newCommission,
  });

  factory SetCommission._decode(_i1.Input input) {
    return SetCommission(
      poolId: _i1.U32Codec.codec.decode(input),
      newCommission:
          const _i1.OptionCodec<_i12.Tuple2<_i13.Perbill, _i5.AccountId32>>(
              _i12.Tuple2Codec<_i13.Perbill, _i5.AccountId32>(
        _i13.PerbillCodec(),
        _i5.AccountId32Codec(),
      )).decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// Option<(Perbill, T::AccountId)>
  final _i12.Tuple2<_i13.Perbill, _i5.AccountId32>? newCommission;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_commission': {
          'poolId': poolId,
          'newCommission': [
            newCommission?.value0,
            newCommission?.value1.toList(),
          ],
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size +
        const _i1.OptionCodec<_i12.Tuple2<_i13.Perbill, _i5.AccountId32>>(
            _i12.Tuple2Codec<_i13.Perbill, _i5.AccountId32>(
          _i13.PerbillCodec(),
          _i5.AccountId32Codec(),
        )).sizeHint(newCommission);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    const _i1.OptionCodec<_i12.Tuple2<_i13.Perbill, _i5.AccountId32>>(
        _i12.Tuple2Codec<_i13.Perbill, _i5.AccountId32>(
      _i13.PerbillCodec(),
      _i5.AccountId32Codec(),
    )).encodeTo(
      newCommission,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCommission &&
          other.poolId == poolId &&
          other.newCommission == newCommission;

  @override
  int get hashCode => Object.hash(
        poolId,
        newCommission,
      );
}

/// Set the maximum commission of a pool.
///
/// - Initial max can be set to any `Perbill`, and only smaller values thereafter.
/// - Current commission will be lowered in the event it is higher than a new max
///  commission.
class SetCommissionMax extends Call {
  const SetCommissionMax({
    required this.poolId,
    required this.maxCommission,
  });

  factory SetCommissionMax._decode(_i1.Input input) {
    return SetCommissionMax(
      poolId: _i1.U32Codec.codec.decode(input),
      maxCommission: _i1.U32Codec.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// Perbill
  final _i13.Perbill maxCommission;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_commission_max': {
          'poolId': poolId,
          'maxCommission': maxCommission,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + const _i13.PerbillCodec().sizeHint(maxCommission);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      maxCommission,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCommissionMax &&
          other.poolId == poolId &&
          other.maxCommission == maxCommission;

  @override
  int get hashCode => Object.hash(
        poolId,
        maxCommission,
      );
}

/// Set the commission change rate for a pool.
///
/// Initial change rate is not bounded, whereas subsequent updates can only be more
/// restrictive than the current.
class SetCommissionChangeRate extends Call {
  const SetCommissionChangeRate({
    required this.poolId,
    required this.changeRate,
  });

  factory SetCommissionChangeRate._decode(_i1.Input input) {
    return SetCommissionChangeRate(
      poolId: _i1.U32Codec.codec.decode(input),
      changeRate: _i14.CommissionChangeRate.codec.decode(input),
    );
  }

  /// PoolId
  final int poolId;

  /// CommissionChangeRate<T::BlockNumber>
  final _i14.CommissionChangeRate changeRate;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'set_commission_change_rate': {
          'poolId': poolId,
          'changeRate': changeRate.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    size = size + _i14.CommissionChangeRate.codec.sizeHint(changeRate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
    _i14.CommissionChangeRate.codec.encodeTo(
      changeRate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetCommissionChangeRate &&
          other.poolId == poolId &&
          other.changeRate == changeRate;

  @override
  int get hashCode => Object.hash(
        poolId,
        changeRate,
      );
}

/// Claim pending commission.
///
/// The dispatch origin of this call must be signed by the `root` role of the pool. Pending
/// commission is paid out and added to total claimed commission`. Total pending commission
/// is reset to zero. the current.
class ClaimCommission extends Call {
  const ClaimCommission({required this.poolId});

  factory ClaimCommission._decode(_i1.Input input) {
    return ClaimCommission(poolId: _i1.U32Codec.codec.decode(input));
  }

  /// PoolId
  final int poolId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'claim_commission': {'poolId': poolId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(poolId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      poolId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClaimCommission && other.poolId == poolId;

  @override
  int get hashCode => poolId.hashCode;
}
