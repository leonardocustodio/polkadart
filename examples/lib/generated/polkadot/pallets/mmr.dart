// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/primitive_types/h256.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.H256> _rootHash = const _i1.StorageValue<_i2.H256>(
    prefix: 'Mmr',
    storage: 'RootHash',
    valueCodec: _i2.H256Codec(),
  );

  final _i1.StorageValue<BigInt> _numberOfLeaves =
      const _i1.StorageValue<BigInt>(
    prefix: 'Mmr',
    storage: 'NumberOfLeaves',
    valueCodec: _i3.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i2.H256> _nodes =
      const _i1.StorageMap<BigInt, _i2.H256>(
    prefix: 'Mmr',
    storage: 'Nodes',
    valueCodec: _i2.H256Codec(),
    hasher: _i1.StorageHasher.identity(_i3.U64Codec.codec),
  );

  /// Latest MMR Root hash.
  _i4.Future<_i2.H256> rootHash({_i1.BlockHash? at}) async {
    final hashedKey = _rootHash.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _rootHash.decodeValue(bytes);
    }
    return List<int>.filled(
      32,
      0,
      growable: false,
    ); /* Default */
  }

  /// Current size of the MMR (number of leaves).
  _i4.Future<BigInt> numberOfLeaves({_i1.BlockHash? at}) async {
    final hashedKey = _numberOfLeaves.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _numberOfLeaves.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// Hashes of the nodes in the MMR.
  ///
  /// Note this collection only contains MMR peaks, the inner nodes (and leaves)
  /// are pruned and only stored in the Offchain DB.
  _i4.Future<_i2.H256?> nodes(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nodes.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nodes.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `rootHash`.
  _i5.Uint8List rootHashKey() {
    final hashedKey = _rootHash.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `numberOfLeaves`.
  _i5.Uint8List numberOfLeavesKey() {
    final hashedKey = _numberOfLeaves.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nodes`.
  _i5.Uint8List nodesKey(BigInt key1) {
    final hashedKey = _nodes.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `nodes`.
  _i5.Uint8List nodesMapPrefix() {
    final hashedKey = _nodes.mapPrefix();
    return hashedKey;
  }
}
