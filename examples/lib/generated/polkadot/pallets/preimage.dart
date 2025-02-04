// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;
import 'dart:typed_data' as _i8;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i6;

import '../types/pallet_preimage/old_request_status.dart' as _i3;
import '../types/pallet_preimage/pallet/call.dart' as _i10;
import '../types/pallet_preimage/request_status.dart' as _i4;
import '../types/polkadot_runtime/runtime_call.dart' as _i9;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/tuples.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, _i3.OldRequestStatus> _statusFor =
      const _i1.StorageMap<_i2.H256, _i3.OldRequestStatus>(
    prefix: 'Preimage',
    storage: 'StatusFor',
    valueCodec: _i3.OldRequestStatus.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, _i4.RequestStatus> _requestStatusFor =
      const _i1.StorageMap<_i2.H256, _i4.RequestStatus>(
    prefix: 'Preimage',
    storage: 'RequestStatusFor',
    valueCodec: _i4.RequestStatus.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i5.Tuple2<_i2.H256, int>, List<int>> _preimageFor =
      const _i1.StorageMap<_i5.Tuple2<_i2.H256, int>, List<int>>(
    prefix: 'Preimage',
    storage: 'PreimageFor',
    valueCodec: _i6.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i5.Tuple2Codec<_i2.H256, int>(
      _i2.H256Codec(),
      _i6.U32Codec.codec,
    )),
  );

  /// The request status of a given hash.
  _i7.Future<_i3.OldRequestStatus?> statusFor(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _statusFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _statusFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The request status of a given hash.
  _i7.Future<_i4.RequestStatus?> requestStatusFor(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _requestStatusFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _requestStatusFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  _i7.Future<List<int>?> preimageFor(
    _i5.Tuple2<_i2.H256, int> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _preimageFor.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _preimageFor.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `statusFor`.
  _i8.Uint8List statusForKey(_i2.H256 key1) {
    final hashedKey = _statusFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `requestStatusFor`.
  _i8.Uint8List requestStatusForKey(_i2.H256 key1) {
    final hashedKey = _requestStatusFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `preimageFor`.
  _i8.Uint8List preimageForKey(_i5.Tuple2<_i2.H256, int> key1) {
    final hashedKey = _preimageFor.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `statusFor`.
  _i8.Uint8List statusForMapPrefix() {
    final hashedKey = _statusFor.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `requestStatusFor`.
  _i8.Uint8List requestStatusForMapPrefix() {
    final hashedKey = _requestStatusFor.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `preimageFor`.
  _i8.Uint8List preimageForMapPrefix() {
    final hashedKey = _preimageFor.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Register a preimage on-chain.
  ///
  /// If the preimage was previously requested, no fees or deposits are taken for providing
  /// the preimage. Otherwise, a deposit is taken proportional to the size of the preimage.
  _i9.RuntimeCall notePreimage({required List<int> bytes}) {
    final _call = _i10.Call.values.notePreimage(bytes: bytes);
    return _i9.RuntimeCall.values.preimage(_call);
  }

  /// Clear an unrequested preimage from the runtime storage.
  ///
  /// If `len` is provided, then it will be a much cheaper operation.
  ///
  /// - `hash`: The hash of the preimage to be removed from the store.
  /// - `len`: The length of the preimage of `hash`.
  _i9.RuntimeCall unnotePreimage({required _i2.H256 hash}) {
    final _call = _i10.Call.values.unnotePreimage(hash: hash);
    return _i9.RuntimeCall.values.preimage(_call);
  }

  /// Request a preimage be uploaded to the chain without paying any fees or deposits.
  ///
  /// If the preimage requests has already been provided on-chain, we unreserve any deposit
  /// a user may have paid, and take the control of the preimage out of their hands.
  _i9.RuntimeCall requestPreimage({required _i2.H256 hash}) {
    final _call = _i10.Call.values.requestPreimage(hash: hash);
    return _i9.RuntimeCall.values.preimage(_call);
  }

  /// Clear a previously made request for a preimage.
  ///
  /// NOTE: THIS MUST NOT BE CALLED ON `hash` MORE TIMES THAN `request_preimage`.
  _i9.RuntimeCall unrequestPreimage({required _i2.H256 hash}) {
    final _call = _i10.Call.values.unrequestPreimage(hash: hash);
    return _i9.RuntimeCall.values.preimage(_call);
  }

  /// Ensure that the a bulk of pre-images is upgraded.
  ///
  /// The caller pays no fee if at least 90% of pre-images were successfully updated.
  _i9.RuntimeCall ensureUpdated({required List<_i2.H256> hashes}) {
    final _call = _i10.Call.values.ensureUpdated(hashes: hashes);
    return _i9.RuntimeCall.values.preimage(_call);
  }
}
