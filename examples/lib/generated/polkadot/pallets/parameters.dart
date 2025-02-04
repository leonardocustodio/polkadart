// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/pallet_parameters/pallet/call.dart' as _i8;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/polkadot_runtime/runtime_parameters.dart' as _i7;
import '../types/polkadot_runtime/runtime_parameters_key.dart' as _i2;
import '../types/polkadot_runtime/runtime_parameters_value.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.RuntimeParametersKey, _i3.RuntimeParametersValue>
      _parameters = const _i1
          .StorageMap<_i2.RuntimeParametersKey, _i3.RuntimeParametersValue>(
    prefix: 'Parameters',
    storage: 'Parameters',
    valueCodec: _i3.RuntimeParametersValue.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.RuntimeParametersKey.codec),
  );

  /// Stored parameters.
  _i4.Future<_i3.RuntimeParametersValue?> parameters(
    _i2.RuntimeParametersKey key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _parameters.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _parameters.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `parameters`.
  _i5.Uint8List parametersKey(_i2.RuntimeParametersKey key1) {
    final hashedKey = _parameters.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `parameters`.
  _i5.Uint8List parametersMapPrefix() {
    final hashedKey = _parameters.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Set the value of a parameter.
  ///
  /// The dispatch origin of this call must be `AdminOrigin` for the given `key`. Values be
  /// deleted by setting them to `None`.
  _i6.RuntimeCall setParameter({required _i7.RuntimeParameters keyValue}) {
    final _call = _i8.Call.values.setParameter(keyValue: keyValue);
    return _i6.RuntimeCall.values.parameters(_call);
  }
}
