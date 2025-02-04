// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_whitelist/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_weights/weight_v2/weight.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, dynamic> _whitelistedCall =
      const _i1.StorageMap<_i2.H256, dynamic>(
    prefix: 'Whitelist',
    storage: 'WhitelistedCall',
    valueCodec: _i3.NullCodec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.H256Codec()),
  );

  _i4.Future<dynamic> whitelistedCall(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _whitelistedCall.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _whitelistedCall.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `whitelistedCall`.
  _i5.Uint8List whitelistedCallKey(_i2.H256 key1) {
    final hashedKey = _whitelistedCall.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `whitelistedCall`.
  _i5.Uint8List whitelistedCallMapPrefix() {
    final hashedKey = _whitelistedCall.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  _i6.RuntimeCall whitelistCall({required _i2.H256 callHash}) {
    final _call = _i7.Call.values.whitelistCall(callHash: callHash);
    return _i6.RuntimeCall.values.whitelist(_call);
  }

  _i6.RuntimeCall removeWhitelistedCall({required _i2.H256 callHash}) {
    final _call = _i7.Call.values.removeWhitelistedCall(callHash: callHash);
    return _i6.RuntimeCall.values.whitelist(_call);
  }

  _i6.RuntimeCall dispatchWhitelistedCall({
    required _i2.H256 callHash,
    required int callEncodedLen,
    required _i8.Weight callWeightWitness,
  }) {
    final _call = _i7.Call.values.dispatchWhitelistedCall(
      callHash: callHash,
      callEncodedLen: callEncodedLen,
      callWeightWitness: callWeightWitness,
    );
    return _i6.RuntimeCall.values.whitelist(_call);
  }

  _i6.RuntimeCall dispatchWhitelistedCallWithPreimage(
      {required _i6.RuntimeCall call}) {
    final _call =
        _i7.Call.values.dispatchWhitelistedCallWithPreimage(call: call);
    return _i6.RuntimeCall.values.whitelist(_call);
  }
}
