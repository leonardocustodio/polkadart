// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/frame_support/traits/misc/wrapper_opaque.dart' as _i4;
import '../types/pallet_im_online/pallet/call.dart' as _i8;
import '../types/pallet_im_online/sr25519/app_sr25519/public.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/sp_core/crypto/account_id32.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _heartbeatAfter = const _i1.StorageValue<int>(
    prefix: 'ImOnline',
    storage: 'HeartbeatAfter',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<List<_i3.Public>> _keys =
      const _i1.StorageValue<List<_i3.Public>>(
    prefix: 'ImOnline',
    storage: 'Keys',
    valueCodec: _i2.SequenceCodec<_i3.Public>(_i3.PublicCodec()),
  );

  final _i1.StorageDoubleMap<int, int, _i4.WrapperOpaque> _receivedHeartbeats =
      const _i1.StorageDoubleMap<int, int, _i4.WrapperOpaque>(
    prefix: 'ImOnline',
    storage: 'ReceivedHeartbeats',
    valueCodec: _i4.WrapperOpaque.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  final _i1.StorageDoubleMap<int, _i5.AccountId32, int> _authoredBlocks =
      const _i1.StorageDoubleMap<int, _i5.AccountId32, int>(
    prefix: 'ImOnline',
    storage: 'AuthoredBlocks',
    valueCodec: _i2.U32Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.twoxx64Concat(_i5.AccountId32Codec()),
  );

  /// The block number after which it's ok to send heartbeats in the current
  /// session.
  ///
  /// At the beginning of each session we set this to a value that should fall
  /// roughly in the middle of the session duration. The idea is to first wait for
  /// the validators to produce a block in the current session, so that the
  /// heartbeat later on will not be necessary.
  ///
  /// This value will only be used as a fallback if we fail to get a proper session
  /// progress estimate from `NextSessionRotation`, as those estimates should be
  /// more accurate then the value we calculate for `HeartbeatAfter`.
  _i6.Future<int> heartbeatAfter({_i1.BlockHash? at}) async {
    final hashedKey = _heartbeatAfter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _heartbeatAfter.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// The current set of keys that may issue a heartbeat.
  _i6.Future<List<_i3.Public>> keys({_i1.BlockHash? at}) async {
    final hashedKey = _keys.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _keys.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// For each session index, we keep a mapping of `SessionIndex` and `AuthIndex` to
  /// `WrapperOpaque<BoundedOpaqueNetworkState>`.
  _i6.Future<_i4.WrapperOpaque?> receivedHeartbeats(
    int key1,
    int key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _receivedHeartbeats.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _receivedHeartbeats.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// For each session index, we keep a mapping of `ValidatorId<T>` to the
  /// number of blocks authored by the given authority.
  _i6.Future<int> authoredBlocks(
    int key1,
    _i5.AccountId32 key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _authoredBlocks.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _authoredBlocks.decodeValue(bytes);
    }
    return 0; /* Default */
  }
}

class Txs {
  const Txs();

  /// ## Complexity:
  /// - `O(K + E)` where K is length of `Keys` (heartbeat.validators_len) and E is length of
  ///  `heartbeat.network_state.external_address`
  ///  - `O(K)`: decoding of length `K`
  ///  - `O(E)`: decoding/encoding of length `E`
  _i7.RuntimeCall heartbeat({
    required heartbeat,
    required signature,
  }) {
    final _call = _i8.Call.values.heartbeat(
      heartbeat: heartbeat,
      signature: signature,
    );
    return _i7.RuntimeCall.values.imOnline(_call);
  }
}

class Constants {
  Constants();

  /// A configuration for base priority of unsigned transactions.
  ///
  /// This is exposed so that it can be tuned for particular runtime, when
  /// multiple pallets send unsigned transactions.
  final BigInt unsignedPriority = BigInt.parse(
    '18446744073709551615',
    radix: 10,
  );
}
