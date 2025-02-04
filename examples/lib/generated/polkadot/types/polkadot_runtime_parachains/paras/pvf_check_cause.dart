// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import 'upgrade_strategy.dart' as _i4;

abstract class PvfCheckCause {
  const PvfCheckCause();

  factory PvfCheckCause.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $PvfCheckCauseCodec codec = $PvfCheckCauseCodec();

  static const $PvfCheckCause values = $PvfCheckCause();

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

class $PvfCheckCause {
  const $PvfCheckCause();

  Onboarding onboarding(_i3.Id value0) {
    return Onboarding(value0);
  }

  Upgrade upgrade({
    required _i3.Id id,
    required int includedAt,
    required _i4.UpgradeStrategy upgradeStrategy,
  }) {
    return Upgrade(
      id: id,
      includedAt: includedAt,
      upgradeStrategy: upgradeStrategy,
    );
  }
}

class $PvfCheckCauseCodec with _i1.Codec<PvfCheckCause> {
  const $PvfCheckCauseCodec();

  @override
  PvfCheckCause decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Onboarding._decode(input);
      case 1:
        return Upgrade._decode(input);
      default:
        throw Exception('PvfCheckCause: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    PvfCheckCause value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Onboarding:
        (value as Onboarding).encodeTo(output);
        break;
      case Upgrade:
        (value as Upgrade).encodeTo(output);
        break;
      default:
        throw Exception(
            'PvfCheckCause: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(PvfCheckCause value) {
    switch (value.runtimeType) {
      case Onboarding:
        return (value as Onboarding)._sizeHint();
      case Upgrade:
        return (value as Upgrade)._sizeHint();
      default:
        throw Exception(
            'PvfCheckCause: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Onboarding extends PvfCheckCause {
  const Onboarding(this.value0);

  factory Onboarding._decode(_i1.Input input) {
    return Onboarding(_i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id value0;

  @override
  Map<String, int> toJson() => {'Onboarding': value0};

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
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
      other is Onboarding && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

class Upgrade extends PvfCheckCause {
  const Upgrade({
    required this.id,
    required this.includedAt,
    required this.upgradeStrategy,
  });

  factory Upgrade._decode(_i1.Input input) {
    return Upgrade(
      id: _i1.U32Codec.codec.decode(input),
      includedAt: _i1.U32Codec.codec.decode(input),
      upgradeStrategy: _i4.UpgradeStrategy.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id id;

  /// BlockNumber
  final int includedAt;

  /// UpgradeStrategy
  final _i4.UpgradeStrategy upgradeStrategy;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Upgrade': {
          'id': id,
          'includedAt': includedAt,
          'upgradeStrategy': upgradeStrategy.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(id);
    size = size + _i1.U32Codec.codec.sizeHint(includedAt);
    size = size + _i4.UpgradeStrategy.codec.sizeHint(upgradeStrategy);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      id,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      includedAt,
      output,
    );
    _i4.UpgradeStrategy.codec.encodeTo(
      upgradeStrategy,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Upgrade &&
          other.id == id &&
          other.includedAt == includedAt &&
          other.upgradeStrategy == upgradeStrategy;

  @override
  int get hashCode => Object.hash(
        id,
        includedAt,
        upgradeStrategy,
      );
}
