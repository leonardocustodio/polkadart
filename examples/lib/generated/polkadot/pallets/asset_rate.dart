// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;
import 'dart:typed_data' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;

import '../types/pallet_asset_rate/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    as _i2;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.VersionedLocatableAsset, _i3.FixedU128>
      _conversionRateToNative =
      const _i1.StorageMap<_i2.VersionedLocatableAsset, _i3.FixedU128>(
    prefix: 'AssetRate',
    storage: 'ConversionRateToNative',
    valueCodec: _i3.FixedU128Codec(),
    hasher:
        _i1.StorageHasher.blake2b128Concat(_i2.VersionedLocatableAsset.codec),
  );

  /// Maps an asset to its fixed point representation in the native balance.
  ///
  /// E.g. `native_amount = asset_amount * ConversionRateToNative::<T>::get(asset_kind)`
  _i4.Future<_i3.FixedU128?> conversionRateToNative(
    _i2.VersionedLocatableAsset key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _conversionRateToNative.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _conversionRateToNative.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `conversionRateToNative`.
  _i5.Uint8List conversionRateToNativeKey(_i2.VersionedLocatableAsset key1) {
    final hashedKey = _conversionRateToNative.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage map key prefix for `conversionRateToNative`.
  _i5.Uint8List conversionRateToNativeMapPrefix() {
    final hashedKey = _conversionRateToNative.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Initialize a conversion rate to native balance for the given asset.
  ///
  /// ## Complexity
  /// - O(1)
  _i6.RuntimeCall create({
    required _i2.VersionedLocatableAsset assetKind,
    required _i3.FixedU128 rate,
  }) {
    final _call = _i7.Call.values.create(
      assetKind: assetKind,
      rate: rate,
    );
    return _i6.RuntimeCall.values.assetRate(_call);
  }

  /// Update the conversion rate to native balance for the given asset.
  ///
  /// ## Complexity
  /// - O(1)
  _i6.RuntimeCall update({
    required _i2.VersionedLocatableAsset assetKind,
    required _i3.FixedU128 rate,
  }) {
    final _call = _i7.Call.values.update(
      assetKind: assetKind,
      rate: rate,
    );
    return _i6.RuntimeCall.values.assetRate(_call);
  }

  /// Remove an existing conversion rate to native balance for the given asset.
  ///
  /// ## Complexity
  /// - O(1)
  _i6.RuntimeCall remove({required _i2.VersionedLocatableAsset assetKind}) {
    final _call = _i7.Call.values.remove(assetKind: assetKind);
    return _i6.RuntimeCall.values.assetRate(_call);
  }
}
