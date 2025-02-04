// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_child_bounties/child_bounty.dart' as _i3;
import '../types/pallet_child_bounties/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _childBountyCount = const _i1.StorageValue<int>(
    prefix: 'ChildBounties',
    storage: 'ChildBountyCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, int> _parentChildBounties =
      const _i1.StorageMap<int, int>(
    prefix: 'ChildBounties',
    storage: 'ParentChildBounties',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, int, _i3.ChildBounty> _childBounties =
      const _i1.StorageDoubleMap<int, int, _i3.ChildBounty>(
    prefix: 'ChildBounties',
    storage: 'ChildBounties',
    valueCodec: _i3.ChildBounty.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, List<int>> _childBountyDescriptions =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'ChildBounties',
    storage: 'ChildBountyDescriptions',
    valueCodec: _i2.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, BigInt> _childrenCuratorFees =
      const _i1.StorageMap<int, BigInt>(
    prefix: 'ChildBounties',
    storage: 'ChildrenCuratorFees',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  /// Number of total child bounties.
  _i4.Future<int> childBountyCount({_i1.BlockHash? at}) async {
    final hashedKey = _childBountyCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _childBountyCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Number of child bounties per parent bounty.
  /// Map of parent bounty index to number of child bounties.
  _i4.Future<int> parentChildBounties(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _parentChildBounties.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parentChildBounties.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Child bounties that have been added.
  _i4.Future<_i3.ChildBounty?> childBounties(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _childBounties.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _childBounties.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The description of each child-bounty.
  _i4.Future<List<int>?> childBountyDescriptions(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _childBountyDescriptions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _childBountyDescriptions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The cumulative child-bounty curator fee for each parent bounty.
  _i4.Future<BigInt> childrenCuratorFees(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _childrenCuratorFees.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _childrenCuratorFees.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Returns the storage key for `childBountyCount`.
  _i5.Uint8List childBountyCountKey() {
    final hashedKey = _childBountyCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `parentChildBounties`.
  _i5.Uint8List parentChildBountiesKey(int key1) {
    final hashedKey = _parentChildBounties.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `childBounties`.
  _i5.Uint8List childBountiesKey(
    int key1,
    int key2,
  ) {
    final hashedKey = _childBounties.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `childBountyDescriptions`.
  _i5.Uint8List childBountyDescriptionsKey(int key1) {
    final hashedKey = _childBountyDescriptions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `childrenCuratorFees`.
  _i5.Uint8List childrenCuratorFeesKey(int key1) {
    final hashedKey = _childrenCuratorFees.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `parentChildBounties`.
  _i5.Uint8List parentChildBountiesMapPrefix() {
    final hashedKey = _parentChildBounties.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `childBounties`.
  _i5.Uint8List childBountiesMapPrefix(int key1) {
    final hashedKey = _childBounties.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `childBountyDescriptions`.
  _i5.Uint8List childBountyDescriptionsMapPrefix() {
    final hashedKey = _childBountyDescriptions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `childrenCuratorFees`.
  _i5.Uint8List childrenCuratorFeesMapPrefix() {
    final hashedKey = _childrenCuratorFees.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Add a new child-bounty.
  ///
  /// The dispatch origin for this call must be the curator of parent
  /// bounty and the parent bounty must be in "active" state.
  ///
  /// Child-bounty gets added successfully & fund gets transferred from
  /// parent bounty to child-bounty account, if parent bounty has enough
  /// funds, else the call fails.
  ///
  /// Upper bound to maximum number of active  child bounties that can be
  /// added are managed via runtime trait config
  /// [`Config::MaxActiveChildBountyCount`].
  ///
  /// If the call is success, the status of child-bounty is updated to
  /// "Added".
  ///
  /// - `parent_bounty_id`: Index of parent bounty for which child-bounty is being added.
  /// - `value`: Value for executing the proposal.
  /// - `description`: Text description for the child-bounty.
  _i6.RuntimeCall addChildBounty({
    required BigInt parentBountyId,
    required BigInt value,
    required List<int> description,
  }) {
    final _call = _i7.Call.values.addChildBounty(
      parentBountyId: parentBountyId,
      value: value,
      description: description,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Propose curator for funded child-bounty.
  ///
  /// The dispatch origin for this call must be curator of parent bounty.
  ///
  /// Parent bounty must be in active state, for this child-bounty call to
  /// work.
  ///
  /// Child-bounty must be in "Added" state, for processing the call. And
  /// state of child-bounty is moved to "CuratorProposed" on successful
  /// call completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  /// - `curator`: Address of child-bounty curator.
  /// - `fee`: payment fee to child-bounty curator for execution.
  _i6.RuntimeCall proposeCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
    required _i8.MultiAddress curator,
    required BigInt fee,
  }) {
    final _call = _i7.Call.values.proposeCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
      curator: curator,
      fee: fee,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Accept the curator role for the child-bounty.
  ///
  /// The dispatch origin for this call must be the curator of this
  /// child-bounty.
  ///
  /// A deposit will be reserved from the curator and refund upon
  /// successful payout or cancellation.
  ///
  /// Fee for curator is deducted from curator fee of parent bounty.
  ///
  /// Parent bounty must be in active state, for this child-bounty call to
  /// work.
  ///
  /// Child-bounty must be in "CuratorProposed" state, for processing the
  /// call. And state of child-bounty is moved to "Active" on successful
  /// call completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  _i6.RuntimeCall acceptCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    final _call = _i7.Call.values.acceptCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Unassign curator from a child-bounty.
  ///
  /// The dispatch origin for this call can be either `RejectOrigin`, or
  /// the curator of the parent bounty, or any signed origin.
  ///
  /// For the origin other than T::RejectOrigin and the child-bounty
  /// curator, parent bounty must be in active state, for this call to
  /// work. We allow child-bounty curator and T::RejectOrigin to execute
  /// this call irrespective of the parent bounty state.
  ///
  /// If this function is called by the `RejectOrigin` or the
  /// parent bounty curator, we assume that the child-bounty curator is
  /// malicious or inactive. As a result, child-bounty curator deposit is
  /// slashed.
  ///
  /// If the origin is the child-bounty curator, we take this as a sign
  /// that they are unable to do their job, and are willingly giving up.
  /// We could slash the deposit, but for now we allow them to unreserve
  /// their deposit and exit without issue. (We may want to change this if
  /// it is abused.)
  ///
  /// Finally, the origin can be anyone iff the child-bounty curator is
  /// "inactive". Expiry update due of parent bounty is used to estimate
  /// inactive state of child-bounty curator.
  ///
  /// This allows anyone in the community to call out that a child-bounty
  /// curator is not doing their due diligence, and we should pick a new
  /// one. In this case the child-bounty curator deposit is slashed.
  ///
  /// State of child-bounty is moved to Added state on successful call
  /// completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  _i6.RuntimeCall unassignCurator({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    final _call = _i7.Call.values.unassignCurator(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Award child-bounty to a beneficiary.
  ///
  /// The beneficiary will be able to claim the funds after a delay.
  ///
  /// The dispatch origin for this call must be the parent curator or
  /// curator of this child-bounty.
  ///
  /// Parent bounty must be in active state, for this child-bounty call to
  /// work.
  ///
  /// Child-bounty must be in active state, for processing the call. And
  /// state of child-bounty is moved to "PendingPayout" on successful call
  /// completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  /// - `beneficiary`: Beneficiary account.
  _i6.RuntimeCall awardChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
    required _i8.MultiAddress beneficiary,
  }) {
    final _call = _i7.Call.values.awardChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
      beneficiary: beneficiary,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Claim the payout from an awarded child-bounty after payout delay.
  ///
  /// The dispatch origin for this call may be any signed origin.
  ///
  /// Call works independent of parent bounty state, No need for parent
  /// bounty to be in active state.
  ///
  /// The Beneficiary is paid out with agreed bounty value. Curator fee is
  /// paid & curator deposit is unreserved.
  ///
  /// Child-bounty must be in "PendingPayout" state, for processing the
  /// call. And instance of child-bounty is removed from the state on
  /// successful call completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  _i6.RuntimeCall claimChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    final _call = _i7.Call.values.claimChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }

  /// Cancel a proposed or active child-bounty. Child-bounty account funds
  /// are transferred to parent bounty account. The child-bounty curator
  /// deposit may be unreserved if possible.
  ///
  /// The dispatch origin for this call must be either parent curator or
  /// `T::RejectOrigin`.
  ///
  /// If the state of child-bounty is `Active`, curator deposit is
  /// unreserved.
  ///
  /// If the state of child-bounty is `PendingPayout`, call fails &
  /// returns `PendingPayout` error.
  ///
  /// For the origin other than T::RejectOrigin, parent bounty must be in
  /// active state, for this child-bounty call to work. For origin
  /// T::RejectOrigin execution is forced.
  ///
  /// Instance of child-bounty is removed from the state on successful
  /// call completion.
  ///
  /// - `parent_bounty_id`: Index of parent bounty.
  /// - `child_bounty_id`: Index of child bounty.
  _i6.RuntimeCall closeChildBounty({
    required BigInt parentBountyId,
    required BigInt childBountyId,
  }) {
    final _call = _i7.Call.values.closeChildBounty(
      parentBountyId: parentBountyId,
      childBountyId: childBountyId,
    );
    return _i6.RuntimeCall.values.childBounties(_call);
  }
}

class Constants {
  Constants();

  /// Maximum number of child bounties that can be added to a parent bounty.
  final int maxActiveChildBountyCount = 100;

  /// Minimum value for a child-bounty.
  final BigInt childBountyValueMinimum = BigInt.from(10000000000);
}
