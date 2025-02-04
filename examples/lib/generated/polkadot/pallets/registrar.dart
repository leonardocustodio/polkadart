// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/polkadot_parachain_primitives/primitives/head_data.dart'
    as _i7;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i2;
import '../types/polkadot_parachain_primitives/primitives/validation_code.dart'
    as _i8;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/polkadot_runtime_common/paras_registrar/pallet/call.dart'
    as _i9;
import '../types/polkadot_runtime_common/paras_registrar/para_info.dart' as _i3;
import '../types/sp_core/crypto/account_id32.dart' as _i10;

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
  /// The given account ID is responsible for registering the code and initial head data, but may
  /// only do so if it isn't yet registered. (After that, it's up to governance to do so.)
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

  /// Returns the storage key for `pendingSwap`.
  _i5.Uint8List pendingSwapKey(_i2.Id key1) {
    final hashedKey = _pendingSwap.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `paras`.
  _i5.Uint8List parasKey(_i2.Id key1) {
    final hashedKey = _paras.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `nextFreeParaId`.
  _i5.Uint8List nextFreeParaIdKey() {
    final hashedKey = _nextFreeParaId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `pendingSwap`.
  _i5.Uint8List pendingSwapMapPrefix() {
    final hashedKey = _pendingSwap.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `paras`.
  _i5.Uint8List parasMapPrefix() {
    final hashedKey = _paras.mapPrefix();
    return hashedKey;
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
  /// The account with the originating signature must reserve a deposit.
  ///
  /// The deposit is required to cover the costs associated with storing the genesis head
  /// data and the validation code.
  /// This accounts for the potential to store validation code of a size up to the
  /// `max_code_size`, as defined in the configuration pallet
  ///
  /// Anything already reserved previously for this para ID is accounted for.
  ///
  /// ## Events
  /// The `Registered` event is emitted in case of success.
  _i6.RuntimeCall register({
    required _i2.Id id,
    required _i7.HeadData genesisHead,
    required _i8.ValidationCode validationCode,
  }) {
    final _call = _i9.Call.values.register(
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Force the registration of a Para Id on the relay chain.
  ///
  /// This function must be called by a Root origin.
  ///
  /// The deposit taken can be specified for this registration. Any `ParaId`
  /// can be registered, including sub-1000 IDs which are System Parachains.
  _i6.RuntimeCall forceRegister({
    required _i10.AccountId32 who,
    required BigInt deposit,
    required _i2.Id id,
    required _i7.HeadData genesisHead,
    required _i8.ValidationCode validationCode,
  }) {
    final _call = _i9.Call.values.forceRegister(
      who: who,
      deposit: deposit,
      id: id,
      genesisHead: genesisHead,
      validationCode: validationCode,
    );
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Deregister a Para Id, freeing all data and returning any deposit.
  ///
  /// The caller must be Root, the `para` owner, or the `para` itself. The para must be an
  /// on-demand parachain.
  _i6.RuntimeCall deregister({required _i2.Id id}) {
    final _call = _i9.Call.values.deregister(id: id);
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Swap a lease holding parachain with another parachain, either on-demand or lease
  /// holding.
  ///
  /// The origin must be Root, the `para` owner, or the `para` itself.
  ///
  /// The swap will happen only if there is already an opposite swap pending. If there is not,
  /// the swap will be stored in the pending swaps map, ready for a later confirmatory swap.
  ///
  /// The `ParaId`s remain mapped to the same head data and code so external code can rely on
  /// `ParaId` to be a long-term identifier of a notional "parachain". However, their
  /// scheduling info (i.e. whether they're an on-demand parachain or lease holding
  /// parachain), auction information and the auction deposit are switched.
  _i6.RuntimeCall swap({
    required _i2.Id id,
    required _i2.Id other,
  }) {
    final _call = _i9.Call.values.swap(
      id: id,
      other: other,
    );
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Remove a manager lock from a para. This will allow the manager of a
  /// previously locked para to deregister or swap a para without using governance.
  ///
  /// Can only be called by the Root origin or the parachain.
  _i6.RuntimeCall removeLock({required _i2.Id para}) {
    final _call = _i9.Call.values.removeLock(para: para);
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Reserve a Para Id on the relay chain.
  ///
  /// This function will reserve a new Para Id to be owned/managed by the origin account.
  /// The origin account is able to register head data and validation code using `register` to
  /// create an on-demand parachain. Using the Slots pallet, an on-demand parachain can then
  /// be upgraded to a lease holding parachain.
  ///
  /// ## Arguments
  /// - `origin`: Must be called by a `Signed` origin. Becomes the manager/owner of the new
  ///  para ID.
  ///
  /// ## Deposits/Fees
  /// The origin must reserve a deposit of `ParaDeposit` for the registration.
  ///
  /// ## Events
  /// The `Reserved` event is emitted in case of success, which provides the ID reserved for
  /// use.
  _i6.RuntimeCall reserve() {
    final _call = _i9.Call.values.reserve();
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Add a manager lock from a para. This will prevent the manager of a
  /// para to deregister or swap a para.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is
  /// unlocked.
  _i6.RuntimeCall addLock({required _i2.Id para}) {
    final _call = _i9.Call.values.addLock(para: para);
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Schedule a parachain upgrade.
  ///
  /// This will kick off a check of `new_code` by all validators. After the majority of the
  /// validators have reported on the validity of the code, the code will either be enacted
  /// or the upgrade will be rejected. If the code will be enacted, the current code of the
  /// parachain will be overwritten directly. This means that any PoV will be checked by this
  /// new code. The parachain itself will not be informed explicitly that the validation code
  /// has changed.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is
  /// unlocked.
  _i6.RuntimeCall scheduleCodeUpgrade({
    required _i2.Id para,
    required _i8.ValidationCode newCode,
  }) {
    final _call = _i9.Call.values.scheduleCodeUpgrade(
      para: para,
      newCode: newCode,
    );
    return _i6.RuntimeCall.values.registrar(_call);
  }

  /// Set the parachain's current head.
  ///
  /// Can be called by Root, the parachain, or the parachain manager if the parachain is
  /// unlocked.
  _i6.RuntimeCall setCurrentHead({
    required _i2.Id para,
    required _i7.HeadData newHead,
  }) {
    final _call = _i9.Call.values.setCurrentHead(
      para: para,
      newHead: newHead,
    );
    return _i6.RuntimeCall.values.registrar(_call);
  }
}

class Constants {
  Constants();

  /// The deposit to be paid to run a on-demand parachain.
  /// This should include the cost for storing the genesis head and validation code.
  final BigInt paraDeposit = BigInt.from(1000000000000);

  /// The deposit to be paid per byte stored on chain.
  final BigInt dataDepositPerByte = BigInt.from(10000000);
}
