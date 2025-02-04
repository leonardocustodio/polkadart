// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i2;
import '../types/polkadot_runtime_parachains/inclusion/candidate_pending_availability.dart'
    as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, List<_i3.CandidatePendingAvailability>> _v1 =
      const _i1.StorageMap<_i2.Id, List<_i3.CandidatePendingAvailability>>(
    prefix: 'ParaInclusion',
    storage: 'V1',
    valueCodec: _i4.SequenceCodec<_i3.CandidatePendingAvailability>(
        _i3.CandidatePendingAvailability.codec),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  /// Candidates pending availability by `ParaId`. They form a chain starting from the latest
  /// included head of the para.
  /// Use a different prefix post-migration to v1, since the v0 `PendingAvailability` storage
  /// would otherwise have the exact same prefix which could cause undefined behaviour when doing
  /// the migration.
  _i5.Future<List<_i3.CandidatePendingAvailability>?> v1(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _v1.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _v1.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `v1`.
  _i6.Uint8List v1Key(_i2.Id key1) {
    final hashedKey = _v1.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `v1`.
  _i6.Uint8List v1MapPrefix() {
    final hashedKey = _v1.mapPrefix();
    return hashedKey;
  }
}
