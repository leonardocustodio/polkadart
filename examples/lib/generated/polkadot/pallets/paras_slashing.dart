// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_core_primitives/candidate_hash.dart' as _i2;
import '../types/polkadot_primitives/v7/slashing/dispute_proof.dart' as _i8;
import '../types/polkadot_primitives/v7/slashing/pending_slashes.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/polkadot_runtime_parachains/disputes/slashing/pallet/call.dart'
    as _i10;
import '../types/sp_session/membership_proof.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageDoubleMap<int, _i2.CandidateHash, _i3.PendingSlashes>
      _unappliedSlashes =
      const _i1.StorageDoubleMap<int, _i2.CandidateHash, _i3.PendingSlashes>(
    prefix: 'ParasSlashing',
    storage: 'UnappliedSlashes',
    valueCodec: _i3.PendingSlashes.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i2.CandidateHashCodec()),
  );

  final _i1.StorageMap<int, int> _validatorSetCounts =
      const _i1.StorageMap<int, int>(
    prefix: 'ParasSlashing',
    storage: 'ValidatorSetCounts',
    valueCodec: _i4.U32Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.U32Codec.codec),
  );

  /// Validators pending dispute slashes.
  _i5.Future<_i3.PendingSlashes?> unappliedSlashes(
    int key1,
    _i2.CandidateHash key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _unappliedSlashes.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _unappliedSlashes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// `ValidatorSetCount` per session.
  _i5.Future<int?> validatorSetCounts(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _validatorSetCounts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validatorSetCounts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `unappliedSlashes`.
  _i6.Uint8List unappliedSlashesKey(
    int key1,
    _i2.CandidateHash key2,
  ) {
    final hashedKey = _unappliedSlashes.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `validatorSetCounts`.
  _i6.Uint8List validatorSetCountsKey(int key1) {
    final hashedKey = _validatorSetCounts.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `unappliedSlashes`.
  _i6.Uint8List unappliedSlashesMapPrefix(int key1) {
    final hashedKey = _unappliedSlashes.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `validatorSetCounts`.
  _i6.Uint8List validatorSetCountsMapPrefix() {
    final hashedKey = _validatorSetCounts.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i7.RuntimeCall reportDisputeLostUnsigned({
    required _i8.DisputeProof disputeProof,
    required _i9.MembershipProof keyOwnerProof,
  }) {
    final _call = _i10.Call.values.reportDisputeLostUnsigned(
      disputeProof: disputeProof,
      keyOwnerProof: keyOwnerProof,
    );
    return _i7.RuntimeCall.values.parasSlashing(_call);
  }
}
