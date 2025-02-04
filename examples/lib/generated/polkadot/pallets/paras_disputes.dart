// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/b_tree_set.dart' as _i5;
import '../types/polkadot_core_primitives/candidate_hash.dart' as _i3;
import '../types/polkadot_primitives/v7/dispute_state.dart' as _i4;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/polkadot_runtime_parachains/disputes/pallet/call.dart' as _i9;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _lastPrunedSession = const _i1.StorageValue<int>(
    prefix: 'ParasDisputes',
    storage: 'LastPrunedSession',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageDoubleMap<int, _i3.CandidateHash, _i4.DisputeState>
      _disputes =
      const _i1.StorageDoubleMap<int, _i3.CandidateHash, _i4.DisputeState>(
    prefix: 'ParasDisputes',
    storage: 'Disputes',
    valueCodec: _i4.DisputeState.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.CandidateHashCodec()),
  );

  final _i1.StorageDoubleMap<int, _i3.CandidateHash, _i5.BTreeSet>
      _backersOnDisputes =
      const _i1.StorageDoubleMap<int, _i3.CandidateHash, _i5.BTreeSet>(
    prefix: 'ParasDisputes',
    storage: 'BackersOnDisputes',
    valueCodec: _i5.BTreeSetCodec(),
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.CandidateHashCodec()),
  );

  final _i1.StorageDoubleMap<int, _i3.CandidateHash, int> _included =
      const _i1.StorageDoubleMap<int, _i3.CandidateHash, int>(
    prefix: 'ParasDisputes',
    storage: 'Included',
    valueCodec: _i2.U32Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i3.CandidateHashCodec()),
  );

  final _i1.StorageValue<int?> _frozen = const _i1.StorageValue<int?>(
    prefix: 'ParasDisputes',
    storage: 'Frozen',
    valueCodec: _i2.OptionCodec<int>(_i2.U32Codec.codec),
  );

  /// The last pruned session, if any. All data stored by this module
  /// references sessions.
  _i6.Future<int?> lastPrunedSession({_i1.BlockHash? at}) async {
    final hashedKey = _lastPrunedSession.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lastPrunedSession.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All ongoing or concluded disputes for the last several sessions.
  _i6.Future<_i4.DisputeState?> disputes(
    int key1,
    _i3.CandidateHash key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _disputes.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _disputes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Backing votes stored for each dispute.
  /// This storage is used for slashing.
  _i6.Future<_i5.BTreeSet?> backersOnDisputes(
    int key1,
    _i3.CandidateHash key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _backersOnDisputes.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _backersOnDisputes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All included blocks on the chain, as well as the block number in this chain that
  /// should be reverted back to if the candidate is disputed and determined to be invalid.
  _i6.Future<int?> included(
    int key1,
    _i3.CandidateHash key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _included.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _included.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Whether the chain is frozen. Starts as `None`. When this is `Some`,
  /// the chain will not accept any new parachain blocks for backing or inclusion,
  /// and its value indicates the last valid block number in the chain.
  /// It can only be set back to `None` by governance intervention.
  _i6.Future<int?> frozen({_i1.BlockHash? at}) async {
    final hashedKey = _frozen.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _frozen.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// Returns the storage key for `lastPrunedSession`.
  _i7.Uint8List lastPrunedSessionKey() {
    final hashedKey = _lastPrunedSession.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `disputes`.
  _i7.Uint8List disputesKey(
    int key1,
    _i3.CandidateHash key2,
  ) {
    final hashedKey = _disputes.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `backersOnDisputes`.
  _i7.Uint8List backersOnDisputesKey(
    int key1,
    _i3.CandidateHash key2,
  ) {
    final hashedKey = _backersOnDisputes.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `included`.
  _i7.Uint8List includedKey(
    int key1,
    _i3.CandidateHash key2,
  ) {
    final hashedKey = _included.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage key for `frozen`.
  _i7.Uint8List frozenKey() {
    final hashedKey = _frozen.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `disputes`.
  _i7.Uint8List disputesMapPrefix(int key1) {
    final hashedKey = _disputes.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `backersOnDisputes`.
  _i7.Uint8List backersOnDisputesMapPrefix(int key1) {
    final hashedKey = _backersOnDisputes.mapPrefix(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `included`.
  _i7.Uint8List includedMapPrefix(int key1) {
    final hashedKey = _included.mapPrefix(key1);
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i8.RuntimeCall forceUnfreeze() {
    final _call = _i9.Call.forceUnfreeze;
    return _i8.RuntimeCall.values.parasDisputes(_call);
  }
}
