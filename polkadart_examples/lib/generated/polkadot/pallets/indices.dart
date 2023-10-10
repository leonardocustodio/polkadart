// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_indices/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i3;
import '../types/tuples.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<int, _i2.Tuple3<_i3.AccountId32, BigInt, bool>>
      _accounts =
      const _i1.StorageMap<int, _i2.Tuple3<_i3.AccountId32, BigInt, bool>>(
    prefix: 'Indices',
    storage: 'Accounts',
    valueCodec: _i2.Tuple3Codec<_i3.AccountId32, BigInt, bool>(
      _i3.AccountId32Codec(),
      _i4.U128Codec.codec,
      _i4.BoolCodec.codec,
    ),
    hasher: _i1.StorageHasher.blake2b128Concat(_i4.U32Codec.codec),
  );

  /// The lookup from index to account.
  _i5.Future<_i2.Tuple3<_i3.AccountId32, BigInt, bool>?> accounts(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _accounts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _accounts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Assign an previously unassigned index.
  ///
  /// Payment: `Deposit` is reserved from the sender account.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `index`: the index to be claimed. This must not be in use.
  ///
  /// Emits `IndexAssigned` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i6.RuntimeCall claim({required index}) {
    final _call = _i7.Call.values.claim(index: index);
    return _i6.RuntimeCall.values.indices(_call);
  }

  /// Assign an index already owned by the sender to another account. The balance reservation
  /// is effectively transferred to the new account.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `index`: the index to be re-assigned. This must be owned by the sender.
  /// - `new`: the new owner of the index. This function is a no-op if it is equal to sender.
  ///
  /// Emits `IndexAssigned` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i6.RuntimeCall transfer({
    required new_,
    required index,
  }) {
    final _call = _i7.Call.values.transfer(
      new_: new_,
      index: index,
    );
    return _i6.RuntimeCall.values.indices(_call);
  }

  /// Free up an index owned by the sender.
  ///
  /// Payment: Any previous deposit placed for the index is unreserved in the sender account.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must own the index.
  ///
  /// - `index`: the index to be freed. This must be owned by the sender.
  ///
  /// Emits `IndexFreed` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i6.RuntimeCall free({required index}) {
    final _call = _i7.Call.values.free(index: index);
    return _i6.RuntimeCall.values.indices(_call);
  }

  /// Force an index to an account. This doesn't require a deposit. If the index is already
  /// held, then any deposit is reimbursed to its current owner.
  ///
  /// The dispatch origin for this call must be _Root_.
  ///
  /// - `index`: the index to be (re-)assigned.
  /// - `new`: the new owner of the index. This function is a no-op if it is equal to sender.
  /// - `freeze`: if set to `true`, will freeze the index so it cannot be transferred.
  ///
  /// Emits `IndexAssigned` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i6.RuntimeCall forceTransfer({
    required new_,
    required index,
    required freeze,
  }) {
    final _call = _i7.Call.values.forceTransfer(
      new_: new_,
      index: index,
      freeze: freeze,
    );
    return _i6.RuntimeCall.values.indices(_call);
  }

  /// Freeze an index so it will always point to the sender account. This consumes the
  /// deposit.
  ///
  /// The dispatch origin for this call must be _Signed_ and the signing account must have a
  /// non-frozen account `index`.
  ///
  /// - `index`: the index to be frozen in place.
  ///
  /// Emits `IndexFrozen` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i6.RuntimeCall freeze({required index}) {
    final _call = _i7.Call.values.freeze(index: index);
    return _i6.RuntimeCall.values.indices(_call);
  }
}

class Constants {
  Constants();

  /// The deposit needed for reserving an index.
  final BigInt deposit = BigInt.from(100000000000);
}
