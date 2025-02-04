// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:typed_data' as _i7;

import 'package:polkadart/polkadart.dart' as _i1;
import 'package:polkadart/scale_codec.dart' as _i4;

import '../types/pallet_state_trie_migration/pallet/call.dart' as _i9;
import '../types/pallet_state_trie_migration/pallet/migration_limits.dart'
    as _i3;
import '../types/pallet_state_trie_migration/pallet/migration_task.dart' as _i2;
import '../types/pallet_state_trie_migration/pallet/progress.dart' as _i6;
import '../types/polkadot_runtime/runtime_call.dart' as _i8;

class Queries {
  const Queries(this.__api);

  final _i1.StateApi __api;

  final _i1.StorageValue<_i2.MigrationTask> _migrationProcess =
      const _i1.StorageValue<_i2.MigrationTask>(
    prefix: 'StateTrieMigration',
    storage: 'MigrationProcess',
    valueCodec: _i2.MigrationTask.codec,
  );

  final _i1.StorageValue<_i3.MigrationLimits?> _autoLimits =
      const _i1.StorageValue<_i3.MigrationLimits?>(
    prefix: 'StateTrieMigration',
    storage: 'AutoLimits',
    valueCodec: _i4.OptionCodec<_i3.MigrationLimits>(_i3.MigrationLimits.codec),
  );

  final _i1.StorageValue<_i3.MigrationLimits> _signedMigrationMaxLimits =
      const _i1.StorageValue<_i3.MigrationLimits>(
    prefix: 'StateTrieMigration',
    storage: 'SignedMigrationMaxLimits',
    valueCodec: _i3.MigrationLimits.codec,
  );

  /// Migration progress.
  ///
  /// This stores the snapshot of the last migrated keys. It can be set into motion and move
  /// forward by any of the means provided by this pallet.
  _i5.Future<_i2.MigrationTask> migrationProcess({_i1.BlockHash? at}) async {
    final hashedKey = _migrationProcess.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _migrationProcess.decodeValue(bytes);
    }
    return _i2.MigrationTask(
      progressTop: _i6.ToStart(),
      progressChild: _i6.ToStart(),
      size: 0,
      topItems: 0,
      childItems: 0,
    ); /* Default */
  }

  /// The limits that are imposed on automatic migrations.
  ///
  /// If set to None, then no automatic migration happens.
  _i5.Future<_i3.MigrationLimits?> autoLimits({_i1.BlockHash? at}) async {
    final hashedKey = _autoLimits.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _autoLimits.decodeValue(bytes);
    }
    return null; /* Default */
  }

  /// The maximum limits that the signed migration could use.
  ///
  /// If not set, no signed submission is allowed.
  _i5.Future<_i3.MigrationLimits?> signedMigrationMaxLimits(
      {_i1.BlockHash? at}) async {
    final hashedKey = _signedMigrationMaxLimits.hashedKey();
    final bytes = await __api.getStorage(
      hashedKey,
      at: at,
    );
    if (bytes != null) {
      return _signedMigrationMaxLimits.decodeValue(bytes);
    }
    return null; /* Nullable */
  }

  /// Returns the storage key for `migrationProcess`.
  _i7.Uint8List migrationProcessKey() {
    final hashedKey = _migrationProcess.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `autoLimits`.
  _i7.Uint8List autoLimitsKey() {
    final hashedKey = _autoLimits.hashedKey();
    return hashedKey;
  }

  /// Returns the storage key for `signedMigrationMaxLimits`.
  _i7.Uint8List signedMigrationMaxLimitsKey() {
    final hashedKey = _signedMigrationMaxLimits.hashedKey();
    return hashedKey;
  }
}

class Txs {
  const Txs();

  /// Control the automatic migration.
  ///
  /// The dispatch origin of this call must be [`Config::ControlOrigin`].
  _i8.RuntimeCall controlAutoMigration({_i3.MigrationLimits? maybeConfig}) {
    final _call =
        _i9.Call.values.controlAutoMigration(maybeConfig: maybeConfig);
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }

  /// Continue the migration for the given `limits`.
  ///
  /// The dispatch origin of this call can be any signed account.
  ///
  /// This transaction has NO MONETARY INCENTIVES. calling it will not reward anyone. Albeit,
  /// Upon successful execution, the transaction fee is returned.
  ///
  /// The (potentially over-estimated) of the byte length of all the data read must be
  /// provided for up-front fee-payment and weighing. In essence, the caller is guaranteeing
  /// that executing the current `MigrationTask` with the given `limits` will not exceed
  /// `real_size_upper` bytes of read data.
  ///
  /// The `witness_task` is merely a helper to prevent the caller from being slashed or
  /// generally trigger a migration that they do not intend. This parameter is just a message
  /// from caller, saying that they believed `witness_task` was the last state of the
  /// migration, and they only wish for their transaction to do anything, if this assumption
  /// holds. In case `witness_task` does not match, the transaction fails.
  ///
  /// Based on the documentation of [`MigrationTask::migrate_until_exhaustion`], the
  /// recommended way of doing this is to pass a `limit` that only bounds `count`, as the
  /// `size` limit can always be overwritten.
  _i8.RuntimeCall continueMigrate({
    required _i3.MigrationLimits limits,
    required int realSizeUpper,
    required _i2.MigrationTask witnessTask,
  }) {
    final _call = _i9.Call.values.continueMigrate(
      limits: limits,
      realSizeUpper: realSizeUpper,
      witnessTask: witnessTask,
    );
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }

  /// Migrate the list of top keys by iterating each of them one by one.
  ///
  /// This does not affect the global migration process tracker ([`MigrationProcess`]), and
  /// should only be used in case any keys are leftover due to a bug.
  _i8.RuntimeCall migrateCustomTop({
    required List<List<int>> keys,
    required int witnessSize,
  }) {
    final _call = _i9.Call.values.migrateCustomTop(
      keys: keys,
      witnessSize: witnessSize,
    );
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }

  /// Migrate the list of child keys by iterating each of them one by one.
  ///
  /// All of the given child keys must be present under one `child_root`.
  ///
  /// This does not affect the global migration process tracker ([`MigrationProcess`]), and
  /// should only be used in case any keys are leftover due to a bug.
  _i8.RuntimeCall migrateCustomChild({
    required List<int> root,
    required List<List<int>> childKeys,
    required int totalSize,
  }) {
    final _call = _i9.Call.values.migrateCustomChild(
      root: root,
      childKeys: childKeys,
      totalSize: totalSize,
    );
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }

  /// Set the maximum limit of the signed migration.
  _i8.RuntimeCall setSignedMaxLimits({required _i3.MigrationLimits limits}) {
    final _call = _i9.Call.values.setSignedMaxLimits(limits: limits);
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }

  /// Forcefully set the progress the running migration.
  ///
  /// This is only useful in one case: the next key to migrate is too big to be migrated with
  /// a signed account, in a parachain context, and we simply want to skip it. A reasonable
  /// example of this would be `:code:`, which is both very expensive to migrate, and commonly
  /// used, so probably it is already migrated.
  ///
  /// In case you mess things up, you can also, in principle, use this to reset the migration
  /// process.
  _i8.RuntimeCall forceSetProgress({
    required _i6.Progress progressTop,
    required _i6.Progress progressChild,
  }) {
    final _call = _i9.Call.values.forceSetProgress(
      progressTop: progressTop,
      progressChild: progressChild,
    );
    return _i8.RuntimeCall.values.stateTrieMigration(_call);
  }
}

class Constants {
  Constants();

  /// Maximal number of bytes that a key can have.
  ///
  /// FRAME itself does not limit the key length.
  /// The concrete value must therefore depend on your storage usage.
  /// A [`frame_support::storage::StorageNMap`] for example can have an arbitrary number of
  /// keys which are then hashed and concatenated, resulting in arbitrarily long keys.
  ///
  /// Use the *state migration RPC* to retrieve the length of the longest key in your
  /// storage: <https://github.com/paritytech/substrate/issues/11642>
  ///
  /// The migration will halt with a `Halted` event if this value is too small.
  /// Since there is no real penalty from over-estimating, it is advised to use a large
  /// value. The default is 512 byte.
  ///
  /// Some key lengths for reference:
  /// - [`frame_support::storage::StorageValue`]: 32 byte
  /// - [`frame_support::storage::StorageMap`]: 64 byte
  /// - [`frame_support::storage::StorageDoubleMap`]: 96 byte
  ///
  /// For more info see
  /// <https://www.shawntabrizi.com/blog/substrate/querying-substrate-storage-via-rpc/>
  final int maxKeyLen = 512;
}
