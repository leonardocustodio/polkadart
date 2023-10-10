// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/polkadot_parachain/primitives/id.dart' as _i4;
import '../types/polkadot_primitives/v4/candidate_commitments.dart' as _i6;
import '../types/polkadot_primitives/v4/validator_index.dart' as _i2;
import '../types/polkadot_runtime_parachains/inclusion/availability_bitfield_record.dart'
    as _i3;
import '../types/polkadot_runtime_parachains/inclusion/candidate_pending_availability.dart'
    as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.ValidatorIndex, _i3.AvailabilityBitfieldRecord>
      _availabilityBitfields =
      const _i1.StorageMap<_i2.ValidatorIndex, _i3.AvailabilityBitfieldRecord>(
    prefix: 'ParaInclusion',
    storage: 'AvailabilityBitfields',
    valueCodec: _i3.AvailabilityBitfieldRecord.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.ValidatorIndexCodec()),
  );

  final _i1.StorageMap<_i4.Id, _i5.CandidatePendingAvailability>
      _pendingAvailability =
      const _i1.StorageMap<_i4.Id, _i5.CandidatePendingAvailability>(
    prefix: 'ParaInclusion',
    storage: 'PendingAvailability',
    valueCodec: _i5.CandidatePendingAvailability.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.IdCodec()),
  );

  final _i1.StorageMap<_i4.Id, _i6.CandidateCommitments>
      _pendingAvailabilityCommitments =
      const _i1.StorageMap<_i4.Id, _i6.CandidateCommitments>(
    prefix: 'ParaInclusion',
    storage: 'PendingAvailabilityCommitments',
    valueCodec: _i6.CandidateCommitments.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i4.IdCodec()),
  );

  /// The latest bitfield for each validator, referred to by their index in the validator set.
  _i7.Future<_i3.AvailabilityBitfieldRecord?> availabilityBitfields(
    _i2.ValidatorIndex key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _availabilityBitfields.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _availabilityBitfields.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Candidates pending availability by `ParaId`.
  _i7.Future<_i5.CandidatePendingAvailability?> pendingAvailability(
    _i4.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pendingAvailability.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingAvailability.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The commitments of candidates pending availability, by `ParaId`.
  _i7.Future<_i6.CandidateCommitments?> pendingAvailabilityCommitments(
    _i4.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _pendingAvailabilityCommitments.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _pendingAvailabilityCommitments.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}
