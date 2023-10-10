// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/polkadot_parachain/primitives/id.dart' as _i2;
import '../types/polkadot_runtime/runtime_call.dart' as _i5;
import '../types/polkadot_runtime_common/paras_registrar/pallet/call.dart'
    as _i6;
import '../types/polkadot_runtime_common/paras_registrar/para_info.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, _i2.Id> _pendingSwap =
      const _i1.StorageMap<_i2.Id, _i2.Id>(
    prefix: 'Registrar',
    storage: 'PendingSwap',
    valueCodec: _i2.IdCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageMap<_i2.Id, _i3.ParaInfo> _paras =
      const _i1.StorageMap<_i2.Id, _i3.ParaInfo>(
    prefix: 'Registrar',
    storage: 'Paras',
    valueCodec: _i3.ParaInfo.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageValue<_i2.Id> _nextFreeParaId =
      const _i1.StorageValue<_i2.Id>(
    prefix: 'Registrar',
    storage: 'NextFreeParaId',
    valueCodec: _i2.IdCodec(),
  );

  /// Pending swap operations.
  _i4.Future<_i2.Id?> pendingSwap(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pendingSwap.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingSwap.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Amount held on deposit for each para and the original depositor.
  ///
  /// The given account ID is responsible for registering the code and initial head data, but may only do
  /// so if it isn't yet registered. (After that, it's up to governance to do so.)
  _i4.Future<_i3.ParaInfo?> paras(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _paras.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _paras.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The next free `ParaId`.
  _i4.Future<_i2.Id> nextFreeParaId({_i1.BlockHash? at}) async {
    final hashedKey = _nextFreeParaId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextFreeParaId.decodeValue(bytes);
    }
    return 0; /* Default */
  }
}

class Txs {
  const Txs();

  /// Register head data and validation code for a reserved Para Id.
  ///
  /// ## Arguments
  /// - `origin`: Must be called by a `Signed` origin.
  /// - `id`: The para ID. Must be owned/managed by the `origin` signing account.
  /// - `genesis_head`: The genesis head data of the parachain/thread.
  /// - `validation_code`: The initial validation code of the parachain/thread.
  ///
  /// ## Deposits/Fees
  /// The origin signed account must reserve a corresponding deposit for the registration. Anything already
  /// reserved previously for this para ID is accounted for.
  ///
  /// ## Events
  /// The `Registered` event is emitted in case of success.
  _i5.RuntimeCall register({
    required id,
    required genesisHead,
    required validationCode,
  }) {
    final _call = _i6.Call.values.register(
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Force the registration of a Para Id on the relay chain.
  ///
  /// This function must be called by a Root origin.
  ///
  /// The deposit taken can be specified for this registration. Any `ParaId`
  /// can be registered, including sub-1000 IDs which are System Parachains.
  _i5.RuntimeCall forceRegister({
    required who,
    required deposit,
    required id,
    required genesisHead,
    required validationCode,
  }) {
    final _call = _i6.Call.values.forceRegister(
      who: who,
      deposit: deposit,
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Deregister a Para Id, freeing all data and returning any deposit.
  ///
  /// The caller must be Root, the `para` owner, or the `para` itself. The para must be a parathread.
  _i5.RuntimeCall deregister({required id}) {
    final _call = _i6.Call.values.deregister(id: id);
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Swap a parachain with another parachain or parathread.
  ///
  /// The origin must be Root, the `para` owner, or the `para` itself.
  ///
  /// The swap will happen only if there is already an opposite swap pending. If there is not,
  /// the swap will be stored in the pending swaps map, ready for a later confirmatory swap.
  ///
  /// The `ParaId`s remain mapped to the same head data and code so external code can rely on
  /// `ParaId` to be a long-term identifier of a notional "parachain". However, their
  /// scheduling info (i.e. whether they're a parathread or parachain), auction information
  /// and the auction deposit are switched.
  _i5.RuntimeCall swap({
    required id,
    required other,
  }) {
    final _call = _i6.Call.values.swap(
      id: id,
      other: other,
    );
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Remove a manager lock from a para. This will allow the manager of a
  /// previously locked para to deregister or swap a para without using governance.
  ///
  /// Can only be called by the Root origin or the parachain.
  _i5.RuntimeCall removeLock({required para}) {
    final _call = _i6.Call.values.removeLock(para: para);
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Reserve a Para Id on the relay chain.
  ///
  /// This function will reserve a new Para Id to be owned/managed by the origin account.
  /// The origin account is able to register head data and validation code using `register` to create
  /// a parathread. Using the Slots pallet, a parathread can then be upgraded to get a parachain slot.
  ///
  /// ## Arguments
  /// - `origin`: Must be called by a `Signed` origin. Becomes the manager/owner of the new para ID.
  ///
  /// ## Deposits/Fees
  /// The origin must reserve a deposit of `ParaDeposit` for the registration.
  ///
  /// ## Events
  /// The `Reserved` event is emitted in case of success, which provides the ID reserved for use.
  _i5.RuntimeCall reserve() {
    final _call = _i6.Call.values.reserve();
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Add a manager lock from a para. This will prevent the manager of a
  /// para to deregister or swap a para.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is unlocked.
  _i5.RuntimeCall addLock({required para}) {
    final _call = _i6.Call.values.addLock(para: para);
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Schedule a parachain upgrade.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is unlocked.
  _i5.RuntimeCall scheduleCodeUpgrade({
    required para,
    required newCode,
  }) {
    final _call = _i6.Call.values.scheduleCodeUpgrade(
      para: para,
      newCode: newCode,
    );
    return _i5.RuntimeCall.values.registrar(_call);
  }

  /// Set the parachain's current head.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is unlocked.
  _i5.RuntimeCall setCurrentHead({
    required para,
    required newHead,
  }) {
    final _call = _i6.Call.values.setCurrentHead(
      para: para,
      newHead: newHead,
    );
    return _i5.RuntimeCall.values.registrar(_call);
  }
}

class Constants {
  Constants();

  /// The deposit to be paid to run a parathread.
  /// This should include the cost for storing the genesis head and validation code.
  final BigInt paraDeposit = BigInt.from(1000000000000);

  /// The deposit to be paid per byte stored on chain.
  final BigInt dataDepositPerByte = BigInt.from(10000000);
}
