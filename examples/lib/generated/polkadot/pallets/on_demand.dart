// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:typed_data' as _i9;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i7;

import '../types/binary_heap_2.dart' as _i5;
import '../types/frame_support/pallet_id.dart' as _i13;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i2;
import '../types/polkadot_primitives/v7/core_index.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i10;
import '../types/polkadot_runtime_parachains/assigner_on_demand/pallet/call.dart'
    as _i11;
import '../types/polkadot_runtime_parachains/assigner_on_demand/types/core_affinity_count.dart'
    as _i3;
import '../types/polkadot_runtime_parachains/assigner_on_demand/types/queue_status_type.dart'
    as _i4;
import '../types/sp_arithmetic/fixed_point/fixed_u128.dart' as _i12;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, _i3.CoreAffinityCount> _paraIdAffinity =
      const _i1.StorageMap<_i2.Id, _i3.CoreAffinityCount>(
    prefix: 'OnDemand',
    storage: 'ParaIdAffinity',
    valueCodec: _i3.CoreAffinityCount.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageValue<_i4.QueueStatusType> _queueStatus =
      const _i1.StorageValue<_i4.QueueStatusType>(
    prefix: 'OnDemand',
    storage: 'QueueStatus',
    valueCodec: _i4.QueueStatusType.codec,
  );

  final _i1.StorageValue<_i5.BinaryHeap> _freeEntries =
      const _i1.StorageValue<_i5.BinaryHeap>(
    prefix: 'OnDemand',
    storage: 'FreeEntries',
    valueCodec: _i5.BinaryHeapCodec(),
  );

  final _i1.StorageMap<_i6.CoreIndex, _i5.BinaryHeap> _affinityEntries =
      const _i1.StorageMap<_i6.CoreIndex, _i5.BinaryHeap>(
    prefix: 'OnDemand',
    storage: 'AffinityEntries',
    valueCodec: _i5.BinaryHeapCodec(),
    hasher: _i1.StorageHasher.twoxx64Concat(_i6.CoreIndexCodec()),
  );

  final _i1.StorageValue<List<BigInt>> _revenue =
      const _i1.StorageValue<List<BigInt>>(
    prefix: 'OnDemand',
    storage: 'Revenue',
    valueCodec: _i7.SequenceCodec<BigInt>(_i7.U128Codec.codec),
  );

  /// Maps a `ParaId` to `CoreIndex` and keeps track of how many assignments the scheduler has in
  /// it's lookahead. Keeping track of this affinity prevents parallel execution of the same
  /// `ParaId` on two or more `CoreIndex`es.
  _i8.Future<_i3.CoreAffinityCount?> paraIdAffinity(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _paraIdAffinity.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _paraIdAffinity.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Overall status of queue (both free + affinity entries)
  _i8.Future<_i4.QueueStatusType> queueStatus({_i1.BlockHash? at}) async {
    final hashedKey = _queueStatus.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _queueStatus.decodeValue(bytes);
    }
    return _i4.QueueStatusType(
      traffic: BigInt.parse(
        '1000000000000000000',
        radix: 10,
      ),
      nextIndex: 0,
      smallestIndex: 0,
      freedIndices: [],
    ); /* Default */
  }

  /// Priority queue for all orders which don't yet (or not any more) have any core affinity.
  _i8.Future<_i5.BinaryHeap> freeEntries({_i1.BlockHash? at}) async {
    final hashedKey = _freeEntries.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _freeEntries.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Queue entries that are currently bound to a particular core due to core affinity.
  _i8.Future<_i5.BinaryHeap> affinityEntries(
    _i6.CoreIndex key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _affinityEntries.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _affinityEntries.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Keeps track of accumulated revenue from on demand order sales.
  _i8.Future<List<BigInt>> revenue({_i1.BlockHash? at}) async {
    final hashedKey = _revenue.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _revenue.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// Returns the storage key for `paraIdAffinity`.
  _i9.Uint8List paraIdAffinityKey(_i2.Id key1) {
    final hashedKey = _paraIdAffinity.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `queueStatus`.
  _i9.Uint8List queueStatusKey() {
    final hashedKey = _queueStatus.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `freeEntries`.
  _i9.Uint8List freeEntriesKey() {
    final hashedKey = _freeEntries.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `affinityEntries`.
  _i9.Uint8List affinityEntriesKey(_i6.CoreIndex key1) {
    final hashedKey = _affinityEntries.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `revenue`.
  _i9.Uint8List revenueKey() {
    final hashedKey = _revenue.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `paraIdAffinity`.
  _i9.Uint8List paraIdAffinityMapPrefix() {
    final hashedKey = _paraIdAffinity.mapPrefix();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `affinityEntries`.
  _i9.Uint8List affinityEntriesMapPrefix() {
    final hashedKey = _affinityEntries.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Create a single on demand core order.
  /// Will use the spot price for the current block and will reap the account if needed.
  ///
  /// Parameters:
  /// - `origin`: The sender of the call, funds will be withdrawn from this account.
  /// - `max_amount`: The maximum balance to withdraw from the origin to place an order.
  /// - `para_id`: A `ParaId` the origin wants to provide blockspace for.
  ///
  /// Errors:
  /// - `InsufficientBalance`: from the Currency implementation
  /// - `QueueFull`
  /// - `SpotPriceHigherThanMaxAmount`
  ///
  /// Events:
  /// - `OnDemandOrderPlaced`
  _i10.RuntimeCall placeOrderAllowDeath({
    required BigInt maxAmount,
    required _i2.Id paraId,
  }) {
    final _call = _i11.Call.values.placeOrderAllowDeath(
      maxAmount: maxAmount,
      paraId: paraId,
    );
    return _i10.RuntimeCall.values.onDemand(_call);
  }

  /// Same as the [`place_order_allow_death`](Self::place_order_allow_death) call , but with a
  /// check that placing the order will not reap the account.
  ///
  /// Parameters:
  /// - `origin`: The sender of the call, funds will be withdrawn from this account.
  /// - `max_amount`: The maximum balance to withdraw from the origin to place an order.
  /// - `para_id`: A `ParaId` the origin wants to provide blockspace for.
  ///
  /// Errors:
  /// - `InsufficientBalance`: from the Currency implementation
  /// - `QueueFull`
  /// - `SpotPriceHigherThanMaxAmount`
  ///
  /// Events:
  /// - `OnDemandOrderPlaced`
  _i10.RuntimeCall placeOrderKeepAlive({
    required BigInt maxAmount,
    required _i2.Id paraId,
  }) {
    final _call = _i11.Call.values.placeOrderKeepAlive(
      maxAmount: maxAmount,
      paraId: paraId,
    );
    return _i10.RuntimeCall.values.onDemand(_call);
  }
}

class Constants {
  Constants();

  /// The default value for the spot traffic multiplier.
  final _i12.FixedU128 trafficDefaultValue = BigInt.parse(
    '1000000000000000000',
    radix: 10,
  );

  /// The maximum number of blocks some historical revenue
  /// information stored for.
  final int maxHistoricalRevenue = 160;

  /// Identifier for the internal revenue balance.
  final _i13.PalletId palletId = const <int>[
    112,
    121,
    47,
    111,
    110,
    100,
    109,
    100,
  ];
}
