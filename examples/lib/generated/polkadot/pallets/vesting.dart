// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_vesting/pallet/call.dart' as _i9;
import '../types/pallet_vesting/releases.dart' as _i5;
import '../types/pallet_vesting/vesting_info/vesting_info.dart' as _i3;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;
import '../types/sp_core/crypto/account_id32.dart' as _i2;
import '../types/sp_runtime/multiaddress/multi_address.dart' as _i10;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageMap<_i2.AccountId32, List<_i3.VestingInfo>> _vesting =
      const _i1.StorageMap<_i2.AccountId32, List<_i3.VestingInfo>>(
    prefix: 'Vesting',
    storage: 'Vesting',
    valueCodec: _i4.SequenceCodec<_i3.VestingInfo>(_i3.VestingInfo.codec),
    hasher: _i1.StorageHasher.blake2b128Concat(_i2.AccountId32Codec()),
  );

  final _i1.StorageValue<_i5.Releases> _storageVersion =
      const _i1.StorageValue<_i5.Releases>(
    prefix: 'Vesting',
    storage: 'StorageVersion',
    valueCodec: _i5.Releases.codec,
  );

  /// Information regarding the vesting of a given account.
  _i6.Future<List<_i3.VestingInfo>?> vesting(
    _i2.AccountId32 key1, {
    _i1.BlockHash? at,
  }) async {
    final hashedKey = _vesting.hashedKeyFor(key1);
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _vesting.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Storage version of the pallet.
  ///
  /// New networks start with latest version, as determined by the genesis build.
  _i6.Future<_i5.Releases> storageVersion({_i1.BlockHash? at}) async {
    final hashedKey = _storageVersion.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _storageVersion.decodeValue(bytes);
    }
    return _i5.Releases.v0; /* Default */
  }

  /// Returns the storage key for `vesting`.
  _i7.Uint8List vestingKey(_i2.AccountId32 key1) {
    final hashedKey = _vesting.hashedKeyFor(key1);
    return hashedKey;
  }

  /// Returns the storage key for `storageVersion`.
  _i7.Uint8List storageVersionKey() {
    final hashedKey = _storageVersion.hashedKey();
    return hashedKey;
  }

  /// Returns the storage map key prefix for `vesting`.
  _i7.Uint8List vestingMapPrefix() {
    final hashedKey = _vesting.mapPrefix();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Unlock any vested funds of the sender account.
  ///
  /// The dispatch origin for this call must be _Signed_ and the sender must have funds still
  /// locked under this pallet.
  ///
  /// Emits either `VestingCompleted` or `VestingUpdated`.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i8.RuntimeCall vest() {
    final _call = _i9.Call.values.vest();
    return _i8.RuntimeCall.values.vesting(_call);
  }

  /// Unlock any vested funds of a `target` account.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `target`: The account whose vested funds should be unlocked. Must have funds still
  /// locked under this pallet.
  ///
  /// Emits either `VestingCompleted` or `VestingUpdated`.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i8.RuntimeCall vestOther({required _i10.MultiAddress target}) {
    final _call = _i9.Call.values.vestOther(target: target);
    return _i8.RuntimeCall.values.vesting(_call);
  }

  /// Create a vested transfer.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `target`: The account receiving the vested funds.
  /// - `schedule`: The vesting schedule attached to the transfer.
  ///
  /// Emits `VestingCreated`.
  ///
  /// NOTE: This will unlock all schedules through the current block.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i8.RuntimeCall vestedTransfer({
    required _i10.MultiAddress target,
    required _i3.VestingInfo schedule,
  }) {
    final _call = _i9.Call.values.vestedTransfer(
      target: target,
      schedule: schedule,
    );
    return _i8.RuntimeCall.values.vesting(_call);
  }

  /// Force a vested transfer.
  ///
  /// The dispatch origin for this call must be _Root_.
  ///
  /// - `source`: The account whose funds should be transferred.
  /// - `target`: The account that should be transferred the vested funds.
  /// - `schedule`: The vesting schedule attached to the transfer.
  ///
  /// Emits `VestingCreated`.
  ///
  /// NOTE: This will unlock all schedules through the current block.
  ///
  /// ## Complexity
  /// - `O(1)`.
  _i8.RuntimeCall forceVestedTransfer({
    required _i10.MultiAddress source,
    required _i10.MultiAddress target,
    required _i3.VestingInfo schedule,
  }) {
    final _call = _i9.Call.values.forceVestedTransfer(
      source: source,
      target: target,
      schedule: schedule,
    );
    return _i8.RuntimeCall.values.vesting(_call);
  }

  /// Merge two vesting schedules together, creating a new vesting schedule that unlocks over
  /// the highest possible start and end blocks. If both schedules have already started the
  /// current block will be used as the schedule start; with the caveat that if one schedule
  /// is finished by the current block, the other will be treated as the new merged schedule,
  /// unmodified.
  ///
  /// NOTE: If `schedule1_index == schedule2_index` this is a no-op.
  /// NOTE: This will unlock all schedules through the current block prior to merging.
  /// NOTE: If both schedules have ended by the current block, no new schedule will be created
  /// and both will be removed.
  ///
  /// Merged schedule attributes:
  /// - `starting_block`: `MAX(schedule1.starting_block, scheduled2.starting_block,
  ///  current_block)`.
  /// - `ending_block`: `MAX(schedule1.ending_block, schedule2.ending_block)`.
  /// - `locked`: `schedule1.locked_at(current_block) + schedule2.locked_at(current_block)`.
  ///
  /// The dispatch origin for this call must be _Signed_.
  ///
  /// - `schedule1_index`: index of the first schedule to merge.
  /// - `schedule2_index`: index of the second schedule to merge.
  _i8.RuntimeCall mergeSchedules({
    required int schedule1Index,
    required int schedule2Index,
  }) {
    final _call = _i9.Call.values.mergeSchedules(
      schedule1Index: schedule1Index,
      schedule2Index: schedule2Index,
    );
    return _i8.RuntimeCall.values.vesting(_call);
  }

  /// Force remove a vesting schedule
  ///
  /// The dispatch origin for this call must be _Root_.
  ///
  /// - `target`: An account that has a vesting schedule
  /// - `schedule_index`: The vesting schedule index that should be removed
  _i8.RuntimeCall forceRemoveVestingSchedule({
    required _i10.MultiAddress target,
    required int scheduleIndex,
  }) {
    final _call = _i9.Call.values.forceRemoveVestingSchedule(
      target: target,
      scheduleIndex: scheduleIndex,
    );
    return _i8.RuntimeCall.values.vesting(_call);
  }
}

class Constants {
  Constants();

  /// The minimum amount transferred to call `vested_transfer`.
  final BigInt minVestedTransfer = BigInt.from(10000000000);

  final int maxVestingSchedules = 28;
}
