// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../sp_core/crypto/account_id32.dart' as _i3;

abstract class ChildBountyStatus {
  const ChildBountyStatus();

  factory ChildBountyStatus.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ChildBountyStatusCodec codec = $ChildBountyStatusCodec();

  static const $ChildBountyStatus values = $ChildBountyStatus();

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

class $ChildBountyStatus {
  const $ChildBountyStatus();

  Added added() {
    return Added();
  }

  CuratorProposed curatorProposed({required _i3.AccountId32 curator}) {
    return CuratorProposed(curator: curator);
  }

  Active active({required _i3.AccountId32 curator}) {
    return Active(curator: curator);
  }

  PendingPayout pendingPayout({
    required _i3.AccountId32 curator,
    required _i3.AccountId32 beneficiary,
    required int unlockAt,
  }) {
    return PendingPayout(
      curator: curator,
      beneficiary: beneficiary,
      unlockAt: unlockAt,
    );
  }
}

class $ChildBountyStatusCodec with _i1.Codec<ChildBountyStatus> {
  const $ChildBountyStatusCodec();

  @override
  ChildBountyStatus decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const Added();
      case 1:
        return CuratorProposed._decode(input);
      case 2:
        return Active._decode(input);
      case 3:
        return PendingPayout._decode(input);
      default:
        throw Exception('ChildBountyStatus: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    ChildBountyStatus value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case Added:
        (value as Added).encodeTo(output);
        break;
      case CuratorProposed:
        (value as CuratorProposed).encodeTo(output);
        break;
      case Active:
        (value as Active).encodeTo(output);
        break;
      case PendingPayout:
        (value as PendingPayout).encodeTo(output);
        break;
      default:
        throw Exception(
            'ChildBountyStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(ChildBountyStatus value) {
    switch (value.runtimeType) {
      case Added:
        return 1;
      case CuratorProposed:
        return (value as CuratorProposed)._sizeHint();
      case Active:
        return (value as Active)._sizeHint();
      case PendingPayout:
        return (value as PendingPayout)._sizeHint();
      default:
        throw Exception(
            'ChildBountyStatus: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

class Added extends ChildBountyStatus {
  const Added();

  @override
  Map<String, dynamic> toJson() => {'Added': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Added;

  @override
  int get hashCode => runtimeType.hashCode;
}

class CuratorProposed extends ChildBountyStatus {
  const CuratorProposed({required this.curator});

  factory CuratorProposed._decode(_i1.Input input) {
    return CuratorProposed(curator: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// AccountId
  final _i3.AccountId32 curator;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'CuratorProposed': {'curator': curator.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(curator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      curator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CuratorProposed &&
          _i4.listsEqual(
            other.curator,
            curator,
          );

  @override
  int get hashCode => curator.hashCode;
}

class Active extends ChildBountyStatus {
  const Active({required this.curator});

  factory Active._decode(_i1.Input input) {
    return Active(curator: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// AccountId
  final _i3.AccountId32 curator;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Active': {'curator': curator.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(curator);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      curator,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Active &&
          _i4.listsEqual(
            other.curator,
            curator,
          );

  @override
  int get hashCode => curator.hashCode;
}

class PendingPayout extends ChildBountyStatus {
  const PendingPayout({
    required this.curator,
    required this.beneficiary,
    required this.unlockAt,
  });

  factory PendingPayout._decode(_i1.Input input) {
    return PendingPayout(
      curator: const _i1.U8ArrayCodec(32).decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
      unlockAt: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountId
  final _i3.AccountId32 curator;

  /// AccountId
  final _i3.AccountId32 beneficiary;

  /// BlockNumber
  final int unlockAt;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PendingPayout': {
          'curator': curator.toList(),
          'beneficiary': beneficiary.toList(),
          'unlockAt': unlockAt,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(curator);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    size = size + _i1.U32Codec.codec.sizeHint(unlockAt);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      curator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      unlockAt,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PendingPayout &&
          _i4.listsEqual(
            other.curator,
            curator,
          ) &&
          _i4.listsEqual(
            other.beneficiary,
            beneficiary,
          ) &&
          other.unlockAt == unlockAt;

  @override
  int get hashCode => Object.hash(
        curator,
        beneficiary,
        unlockAt,
      );
}
