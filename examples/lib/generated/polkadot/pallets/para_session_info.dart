// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/polkadot_primitives/v7/assignment_app/public.dart' as _i2;
import '../types/polkadot_primitives/v7/executor_params/executor_params.dart'
    as _i6;
import '../types/polkadot_primitives/v7/session_info.dart' as _i4;
import '../types/sp_core/crypto/account_id32.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.Public>> _assignmentKeysUnsafe =
      const _i1.StorageValue<List<_i2.Public>>(
    prefix: 'ParaSessionInfo',
    storage: 'AssignmentKeysUnsafe',
    valueCodec: _i3.SequenceCodec<_i2.Public>(_i2.PublicCodec()),
  );

  final _i1.StorageValue<int> _earliestStoredSession =
      const _i1.StorageValue<int>(
    prefix: 'ParaSessionInfo',
    storage: 'EarliestStoredSession',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageMap<int, _i4.SessionInfo> _sessions =
      const _i1.StorageMap<int, _i4.SessionInfo>(
    prefix: 'ParaSessionInfo',
    storage: 'Sessions',
    valueCodec: _i4.SessionInfo.codec,
    hasher: _i1.StorageHasher.identity(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, List<_i5.AccountId32>> _accountKeys =
      const _i1.StorageMap<int, List<_i5.AccountId32>>(
    prefix: 'ParaSessionInfo',
    storage: 'AccountKeys',
    valueCodec: _i3.SequenceCodec<_i5.AccountId32>(_i5.AccountId32Codec()),
    hasher: _i1.StorageHasher.identity(_i3.U32Codec.codec),
  );

  final _i1.StorageMap<int, _i6.ExecutorParams> _sessionExecutorParams =
      const _i1.StorageMap<int, _i6.ExecutorParams>(
    prefix: 'ParaSessionInfo',
    storage: 'SessionExecutorParams',
    valueCodec: _i6.ExecutorParamsCodec(),
    hasher: _i1.StorageHasher.identity(_i3.U32Codec.codec),
  );

  /// Assignment keys for the current session.
  /// Note that this API is private due to it being prone to 'off-by-one' at session boundaries.
  /// When in doubt, use `Sessions` API instead.
  _i7.Future<List<_i2.Public>> assignmentKeysUnsafe({_i1.BlockHash? at}) async {
    final hashedKey = _assignmentKeysUnsafe.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _assignmentKeysUnsafe.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The earliest session for which previous session info is stored.
  _i7.Future<int> earliestStoredSession({_i1.BlockHash? at}) async {
    final hashedKey = _earliestStoredSession.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _earliestStoredSession.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Session information in a rolling window.
  /// Should have an entry in range `EarliestStoredSession..=CurrentSessionIndex`.
  /// Does not have any entries before the session index in the first session change notification.
  _i7.Future<_i4.SessionInfo?> sessions(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _sessions.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _sessions.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The validator account keys of the validators actively participating in parachain consensus.
  _i7.Future<List<_i5.AccountId32>?> accountKeys(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _accountKeys.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _accountKeys.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Executor parameter set for a given session index
  _i7.Future<_i6.ExecutorParams?> sessionExecutorParams(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _sessionExecutorParams.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _sessionExecutorParams.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `assignmentKeysUnsafe`.
  _i8.Uint8List assignmentKeysUnsafeKey() {
    final hashedKey = _assignmentKeysUnsafe.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `earliestStoredSession`.
  _i8.Uint8List earliestStoredSessionKey() {
    final hashedKey = _earliestStoredSession.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `sessions`.
  _i8.Uint8List sessionsKey(int key1) {
    final hashedKey = _sessions.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `accountKeys`.
  _i8.Uint8List accountKeysKey(int key1) {
    final hashedKey = _accountKeys.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `sessionExecutorParams`.
  _i8.Uint8List sessionExecutorParamsKey(int key1) {
    final hashedKey = _sessionExecutorParams.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `sessions`.
  _i8.Uint8List sessionsMapPrefix() {
    final hashedKey = _sessions.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `accountKeys`.
  _i8.Uint8List accountKeysMapPrefix() {
    final hashedKey = _accountKeys.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `sessionExecutorParams`.
  _i8.Uint8List sessionExecutorParamsMapPrefix() {
    final hashedKey = _sessionExecutorParams.mapPrefix();
    return hashedKey;
  }
}
