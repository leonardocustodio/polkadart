// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i5;

import '../types/polkadot_parachain/primitives/id.dart' as _i2;
import '../types/polkadot_runtime/runtime_call.dart' as _i7;
import '../types/polkadot_runtime_common/slots/pallet/call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i4;
import '../types/tuples.dart' as _i3;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.Id, List<_i3.Tuple2<_i4.AccountId32, BigInt>?>>
      _leases =
      const _i1.StorageMap<_i2.Id, List<_i3.Tuple2<_i4.AccountId32, BigInt>?>>(
    prefix: 'Slots',
    storage: 'Leases',
    valueCodec: _i5.SequenceCodec<_i3.Tuple2<_i4.AccountId32, BigInt>?>(
        _i5.OptionCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
            _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
      _i4.AccountId32Codec(),
      _i5.U128Codec.codec,
    ))),
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.IdCodec()),
  );

  /// Amounts held on deposit for each (possibly future) leased parachain.
  ///
  /// The actual amount locked on its behalf by any account at any time is the maximum of the second values
  /// of the items in this list whose first value is the account.
  ///
  /// The first item in the list is the amount locked for the current Lease Period. Following
  /// items are for the subsequent lease periods.
  ///
  /// The default value (an empty list) implies that the parachain no longer exists (or never
  /// existed) as far as this pallet is concerned.
  ///
  /// If a parachain doesn't exist *yet* but is scheduled to exist in the future, then it
  /// will be left-padded with one or more `None`s to denote the fact that nothing is held on
  /// deposit for the non-existent chain currently, but is held at some point in the future.
  ///
  /// It is illegal for a `None` value to trail in the list.
  _i6.Future<List<_i3.Tuple2<_i4.AccountId32, BigInt>?>> leases(
    _i2.Id key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _leases.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _leases.decodeValue(bytes);
    }
    return []; /* Default */
  }
}

class Txs {
  const Txs();

  /// Just a connect into the `lease_out` call, in case Root wants to force some lease to happen
  /// independently of any other on-chain mechanism to use it.
  ///
  /// The dispatch origin for this call must match `T::ForceOrigin`.
  _i7.RuntimeCall forceLease({
    required para,
    required leaser,
    required amount,
    required periodBegin,
    required periodCount,
  }) {
    final _call = _i8.Call.values.forceLease(
      para: para,
      leaser: leaser,
      amount: amount,
      periodBegin: periodBegin,
      periodCount: periodCount,
    );
    return _i7.RuntimeCall.values.slots(_call);
  }

  /// Clear all leases for a Para Id, refunding any deposits back to the original owners.
  ///
  /// The dispatch origin for this call must match `T::ForceOrigin`.
  _i7.RuntimeCall clearAllLeases({required para}) {
    final _call = _i8.Call.values.clearAllLeases(para: para);
    return _i7.RuntimeCall.values.slots(_call);
  }

  /// Try to onboard a parachain that has a lease for the current lease period.
  ///
  /// This function can be useful if there was some state issue with a para that should
  /// have onboarded, but was unable to. As long as they have a lease period, we can
  /// let them onboard from here.
  ///
  /// Origin must be signed, but can be called by anyone.
  _i7.RuntimeCall triggerOnboard({required para}) {
    final _call = _i8.Call.values.triggerOnboard(para: para);
    return _i7.RuntimeCall.values.slots(_call);
  }
}

class Constants {
  Constants();

  /// The number of blocks over which a single period lasts.
  final int leasePeriod = 1209600;

  /// The number of blocks to offset each lease period by.
  final int leaseOffset = 921600;
}
