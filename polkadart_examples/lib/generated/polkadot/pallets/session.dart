// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_session/pallet/call.dart' as _i9;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/polkadot_runtime/session_keys.dart' as _i5;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_core/crypto/key_type_id.dart' as _i6;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<List<_i2.AccountId32>> _validators =
      const _i1.StorageValue<List<_i2.AccountId32>>(
    prefix: 'Session',
    storage: 'Validators',
    valueCodec: _i3.SequenceCodec<_i2.AccountId32>(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<int> _currentIndex = const _i1.StorageValue<int>(
    prefix: 'Session',
    storage: 'CurrentIndex',
    valueCodec: _i3.U32Codec.codec,
  );

  final _i1.StorageValue<bool> _queuedChanged = const _i1.StorageValue<bool>(
    prefix: 'Session',
    storage: 'QueuedChanged',
    valueCodec: _i3.BoolCodec.codec,
  );

  final _i1.StorageValue<List<_i4.Tuple2<_i2.AccountId32, _i5.SessionKeys>>>
      _queuedKeys = const _i1
          .StorageValue<List<_i4.Tuple2<_i2.AccountId32, _i5.SessionKeys>>>(
    prefix: 'Session',
    storage: 'QueuedKeys',
    valueCodec: _i3.SequenceCodec<_i4.Tuple2<_i2.AccountId32, _i5.SessionKeys>>(
        _i4.Tuple2Codec<_i2.AccountId32, _i5.SessionKeys>(
      _i2.AccountId32Codec(),
      _i5.SessionKeys.codec,
    )),
  );

  final _i1.StorageValue<List<int>> _disabledValidators =
      const _i1.StorageValue<List<int>>(
    prefix: 'Session',
    storage: 'DisabledValidators',
    valueCodec: _i3.U32SequenceCodec.codec,
  );

  final _i1.StorageMap<_i2.AccountId32, _i5.SessionKeys> _nextKeys =
      const _i1.StorageMap<_i2.AccountId32, _i5.SessionKeys>(
    prefix: 'Session',
    storage: 'NextKeys',
    valueCodec: _i5.SessionKeys.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageMap<_i4.Tuple2<_i6.KeyTypeId, List<int>>, _i2.AccountId32>
      _keyOwner = const _i1
          .StorageMap<_i4.Tuple2<_i6.KeyTypeId, List<int>>, _i2.AccountId32>(
    prefix: 'Session',
    storage: 'KeyOwner',
    valueCodec: _i2.AccountId32Codec(),
    hasher: _i1.StorageHasher.twoxx64Concat(
        _i4.Tuple2Codec<_i6.KeyTypeId, List<int>>(
      _i6.KeyTypeIdCodec(),
      _i3.U8SequenceCodec.codec,
    )),
  );

  /// The current set of validators.
  _i7.Future<List<_i2.AccountId32>> validators({_i1.BlockHash? at}) async {
    final hashedKey = _validators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _validators.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Current index of the session.
  _i7.Future<int> currentIndex({_i1.BlockHash? at}) async {
    final hashedKey = _currentIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// True if the underlying economic identities or weighting behind the validators
  /// has changed in the queued validator set.
  _i7.Future<bool> queuedChanged({_i1.BlockHash? at}) async {
    final hashedKey = _queuedChanged.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queuedChanged.decodeValue(bytes);
    }
    return false; /* Default */
  }

  /// The queued keys for the next session. When the next session begins, these keys
  /// will be used to determine the validator's session keys.
  _i7.Future<List<_i4.Tuple2<_i2.AccountId32, _i5.SessionKeys>>> queuedKeys(
      {_i1.BlockHash? at}) async {
    final hashedKey = _queuedKeys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queuedKeys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Indices of disabled validators.
  ///
  /// The vec is always kept sorted so that we can find whether a given validator is
  /// disabled using binary search. It gets cleared when `on_session_ending` returns
  /// a new set of identities.
  _i7.Future<List<int>> disabledValidators({_i1.BlockHash? at}) async {
    final hashedKey = _disabledValidators.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _disabledValidators.decodeValue(bytes);
    }
    return List<int>.filled(
      0,
      0,
      growable: true,
    ); /* Default */
  }

  /// The next session keys for a validator.
  _i7.Future<_i5.SessionKeys?> nextKeys(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _nextKeys.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextKeys.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The owner of a key. The key is the `KeyTypeId` + the encoded key.
  _i7.Future<_i2.AccountId32?> keyOwner(
    _i4.Tuple2<_i6.KeyTypeId, List<int>> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _keyOwner.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _keyOwner.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Sets the session key(s) of the function caller to `keys`.
  /// Allows an account to set its session key prior to becoming a validator.
  /// This doesn't take effect until the next session.
  ///
  /// The dispatch origin of this function must be signed.
  ///
  /// ## Complexity
  /// - `O(1)`. Actual cost depends on the number of length of `T::Keys::key_ids()` which is
  ///  fixed.
  _i8.RuntimeCall setKeys({
    required keys,
    required proof,
  }) {
    final _call = _i9.Call.values.setKeys(
      keys: keys,
      proof: proof,
    );
    return _i8.RuntimeCall.values.session(_call);
  }

  /// Removes any session key(s) of the function caller.
  ///
  /// This doesn't take effect until the next session.
  ///
  /// The dispatch origin of this function must be Signed and the account must be either be
  /// convertible to a validator ID using the chain's typical addressing system (this usually
  /// means being a controller account) or directly convertible into a validator ID (which
  /// usually means being a stash account).
  ///
  /// ## Complexity
  /// - `O(1)` in number of key types. Actual cost depends on the number of length of
  ///  `T::Keys::key_ids()` which is fixed.
  _i8.RuntimeCall purgeKeys() {
    final _call = _i9.Call.values.purgeKeys();
    return _i8.RuntimeCall.values.session(_call);
  }
}
