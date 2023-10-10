// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i3;

import '../types/pallet_whitelist/pallet/call.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i5;
import '../types/primitive_types/h256.dart' as _i2;

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
}

class Txs {
  const Txs();

  _i5.RuntimeCall whitelistCall({required callHash}) {
    final _call = _i6.Call.values.whitelistCall(callHash: callHash);
    return _i5.RuntimeCall.values.whitelist(_call);
  }

  _i5.RuntimeCall removeWhitelistedCall({required callHash}) {
    final _call = _i6.Call.values.removeWhitelistedCall(callHash: callHash);
    return _i5.RuntimeCall.values.whitelist(_call);
  }

  _i5.RuntimeCall dispatchWhitelistedCall({
    required callHash,
    required callEncodedLen,
    required callWeightWitness,
  }) {
    final _call = _i6.Call.values.dispatchWhitelistedCall(
      callHash: callHash,
      callEncodedLen: callEncodedLen,
      callWeightWitness: callWeightWitness,
    );
    return _i5.RuntimeCall.values.whitelist(_call);
  }

  _i5.RuntimeCall dispatchWhitelistedCallWithPreimage({required call}) {
    final _call =
        _i6.Call.values.dispatchWhitelistedCallWithPreimage(call: call);
    return _i5.RuntimeCall.values.whitelist(_call);
  }
}
