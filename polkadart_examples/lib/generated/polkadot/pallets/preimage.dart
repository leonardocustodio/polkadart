// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/pallet_preimage/pallet/call.dart' as _i8;
import '../types/pallet_preimage/request_status.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/tuples.dart' as _i4;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, _i3.RequestStatus> _statusFor =
      const _i1.StorageMap<_i2.H256, _i3.RequestStatus>(
    prefix: 'Preimage',
    storage: 'StatusFor',
    valueCodec: _i3.RequestStatus.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i4.Tuple2<_i2.H256, int>, List<int>> _preimageFor =
      const _i1.StorageMap<_i4.Tuple2<_i2.H256, int>, List<int>>(
    prefix: 'Preimage',
    storage: 'PreimageFor',
    valueCodec: _i5.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i4.Tuple2Codec<_i2.H256, int>(
      _i2.H256Codec(),
      _i5.U32Codec.codec,
    )),
  );

  /// The request status of a given hash.
  _i6.Future<_i3.RequestStatus?> statusFor(
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

  _i6.Future<List<int>?> preimageFor(
    _i4.Tuple2<_i2.H256, int> key1, {
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
}

class Txs {
  const Txs();

  /// Register a preimage on-chain.
  ///
  /// If the preimage was previously requested, no fees or deposits are taken for providing
  /// the preimage. Otherwise, a deposit is taken proportional to the size of the preimage.
  _i7.RuntimeCall notePreimage({required bytes}) {
    final _call = _i8.Call.values.notePreimage(bytes: bytes);
    return _i7.RuntimeCall.values.preimage(_call);
  }

  /// Clear an unrequested preimage from the runtime storage.
  ///
  /// If `len` is provided, then it will be a much cheaper operation.
  ///
  /// - `hash`: The hash of the preimage to be removed from the store.
  /// - `len`: The length of the preimage of `hash`.
  _i7.RuntimeCall unnotePreimage({required hash}) {
    final _call = _i8.Call.values.unnotePreimage(hash: hash);
    return _i7.RuntimeCall.values.preimage(_call);
  }

  /// Request a preimage be uploaded to the chain without paying any fees or deposits.
  ///
  /// If the preimage requests has already been provided on-chain, we unreserve any deposit
  /// a user may have paid, and take the control of the preimage out of their hands.
  _i7.RuntimeCall requestPreimage({required hash}) {
    final _call = _i8.Call.values.requestPreimage(hash: hash);
    return _i7.RuntimeCall.values.preimage(_call);
  }

  /// Clear a previously made request for a preimage.
  ///
  /// NOTE: THIS MUST NOT BE CALLED ON `hash` MORE TIMES THAN `request_preimage`.
  _i7.RuntimeCall unrequestPreimage({required hash}) {
    final _call = _i8.Call.values.unrequestPreimage(hash: hash);
    return _i7.RuntimeCall.values.preimage(_call);
  }
}
