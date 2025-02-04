// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:typed_data' as _i11;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/frame_support/pallet_id.dart' as _i24;
import '../types/pallet_nomination_pools/bond_extra.dart' as _i14;
import '../types/pallet_nomination_pools/bonded_pool_inner.dart' as _i6;
import '../types/pallet_nomination_pools/claim_permission.dart' as _i9;
import '../types/pallet_nomination_pools/commission_change_rate.dart' as _i22;
import '../types/pallet_nomination_pools/commission_claim_permission.dart'
    as _i23;
import '../types/pallet_nomination_pools/config_op_1.dart' as _i17;
import '../types/pallet_nomination_pools/config_op_2.dart' as _i18;
import '../types/pallet_nomination_pools/config_op_3.dart' as _i19;
import '../types/pallet_nomination_pools/config_op_4.dart' as _i20;
import '../types/pallet_nomination_pools/pallet/call.dart' as _i13;
import '../types/pallet_nomination_pools/pool_member.dart' as _i5;
import '../types/pallet_nomination_pools/pool_state.dart' as _i16;
import '../types/pallet_nomination_pools/reward_pool.dart' as _i7;
import '../types/pallet_nomination_pools/sub_pools.dart' as _i8;
import '../types/polkadot_runtime/runtime_call.dart' as _i12;
import '../types/sp_arithmetic/per_things/perbill.dart' as _i3;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i15;
import '../types/tuples.dart' as _i21;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _totalValueLocked =
      const _i1.StorageValue<BigInt>(
    prefix: 'NominationPools',
    storage: 'TotalValueLocked',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<BigInt> _minJoinBond = const _i1.StorageValue<BigInt>(
    prefix: 'NominationPools',
    storage: 'MinJoinBond',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<BigInt> _minCreateBond =
      const _i1.StorageValue<BigInt>(
    prefix: 'NominationPools',
    storage: 'MinCreateBond',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<int> _maxPools = const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'MaxPools',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxPoolMembers = const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'MaxPoolMembers',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _maxPoolMembersPerPool =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'MaxPoolMembersPerPool',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i3.Perbill> _globalMaxCommission =
      const _i1.StorageValue<_i3.Perbill>(
    prefix: 'NominationPools',
    storage: 'GlobalMaxCommission',
    valueCodec: _i3.PerbillCodec(),
  );

  final _i1.StorageMap<_i4.AccountId32, _i5.PoolMember> _poolMembers =
      const _i1.StorageMap<_i4.AccountId32, _i5.PoolMember>(
    prefix: 'NominationPools',
    storage: 'PoolMembers',
    valueCodec: _i5.PoolMember.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForPoolMembers =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForPoolMembers',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i6.BondedPoolInner> _bondedPools =
      const _i1.StorageMap<int, _i6.BondedPoolInner>(
    prefix: 'NominationPools',
    storage: 'BondedPools',
    valueCodec: _i6.BondedPoolInner.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<int> _counterForBondedPools =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForBondedPools',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i7.RewardPool> _rewardPools =
      const _i1.StorageMap<int, _i7.RewardPool>(
    prefix: 'NominationPools',
    storage: 'RewardPools',
    valueCodec: _i7.RewardPool.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<int> _counterForRewardPools =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForRewardPools',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i8.SubPools> _subPoolsStorage =
      const _i1.StorageMap<int, _i8.SubPools>(
    prefix: 'NominationPools',
    storage: 'SubPoolsStorage',
    valueCodec: _i8.SubPools.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<int> _counterForSubPoolsStorage =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForSubPoolsStorage',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, List<int>> _metadata =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'NominationPools',
    storage: 'Metadata',
    valueCodec: _i2.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<int> _counterForMetadata = const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForMetadata',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<int> _lastPoolId = const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'LastPoolId',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<_i4.AccountId32, int> _reversePoolIdLookup =
      const _i1.StorageMap<_i4.AccountId32, int>(
    prefix: 'NominationPools',
    storage: 'ReversePoolIdLookup',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForReversePoolIdLookup =
      const _i1.StorageValue<int>(
    prefix: 'NominationPools',
    storage: 'CounterForReversePoolIdLookup',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<_i4.AccountId32, _i9.ClaimPermission> _claimPermissions =
      const _i1.StorageMap<_i4.AccountId32, _i9.ClaimPermission>(
    prefix: 'NominationPools',
    storage: 'ClaimPermissions',
    valueCodec: _i9.ClaimPermission.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.AccountId32Codec()),
  );

  /// The sum of funds across all pools.
  ///
  /// This might be lower but never higher than the sum of `total_balance` of all [`PoolMembers`]
  /// because calling `pool_withdraw_unbonded` might decrease the total stake of the pool's
  /// `bonded_account` without adjusting the pallet-internal `UnbondingPool`'s.
  _i10.Future<BigInt> totalValueLocked({_i1.BlockHash? at}) async {
    final hashedKey = _totalValueLocked.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _totalValueLocked.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Minimum amount to bond to join a pool.
  _i10.Future<BigInt> minJoinBond({_i1.BlockHash? at}) async {
    final hashedKey = _minJoinBond.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minJoinBond.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Minimum bond required to create a pool.
  ///
  /// This is the amount that the depositor must put as their initial stake in the pool, as an
  /// indication of "skin in the game".
  ///
  /// This is the value that will always exist in the staking ledger of the pool bonded account
  /// while all other accounts leave.
  _i10.Future<BigInt> minCreateBond({_i1.BlockHash? at}) async {
    final hashedKey = _minCreateBond.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _minCreateBond.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Maximum number of nomination pools that can exist. If `None`, then an unbounded number of
  /// pools can exist.
  _i10.Future<int?> maxPools({_i1.BlockHash? at}) async {
    final hashedKey = _maxPools.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxPools.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Maximum number of members that can exist in the system. If `None`, then the count
  /// members are not bound on a system wide basis.
  _i10.Future<int?> maxPoolMembers({_i1.BlockHash? at}) async {
    final hashedKey = _maxPoolMembers.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxPoolMembers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Maximum number of members that may belong to pool. If `None`, then the count of
  /// members is not bound on a per pool basis.
  _i10.Future<int?> maxPoolMembersPerPool({_i1.BlockHash? at}) async {
    final hashedKey = _maxPoolMembersPerPool.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _maxPoolMembersPerPool.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The maximum commission that can be charged by a pool. Used on commission payouts to bound
  /// pool commissions that are > `GlobalMaxCommission`, necessary if a future
  /// `GlobalMaxCommission` is lower than some current pool commissions.
  _i10.Future<_i3.Perbill?> globalMaxCommission({_i1.BlockHash? at}) async {
    final hashedKey = _globalMaxCommission.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _globalMaxCommission.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Active members.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i10.Future<_i5.PoolMember?> poolMembers(
    _i4.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _poolMembers.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _poolMembers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForPoolMembers({_i1.BlockHash? at}) async {
    final hashedKey = _counterForPoolMembers.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForPoolMembers.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Storage for bonded pools.
  _i10.Future<_i6.BondedPoolInner?> bondedPools(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bondedPools.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bondedPools.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForBondedPools({_i1.BlockHash? at}) async {
    final hashedKey = _counterForBondedPools.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForBondedPools.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Reward pools. This is where there rewards for each pool accumulate. When a members payout is
  /// claimed, the balance comes out of the reward pool. Keyed by the bonded pools account.
  _i10.Future<_i7.RewardPool?> rewardPools(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _rewardPools.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _rewardPools.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForRewardPools({_i1.BlockHash? at}) async {
    final hashedKey = _counterForRewardPools.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForRewardPools.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Groups of unbonding pools. Each group of unbonding pools belongs to a
  /// bonded pool, hence the name sub-pools. Keyed by the bonded pools account.
  _i10.Future<_i8.SubPools?> subPoolsStorage(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _subPoolsStorage.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _subPoolsStorage.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForSubPoolsStorage({_i1.BlockHash? at}) async {
    final hashedKey = _counterForSubPoolsStorage.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForSubPoolsStorage.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Metadata for the pool.
  _i10.Future<List<int>> metadata(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _metadata.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _metadata.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForMetadata({_i1.BlockHash? at}) async {
    final hashedKey = _counterForMetadata.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForMetadata.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Ever increasing number of all pools created so far.
  _i10.Future<int> lastPoolId({_i1.BlockHash? at}) async {
    final hashedKey = _lastPoolId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastPoolId.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// A reverse lookup from the pool's account id to its id.
  ///
  /// This is only used for slashing and on automatic withdraw update. In all other instances, the
  /// pool id is used, and the accounts are deterministically derived from it.
  _i10.Future<int?> reversePoolIdLookup(
    _i4.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reversePoolIdLookup.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reversePoolIdLookup.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i10.Future<int> counterForReversePoolIdLookup({_i1.BlockHash? at}) async {
    final hashedKey = _counterForReversePoolIdLookup.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForReversePoolIdLookup.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Map from a pool member account to their opted claim permission.
  _i10.Future<_i9.ClaimPermission> claimPermissions(
    _i4.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _claimPermissions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _claimPermissions.decodeValue(bytes);
    }
    return _i9.ClaimPermission.permissionlessWithdraw; /* Default */
  }

  /// Returns the storage key for `totalValueLocked`.
  _i11.Uint8List totalValueLockedKey() {
    final hashedKey = _totalValueLocked.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minJoinBond`.
  _i11.Uint8List minJoinBondKey() {
    final hashedKey = _minJoinBond.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `minCreateBond`.
  _i11.Uint8List minCreateBondKey() {
    final hashedKey = _minCreateBond.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxPools`.
  _i11.Uint8List maxPoolsKey() {
    final hashedKey = _maxPools.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxPoolMembers`.
  _i11.Uint8List maxPoolMembersKey() {
    final hashedKey = _maxPoolMembers.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `maxPoolMembersPerPool`.
  _i11.Uint8List maxPoolMembersPerPoolKey() {
    final hashedKey = _maxPoolMembersPerPool.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `globalMaxCommission`.
  _i11.Uint8List globalMaxCommissionKey() {
    final hashedKey = _globalMaxCommission.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `poolMembers`.
  _i11.Uint8List poolMembersKey(_i4.AccountId32 key1) {
    final hashedKey = _poolMembers.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForPoolMembers`.
  _i11.Uint8List counterForPoolMembersKey() {
    final hashedKey = _counterForPoolMembers.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `bondedPools`.
  _i11.Uint8List bondedPoolsKey(int key1) {
    final hashedKey = _bondedPools.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForBondedPools`.
  _i11.Uint8List counterForBondedPoolsKey() {
    final hashedKey = _counterForBondedPools.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `rewardPools`.
  _i11.Uint8List rewardPoolsKey(int key1) {
    final hashedKey = _rewardPools.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForRewardPools`.
  _i11.Uint8List counterForRewardPoolsKey() {
    final hashedKey = _counterForRewardPools.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `subPoolsStorage`.
  _i11.Uint8List subPoolsStorageKey(int key1) {
    final hashedKey = _subPoolsStorage.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForSubPoolsStorage`.
  _i11.Uint8List counterForSubPoolsStorageKey() {
    final hashedKey = _counterForSubPoolsStorage.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `metadata`.
  _i11.Uint8List metadataKey(int key1) {
    final hashedKey = _metadata.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForMetadata`.
  _i11.Uint8List counterForMetadataKey() {
    final hashedKey = _counterForMetadata.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `lastPoolId`.
  _i11.Uint8List lastPoolIdKey() {
    final hashedKey = _lastPoolId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `reversePoolIdLookup`.
  _i11.Uint8List reversePoolIdLookupKey(_i4.AccountId32 key1) {
    final hashedKey = _reversePoolIdLookup.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `counterForReversePoolIdLookup`.
  _i11.Uint8List counterForReversePoolIdLookupKey() {
    final hashedKey = _counterForReversePoolIdLookup.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `claimPermissions`.
  _i11.Uint8List claimPermissionsKey(_i4.AccountId32 key1) {
    final hashedKey = _claimPermissions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `poolMembers`.
  _i11.Uint8List poolMembersMapPrefix() {
    final hashedKey = _poolMembers.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `bondedPools`.
  _i11.Uint8List bondedPoolsMapPrefix() {
    final hashedKey = _bondedPools.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `rewardPools`.
  _i11.Uint8List rewardPoolsMapPrefix() {
    final hashedKey = _rewardPools.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `subPoolsStorage`.
  _i11.Uint8List subPoolsStorageMapPrefix() {
    final hashedKey = _subPoolsStorage.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `metadata`.
  _i11.Uint8List metadataMapPrefix() {
    final hashedKey = _metadata.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reversePoolIdLookup`.
  _i11.Uint8List reversePoolIdLookupMapPrefix() {
    final hashedKey = _reversePoolIdLookup.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `claimPermissions`.
  _i11.Uint8List claimPermissionsMapPrefix() {
    final hashedKey = _claimPermissions.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

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
  _i12.RuntimeCall join({
    required BigInt amount,
    required int poolId,
  }) {
    final _call = _i13.Call.values.join(
      amount: amount,
      poolId: poolId,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Bond `extra` more funds from `origin` into the pool to which they already belong.
  ///
  /// Additional funds can come from either the free balance of the account, of from the
  /// accumulated rewards, see [`BondExtra`].
  ///
  /// Bonding extra funds implies an automatic payout of all pending rewards as well.
  /// See `bond_extra_other` to bond pending rewards of `other` members.
  _i12.RuntimeCall bondExtra({required _i14.BondExtra extra}) {
    final _call = _i13.Call.values.bondExtra(extra: extra);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// A bonded member can use this to claim their payout based on the rewards that the pool
  /// has accumulated since their last claimed payout (OR since joining if this is their first
  /// time claiming rewards). The payout will be transferred to the member's account.
  ///
  /// The member will earn rewards pro rata based on the members stake vs the sum of the
  /// members in the pools stake. Rewards do not "expire".
  ///
  /// See `claim_payout_other` to claim rewards on behalf of some `other` pool member.
  _i12.RuntimeCall claimPayout() {
    final _call = _i13.Call.values.claimPayout();
    return _i12.RuntimeCall.values.nominationPools(_call);
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
  _i12.RuntimeCall unbond({
    required _i15.MultiAddress memberAccount,
    required BigInt unbondingPoints,
  }) {
    final _call = _i13.Call.values.unbond(
      memberAccount: memberAccount,
      unbondingPoints: unbondingPoints,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Call `withdraw_unbonded` for the pools account. This call can be made by any account.
  ///
  /// This is useful if there are too many unlocking chunks to call `unbond`, and some
  /// can be cleared by withdrawing. In the case there are too many unlocking chunks, the user
  /// would probably see an error like `NoMoreChunks` emitted from the staking system when
  /// they attempt to unbond.
  _i12.RuntimeCall poolWithdrawUnbonded({
    required int poolId,
    required int numSlashingSpans,
  }) {
    final _call = _i13.Call.values.poolWithdrawUnbonded(
      poolId: poolId,
      numSlashingSpans: numSlashingSpans,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
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
  /// - If the target is the depositor, the pool will be destroyed.
  /// - If the pool has any pending slash, we also try to slash the member before letting them
  /// withdraw. This calculation adds some weight overhead and is only defensive. In reality,
  /// pool slashes must have been already applied via permissionless [`Call::apply_slash`].
  _i12.RuntimeCall withdrawUnbonded({
    required _i15.MultiAddress memberAccount,
    required int numSlashingSpans,
  }) {
    final _call = _i13.Call.values.withdrawUnbonded(
      memberAccount: memberAccount,
      numSlashingSpans: numSlashingSpans,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
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
  /// needs at have at least `amount + existential_deposit` transferable.
  _i12.RuntimeCall create({
    required BigInt amount,
    required _i15.MultiAddress root,
    required _i15.MultiAddress nominator,
    required _i15.MultiAddress bouncer,
  }) {
    final _call = _i13.Call.values.create(
      amount: amount,
      root: root,
      nominator: nominator,
      bouncer: bouncer,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Create a new delegation pool with a previously used pool id
  ///
  /// # Arguments
  ///
  /// same as `create` with the inclusion of
  /// * `pool_id` - `A valid PoolId.
  _i12.RuntimeCall createWithPoolId({
    required BigInt amount,
    required _i15.MultiAddress root,
    required _i15.MultiAddress nominator,
    required _i15.MultiAddress bouncer,
    required int poolId,
  }) {
    final _call = _i13.Call.values.createWithPoolId(
      amount: amount,
      root: root,
      nominator: nominator,
      bouncer: bouncer,
      poolId: poolId,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Nominate on behalf of the pool.
  ///
  /// The dispatch origin of this call must be signed by the pool nominator or the pool
  /// root role.
  ///
  /// This directly forward the call to the staking pallet, on behalf of the pool bonded
  /// account.
  ///
  /// # Note
  ///
  /// In addition to a `root` or `nominator` role of `origin`, pool's depositor needs to have
  /// at least `depositor_min_bond` in the pool to start nominating.
  _i12.RuntimeCall nominate({
    required int poolId,
    required List<_i4.AccountId32> validators,
  }) {
    final _call = _i13.Call.values.nominate(
      poolId: poolId,
      validators: validators,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
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
  _i12.RuntimeCall setState({
    required int poolId,
    required _i16.PoolState state,
  }) {
    final _call = _i13.Call.values.setState(
      poolId: poolId,
      state: state,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Set a new metadata for the pool.
  ///
  /// The dispatch origin of this call must be signed by the bouncer, or the root role of the
  /// pool.
  _i12.RuntimeCall setMetadata({
    required int poolId,
    required List<int> metadata,
  }) {
    final _call = _i13.Call.values.setMetadata(
      poolId: poolId,
      metadata: metadata,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Update configurations for the nomination pools. The origin for this call must be
  /// [`Config::AdminOrigin`].
  ///
  /// # Arguments
  ///
  /// * `min_join_bond` - Set [`MinJoinBond`].
  /// * `min_create_bond` - Set [`MinCreateBond`].
  /// * `max_pools` - Set [`MaxPools`].
  /// * `max_members` - Set [`MaxPoolMembers`].
  /// * `max_members_per_pool` - Set [`MaxPoolMembersPerPool`].
  /// * `global_max_commission` - Set [`GlobalMaxCommission`].
  _i12.RuntimeCall setConfigs({
    required _i17.ConfigOp minJoinBond,
    required _i17.ConfigOp minCreateBond,
    required _i18.ConfigOp maxPools,
    required _i18.ConfigOp maxMembers,
    required _i18.ConfigOp maxMembersPerPool,
    required _i19.ConfigOp globalMaxCommission,
  }) {
    final _call = _i13.Call.values.setConfigs(
      minJoinBond: minJoinBond,
      minCreateBond: minCreateBond,
      maxPools: maxPools,
      maxMembers: maxMembers,
      maxMembersPerPool: maxMembersPerPool,
      globalMaxCommission: globalMaxCommission,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Update the roles of the pool.
  ///
  /// The root is the only entity that can change any of the roles, including itself,
  /// excluding the depositor, who can never change.
  ///
  /// It emits an event, notifying UIs of the role change. This event is quite relevant to
  /// most pool members and they should be informed of changes to pool roles.
  _i12.RuntimeCall updateRoles({
    required int poolId,
    required _i20.ConfigOp newRoot,
    required _i20.ConfigOp newNominator,
    required _i20.ConfigOp newBouncer,
  }) {
    final _call = _i13.Call.values.updateRoles(
      poolId: poolId,
      newRoot: newRoot,
      newNominator: newNominator,
      newBouncer: newBouncer,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Chill on behalf of the pool.
  ///
  /// The dispatch origin of this call can be signed by the pool nominator or the pool
  /// root role, same as [`Pallet::nominate`].
  ///
  /// Under certain conditions, this call can be dispatched permissionlessly (i.e. by any
  /// account).
  ///
  /// # Conditions for a permissionless dispatch:
  /// * When pool depositor has less than `MinNominatorBond` staked, otherwise  pool members
  ///  are unable to unbond.
  ///
  /// # Conditions for permissioned dispatch:
  /// * The caller has a nominator or root role of the pool.
  /// This directly forward the call to the staking pallet, on behalf of the pool bonded
  /// account.
  _i12.RuntimeCall chill({required int poolId}) {
    final _call = _i13.Call.values.chill(poolId: poolId);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// `origin` bonds funds from `extra` for some pool member `member` into their respective
  /// pools.
  ///
  /// `origin` can bond extra funds from free balance or pending rewards when `origin ==
  /// other`.
  ///
  /// In the case of `origin != other`, `origin` can only bond extra pending rewards of
  /// `other` members assuming set_claim_permission for the given member is
  /// `PermissionlessCompound` or `PermissionlessAll`.
  _i12.RuntimeCall bondExtraOther({
    required _i15.MultiAddress member,
    required _i14.BondExtra extra,
  }) {
    final _call = _i13.Call.values.bondExtraOther(
      member: member,
      extra: extra,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Allows a pool member to set a claim permission to allow or disallow permissionless
  /// bonding and withdrawing.
  ///
  /// # Arguments
  ///
  /// * `origin` - Member of a pool.
  /// * `permission` - The permission to be applied.
  _i12.RuntimeCall setClaimPermission(
      {required _i9.ClaimPermission permission}) {
    final _call = _i13.Call.values.setClaimPermission(permission: permission);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// `origin` can claim payouts on some pool member `other`'s behalf.
  ///
  /// Pool member `other` must have a `PermissionlessWithdraw` or `PermissionlessAll` claim
  /// permission for this call to be successful.
  _i12.RuntimeCall claimPayoutOther({required _i4.AccountId32 other}) {
    final _call = _i13.Call.values.claimPayoutOther(other: other);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Set the commission of a pool.
  /// Both a commission percentage and a commission payee must be provided in the `current`
  /// tuple. Where a `current` of `None` is provided, any current commission will be removed.
  ///
  /// - If a `None` is supplied to `new_commission`, existing commission will be removed.
  _i12.RuntimeCall setCommission({
    required int poolId,
    _i21.Tuple2<_i3.Perbill, _i4.AccountId32>? newCommission,
  }) {
    final _call = _i13.Call.values.setCommission(
      poolId: poolId,
      newCommission: newCommission,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Set the maximum commission of a pool.
  ///
  /// - Initial max can be set to any `Perbill`, and only smaller values thereafter.
  /// - Current commission will be lowered in the event it is higher than a new max
  ///  commission.
  _i12.RuntimeCall setCommissionMax({
    required int poolId,
    required _i3.Perbill maxCommission,
  }) {
    final _call = _i13.Call.values.setCommissionMax(
      poolId: poolId,
      maxCommission: maxCommission,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Set the commission change rate for a pool.
  ///
  /// Initial change rate is not bounded, whereas subsequent updates can only be more
  /// restrictive than the current.
  _i12.RuntimeCall setCommissionChangeRate({
    required int poolId,
    required _i22.CommissionChangeRate changeRate,
  }) {
    final _call = _i13.Call.values.setCommissionChangeRate(
      poolId: poolId,
      changeRate: changeRate,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Claim pending commission.
  ///
  /// The dispatch origin of this call must be signed by the `root` role of the pool. Pending
  /// commission is paid out and added to total claimed commission`. Total pending commission
  /// is reset to zero. the current.
  _i12.RuntimeCall claimCommission({required int poolId}) {
    final _call = _i13.Call.values.claimCommission(poolId: poolId);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Top up the deficit or withdraw the excess ED from the pool.
  ///
  /// When a pool is created, the pool depositor transfers ED to the reward account of the
  /// pool. ED is subject to change and over time, the deposit in the reward account may be
  /// insufficient to cover the ED deficit of the pool or vice-versa where there is excess
  /// deposit to the pool. This call allows anyone to adjust the ED deposit of the
  /// pool by either topping up the deficit or claiming the excess.
  _i12.RuntimeCall adjustPoolDeposit({required int poolId}) {
    final _call = _i13.Call.values.adjustPoolDeposit(poolId: poolId);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Set or remove a pool's commission claim permission.
  ///
  /// Determines who can claim the pool's pending commission. Only the `Root` role of the pool
  /// is able to configure commission claim permissions.
  _i12.RuntimeCall setCommissionClaimPermission({
    required int poolId,
    _i23.CommissionClaimPermission? permission,
  }) {
    final _call = _i13.Call.values.setCommissionClaimPermission(
      poolId: poolId,
      permission: permission,
    );
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Apply a pending slash on a member.
  ///
  /// Fails unless [`crate::pallet::Config::StakeAdapter`] is of strategy type:
  /// [`adapter::StakeStrategyType::Delegate`].
  ///
  /// This call can be dispatched permissionlessly (i.e. by any account). If the member has
  /// slash to be applied, caller may be rewarded with the part of the slash.
  _i12.RuntimeCall applySlash({required _i15.MultiAddress memberAccount}) {
    final _call = _i13.Call.values.applySlash(memberAccount: memberAccount);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Migrates delegated funds from the pool account to the `member_account`.
  ///
  /// Fails unless [`crate::pallet::Config::StakeAdapter`] is of strategy type:
  /// [`adapter::StakeStrategyType::Delegate`].
  ///
  /// This is a permission-less call and refunds any fee if claim is successful.
  ///
  /// If the pool has migrated to delegation based staking, the staked tokens of pool members
  /// can be moved and held in their own account. See [`adapter::DelegateStake`]
  _i12.RuntimeCall migrateDelegation(
      {required _i15.MultiAddress memberAccount}) {
    final _call =
        _i13.Call.values.migrateDelegation(memberAccount: memberAccount);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }

  /// Migrate pool from [`adapter::StakeStrategyType::Transfer`] to
  /// [`adapter::StakeStrategyType::Delegate`].
  ///
  /// Fails unless [`crate::pallet::Config::StakeAdapter`] is of strategy type:
  /// [`adapter::StakeStrategyType::Delegate`].
  ///
  /// This call can be dispatched permissionlessly, and refunds any fee if successful.
  ///
  /// If the pool has already migrated to delegation based staking, this call will fail.
  _i12.RuntimeCall migratePoolToDelegateStake({required int poolId}) {
    final _call = _i13.Call.values.migratePoolToDelegateStake(poolId: poolId);
    return _i12.RuntimeCall.values.nominationPools(_call);
  }
}

class Constants {
  Constants();

  /// The nomination pool's pallet id.
  final _i24.PalletId palletId = const <int>[
    112,
    121,
    47,
    110,
    111,
    112,
    108,
    115,
  ];

  /// The maximum pool points-to-balance ratio that an `open` pool can have.
  ///
  /// This is important in the event slashing takes place and the pool's points-to-balance
  /// ratio becomes disproportional.
  ///
  /// Moreover, this relates to the `RewardCounter` type as well, as the arithmetic operations
  /// are a function of number of points, and by setting this value to e.g. 10, you ensure
  /// that the total number of points in the system are at most 10 times the total_issuance of
  /// the chain, in the absolute worse case.
  ///
  /// For a value of 10, the threshold would be a pool points-to-balance ratio of 10:1.
  /// Such a scenario would also be the equivalent of the pool being 90% slashed.
  final int maxPointsToBalance = 10;

  /// The maximum number of simultaneous unbonding chunks that can exist per member.
  final int maxUnbonding = 32;
}
