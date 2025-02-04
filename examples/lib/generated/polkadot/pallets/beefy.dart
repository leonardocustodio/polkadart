// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_beefy/pallet/call.dart' as _i9;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/sp_consensus_beefy/double_voting_proof.dart' as _i7;
import '../types/sp_consensus_beefy/ecdsa_crypto/public.dart' as _i2;
import '../types/sp_session/membership_proof.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.Public>> _authorities =
      const _i1.StorageValue<List<_i2.Public>>(
    prefix: 'Beefy',
    storage: 'Authorities',
    valueCodec: _i3.SequenceCodec<_i2.Public>(_i2.PublicCodec()),
  );

  final _i1.StorageValue<BigInt> _validatorSetId =
      const _i1.StorageValue<BigInt>(
    prefix: 'Beefy',
    storage: 'ValidatorSetId',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageValue<List<_i2.Public>> _nextAuthorities =
      const _i1.StorageValue<List<_i2.Public>>(
    prefix: 'Beefy',
    storage: 'NextAuthorities',
    valueCodec: _i3.SequenceCodec<_i2.Public>(_i2.PublicCodec()),
  );

  final _i1.StorageMap<BigInt, int> _setIdSession =
      const _i1.StorageMap<BigInt, int>(
    prefix: 'Beefy',
    storage: 'SetIdSession',
    valueCodec: _i3.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i3.U64Codec.codec),
  );

  final _i1.StorageValue<int?> _genesisBlock = const _i1.StorageValue<int?>(
    prefix: 'Beefy',
    storage: 'GenesisBlock',
    valueCodec: _i3.OptionCodec<int>(_i3.U32Codec.codec),
  );

  /// The current authorities set
  _i4.Future<List<_i2.Public>> authorities({_i1.BlockHash? at}) async {
    final hashedKey = _authorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authorities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current validator set id
  _i4.Future<BigInt> validatorSetId({_i1.BlockHash? at}) async {
    final hashedKey = _validatorSetId.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validatorSetId.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Authorities set scheduled to be used with the next session
  _i4.Future<List<_i2.Public>> nextAuthorities({_i1.BlockHash? at}) async {
    final hashedKey = _nextAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextAuthorities.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// A mapping from BEEFY set ID to the index of the *most recent* session for which its
  /// members were responsible.
  ///
  /// This is only used for validating equivocation proofs. An equivocation proof must
  /// contains a key-ownership proof for a given session, therefore we need a way to tie
  /// together sessions and BEEFY set ids, i.e. we need to validate that a validator
  /// was the owner of a given key on a given session, and what the active set ID was
  /// during that session.
  ///
  /// TWOX-NOTE: `ValidatorSetId` is not under user control.
  _i4.Future<int?> setIdSession(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _setIdSession.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _setIdSession.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Block number where BEEFY consensus is enabled/started.
  /// By changing this (through privileged `set_new_genesis()`), BEEFY consensus is effectively
  /// restarted from the newly set block number.
  _i4.Future<int?> genesisBlock({_i1.BlockHash? at}) async {
    final hashedKey = _genesisBlock.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _genesisBlock.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// Returns the storage key for `authorities`.
  _i5.Uint8List authoritiesKey() {
    final hashedKey = _authorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `validatorSetId`.
  _i5.Uint8List validatorSetIdKey() {
    final hashedKey = _validatorSetId.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextAuthorities`.
  _i5.Uint8List nextAuthoritiesKey() {
    final hashedKey = _nextAuthorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `setIdSession`.
  _i5.Uint8List setIdSessionKey(BigInt key1) {
    final hashedKey = _setIdSession.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `genesisBlock`.
  _i5.Uint8List genesisBlockKey() {
    final hashedKey = _genesisBlock.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `setIdSession`.
  _i5.Uint8List setIdSessionMapPrefix() {
    final hashedKey = _setIdSession.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Report voter equivocation/misbehavior. This method will verify the
  /// equivocation proof and validate the given key ownership proof
  /// against the extracted offender. If both are valid, the offence
  /// will be reported.
  _i6.RuntimeCall reportEquivocation({
    required _i7.DoubleVotingProof equivocationProof,
    required _i8.MembershipProof keyOwnerProof,
  }) {
    final _call = _i9.Call.values.reportEquivocation(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
    return _i6.RuntimeCall.values.beefy(_call);
  }

  /// Report voter equivocation/misbehavior. This method will verify the
  /// equivocation proof and validate the given key ownership proof
  /// against the extracted offender. If both are valid, the offence
  /// will be reported.
  ///
  /// This extrinsic must be called unsigned and it is expected that only
  /// block authors will call it (validated in `ValidateUnsigned`), as such
  /// if the block author is defined it will be defined as the equivocation
  /// reporter.
  _i6.RuntimeCall reportEquivocationUnsigned({
    required _i7.DoubleVotingProof equivocationProof,
    required _i8.MembershipProof keyOwnerProof,
  }) {
    final _call = _i9.Call.values.reportEquivocationUnsigned(
      equivocationProof: equivocationProof,
      keyOwnerProof: keyOwnerProof,
    );
    return _i6.RuntimeCall.values.beefy(_call);
  }

  /// Reset BEEFY consensus by setting a new BEEFY genesis at `delay_in_blocks` blocks in the
  /// future.
  ///
  /// Note: `delay_in_blocks` has to be at least 1.
  _i6.RuntimeCall setNewGenesis({required int delayInBlocks}) {
    final _call = _i9.Call.values.setNewGenesis(delayInBlocks: delayInBlocks);
    return _i6.RuntimeCall.values.beefy(_call);
  }
}

class Constants {
  Constants();

  /// The maximum number of authorities that can be added.
  final int maxAuthorities = 100000;

  /// The maximum number of nominators for each validator.
  final int maxNominators = 512;

  /// The maximum number of entries to keep in the set id to session index mapping.
  ///
  /// Since the `SetIdSession` map is only used for validating equivocations this
  /// value should relate to the bonding duration of whatever staking system is
  /// being used (if any). If equivocation handling is not enabled then this value
  /// can be zero.
  final BigInt maxSetIdSessionEntries = BigInt.from(168);
}
