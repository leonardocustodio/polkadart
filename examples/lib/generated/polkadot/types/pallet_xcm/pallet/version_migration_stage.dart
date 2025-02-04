// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

abstract class VersionMigrationStage {
  const VersionMigrationStage();

  factory VersionMigrationStage.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $VersionMigrationStageCodec codec =
      $VersionMigrationStageCodec();

  static const $VersionMigrationStage values = $VersionMigrationStage();

  _i2.Uint8List encode() {
    final output = _i1.ByteOutput(codec.sizeHint(this));
    codec.encodeTo(this, output);
    return output.toBytes();
  }

  int sizeHint() {
    return codec.sizeHint(this);
  }

  Map<String, dynamic> toJson();
}

class $VersionMigrationStage {
  const $VersionMigrationStage();

  MigrateSupportedVersion migrateSupportedVersion() {
    return MigrateSupportedVersion();
  }

  MigrateVersionNotifiers migrateVersionNotifiers() {
    return MigrateVersionNotifiers();
  }

  NotifyCurrentTargets notifyCurrentTargets(List<int>? value0) {
    return NotifyCurrentTargets(value0);
  }

  MigrateAndNotifyOldTargets migrateAndNotifyOldTargets() {
    return MigrateAndNotifyOldTargets();
  }
}

class $VersionMigrationStageCodec with _i1.Codec<VersionMigrationStage> {
  const $VersionMigrationStageCodec();

  @override
  VersionMigrationStage decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const MigrateSupportedVersion();
      case 1:
        return const MigrateVersionNotifiers();
      case 2:
        return NotifyCurrentTargets._decode(input);
      case 3:
        return const MigrateAndNotifyOldTargets();
      default:
        throw Exception(
            'VersionMigrationStage: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    VersionMigrationStage value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case MigrateSupportedVersion:
        (value as MigrateSupportedVersion).encodeTo(output);
        break;
      case MigrateVersionNotifiers:
        (value as MigrateVersionNotifiers).encodeTo(output);
        break;
      case NotifyCurrentTargets:
        (value as NotifyCurrentTargets).encodeTo(output);
        break;
      case MigrateAndNotifyOldTargets:
        (value as MigrateAndNotifyOldTargets).encodeTo(output);
        break;
      default:
        throw Exception(
            'VersionMigrationStage: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(VersionMigrationStage value) {
    switch (value.runtimeType) {
      case MigrateSupportedVersion:
        return 1;
      case MigrateVersionNotifiers:
        return 1;
      case NotifyCurrentTargets:
        return (value as NotifyCurrentTargets)._sizeHint();
      case MigrateAndNotifyOldTargets:
        return 1;
      default:
        throw Exception(
            'VersionMigrationStage: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class MigrateSupportedVersion extends VersionMigrationStage {
  const MigrateSupportedVersion();

  @override
  Map<String, dynamic> toJson() => {'MigrateSupportedVersion': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MigrateSupportedVersion;

  @override
  int get hashCode => runtimeType.hashCode;
}

class MigrateVersionNotifiers extends VersionMigrationStage {
  const MigrateVersionNotifiers();

  @override
  Map<String, dynamic> toJson() => {'MigrateVersionNotifiers': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MigrateVersionNotifiers;

  @override
  int get hashCode => runtimeType.hashCode;
}

class NotifyCurrentTargets extends VersionMigrationStage {
  const NotifyCurrentTargets(this.value0);

  factory NotifyCurrentTargets._decode(_i1.Input input) {
    return NotifyCurrentTargets(
        const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .decode(input));
  }

  /// Option<Vec<u8>>
  final List<int>? value0;

  @override
  Map<String, List<int>?> toJson() => {'NotifyCurrentTargets': value0};

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec)
            .sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.OptionCodec<List<int>>(_i1.U8SequenceCodec.codec).encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NotifyCurrentTargets && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class MigrateAndNotifyOldTargets extends VersionMigrationStage {
  const MigrateAndNotifyOldTargets();

  @override
  Map<String, dynamic> toJson() => {'MigrateAndNotifyOldTargets': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MigrateAndNotifyOldTargets;

  @override
  int get hashCode => runtimeType.hashCode;
}
