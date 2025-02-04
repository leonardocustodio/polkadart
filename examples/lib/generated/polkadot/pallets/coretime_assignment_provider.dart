// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/polkadot_primitives/v7/core_index.dart' as _i3;
import '../types/polkadot_runtime_parachains/assigner_coretime/core_descriptor.dart'
    as _i6;
import '../types/polkadot_runtime_parachains/assigner_coretime/schedule.dart'
    as _i4;
import '../types/tuples.dart' as _i2;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Tuple2<int, _i3.CoreIndex>, _i4.Schedule>
      _coreSchedules =
      const _i1.StorageMap<_i2.Tuple2<int, _i3.CoreIndex>, _i4.Schedule>(
    prefix: 'CoretimeAssignmentProvider',
    storage: 'CoreSchedules',
    valueCodec: _i4.Schedule.codec,
    hasher: _i1.StorageHasher.twoxx256(_i2.Tuple2Codec<int, _i3.CoreIndex>(
      _i5.U32Codec.codec,
      _i3.CoreIndexCodec(),
    )),
  );

  final _i1.StorageMap<_i3.CoreIndex, _i6.CoreDescriptor> _coreDescriptors =
      const _i1.StorageMap<_i3.CoreIndex, _i6.CoreDescriptor>(
    prefix: 'CoretimeAssignmentProvider',
    storage: 'CoreDescriptors',
    valueCodec: _i6.CoreDescriptor.codec,
    hasher: _i1.StorageHasher.twoxx256(_i3.CoreIndexCodec()),
  );

  /// Scheduled assignment sets.
  ///
  /// Assignments as of the given block number. They will go into state once the block number is
  /// reached (and replace whatever was in there before).
  _i7.Future<_i4.Schedule?> coreSchedules(
    _i2.Tuple2<int, _i3.CoreIndex> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _coreSchedules.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _coreSchedules.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Assignments which are currently active.
  ///
  /// They will be picked from `PendingAssignments` once we reach the scheduled block number in
  /// `PendingAssignments`.
  _i7.Future<_i6.CoreDescriptor> coreDescriptors(
    _i3.CoreIndex key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _coreDescriptors.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _coreDescriptors.decodeValue(bytes);
    }
    return _i6.CoreDescriptor(
      queue: null,
      currentWork: null,
    ); /* Default */
  }

  /// Returns the storage key for `coreSchedules`.
  _i8.Uint8List coreSchedulesKey(_i2.Tuple2<int, _i3.CoreIndex> key1) {
    final hashedKey = _coreSchedules.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `coreDescriptors`.
  _i8.Uint8List coreDescriptorsKey(_i3.CoreIndex key1) {
    final hashedKey = _coreDescriptors.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `coreSchedules`.
  _i8.Uint8List coreSchedulesMapPrefix() {
    final hashedKey = _coreSchedules.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `coreDescriptors`.
  _i8.Uint8List coreDescriptorsMapPrefix() {
    final hashedKey = _coreDescriptors.mapPrefix();
    return hashedKey;
  }
}
