// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i12;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/pallet_xcm/pallet/call.dart' as _i14;
import '../types/pallet_xcm/pallet/query_status.dart' as _i3;
import '../types/pallet_xcm/pallet/remote_locked_fungible_record.dart' as _i11;
import '../types/pallet_xcm/pallet/version_migration_stage.dart' as _i8;
import '../types/polkadot_runtime/runtime_call.dart' as _i13;
import '../types/primitive_types/h256.dart' as _i4;
import '../types/sp_core/crypto/account_id32.dart' as _i9;
import '../types/sp_weights/weight_v2/weight.dart' as _i7;
import '../types/tuples.dart' as _i6;
import '../types/xcm/versioned_asset_id.dart' as _i10;
import '../types/xcm/versioned_multi_location.dart' as _i5;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<BigInt> _queryCounter = const _i1.StorageValue<BigInt>(
    prefix: 'XcmPallet',
    storage: 'QueryCounter',
    valueCodec: _i2.U64Codec.codec,
  );

  final _i1.StorageMap<BigInt, _i3.QueryStatus> _queries =
      const _i1.StorageMap<BigInt, _i3.QueryStatus>(
    prefix: 'XcmPallet',
    storage: 'Queries',
    valueCodec: _i3.QueryStatus.codec,
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.U64Codec.codec),
  );

  final _i1.StorageMap<_i4.H256, int> _assetTraps =
      const _i1.StorageMap<_i4.H256, int>(
    prefix: 'XcmPallet',
    storage: 'AssetTraps',
    valueCodec: _i2.U32Codec.codec,
    hasher: _i1.StorageHasher.identity(_i4.H256Codec()),
  );

  final _i1.StorageValue<int> _safeXcmVersion = const _i1.StorageValue<int>(
    prefix: 'XcmPallet',
    storage: 'SafeXcmVersion',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation, int>
      _supportedVersion =
      const _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation, int>(
    prefix: 'XcmPallet',
    storage: 'SupportedVersion',
    valueCodec: _i2.U32Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2:
        _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec),
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation, BigInt>
      _versionNotifiers =
      const _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation, BigInt>(
    prefix: 'XcmPallet',
    storage: 'VersionNotifiers',
    valueCodec: _i2.U64Codec.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2:
        _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec),
  );

  final _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation,
          _i6.Tuple3<BigInt, _i7.Weight, int>> _versionNotifyTargets =
      const _i1.StorageDoubleMap<int, _i5.VersionedMultiLocation,
          _i6.Tuple3<BigInt, _i7.Weight, int>>(
    prefix: 'XcmPallet',
    storage: 'VersionNotifyTargets',
    valueCodec: _i6.Tuple3Codec<BigInt, _i7.Weight, int>(
      _i2.U64Codec.codec,
      _i7.Weight.codec,
      _i2.U32Codec.codec,
    ),
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2:
        _i1.StorageHasher.blake2b128Concat(_i5.VersionedMultiLocation.codec),
  );

  final _i1.StorageValue<List<_i6.Tuple2<_i5.VersionedMultiLocation, int>>>
      _versionDiscoveryQueue =
      const _i1.StorageValue<List<_i6.Tuple2<_i5.VersionedMultiLocation, int>>>(
    prefix: 'XcmPallet',
    storage: 'VersionDiscoveryQueue',
    valueCodec: _i2.SequenceCodec<_i6.Tuple2<_i5.VersionedMultiLocation, int>>(
        _i6.Tuple2Codec<_i5.VersionedMultiLocation, int>(
      _i5.VersionedMultiLocation.codec,
      _i2.U32Codec.codec,
    )),
  );

  final _i1.StorageValue<_i8.VersionMigrationStage> _currentMigration =
      const _i1.StorageValue<_i8.VersionMigrationStage>(
    prefix: 'XcmPallet',
    storage: 'CurrentMigration',
    valueCodec: _i8.VersionMigrationStage.codec,
  );

  final _i1.StorageTripleMap<int, _i9.AccountId32, _i10.VersionedAssetId,
          _i11.RemoteLockedFungibleRecord> _remoteLockedFungibles =
      const _i1.StorageTripleMap<int, _i9.AccountId32, _i10.VersionedAssetId,
          _i11.RemoteLockedFungibleRecord>(
    prefix: 'XcmPallet',
    storage: 'RemoteLockedFungibles',
    valueCodec: _i11.RemoteLockedFungibleRecord.codec,
    hasher1: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
    hasher2: _i1.StorageHasher.blake2b128Concat(_i9.AccountId32Codec()),
    hasher3: _i1.StorageHasher.blake2b128Concat(_i10.VersionedAssetId.codec),
  );

  final _i1.StorageMap<_i9.AccountId32,
          List<_i6.Tuple2<BigInt, _i5.VersionedMultiLocation>>>
      _lockedFungibles = const _i1.StorageMap<_i9.AccountId32,
          List<_i6.Tuple2<BigInt, _i5.VersionedMultiLocation>>>(
    prefix: 'XcmPallet',
    storage: 'LockedFungibles',
    valueCodec:
        _i2.SequenceCodec<_i6.Tuple2<BigInt, _i5.VersionedMultiLocation>>(
            _i6.Tuple2Codec<BigInt, _i5.VersionedMultiLocation>(
      _i2.U128Codec.codec,
      _i5.VersionedMultiLocation.codec,
    )),
    hasher: _i1.StorageHasher.blake2b128Concat(_i9.AccountId32Codec()),
  );

  final _i1.StorageValue<bool> _xcmExecutionSuspended =
      const _i1.StorageValue<bool>(
    prefix: 'XcmPallet',
    storage: 'XcmExecutionSuspended',
    valueCodec: _i2.BoolCodec.codec,
  );

  /// The latest available query index.
  _i12.Future<BigInt> queryCounter({_i1.BlockHash? at}) async {
    final hashedKey = _queryCounter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queryCounter.decodeValue(bytes);
    }
    return BigInt.zero; /* Default */
  }

  /// The ongoing queries.
  _i12.Future<_i3.QueryStatus?> queries(
    BigInt key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _queries.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queries.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The existing asset traps.
  ///
  /// Key is the blake2 256 hash of (origin, versioned `MultiAssets`) pair. Value is the number of
  /// times this pair has been trapped (usually just 1 if it exists at all).
  _i12.Future<int> assetTraps(
    _i4.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _assetTraps.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _assetTraps.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Default version to encode XCM when latest version of destination is unknown. If `None`,
  /// then the destinations whose XCM version is unknown are considered unreachable.
  _i12.Future<int?> safeXcmVersion({_i1.BlockHash? at}) async {
    final hashedKey = _safeXcmVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _safeXcmVersion.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The Latest versions that we know various locations support.
  _i12.Future<int?> supportedVersion(
    int key1,
    _i5.VersionedMultiLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _supportedVersion.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _supportedVersion.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// All locations that we have requested version notifications from.
  _i12.Future<BigInt?> versionNotifiers(
    int key1,
    _i5.VersionedMultiLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _versionNotifiers.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionNotifiers.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The target locations that are subscribed to our version changes, as well as the most recent
  /// of our versions we informed them of.
  _i12.Future<_i6.Tuple3<BigInt, _i7.Weight, int>?> versionNotifyTargets(
    int key1,
    _i5.VersionedMultiLocation key2, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _versionNotifyTargets.hashedKeyFor(
      key1,
      key2,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionNotifyTargets.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Destinations whose latest XCM version we would like to know. Duplicates not allowed, and
  /// the `u32` counter is the number of times that a send to the destination has been attempted,
  /// which is used as a prioritization.
  _i12.Future<List<_i6.Tuple2<_i5.VersionedMultiLocation, int>>>
      versionDiscoveryQueue({_i1.BlockHash? at}) async {
    final hashedKey = _versionDiscoveryQueue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _versionDiscoveryQueue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The current migration's stage, if any.
  _i12.Future<_i8.VersionMigrationStage?> currentMigration(
      {_i1.BlockHash? at}) async {
    final hashedKey = _currentMigration.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _currentMigration.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Fungible assets which we know are locked on a remote chain.
  _i12.Future<_i11.RemoteLockedFungibleRecord?> remoteLockedFungibles(
    int key1,
    _i9.AccountId32 key2,
    _i10.VersionedAssetId key3, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _remoteLockedFungibles.hashedKeyFor(
      key1,
      key2,
      key3,
    );
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _remoteLockedFungibles.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Fungible assets which we know are locked on this chain.
  _i12.Future<List<_i6.Tuple2<BigInt, _i5.VersionedMultiLocation>>?>
      lockedFungibles(
    _i9.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _lockedFungibles.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _lockedFungibles.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Global suspension state of the XCM executor.
  _i12.Future<bool> xcmExecutionSuspended({_i1.BlockHash? at}) async {
    final hashedKey = _xcmExecutionSuspended.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _xcmExecutionSuspended.decodeValue(bytes);
    }
    return false; /* Default */
  }
}

class Txs {
  const Txs();

  _i13.RuntimeCall send({
    required dest,
    required message,
  }) {
    final _call = _i14.Call.values.send(
      dest: dest,
      message: message,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Teleport some assets from the local chain to some destination chain.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
  /// with all fees taken as needed from the asset.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
  ///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
  ///  an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. The first item should be the currency used to to pay the fee on the
  ///  `dest` side. May not be empty.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  _i13.RuntimeCall teleportAssets({
    required dest,
    required beneficiary,
    required assets,
    required feeAssetItem,
  }) {
    final _call = _i14.Call.values.teleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Transfer some assets from the local chain to the sovereign account of a destination
  /// chain and forward a notification XCM.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`. The weight limit for fees is not provided and thus is unlimited,
  /// with all fees taken as needed from the asset.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
  ///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
  ///  an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the fee on the
  ///  `dest` side.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  _i13.RuntimeCall reserveTransferAssets({
    required dest,
    required beneficiary,
    required assets,
    required feeAssetItem,
  }) {
    final _call = _i14.Call.values.reserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Execute an XCM message from a local, signed, origin.
  ///
  /// An event is deposited indicating whether `msg` could be executed completely or only
  /// partially.
  ///
  /// No more than `max_weight` will be used in its attempted execution. If this is less than the
  /// maximum amount of weight that the message could take to be executed, then no execution
  /// attempt will be made.
  ///
  /// NOTE: A successful return to this does *not* imply that the `msg` was executed successfully
  /// to completion; only that *some* of it was executed.
  _i13.RuntimeCall execute({
    required message,
    required maxWeight,
  }) {
    final _call = _i14.Call.values.execute(
      message: message,
      maxWeight: maxWeight,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Extoll that a particular destination can be communicated with through a particular
  /// version of XCM.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The destination that is being described.
  /// - `xcm_version`: The latest version of XCM that `location` supports.
  _i13.RuntimeCall forceXcmVersion({
    required location,
    required xcmVersion,
  }) {
    final _call = _i14.Call.values.forceXcmVersion(
      location: location,
      xcmVersion: xcmVersion,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Set a safe XCM version (the version that XCM should be encoded with if the most recent
  /// version a destination can accept is unknown).
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `maybe_xcm_version`: The default XCM encoding version, or `None` to disable.
  _i13.RuntimeCall forceDefaultXcmVersion({maybeXcmVersion}) {
    final _call = _i14.Call.values
        .forceDefaultXcmVersion(maybeXcmVersion: maybeXcmVersion);
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Ask a location to notify us regarding their XCM version and any changes to it.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The location to which we should subscribe for XCM version notifications.
  _i13.RuntimeCall forceSubscribeVersionNotify({required location}) {
    final _call =
        _i14.Call.values.forceSubscribeVersionNotify(location: location);
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Require that a particular destination should no longer notify us regarding any XCM
  /// version changes.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `location`: The location to which we are currently subscribed for XCM version
  ///  notifications which we no longer desire.
  _i13.RuntimeCall forceUnsubscribeVersionNotify({required location}) {
    final _call =
        _i14.Call.values.forceUnsubscribeVersionNotify(location: location);
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Transfer some assets from the local chain to the sovereign account of a destination
  /// chain and forward a notification XCM.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
  /// is needed than `weight_limit`, then the operation will fail and the assets send may be
  /// at risk.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
  ///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
  ///  an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. This should include the assets used to pay the fee on the
  ///  `dest` side.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i13.RuntimeCall limitedReserveTransferAssets({
    required dest,
    required beneficiary,
    required assets,
    required feeAssetItem,
    required weightLimit,
  }) {
    final _call = _i14.Call.values.limitedReserveTransferAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Teleport some assets from the local chain to some destination chain.
  ///
  /// Fee payment on the destination side is made from the asset in the `assets` vector of
  /// index `fee_asset_item`, up to enough to pay for `weight_limit` of weight. If more weight
  /// is needed than `weight_limit`, then the operation will fail and the assets send may be
  /// at risk.
  ///
  /// - `origin`: Must be capable of withdrawing the `assets` and executing XCM.
  /// - `dest`: Destination context for the assets. Will typically be `X2(Parent, Parachain(..))` to send
  ///  from parachain to parachain, or `X1(Parachain(..))` to send from relay to parachain.
  /// - `beneficiary`: A beneficiary location for the assets in the context of `dest`. Will generally be
  ///  an `AccountId32` value.
  /// - `assets`: The assets to be withdrawn. The first item should be the currency used to to pay the fee on the
  ///  `dest` side. May not be empty.
  /// - `fee_asset_item`: The index into `assets` of the item which should be used to pay
  ///  fees.
  /// - `weight_limit`: The remote-side weight limit, if any, for the XCM fee purchase.
  _i13.RuntimeCall limitedTeleportAssets({
    required dest,
    required beneficiary,
    required assets,
    required feeAssetItem,
    required weightLimit,
  }) {
    final _call = _i14.Call.values.limitedTeleportAssets(
      dest: dest,
      beneficiary: beneficiary,
      assets: assets,
      feeAssetItem: feeAssetItem,
      weightLimit: weightLimit,
    );
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }

  /// Set or unset the global suspension state of the XCM executor.
  ///
  /// - `origin`: Must be an origin specified by AdminOrigin.
  /// - `suspended`: `true` to suspend, `false` to resume.
  _i13.RuntimeCall forceSuspension({required suspended}) {
    final _call = _i14.Call.values.forceSuspension(suspended: suspended);
    return _i13.RuntimeCall.values.xcmPallet(_call);
  }
}
