// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i6;

import '../types/pallet_identity/pallet/call.dart' as _i10;
import '../types/pallet_identity/types/data.dart' as _i5;
import '../types/pallet_identity/types/registrar_info.dart' as _i7;
import '../types/pallet_identity/types/registration.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, _i3.Registration> _identityOf =
      const _i1.StorageMap<_i2.AccountId32, _i3.Registration>(
    prefix: 'Identity',
    storage: 'IdentityOf',
    valueCodec: _i3.Registration.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageMap<_i2.AccountId32, _i4.Tuple2<_i2.AccountId32, _i5.Data>>
      _superOf = const _i1
          .StorageMap<_i2.AccountId32, _i4.Tuple2<_i2.AccountId32, _i5.Data>>(
    prefix: 'Identity',
    storage: 'SuperOf',
    valueCodec: _i4.Tuple2Codec<_i2.AccountId32, _i5.Data>(
      _i2.AccountId32Codec(),
      _i5.Data.codec,
    ),
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.AccountId32Codec()),
  );

  final _i1
      .StorageMap<_i2.AccountId32, _i4.Tuple2<BigInt, List<_i2.AccountId32>>>
      _subsOf = const _i1.StorageMap<_i2.AccountId32,
          _i4.Tuple2<BigInt, List<_i2.AccountId32>>>(
    prefix: 'Identity',
    storage: 'SubsOf',
    valueCodec: _i4.Tuple2Codec<BigInt, List<_i2.AccountId32>>(
      _i6.U128Codec.codec,
      _i6.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<List<_i7.RegistrarInfo?>> _registrars =
      const _i1.StorageValue<List<_i7.RegistrarInfo?>>(
    prefix: 'Identity',
    storage: 'Registrars',
    valueCodec: _i6.SequenceCodec<_i7.RegistrarInfo?>(
        _i6.OptionCodec<_i7.RegistrarInfo>(_i7.RegistrarInfo.codec)),
  );

  /// Information that is pertinent to identify the entity behind an account.
  ///
  /// TWOX-NOTE: OK ― `AccountId` is a secure hash.
  _i8.Future<_i3.Registration?> identityOf(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _identityOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _identityOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The super-identity of an alternative "sub" identity together with its name, within that
  /// context. If the account is not some other account's sub-identity, then just `None`.
  _i8.Future<_i4.Tuple2<_i2.AccountId32, _i5.Data>?> superOf(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _superOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _superOf.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Alternative "sub" identities of this account.
  ///
  /// The first item is the deposit, the second is a vector of the accounts.
  ///
  /// TWOX-NOTE: OK ― `AccountId` is a secure hash.
  _i8.Future<_i4.Tuple2<BigInt, List<_i2.AccountId32>>> subsOf(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _subsOf.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _subsOf.decodeValue(bytes);
    }
    return _i4.Tuple2<BigInt, List<_i2.AccountId32>>(
      BigInt.zero,
      [],
    ); /* Default */
  }

  /// The set of registrars. Not expected to get very big as can only be added through a
  /// special origin (likely a council motion).
  ///
  /// The index into this can be cast to `RegistrarIndex` to get a valid value.
  _i8.Future<List<_i7.RegistrarInfo?>> registrars({_i1.BlockHash? at}) async {
    final hashedKey = _registrars.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _registrars.decodeValue(bytes);
    }
    return []; /* Default */
  }
}

class Txs {
  const Txs();

  /// Add a registrar to the system.
  ///
  /// The dispatch origin for this call must be `T::RegistrarOrigin`.
  ///
  /// - `account`: the account of the registrar.
  ///
  /// Emits `RegistrarAdded` if successful.
  ///
  /// ## Complexity
  /// - `O(R)` where `R` registrar-count (governance-bounded and code-bounded).
  _i9.RuntimeCall addRegistrar({required account}) {
    final _call = _i10.Call.values.addRegistrar(account: account);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Set an account's identity information and reserve the appropriate deposit.
  ///
  /// If the account already has identity information, the deposit is taken as part payment
  /// for the new deposit.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `info`: The identity information.
  ///
  /// Emits `IdentitySet` if successful.
  ///
  /// ## Complexity
  /// - `O(X + X' + R)`
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded)
  ///  - where `R` judgements-count (registrar-count-bounded)
  _i9.RuntimeCall setIdentity({required info}) {
    final _call = _i10.Call.values.setIdentity(info: info);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Set the sub-accounts of the sender.
  ///
  /// Payment: Any aggregate balance reserved by previous `set_subs` calls will be returned
  /// and an amount `SubAccountDeposit` will be reserved for each item in `subs`.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// identity.
  ///
  /// - `subs`: The identity's (new) sub-accounts.
  ///
  /// ## Complexity
  /// - `O(P + S)`
  ///  - where `P` old-subs-count (hard- and deposit-bounded).
  ///  - where `S` subs-count (hard- and deposit-bounded).
  _i9.RuntimeCall setSubs({required subs}) {
    final _call = _i10.Call.values.setSubs(subs: subs);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Clear an account's identity info and all sub-accounts and return all deposits.
  ///
  /// Payment: All reserved balances on the account are returned.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// identity.
  ///
  /// Emits `IdentityCleared` if successful.
  ///
  /// ## Complexity
  /// - `O(R + S + X)`
  ///  - where `R` registrar-count (governance-bounded).
  ///  - where `S` subs-count (hard- and deposit-bounded).
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded).
  _i9.RuntimeCall clearIdentity() {
    final _call = _i10.Call.values.clearIdentity();
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Request a judgement from a registrar.
  ///
  /// Payment: At most `max_fee` will be reserved for payment to the registrar if judgement
  /// given.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a
  /// registered identity.
  ///
  /// - `reg_index`: The index of the registrar whose judgement is requested.
  /// - `max_fee`: The maximum fee that may be paid. This should just be auto-populated as:
  ///
  /// ```nocompile
  /// Self::registrars().get(reg_index).unwrap().fee
  /// ```
  ///
  /// Emits `JudgementRequested` if successful.
  ///
  /// ## Complexity
  /// - `O(R + X)`.
  ///  - where `R` registrar-count (governance-bounded).
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded).
  _i9.RuntimeCall requestJudgement({
    required regIndex,
    required maxFee,
  }) {
    final _call = _i10.Call.values.requestJudgement(
      regIndex: regIndex,
      maxFee: maxFee,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Cancel a previous request.
  ///
  /// Payment: A previously reserved deposit is returned on success.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a
  /// registered identity.
  ///
  /// - `reg_index`: The index of the registrar whose judgement is no longer requested.
  ///
  /// Emits `JudgementUnrequested` if successful.
  ///
  /// ## Complexity
  /// - `O(R + X)`.
  ///  - where `R` registrar-count (governance-bounded).
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded).
  _i9.RuntimeCall cancelRequest({required regIndex}) {
    final _call = _i10.Call.values.cancelRequest(regIndex: regIndex);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Set the fee required for a judgement to be requested from a registrar.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must be the account
  /// of the registrar whose index is `index`.
  ///
  /// - `index`: the index of the registrar whose fee is to be set.
  /// - `fee`: the new fee.
  ///
  /// ## Complexity
  /// - `O(R)`.
  ///  - where `R` registrar-count (governance-bounded).
  _i9.RuntimeCall setFee({
    required index,
    required fee,
  }) {
    final _call = _i10.Call.values.setFee(
      index: index,
      fee: fee,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Change the account associated with a registrar.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must be the account
  /// of the registrar whose index is `index`.
  ///
  /// - `index`: the index of the registrar whose fee is to be set.
  /// - `new`: the new account ID.
  ///
  /// ## Complexity
  /// - `O(R)`.
  ///  - where `R` registrar-count (governance-bounded).
  _i9.RuntimeCall setAccountId({
    required index,
    required new_,
  }) {
    final _call = _i10.Call.values.setAccountId(
      index: index,
      new_: new_,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Set the field information for a registrar.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must be the account
  /// of the registrar whose index is `index`.
  ///
  /// - `index`: the index of the registrar whose fee is to be set.
  /// - `fields`: the fields that the registrar concerns themselves with.
  ///
  /// ## Complexity
  /// - `O(R)`.
  ///  - where `R` registrar-count (governance-bounded).
  _i9.RuntimeCall setFields({
    required index,
    required fields,
  }) {
    final _call = _i10.Call.values.setFields(
      index: index,
      fields: fields,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Provide a judgement for an account's identity.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must be the account
  /// of the registrar whose index is `reg_index`.
  ///
  /// - `reg_index`: the index of the registrar whose judgement is being made.
  /// - `target`: the account whose identity the judgement is upon. This must be an account
  ///  with a registered identity.
  /// - `judgement`: the judgement of the registrar of index `reg_index` about `target`.
  /// - `identity`: The hash of the [`IdentityInfo`] for that the judgement is provided.
  ///
  /// Emits `JudgementGiven` if successful.
  ///
  /// ## Complexity
  /// - `O(R + X)`.
  ///  - where `R` registrar-count (governance-bounded).
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded).
  _i9.RuntimeCall provideJudgement({
    required regIndex,
    required target,
    required judgement,
    required identity,
  }) {
    final _call = _i10.Call.values.provideJudgement(
      regIndex: regIndex,
      target: target,
      judgement: judgement,
      identity: identity,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Remove an account's identity and sub-account information and slash the deposits.
  ///
  /// Payment: Reserved balances from `set_subs` and `set_identity` are slashed and handled by
  /// `Slash`. Verification request deposits are not returned; they should be cancelled
  /// manually using `cancel_request`.
  ///
  /// The dispatch origin for this call must match `T::ForceOrigin`.
  ///
  /// - `target`: the account whose identity the judgement is upon. This must be an account
  ///  with a registered identity.
  ///
  /// Emits `IdentityKilled` if successful.
  ///
  /// ## Complexity
  /// - `O(R + S + X)`
  ///  - where `R` registrar-count (governance-bounded).
  ///  - where `S` subs-count (hard- and deposit-bounded).
  ///  - where `X` additional-field-count (deposit-bounded and code-bounded).
  _i9.RuntimeCall killIdentity({required target}) {
    final _call = _i10.Call.values.killIdentity(target: target);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Add the given account to the sender's subs.
  ///
  /// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
  /// to the sender.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// sub identity of `sub`.
  _i9.RuntimeCall addSub({
    required sub,
    required data,
  }) {
    final _call = _i10.Call.values.addSub(
      sub: sub,
      data: data,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Alter the associated name of the given sub-account.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// sub identity of `sub`.
  _i9.RuntimeCall renameSub({
    required sub,
    required data,
  }) {
    final _call = _i10.Call.values.renameSub(
      sub: sub,
      data: data,
    );
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Remove the given account from the sender's subs.
  ///
  /// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
  /// to the sender.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// sub identity of `sub`.
  _i9.RuntimeCall removeSub({required sub}) {
    final _call = _i10.Call.values.removeSub(sub: sub);
    return _i9.RuntimeCall.values.identity(_call);
  }

  /// Remove the sender as a sub-account.
  ///
  /// Payment: Balance reserved by a previous `set_subs` call for one sub will be repatriated
  /// to the sender (*not* the original depositor).
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have a registered
  /// super-identity.
  ///
  /// NOTE: This should not normally be used, but is provided in the case that the non-
  /// controller of an account is maliciously registered as a sub-account.
  _i9.RuntimeCall quitSub() {
    final _call = _i10.Call.values.quitSub();
    return _i9.RuntimeCall.values.identity(_call);
  }
}

class Constants {
  Constants();

  /// The amount held on deposit for a registered identity
  final BigInt basicDeposit = BigInt.from(202580000000);

  /// The amount held on deposit per additional field for a registered identity.
  final BigInt fieldDeposit = BigInt.from(660000000);

  /// The amount held on deposit for a registered subaccount. This should account for the fact
  /// that one storage item's value will increase by the size of an account ID, and there will
  /// be another trie item whose value is the size of an account ID plus 32 bytes.
  final BigInt subAccountDeposit = BigInt.from(200530000000);

  /// The maximum number of sub-accounts allowed per identified account.
  final int maxSubAccounts = 100;

  /// Maximum number of additional fields that may be stored in an ID. Needed to bound the I/O
  /// required to access an identity, but can be pretty high.
  final int maxAdditionalFields = 100;

  /// Maxmimum number of registrars allowed in the system. Needed to bound the complexity
  /// of, e.g., updating judgements.
  final int maxRegistrars = 20;
}
