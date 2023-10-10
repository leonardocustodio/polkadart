// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_bounties/bounty.dart' as _i3;
import '../types/pallet_bounties/pallet/call.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i5;
import '../types/sp_arithmetic/per_things/permill.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _bountyCount = const _i1.StorageValue<int>(
    prefix: 'Bounties',
    storage: 'BountyCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i3.Bounty> _bounties =
      const _i1.StorageMap<int, _i3.Bounty>(
    prefix: 'Bounties',
    storage: 'Bounties',
    valueCodec: _i3.Bounty.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageMap<int, List<int>> _bountyDescriptions =
      const _i1.StorageMap<int, List<int>>(
    prefix: 'Bounties',
    storage: 'BountyDescriptions',
    valueCodec: _i2.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<List<int>> _bountyApprovals =
      const _i1.StorageValue<List<int>>(
    prefix: 'Bounties',
    storage: 'BountyApprovals',
    valueCodec: _i2.U32SequenceCodec.codec,
  );

  /// Number of bounty proposals that have been made.
  _i4.Future<int> bountyCount({_i1.BlockHash? at}) async {
    final hashedKey = _bountyCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bountyCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Bounties that have been made.
  _i4.Future<_i3.Bounty?> bounties(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bounties.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bounties.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The description of each bounty.
  _i4.Future<List<int>?> bountyDescriptions(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _bountyDescriptions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bountyDescriptions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Bounty indices that have been approved but not yet funded.
  _i4.Future<List<int>> bountyApprovals({_i1.BlockHash? at}) async {
    final hashedKey = _bountyApprovals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _bountyApprovals.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }
}

class Txs {
  const Txs();

  /// Propose a new bounty.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Payment: `TipReportDepositBase` will be reserved from the origin account, as well as
  /// `DataDepositPerByte` for each byte in `reason`. It will be unreserved upon approval,
  /// or slashed when rejected.
  ///
  /// - `curator`: The curator account whom will manage this bounty.
  /// - `fee`: The curator fee.
  /// - `value`: The total payment amount of this bounty, curator fee included.
  /// - `description`: The description of this bounty.
  _i5.RuntimeCall proposeBounty({
    required value,
    required description,
  }) {
    final _call = _i6.Call.values.proposeBounty(
      value: value,
      description: description,
    );
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Approve a bounty proposal. At a later time, the bounty will be funded and become active
  /// and the original deposit will be returned.
  ///
  /// May only be called from `T::SpendOrigin`.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall approveBounty({required bountyId}) {
    final _call = _i6.Call.values.approveBounty(bountyId: bountyId);
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Assign a curator to a funded bounty.
  ///
  /// May only be called from `T::SpendOrigin`.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall proposeCurator({
    required bountyId,
    required curator,
    required fee,
  }) {
    final _call = _i6.Call.values.proposeCurator(
      bountyId: bountyId,
      curator: curator,
      fee: fee,
    );
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Unassign curator from a bounty.
  ///
  /// This function can only be called by the `RejectOrigin` a signed origin.
  ///
  /// If this function is called by the `RejectOrigin`, we assume that the curator is
  /// malicious or inactive. As a result, we will slash the curator when possible.
  ///
  /// If the origin is the curator, we take this as a sign they are unable to do their job and
  /// they willingly give up. We could slash them, but for now we allow them to recover their
  /// deposit and exit without issue. (We may want to change this if it is abused.)
  ///
  /// Finally, the origin can be anyone if and only if the curator is "inactive". This allows
  /// anyone in the community to call out that a curator is not doing their due diligence, and
  /// we should pick a new curator. In this case the curator should also be slashed.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall unassignCurator({required bountyId}) {
    final _call = _i6.Call.values.unassignCurator(bountyId: bountyId);
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Accept the curator role for a bounty.
  /// A deposit will be reserved from curator and refund upon successful payout.
  ///
  /// May only be called from the curator.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall acceptCurator({required bountyId}) {
    final _call = _i6.Call.values.acceptCurator(bountyId: bountyId);
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Award bounty to a beneficiary account. The beneficiary will be able to claim the funds
  /// after a delay.
  ///
  /// The dispatch origin for this call must be the curator of this bounty.
  ///
  /// - `bounty_id`: Bounty ID to award.
  /// - `beneficiary`: The beneficiary account whom will receive the payout.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall awardBounty({
    required bountyId,
    required beneficiary,
  }) {
    final _call = _i6.Call.values.awardBounty(
      bountyId: bountyId,
      beneficiary: beneficiary,
    );
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Claim the payout from an awarded bounty after payout delay.
  ///
  /// The dispatch origin for this call must be the beneficiary of this bounty.
  ///
  /// - `bounty_id`: Bounty ID to claim.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall claimBounty({required bountyId}) {
    final _call = _i6.Call.values.claimBounty(bountyId: bountyId);
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Cancel a proposed or active bounty. All the funds will be sent to treasury and
  /// the curator deposit will be unreserved if possible.
  ///
  /// Only `T::RejectOrigin` is able to cancel a bounty.
  ///
  /// - `bounty_id`: Bounty ID to cancel.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall closeBounty({required bountyId}) {
    final _call = _i6.Call.values.closeBounty(bountyId: bountyId);
    return _i5.RuntimeCall.values.bounties(_call);
  }

  /// Extend the expiry time of an active bounty.
  ///
  /// The dispatch origin for this call must be the curator of this bounty.
  ///
  /// - `bounty_id`: Bounty ID to extend.
  /// - `remark`: additional information.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall extendBountyExpiry({
    required bountyId,
    required remark,
  }) {
    final _call = _i6.Call.values.extendBountyExpiry(
      bountyId: bountyId,
      remark: remark,
    );
    return _i5.RuntimeCall.values.bounties(_call);
  }
}

class Constants {
  Constants();

  /// The amount held on deposit for placing a bounty proposal.
  final BigInt bountyDepositBase = BigInt.from(10000000000);

  /// The delay period for which a bounty beneficiary need to wait before claim the payout.
  final int bountyDepositPayoutDelay = 115200;

  /// Bounty duration in blocks.
  final int bountyUpdatePeriod = 1296000;

  /// The curator deposit is calculated as a percentage of the curator fee.
  ///
  /// This deposit has optional upper and lower bounds with `CuratorDepositMax` and
  /// `CuratorDepositMin`.
  final _i7.Permill curatorDepositMultiplier = 500000;

  /// Maximum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? curatorDepositMax = BigInt.from(2000000000000);

  /// Minimum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? curatorDepositMin = BigInt.from(100000000000);

  /// Minimum value for a bounty.
  final BigInt bountyValueMinimum = BigInt.from(100000000000);

  /// The amount held on deposit per byte within the tip report reason or bounty description.
  final BigInt dataDepositPerByte = BigInt.from(100000000);

  /// Maximum acceptable reason length.
  ///
  /// Benchmarks depend on this value, be sure to update weights file when changing this value
  final int maximumReasonLength = 16384;
}
