// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/frame_support/pallet_id.dart' as _i8;
import '../types/pallet_treasury/pallet/call.dart' as _i6;
import '../types/pallet_treasury/proposal.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i5;
import '../types/sp_arithmetic/per_things/permill.dart' as _i7;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _proposalCount = const _i1.StorageValue<int>(
    prefix: 'Treasury',
    storage: 'ProposalCount',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i3.Proposal> _proposals =
      const _i1.StorageMap<int, _i3.Proposal>(
    prefix: 'Treasury',
    storage: 'Proposals',
    valueCodec: _i3.Proposal.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageValue<BigInt> _deactivated = const _i1.StorageValue<BigInt>(
    prefix: 'Treasury',
    storage: 'Deactivated',
    valueCodec: _i2.U128Codec.codec,
  );

  final _i1.StorageValue<List<int>> _approvals =
      const _i1.StorageValue<List<int>>(
    prefix: 'Treasury',
    storage: 'Approvals',
    valueCodec: _i2.U32SequenceCodec.codec,
  );

  /// Number of proposals that have been made.
  _i4.Future<int> proposalCount({_i1.BlockHash? at}) async {
    final hashedKey = _proposalCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposalCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Proposals that have been made.
  _i4.Future<_i3.Proposal?> proposals(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _proposals.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _proposals.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The amount which has been reported as inactive to Currency.
  _i4.Future<BigInt> deactivated({_i1.BlockHash? at}) async {
    final hashedKey = _deactivated.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _deactivated.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Proposal indices that have been approved but not yet awarded.
  _i4.Future<List<int>> approvals({_i1.BlockHash? at}) async {
    final hashedKey = _approvals.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _approvals.decodeValue(bytes);
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

  /// Put forward a suggestion for spending. A deposit proportional to the value
  /// is reserved and slashed if the proposal is rejected. It is returned once the
  /// proposal is awarded.
  ///
  /// ## Complexity
  /// - O(1)
  _i5.RuntimeCall proposeSpend({
    required value,
    required beneficiary,
  }) {
    final _call = _i6.Call.values.proposeSpend(
      value: value,
      beneficiary: beneficiary,
    );
    return _i5.RuntimeCall.values.treasury(_call);
  }

  /// Reject a proposed spend. The original deposit will be slashed.
  ///
  /// May only be called from `T::RejectOrigin`.
  ///
  /// ## Complexity
  /// - O(1)
  _i5.RuntimeCall rejectProposal({required proposalId}) {
    final _call = _i6.Call.values.rejectProposal(proposalId: proposalId);
    return _i5.RuntimeCall.values.treasury(_call);
  }

  /// Approve a proposal. At a later time, the proposal will be allocated to the beneficiary
  /// and the original deposit will be returned.
  ///
  /// May only be called from `T::ApproveOrigin`.
  ///
  /// ## Complexity
  /// - O(1).
  _i5.RuntimeCall approveProposal({required proposalId}) {
    final _call = _i6.Call.values.approveProposal(proposalId: proposalId);
    return _i5.RuntimeCall.values.treasury(_call);
  }

  /// Propose and approve a spend of treasury funds.
  ///
  /// - `origin`: Must be `SpendOrigin` with the `Success` value being at least `amount`.
  /// - `amount`: The amount to be transferred from the treasury to the `beneficiary`.
  /// - `beneficiary`: The destination account for the transfer.
  ///
  /// NOTE: For record-keeping purposes, the proposer is deemed to be equivalent to the
  /// beneficiary.
  _i5.RuntimeCall spend({
    required amount,
    required beneficiary,
  }) {
    final _call = _i6.Call.values.spend(
      amount: amount,
      beneficiary: beneficiary,
    );
    return _i5.RuntimeCall.values.treasury(_call);
  }

  /// Force a previously approved proposal to be removed from the approval queue.
  /// The original deposit will no longer be returned.
  ///
  /// May only be called from `T::RejectOrigin`.
  /// - `proposal_id`: The index of a proposal
  ///
  /// ## Complexity
  /// - O(A) where `A` is the number of approvals
  ///
  /// Errors:
  /// - `ProposalNotApproved`: The `proposal_id` supplied was not found in the approval queue,
  /// i.e., the proposal has not been approved. This could also mean the proposal does not
  /// exist altogether, thus there is no way it would have been approved in the first place.
  _i5.RuntimeCall removeApproval({required proposalId}) {
    final _call = _i6.Call.values.removeApproval(proposalId: proposalId);
    return _i5.RuntimeCall.values.treasury(_call);
  }
}

class Constants {
  Constants();

  /// Fraction of a proposal's value that should be bonded in order to place the proposal.
  /// An accepted proposal gets these back. A rejected proposal does not.
  final _i7.Permill proposalBond = 50000;

  /// Minimum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt proposalBondMinimum = BigInt.from(1000000000000);

  /// Maximum amount of funds that should be placed in a deposit for making a proposal.
  final BigInt? proposalBondMaximum = BigInt.from(5000000000000);

  /// Period between successive spends.
  final int spendPeriod = 345600;

  /// Percentage of spare funds (if any) that are burnt per spend period.
  final _i7.Permill burn = 10000;

  /// The treasury's pallet id, used for deriving its sovereign account ID.
  final _i8.PalletId palletId = const <int>[
    112,
    121,
    47,
    116,
    114,
    115,
    114,
    121,
  ];

  /// The maximum number of approvals that can wait in the spending queue.
  ///
  /// NOTE: This parameter is also used within the Bounties Pallet extension if enabled.
  final int maxApprovals = 100;
}
