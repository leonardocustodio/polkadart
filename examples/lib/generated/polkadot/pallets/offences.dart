// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_staking/offence/offence_details.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, _i3.OffenceDetails> _reports =
      const _i1.StorageMap<_i2.H256, _i3.OffenceDetails>(
    prefix: 'Offences',
    storage: 'Reports',
    valueCodec: _i3.OffenceDetails.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.H256Codec()),
  );

  final _i1.StorageDoubleMap<List<int>, List<int>, List<_i2.H256>>
      _concurrentReportsIndex =
      const _i1.StorageDoubleMap<List<int>, List<int>, List<_i2.H256>>(
    prefix: 'Offences',
    storage: 'ConcurrentReportsIndex',
    valueCodec: _i4.SequenceCodec<_i2.H256>(_i2.H256Codec()),
    hasher1: _i1.StorageHasher.twoxx64Concat(_i4.U8ArrayCodec(16)),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i4.U8SequenceCodec.codec),
  );

  /// The primary structure that holds all offence records keyed by report identifiers.
  _i5.Future<_i3.OffenceDetails?> reports(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reports.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reports.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// A vector of reports of the same kind that happened at the same time slot.
  _i5.Future<List<_i2.H256>> concurrentReportsIndex(
    List<int> key1,
    List<int> key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _concurrentReportsIndex.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _concurrentReportsIndex.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `reports`.
  _i6.Uint8List reportsKey(_i2.H256 key1) {
    final hashedKey = _reports.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `concurrentReportsIndex`.
  _i6.Uint8List concurrentReportsIndexKey(
    List<int> key1,
    List<int> key2,
  ) {
    final hashedKey = _concurrentReportsIndex.hashedKeyFor(
      key1,
      key2,
    );
    return hashedKey;
  }

  /// Returns the storage map key prefix for `reports`.
  _i6.Uint8List reportsMapPrefix() {
    final hashedKey = _reports.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `concurrentReportsIndex`.
  _i6.Uint8List concurrentReportsIndexMapPrefix(List<int> key1) {
    final hashedKey = _concurrentReportsIndex.mapPrefix(key1);
    return hashedKey;
  }
}
