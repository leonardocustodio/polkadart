// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;
import 'dart:typed_data' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/sp_consensus_beefy/mmr/beefy_authority_set.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.BeefyAuthoritySet> _beefyAuthorities =
      const _i1.StorageValue<_i2.BeefyAuthoritySet>(
    prefix: 'BeefyMmrLeaf',
    storage: 'BeefyAuthorities',
    valueCodec: _i2.BeefyAuthoritySet.codec,
  );

  final _i1.StorageValue<_i2.BeefyAuthoritySet> _beefyNextAuthorities =
      const _i1.StorageValue<_i2.BeefyAuthoritySet>(
    prefix: 'BeefyMmrLeaf',
    storage: 'BeefyNextAuthorities',
    valueCodec: _i2.BeefyAuthoritySet.codec,
  );

  /// Details of current BEEFY authority set.
  _i3.Future<_i2.BeefyAuthoritySet> beefyAuthorities(
      {_i1.BlockHash? at}) async {
    final hashedKey = _beefyAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _beefyAuthorities.decodeValue(bytes);
    }
    return _i2.BeefyAuthoritySet(
      id: BigInt.zero,
      len: 0,
      keysetCommitment: List<int>.filled(
        32,
        0,
        growable: false,
      ),
    ); /* Default */
  }

  /// Details of next BEEFY authority set.
  ///
  /// This storage entry is used as cache for calls to `update_beefy_next_authority_set`.
  _i3.Future<_i2.BeefyAuthoritySet> beefyNextAuthorities(
      {_i1.BlockHash? at}) async {
    final hashedKey = _beefyNextAuthorities.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _beefyNextAuthorities.decodeValue(bytes);
    }
    return _i2.BeefyAuthoritySet(
      id: BigInt.zero,
      len: 0,
      keysetCommitment: List<int>.filled(
        32,
        0,
        growable: false,
      ),
    ); /* Default */
  }

  /// Returns the storage key for `beefyAuthorities`.
  _i4.Uint8List beefyAuthoritiesKey() {
    final hashedKey = _beefyAuthorities.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `beefyNextAuthorities`.
  _i4.Uint8List beefyNextAuthoritiesKey() {
    final hashedKey = _beefyNextAuthorities.hashedKey();
    return hashedKey;
  }
}
