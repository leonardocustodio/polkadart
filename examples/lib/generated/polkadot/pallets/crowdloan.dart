// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/frame_support/pallet_id.dart' as _i12;
import '../types/polkadot_parachain_primitives/primitives/id.dart' as _i2;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/polkadot_runtime_common/crowdloan/fund_info.dart' as _i3;
import '../types/polkadot_runtime_common/crowdloan/pallet/call.dart' as _i9;
import '../types/sp_core/crypto/account_id32.dart' as _i11;
import '../types/sp_runtime/multi_signature.dart' as _i10;
import '../types/sp_runtime/multi_signer.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, _i3.FundInfo> _funds =
      const _i1.StorageMap<_i2.Id, _i3.FundInfo>(
    prefix: 'Crowdloan',
    storage: 'Funds',
    valueCodec: _i3.FundInfo.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  final _i1.StorageValue<List<_i2.Id>> _newRaise =
      const _i1.StorageValue<List<_i2.Id>>(
    prefix: 'Crowdloan',
    storage: 'NewRaise',
    valueCodec: _i4.SequenceCodec<_i2.Id>(_i2.IdCodec()),
  );

  final _i1.StorageValue<int> _endingsCount = const _i1.StorageValue<int>(
    prefix: 'Crowdloan',
    storage: 'EndingsCount',
    valueCodec: _i4.U32Codec.codec,
  );

  final _i1.StorageValue<int> _nextFundIndex = const _i1.StorageValue<int>(
    prefix: 'Crowdloan',
    storage: 'NextFundIndex',
    valueCodec: _i4.U32Codec.codec,
  );

  /// Info on all of the funds.
  _i5.Future<_i3.FundInfo?> funds(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _funds.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _funds.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// The funds that have had additional contributions during the last block. This is used
  /// in order to determine which funds should submit new or updated bids.
  _i5.Future<List<_i2.Id>> newRaise({_i1.BlockHash? at}) async {
    final hashedKey = _newRaise.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _newRaise.decodeValue(bytes);
    }
    return []; /* Default */
  }

  /// The number of auctions that have entered into their ending period so far.
  _i5.Future<int> endingsCount({_i1.BlockHash? at}) async {
    final hashedKey = _endingsCount.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _endingsCount.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Tracker for the next available fund index
  _i5.Future<int> nextFundIndex({_i1.BlockHash? at}) async {
    final hashedKey = _nextFundIndex.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _nextFundIndex.decodeValue(bytes);
    }
    return 0; /* Default */
  }

  /// Returns the storage key for `funds`.
  _i6.Uint8List fundsKey(_i2.Id key1) {
    final hashedKey = _funds.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `newRaise`.
  _i6.Uint8List newRaiseKey() {
    final hashedKey = _newRaise.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `endingsCount`.
  _i6.Uint8List endingsCountKey() {
    final hashedKey = _endingsCount.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `nextFundIndex`.
  _i6.Uint8List nextFundIndexKey() {
    final hashedKey = _nextFundIndex.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `funds`.
  _i6.Uint8List fundsMapPrefix() {
    final hashedKey = _funds.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Create a new crowdloaning campaign for a parachain slot with the given lease period
  /// range.
  ///
  /// This applies a lock to your parachain configuration, ensuring that it cannot be changed
  /// by the parachain manager.
  _i7.RuntimeCall create({
    required BigInt index,
    required BigInt cap,
    required BigInt firstPeriod,
    required BigInt lastPeriod,
    required BigInt end,
    _i8.MultiSigner? verifier,
  }) {
    final _call = _i9.Call.values.create(
      index: index,
      cap: cap,
      firstPeriod: firstPeriod,
      lastPeriod: lastPeriod,
      end: end,
      verifier: verifier,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Contribute to a crowd sale. This will transfer some balance over to fund a parachain
  /// slot. It will be withdrawable when the crowdloan has ended and the funds are unused.
  _i7.RuntimeCall contribute({
    required BigInt index,
    required BigInt value,
    _i10.MultiSignature? signature,
  }) {
    final _call = _i9.Call.values.contribute(
      index: index,
      value: value,
      signature: signature,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Withdraw full balance of a specific contributor.
  ///
  /// Origin must be signed, but can come from anyone.
  ///
  /// The fund must be either in, or ready for, retirement. For a fund to be *in* retirement,
  /// then the retirement flag must be set. For a fund to be ready for retirement, then:
  /// - it must not already be in retirement;
  /// - the amount of raised funds must be bigger than the _free_ balance of the account;
  /// - and either:
  ///  - the block number must be at least `end`; or
  ///  - the current lease period must be greater than the fund's `last_period`.
  ///
  /// In this case, the fund's retirement flag is set and its `end` is reset to the current
  /// block number.
  ///
  /// - `who`: The account whose contribution should be withdrawn.
  /// - `index`: The parachain to whose crowdloan the contribution was made.
  _i7.RuntimeCall withdraw({
    required _i11.AccountId32 who,
    required BigInt index,
  }) {
    final _call = _i9.Call.values.withdraw(
      who: who,
      index: index,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Automatically refund contributors of an ended crowdloan.
  /// Due to weight restrictions, this function may need to be called multiple
  /// times to fully refund all users. We will refund `RemoveKeysLimit` users at a time.
  ///
  /// Origin must be signed, but can come from anyone.
  _i7.RuntimeCall refund({required BigInt index}) {
    final _call = _i9.Call.values.refund(index: index);
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Remove a fund after the retirement period has ended and all funds have been returned.
  _i7.RuntimeCall dissolve({required BigInt index}) {
    final _call = _i9.Call.values.dissolve(index: index);
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Edit the configuration for an in-progress crowdloan.
  ///
  /// Can only be called by Root origin.
  _i7.RuntimeCall edit({
    required BigInt index,
    required BigInt cap,
    required BigInt firstPeriod,
    required BigInt lastPeriod,
    required BigInt end,
    _i8.MultiSigner? verifier,
  }) {
    final _call = _i9.Call.values.edit(
      index: index,
      cap: cap,
      firstPeriod: firstPeriod,
      lastPeriod: lastPeriod,
      end: end,
      verifier: verifier,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Add an optional memo to an existing crowdloan contribution.
  ///
  /// Origin must be Signed, and the user must have contributed to the crowdloan.
  _i7.RuntimeCall addMemo({
    required _i2.Id index,
    required List<int> memo,
  }) {
    final _call = _i9.Call.values.addMemo(
      index: index,
      memo: memo,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Poke the fund into `NewRaise`
  ///
  /// Origin must be Signed, and the fund has non-zero raise.
  _i7.RuntimeCall poke({required _i2.Id index}) {
    final _call = _i9.Call.values.poke(index: index);
    return _i7.RuntimeCall.values.crowdloan(_call);
  }

  /// Contribute your entire balance to a crowd sale. This will transfer the entire balance of
  /// a user over to fund a parachain slot. It will be withdrawable when the crowdloan has
  /// ended and the funds are unused.
  _i7.RuntimeCall contributeAll({
    required BigInt index,
    _i10.MultiSignature? signature,
  }) {
    final _call = _i9.Call.values.contributeAll(
      index: index,
      signature: signature,
    );
    return _i7.RuntimeCall.values.crowdloan(_call);
  }
}

class Constants {
  Constants();

  /// `PalletId` for the crowdloan pallet. An appropriate value could be
  /// `PalletId(*b"py/cfund")`
  final _i12.PalletId palletId = const <int>[
    112,
    121,
    47,
    99,
    102,
    117,
    110,
    100,
  ];

  /// The minimum amount that may be contributed into a crowdloan. Should almost certainly be
  /// at least `ExistentialDeposit`.
  final BigInt minContribution = BigInt.from(50000000000);

  /// Max number of storage keys to remove per extrinsic call.
  final int removeKeysLimit = 1000;
}
