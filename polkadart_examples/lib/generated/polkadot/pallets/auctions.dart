// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i2;

import '../types/polkadot_parachain/primitives/id.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/polkadot_runtime_common/auctions/pallet/call.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i5;
import '../types/tuples.dart' as _i4;
import '../types/tuples_1.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<int> _auctionCounter = const _i1.StorageValue<int>(
    prefix: 'Auctions',
    storage: 'AuctionCounter',
    valueCodec: _i2.U32Codec.codec,
  );

  final _i1.StorageValue<_i3.Tuple2<int, int>> _auctionInfo =
      const _i1.StorageValue<_i3.Tuple2<int, int>>(
    prefix: 'Auctions',
    storage: 'AuctionInfo',
    valueCodec: _i3.Tuple2Codec<int, int>(
      _i2.U32Codec.codec,
      _i2.U32Codec.codec,
    ),
  );

  final _i1.StorageMap<_i4.Tuple2<_i5.AccountId32, _i6.Id>, BigInt>
      _reservedAmounts =
      const _i1.StorageMap<_i4.Tuple2<_i5.AccountId32, _i6.Id>, BigInt>(
    prefix: 'Auctions',
    storage: 'ReservedAmounts',
    valueCodec: _i2.U128Codec.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(
        _i4.Tuple2Codec<_i5.AccountId32, _i6.Id>(
      _i5.AccountId32Codec(),
      _i6.IdCodec(),
    )),
  );

  final _i1.StorageMap<int, List<_i4.Tuple3<_i5.AccountId32, _i6.Id, BigInt>?>>
      _winning = const _i1
          .StorageMap<int, List<_i4.Tuple3<_i5.AccountId32, _i6.Id, BigInt>?>>(
    prefix: 'Auctions',
    storage: 'Winning',
    valueCodec: _i2.ArrayCodec<_i4.Tuple3<_i5.AccountId32, _i6.Id, BigInt>?>(
      _i2.OptionCodec<_i4.Tuple3<_i5.AccountId32, _i6.Id, BigInt>>(
          _i4.Tuple3Codec<_i5.AccountId32, _i6.Id, BigInt>(
        _i5.AccountId32Codec(),
        _i6.IdCodec(),
        _i2.U128Codec.codec,
      )),
      36,
    ),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.U32Codec.codec),
  );

  /// Number of auctions started so far.
  _i7.Future<int> auctionCounter({_i1.BlockHash? at}) async {
    final hashedKey = _auctionCounter.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _auctionCounter.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Information relating to the current auction, if there is one.
  ///
  /// The first item in the tuple is the lease period index that the first of the four
  /// contiguous lease periods on auction is for. The second is the block number when the
  /// auction will "begin to end", i.e. the first block of the Ending Period of the auction.
  _i7.Future<_i3.Tuple2<int, int>?> auctionInfo({_i1.BlockHash? at}) async {
    final hashedKey = _auctionInfo.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _auctionInfo.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Amounts currently reserved in the accounts of the bidders currently winning
  /// (sub-)ranges.
  _i7.Future<BigInt?> reservedAmounts(
    _i4.Tuple2<_i5.AccountId32, _i6.Id> key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reservedAmounts.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reservedAmounts.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The winning bids for each of the 10 ranges at each sample in the final Ending Period of
  /// the current auction. The map's key is the 0-based index into the Sample Size. The
  /// first sample of the ending period is 0; the last is `Sample Size - 1`.
  _i7.Future<List<_i4.Tuple3<_i5.AccountId32, _i6.Id, BigInt>?>?> winning(
    int key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _winning.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _winning.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Create a new auction.
  ///
  /// This can only happen when there isn't already an auction in progress and may only be
  /// called by the root origin. Accepts the `duration` of this auction and the
  /// `lease_period_index` of the initial lease period of the four that are to be auctioned.
  _i8.RuntimeCall newAuction({
    required duration,
    required leasePeriodIndex,
  }) {
    final _call = _i9.Call.values.newAuction(
      duration: duration,
      leasePeriodIndex: leasePeriodIndex,
    );
    return _i8.RuntimeCall.values.auctions(_call);
  }

  /// Make a new bid from an account (including a parachain account) for deploying a new
  /// parachain.
  ///
  /// Multiple simultaneous bids from the same bidder are allowed only as long as all active
  /// bids overlap each other (i.e. are mutually exclusive). Bids cannot be redacted.
  ///
  /// - `sub` is the sub-bidder ID, allowing for multiple competing bids to be made by (and
  /// funded by) the same account.
  /// - `auction_index` is the index of the auction to bid on. Should just be the present
  /// value of `AuctionCounter`.
  /// - `first_slot` is the first lease period index of the range to bid on. This is the
  /// absolute lease period index value, not an auction-specific offset.
  /// - `last_slot` is the last lease period index of the range to bid on. This is the
  /// absolute lease period index value, not an auction-specific offset.
  /// - `amount` is the amount to bid to be held as deposit for the parachain should the
  /// bid win. This amount is held throughout the range.
  _i8.RuntimeCall bid({
    required para,
    required auctionIndex,
    required firstSlot,
    required lastSlot,
    required amount,
  }) {
    final _call = _i9.Call.values.bid(
      para: para,
      auctionIndex: auctionIndex,
      firstSlot: firstSlot,
      lastSlot: lastSlot,
      amount: amount,
    );
    return _i8.RuntimeCall.values.auctions(_call);
  }

  /// Cancel an in-progress auction.
  ///
  /// Can only be called by Root origin.
  _i8.RuntimeCall cancelAuction() {
    final _call = _i9.Call.values.cancelAuction();
    return _i8.RuntimeCall.values.auctions(_call);
  }
}

class Constants {
  Constants();

  /// The number of blocks over which an auction may be retroactively ended.
  final int endingPeriod = 72000;

  /// The length of each sample to take during the ending period.
  ///
  /// `EndingPeriod` / `SampleLength` = Total # of Samples
  final int sampleLength = 20;

  final int slotRangeCount = 36;

  final int leasePeriodsPerSlot = 8;
}
