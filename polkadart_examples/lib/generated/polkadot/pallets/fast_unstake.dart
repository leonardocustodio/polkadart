// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_fast_unstake/pallet/call.dart' as _i7;
import '../types/pallet_fast_unstake/types/unstake_request.dart' as _i2;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/sp_core/crypto/account_id32.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.UnstakeRequest> _head =
      const _i1.StorageValue<_i2.UnstakeRequest>(
    prefix: 'FastUnstake',
    storage: 'Head',
    valueCodec: _i2.UnstakeRequest.codec,
  );

  final _i1.StorageMap<_i3.AccountId32, BigInt> _queue =
      const _i1.StorageMap<_i3.AccountId32, BigInt>(
    prefix: 'FastUnstake',
    storage: 'Queue',
    valueCodec: _i4.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _counterForQueue = const _i1.StorageValue<int>(
    prefix: 'FastUnstake',
    storage: 'CounterForQueue',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<int> _erasToCheckPerBlock =
      const _i1.StorageValue<int>(
    prefix: 'FastUnstake',
    storage: 'ErasToCheckPerBlock',
    valueCodec: _i4.U32Codec.codec,
  );

  /// The current "head of the queue" being unstaked.
  _i5.Future<_i2.UnstakeRequest?> head({_i1.BlockHash? at}) async {
    final hashedKey = _head.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _head.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The map of all accounts wishing to be unstaked.
  ///
  /// Keeps track of `AccountId` wishing to unstake and it's corresponding deposit.
  ///
  /// TWOX-NOTE: SAFE since `AccountId` is a secure hash.
  _i5.Future<BigInt?> queue(
    _i3.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _queue.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queue.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Counter for the related counted storage map
  _i5.Future<int> counterForQueue({_i1.BlockHash? at}) async {
    final hashedKey = _counterForQueue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _counterForQueue.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Number of eras to check per block.
  ///
  /// If set to 0, this pallet does absolutely nothing.
  ///
  /// Based on the amount of weight available at `on_idle`, up to this many eras of a single
  /// nominator might be checked.
  _i5.Future<int> erasToCheckPerBlock({_i1.BlockHash? at}) async {
    final hashedKey = _erasToCheckPerBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _erasToCheckPerBlock.decodeValue(bytes);
    }
    return 0; /* Default */
  }
}

class Txs {
  const Txs();

  /// Register oneself for fast-unstake.
  ///
  /// The dispatch origin of this call must be signed by the controller account, similar to
  /// `staking::unbond`.
  ///
  /// The stash associated with the origin must have no ongoing unlocking chunks. If
  /// successful, this will fully unbond and chill the stash. Then, it will enqueue the stash
  /// to be checked in further blocks.
  ///
  /// If by the time this is called, the stash is actually eligible for fast-unstake, then
  /// they are guaranteed to remain eligible, because the call will chill them as well.
  ///
  /// If the check works, the entire staking data is removed, i.e. the stash is fully
  /// unstaked.
  ///
  /// If the check fails, the stash remains chilled and waiting for being unbonded as in with
  /// the normal staking system, but they lose part of their unbonding chunks due to consuming
  /// the chain's resources.
  _i6.RuntimeCall registerFastUnstake() {
    final _call = _i7.Call.values.registerFastUnstake();
    return _i6.RuntimeCall.values.fastUnstake(_call);
  }

  /// Deregister oneself from the fast-unstake.
  ///
  /// This is useful if one is registered, they are still waiting, and they change their mind.
  ///
  /// Note that the associated stash is still fully unbonded and chilled as a consequence of
  /// calling `register_fast_unstake`. This should probably be followed by a call to
  /// `Staking::rebond`.
  _i6.RuntimeCall deregister() {
    final _call = _i7.Call.values.deregister();
    return _i6.RuntimeCall.values.fastUnstake(_call);
  }

  /// Control the operation of this pallet.
  ///
  /// Dispatch origin must be signed by the [`Config::ControlOrigin`].
  _i6.RuntimeCall control({required erasToCheck}) {
    final _call = _i7.Call.values.control(erasToCheck: erasToCheck);
    return _i6.RuntimeCall.values.fastUnstake(_call);
  }
}

class Constants {
  Constants();

  /// Deposit to take for unstaking, to make sure we're able to slash the it in order to cover
  /// the costs of resources on unsuccessful unstake.
  final BigInt deposit = BigInt.from(10000000000);
}
