// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_multisig/multisig.dart' as _i3;
import '../types/pallet_multisig/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<_i2.AccountId32, List<int>, _i3.Multisig>
      _multisigs =
      const _i1.StorageDoubleMap<_i2.AccountId32, List<int>, _i3.Multisig>(
    prefix: 'Multisig',
    storage: 'Multisigs',
    valueCodec: _i3.Multisig.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i4.U8ArrayCodec(32)),
  );

  /// The set of open multisig operations.
  _i5.Future<_i3.Multisig?> multisigs(
    _i2.AccountId32 key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _multisigs.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _multisigs.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Immediately dispatch a multi-signature call using a single approval from the caller.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `other_signatories`: The accounts (other than the sender) who are part of the
  /// multi-signature, but do not participate in the approval process.
  /// - `call`: The call to be executed.
  ///
  /// Result is equivalent to the dispatched result.
  ///
  /// ## Complexity
  /// O(Z + C) where Z is the length of the call and C its execution weight.
  _i6.RuntimeCall asMultiThreshold1({
    required otherSignatories,
    required call,
  }) {
    final _call = _i7.Call.values.asMultiThreshold1(
      otherSignatories: otherSignatories,
      call: call,
    );
    return _i6.RuntimeCall.values.multisig(_call);
  }

  /// Register approval for a dispatch to be made from a deterministic composite account if
  /// approved by a total of `threshold - 1` of `other_signatories`.
  ///
  /// If there are enough, then dispatch the call.
  ///
  /// Payment: `DepositBase` will be reserved if this is the first approval, plus
  /// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
  /// is cancelled.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
  /// not the first approval, then it must be `Some`, with the timepoint (block number and
  /// transaction index) of the first approval transaction.
  /// - `call`: The call to be executed.
  ///
  /// NOTE: Unless this is the final approval, you will generally want to use
  /// `approve_as_multi` instead, since it only requires a hash of the call.
  ///
  /// Result is equivalent to the dispatched result if `threshold` is exactly `1`. Otherwise
  /// on success, result is `Ok` and the result from the interior call, if it was executed,
  /// may be found in the deposited `MultisigExecuted` event.
  ///
  /// ## Complexity
  /// - `O(S + Z + Call)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One call encode & hash, both of complexity `O(Z)` where `Z` is tx-len.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - Up to one binary search and insert (`O(logS + S)`).
  /// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
  /// - One event.
  /// - The weight of the `call`.
  /// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
  ///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
  _i6.RuntimeCall asMulti({
    required threshold,
    required otherSignatories,
    maybeTimepoint,
    required call,
    required maxWeight,
  }) {
    final _call = _i7.Call.values.asMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      call: call,
      maxWeight: maxWeight,
    );
    return _i6.RuntimeCall.values.multisig(_call);
  }

  /// Register approval for a dispatch to be made from a deterministic composite account if
  /// approved by a total of `threshold - 1` of `other_signatories`.
  ///
  /// Payment: `DepositBase` will be reserved if this is the first approval, plus
  /// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
  /// is cancelled.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
  /// not the first approval, then it must be `Some`, with the timepoint (block number and
  /// transaction index) of the first approval transaction.
  /// - `call_hash`: The hash of the call to be executed.
  ///
  /// NOTE: If this is the final approval, you will want to use `as_multi` instead.
  ///
  /// ## Complexity
  /// - `O(S)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - Up to one binary search and insert (`O(logS + S)`).
  /// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
  /// - One event.
  /// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
  ///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
  _i6.RuntimeCall approveAsMulti({
    required threshold,
    required otherSignatories,
    maybeTimepoint,
    required callHash,
    required maxWeight,
  }) {
    final _call = _i7.Call.values.approveAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      callHash: callHash,
      maxWeight: maxWeight,
    );
    return _i6.RuntimeCall.values.multisig(_call);
  }

  /// Cancel a pre-existing, on-going multisig transaction. Any deposit reserved previously
  /// for this operation will be unreserved on success.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `threshold`: The total number of approvals for this dispatch before it is executed.
  /// - `other_signatories`: The accounts (other than the sender) who can approve this
  /// dispatch. May not be empty.
  /// - `timepoint`: The timepoint (block number and transaction index) of the first approval
  /// transaction for this dispatch.
  /// - `call_hash`: The hash of the call to be executed.
  ///
  /// ## Complexity
  /// - `O(S)`.
  /// - Up to one balance-reserve or unreserve operation.
  /// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
  ///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
  /// - One encode & hash, both of complexity `O(S)`.
  /// - One event.
  /// - I/O: 1 read `O(S)`, one remove.
  /// - Storage: removes one item.
  _i6.RuntimeCall cancelAsMulti({
    required threshold,
    required otherSignatories,
    required timepoint,
    required callHash,
  }) {
    final _call = _i7.Call.values.cancelAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      timepoint: timepoint,
      callHash: callHash,
    );
    return _i6.RuntimeCall.values.multisig(_call);
  }
}

class Constants {
  Constants();

  /// The base amount of currency needed to reserve for creating a multisig execution or to
  /// store a dispatch call for later.
  ///
  /// This is held for an additional storage item whose value size is
  /// `4 + sizeof((BlockNumber, Balance, AccountId))` bytes and whose key size is
  /// `32 + sizeof(AccountId)` bytes.
  final BigInt depositBase = BigInt.from(200880000000);

  /// The amount of currency needed per unit threshold when creating a multisig execution.
  ///
  /// This is held for adding 32 bytes more into a pre-existing storage value.
  final BigInt depositFactor = BigInt.from(320000000);

  /// The maximum amount of signatories allowed in the multisig.
  final int maxSignatories = 100;
}
