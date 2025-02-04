// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import 'migration_limits.dart' as _i3;
import 'migration_task.dart' as _i4;
import 'progress.dart' as _i5;

/// Contains a variant per dispatchable extrinsic that this pallet has.
abstract class Call {
  const Call();

  factory Call.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $CallCodec codec = $CallCodec();

  static const $Call values = $Call();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, Map<String, dynamic>> toJson();
}

class $Call {
  const $Call();

  ControlAutoMigration controlAutoMigration(
      {_i3.MigrationLimits? maybeConfig}) {
    return ControlAutoMigration(maybeConfig: maybeConfig);
  }

  ContinueMigrate continueMigrate({
    required _i3.MigrationLimits limits,
    required int realSizeUpper,
    required _i4.MigrationTask witnessTask,
  }) {
    return ContinueMigrate(
      limits: limits,
      realSizeUpper: realSizeUpper,
      witnessTask: witnessTask,
    );
  }

  MigrateCustomTop migrateCustomTop({
    required List<List<int>> keys,
    required int witnessSize,
  }) {
    return MigrateCustomTop(
      keys: keys,
      witnessSize: witnessSize,
    );
  }

  MigrateCustomChild migrateCustomChild({
    required List<int> root,
    required List<List<int>> childKeys,
    required int totalSize,
  }) {
    return MigrateCustomChild(
      root: root,
      childKeys: childKeys,
      totalSize: totalSize,
    );
  }

  SetSignedMaxLimits setSignedMaxLimits({required _i3.MigrationLimits limits}) {
    return SetSignedMaxLimits(limits: limits);
  }

  ForceSetProgress forceSetProgress({
    required _i5.Progress progressTop,
    required _i5.Progress progressChild,
  }) {
    return ForceSetProgress(
      progressTop: progressTop,
      progressChild: progressChild,
    );
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ControlAutoMigration._decode(input);
      case 1:
        return ContinueMigrate._decode(input);
      case 2:
        return MigrateCustomTop._decode(input);
      case 3:
        return MigrateCustomChild._decode(input);
      case 4:
        return SetSignedMaxLimits._decode(input);
      case 5:
        return ForceSetProgress._decode(input);
      default:
        throw Exception('Call: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Call value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case ControlAutoMigration:
        (value as ControlAutoMigration).encodeTo(output);
        break;
      case ContinueMigrate:
        (value as ContinueMigrate).encodeTo(output);
        break;
      case MigrateCustomTop:
        (value as MigrateCustomTop).encodeTo(output);
        break;
      case MigrateCustomChild:
        (value as MigrateCustomChild).encodeTo(output);
        break;
      case SetSignedMaxLimits:
        (value as SetSignedMaxLimits).encodeTo(output);
        break;
      case ForceSetProgress:
        (value as ForceSetProgress).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ControlAutoMigration:
        return (value as ControlAutoMigration)._sizeHint();
      case ContinueMigrate:
        return (value as ContinueMigrate)._sizeHint();
      case MigrateCustomTop:
        return (value as MigrateCustomTop)._sizeHint();
      case MigrateCustomChild:
        return (value as MigrateCustomChild)._sizeHint();
      case SetSignedMaxLimits:
        return (value as SetSignedMaxLimits)._sizeHint();
      case ForceSetProgress:
        return (value as ForceSetProgress)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Control the automatic migration.
///
/// The dispatch origin of this call must be [`Config::ControlOrigin`].
class ControlAutoMigration extends Call {
  const ControlAutoMigration({this.maybeConfig});

  factory ControlAutoMigration._decode(_i1.Input input) {
    return ControlAutoMigration(
        maybeConfig: const _i1.OptionCodec<_i3.MigrationLimits>(
                _i3.MigrationLimits.codec)
            .decode(input));
  }

  /// Option<MigrationLimits>
  final _i3.MigrationLimits? maybeConfig;

  @override
  Map<String, Map<String, Map<String, int>?>> toJson() => {
        'control_auto_migration': {'maybeConfig': maybeConfig?.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<_i3.MigrationLimits>(_i3.MigrationLimits.codec)
            .sizeHint(maybeConfig);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.OptionCodec<_i3.MigrationLimits>(_i3.MigrationLimits.codec)
        .encodeTo(
      maybeConfig,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ControlAutoMigration && other.maybeConfig == maybeConfig;

  @override
  int get hashCode => maybeConfig.hashCode;
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
class ContinueMigrate extends Call {
  const ContinueMigrate({
    required this.limits,
    required this.realSizeUpper,
    required this.witnessTask,
  });

  factory ContinueMigrate._decode(_i1.Input input) {
    return ContinueMigrate(
      limits: _i3.MigrationLimits.codec.decode(input),
      realSizeUpper: _i1.U32Codec.codec.decode(input),
      witnessTask: _i4.MigrationTask.codec.decode(input),
    );
  }

  /// MigrationLimits
  final _i3.MigrationLimits limits;

  /// u32
  final int realSizeUpper;

  /// MigrationTask<T>
  final _i4.MigrationTask witnessTask;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'continue_migrate': {
          'limits': limits.toJson(),
          'realSizeUpper': realSizeUpper,
          'witnessTask': witnessTask.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MigrationLimits.codec.sizeHint(limits);
    size = size + _i1.U32Codec.codec.sizeHint(realSizeUpper);
    size = size + _i4.MigrationTask.codec.sizeHint(witnessTask);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MigrationLimits.codec.encodeTo(
      limits,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      realSizeUpper,
      output,
    );
    _i4.MigrationTask.codec.encodeTo(
      witnessTask,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ContinueMigrate &&
          other.limits == limits &&
          other.realSizeUpper == realSizeUpper &&
          other.witnessTask == witnessTask;

  @override
  int get hashCode => Object.hash(
        limits,
        realSizeUpper,
        witnessTask,
      );
}

/// Migrate the list of top keys by iterating each of them one by one.
///
/// This does not affect the global migration process tracker ([`MigrationProcess`]), and
/// should only be used in case any keys are leftover due to a bug.
class MigrateCustomTop extends Call {
  const MigrateCustomTop({
    required this.keys,
    required this.witnessSize,
  });

  factory MigrateCustomTop._decode(_i1.Input input) {
    return MigrateCustomTop(
      keys: const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
          .decode(input),
      witnessSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Vec<Vec<u8>>
  final List<List<int>> keys;

  /// u32
  final int witnessSize;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'migrate_custom_top': {
          'keys': keys.map((value) => value).toList(),
          'witnessSize': witnessSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(keys);
    size = size + _i1.U32Codec.codec.sizeHint(witnessSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      keys,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      witnessSize,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrateCustomTop &&
          _i6.listsEqual(
            other.keys,
            keys,
          ) &&
          other.witnessSize == witnessSize;

  @override
  int get hashCode => Object.hash(
        keys,
        witnessSize,
      );
}

/// Migrate the list of child keys by iterating each of them one by one.
///
/// All of the given child keys must be present under one `child_root`.
///
/// This does not affect the global migration process tracker ([`MigrationProcess`]), and
/// should only be used in case any keys are leftover due to a bug.
class MigrateCustomChild extends Call {
  const MigrateCustomChild({
    required this.root,
    required this.childKeys,
    required this.totalSize,
  });

  factory MigrateCustomChild._decode(_i1.Input input) {
    return MigrateCustomChild(
      root: _i1.U8SequenceCodec.codec.decode(input),
      childKeys: const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
          .decode(input),
      totalSize: _i1.U32Codec.codec.decode(input),
    );
  }

  /// Vec<u8>
  final List<int> root;

  /// Vec<Vec<u8>>
  final List<List<int>> childKeys;

  /// u32
  final int totalSize;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'migrate_custom_child': {
          'root': root,
          'childKeys': childKeys.map((value) => value).toList(),
          'totalSize': totalSize,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(root);
    size = size +
        const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(childKeys);
    size = size + _i1.U32Codec.codec.sizeHint(totalSize);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      root,
      output,
    );
    const _i1.SequenceCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      childKeys,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      totalSize,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MigrateCustomChild &&
          _i6.listsEqual(
            other.root,
            root,
          ) &&
          _i6.listsEqual(
            other.childKeys,
            childKeys,
          ) &&
          other.totalSize == totalSize;

  @override
  int get hashCode => Object.hash(
        root,
        childKeys,
        totalSize,
      );
}

/// Set the maximum limit of the signed migration.
class SetSignedMaxLimits extends Call {
  const SetSignedMaxLimits({required this.limits});

  factory SetSignedMaxLimits._decode(_i1.Input input) {
    return SetSignedMaxLimits(limits: _i3.MigrationLimits.codec.decode(input));
  }

  /// MigrationLimits
  final _i3.MigrationLimits limits;

  @override
  Map<String, Map<String, Map<String, int>>> toJson() => {
        'set_signed_max_limits': {'limits': limits.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MigrationLimits.codec.sizeHint(limits);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i3.MigrationLimits.codec.encodeTo(
      limits,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetSignedMaxLimits && other.limits == limits;

  @override
  int get hashCode => limits.hashCode;
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
class ForceSetProgress extends Call {
  const ForceSetProgress({
    required this.progressTop,
    required this.progressChild,
  });

  factory ForceSetProgress._decode(_i1.Input input) {
    return ForceSetProgress(
      progressTop: _i5.Progress.codec.decode(input),
      progressChild: _i5.Progress.codec.decode(input),
    );
  }

  /// ProgressOf<T>
  final _i5.Progress progressTop;

  /// ProgressOf<T>
  final _i5.Progress progressChild;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'force_set_progress': {
          'progressTop': progressTop.toJson(),
          'progressChild': progressChild.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i5.Progress.codec.sizeHint(progressTop);
    size = size + _i5.Progress.codec.sizeHint(progressChild);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i5.Progress.codec.encodeTo(
      progressTop,
      output,
    );
    _i5.Progress.codec.encodeTo(
      progressChild,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceSetProgress &&
          other.progressTop == progressTop &&
          other.progressChild == progressChild;

  @override
  int get hashCode => Object.hash(
        progressTop,
        progressChild,
      );
}
