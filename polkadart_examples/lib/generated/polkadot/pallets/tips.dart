// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_tips/open_tip.dart' as _i3;
import '../types/pallet_tips/pallet/call.dart' as _i7;
import '../types/polkadot_runtime/runtime_call.dart' as _i6;
import '../types/primitive_types/h256.dart' as _i2;
import '../types/sp_arithmetic/per_things/percent.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.H256, _i3.OpenTip> _tips =
      const _i1.StorageMap<_i2.H256, _i3.OpenTip>(
    prefix: 'Tips',
    storage: 'Tips',
    valueCodec: _i3.OpenTip.codec,
    hasher: _i1.StorageHasher.twoxx64Concat(_i2.H256Codec()),
  );

  final _i1.StorageMap<_i2.H256, List<int>> _reasons =
      const _i1.StorageMap<_i2.H256, List<int>>(
    prefix: 'Tips',
    storage: 'Reasons',
    valueCodec: _i4.U8SequenceCodec.codec,
    hasher: _i1.StorageHasher.identity(_i2.H256Codec()),
  );

  /// TipsMap that are not yet completed. Keyed by the hash of `(reason, who)` from the value.
  /// This has the insecure enumerable hash function since the key itself is already
  /// guaranteed to be a secure hash.
  _i5.Future<_i3.OpenTip?> tips(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _tips.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _tips.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Simple preimage lookup from the reason's hash to the original data. Again, has an
  /// insecure enumerable hash since the key is guaranteed to be the result of a secure hash.
  _i5.Future<List<int>?> reasons(
    _i2.H256 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _reasons.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _reasons.decodeValue(bytes);
    }
    return null; /* Nullable */
  }
}

class Txs {
  const Txs();

  /// Report something `reason` that deserves a tip and claim any eventual the finder's fee.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// Payment: `TipReportDepositBase` will be reserved from the origin account, as well as
  /// `DataDepositPerByte` for each byte in `reason`.
  ///
  /// - `reason`: The reason for, or the thing that deserves, the tip; generally this will be
  ///  a UTF-8-encoded URL.
  /// - `who`: The account which should be credited for the tip.
  ///
  /// Emits `NewTip` if successful.
  ///
  /// ## Complexity
  /// - `O(R)` where `R` length of `reason`.
  ///  - encoding and hashing of 'reason'
  _i6.RuntimeCall reportAwesome({
    required reason,
    required who,
  }) {
    final _call = _i7.Call.values.reportAwesome(
      reason: reason,
      who: who,
    );
    return _i6.RuntimeCall.values.tips(_call);
  }

  /// Retract a prior tip-report from `report_awesome`, and cancel the process of tipping.
  ///
  /// If successful, the original deposit will be unreserved.
  ///
  /// The dispatch origin for this call must be _Signed_ and the tip identified by `hash`
  /// must have been reported by the signing account through `report_awesome` (and not
  /// through `tip_new`).
  ///
  /// - `hash`: The identity of the open tip for which a tip value is declared. This is formed
  ///  as the hash of the tuple of the original tip `reason` and the beneficiary account ID.
  ///
  /// Emits `TipRetracted` if successful.
  ///
  /// ## Complexity
  /// - `O(1)`
  ///  - Depends on the length of `T::Hash` which is fixed.
  _i6.RuntimeCall retractTip({required hash}) {
    final _call = _i7.Call.values.retractTip(hash: hash);
    return _i6.RuntimeCall.values.tips(_call);
  }

  /// Give a tip for something new; no finder's fee will be taken.
  ///
  /// The dispatch origin for this call must be _Signed_ and the signing account must be a
  /// member of the `Tippers` set.
  ///
  /// - `reason`: The reason for, or the thing that deserves, the tip; generally this will be
  ///  a UTF-8-encoded URL.
  /// - `who`: The account which should be credited for the tip.
  /// - `tip_value`: The amount of tip that the sender would like to give. The median tip
  ///  value of active tippers will be given to the `who`.
  ///
  /// Emits `NewTip` if successful.
  ///
  /// ## Complexity
  /// - `O(R + T)` where `R` length of `reason`, `T` is the number of tippers.
  ///  - `O(T)`: decoding `Tipper` vec of length `T`. `T` is charged as upper bound given by
  ///    `ContainsLengthBound`. The actual cost depends on the implementation of
  ///    `T::Tippers`.
  ///  - `O(R)`: hashing and encoding of reason of length `R`
  _i6.RuntimeCall tipNew({
    required reason,
    required who,
    required tipValue,
  }) {
    final _call = _i7.Call.values.tipNew(
      reason: reason,
      who: who,
      tipValue: tipValue,
    );
    return _i6.RuntimeCall.values.tips(_call);
  }

  /// Declare a tip value for an already-open tip.
  ///
  /// The dispatch origin for this call must be _Signed_ and the signing account must be a
  /// member of the `Tippers` set.
  ///
  /// - `hash`: The identity of the open tip for which a tip value is declared. This is formed
  ///  as the hash of the tuple of the hash of the original tip `reason` and the beneficiary
  ///  account ID.
  /// - `tip_value`: The amount of tip that the sender would like to give. The median tip
  ///  value of active tippers will be given to the `who`.
  ///
  /// Emits `TipClosing` if the threshold of tippers has been reached and the countdown period
  /// has started.
  ///
  /// ## Complexity
  /// - `O(T)` where `T` is the number of tippers. decoding `Tipper` vec of length `T`, insert
  ///  tip and check closing, `T` is charged as upper bound given by `ContainsLengthBound`.
  ///  The actual cost depends on the implementation of `T::Tippers`.
  ///
  ///  Actually weight could be lower as it depends on how many tips are in `OpenTip` but it
  ///  is weighted as if almost full i.e of length `T-1`.
  _i6.RuntimeCall tip({
    required hash,
    required tipValue,
  }) {
    final _call = _i7.Call.values.tip(
      hash: hash,
      tipValue: tipValue,
    );
    return _i6.RuntimeCall.values.tips(_call);
  }

  /// Close and payout a tip.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// The tip identified by `hash` must have finished its countdown period.
  ///
  /// - `hash`: The identity of the open tip for which a tip value is declared. This is formed
  ///  as the hash of the tuple of the original tip `reason` and the beneficiary account ID.
  ///
  /// ## Complexity
  /// - : `O(T)` where `T` is the number of tippers. decoding `Tipper` vec of length `T`. `T`
  ///  is charged as upper bound given by `ContainsLengthBound`. The actual cost depends on
  ///  the implementation of `T::Tippers`.
  _i6.RuntimeCall closeTip({required hash}) {
    final _call = _i7.Call.values.closeTip(hash: hash);
    return _i6.RuntimeCall.values.tips(_call);
  }

  /// Remove and slash an already-open tip.
  ///
  /// May only be called from `T::RejectOrigin`.
  ///
  /// As a result, the finder is slashed and the deposits are lost.
  ///
  /// Emits `TipSlashed` if successful.
  ///
  /// ## Complexity
  /// - O(1).
  _i6.RuntimeCall slashTip({required hash}) {
    final _call = _i7.Call.values.slashTip(hash: hash);
    return _i6.RuntimeCall.values.tips(_call);
  }
}

class Constants {
  Constants();

  /// Maximum acceptable reason length.
  ///
  /// Benchmarks depend on this value, be sure to update weights file when changing this value
  final int maximumReasonLength = 16384;

  /// The amount held on deposit per byte within the tip report reason or bounty description.
  final BigInt dataDepositPerByte = BigInt.from(100000000);

  /// The period for which a tip remains open after is has achieved threshold tippers.
  final int tipCountdown = 14400;

  /// The percent of the final tip which goes to the original reporter of the tip.
  final _i8.Percent tipFindersFee = 20;

  /// The amount held on deposit for placing a tip report.
  final BigInt tipReportDepositBase = BigInt.from(10000000000);
}
