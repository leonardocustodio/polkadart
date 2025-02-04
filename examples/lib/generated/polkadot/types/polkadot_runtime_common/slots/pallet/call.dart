// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../../sp_core/crypto/account_id32.dart' as _i4;

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

  ForceLease forceLease({
    required _i3.Id para,
    required _i4.AccountId32 leaser,
    required BigInt amount,
    required int periodBegin,
    required int periodCount,
  }) {
    return ForceLease(
      para: para,
      leaser: leaser,
      amount: amount,
      periodBegin: periodBegin,
      periodCount: periodCount,
    );
  }

  ClearAllLeases clearAllLeases({required _i3.Id para}) {
    return ClearAllLeases(para: para);
  }

  TriggerOnboard triggerOnboard({required _i3.Id para}) {
    return TriggerOnboard(para: para);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ForceLease._decode(input);
      case 1:
        return ClearAllLeases._decode(input);
      case 2:
        return TriggerOnboard._decode(input);
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
      case ForceLease:
        (value as ForceLease).encodeTo(output);
        break;
      case ClearAllLeases:
        (value as ClearAllLeases).encodeTo(output);
        break;
      case TriggerOnboard:
        (value as TriggerOnboard).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ForceLease:
        return (value as ForceLease)._sizeHint();
      case ClearAllLeases:
        return (value as ClearAllLeases)._sizeHint();
      case TriggerOnboard:
        return (value as TriggerOnboard)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Just a connect into the `lease_out` call, in case Root wants to force some lease to
/// happen independently of any other on-chain mechanism to use it.
///
/// The dispatch origin for this call must match `T::ForceOrigin`.
class ForceLease extends Call {
  const ForceLease({
    required this.para,
    required this.leaser,
    required this.amount,
    required this.periodBegin,
    required this.periodCount,
  });

  factory ForceLease._decode(_i1.Input input) {
    return ForceLease(
      para: _i1.U32Codec.codec.decode(input),
      leaser: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      periodBegin: _i1.U32Codec.codec.decode(input),
      periodCount: _i1.U32Codec.codec.decode(input),
    );
  }

  /// ParaId
  final _i3.Id para;

  /// T::AccountId
  final _i4.AccountId32 leaser;

  /// BalanceOf<T>
  final BigInt amount;

  /// LeasePeriodOf<T>
  final int periodBegin;

  /// LeasePeriodOf<T>
  final int periodCount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_lease': {
          'para': para,
          'leaser': leaser.toList(),
          'amount': amount,
          'periodBegin': periodBegin,
          'periodCount': periodCount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    size = size + const _i4.AccountId32Codec().sizeHint(leaser);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size + _i1.U32Codec.codec.sizeHint(periodBegin);
    size = size + _i1.U32Codec.codec.sizeHint(periodCount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      leaser,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      periodBegin,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      periodCount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceLease &&
          other.para == para &&
          _i5.listsEqual(
            other.leaser,
            leaser,
          ) &&
          other.amount == amount &&
          other.periodBegin == periodBegin &&
          other.periodCount == periodCount;

  @override
  int get hashCode => Object.hash(
        para,
        leaser,
        amount,
        periodBegin,
        periodCount,
      );
}

/// Clear all leases for a Para Id, refunding any deposits back to the original owners.
///
/// The dispatch origin for this call must match `T::ForceOrigin`.
class ClearAllLeases extends Call {
  const ClearAllLeases({required this.para});

  factory ClearAllLeases._decode(_i1.Input input) {
    return ClearAllLeases(para: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id para;

  @override
  Map<String, Map<String, int>> toJson() => {
        'clear_all_leases': {'para': para}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ClearAllLeases && other.para == para;

  @override
  int get hashCode => para.hashCode;
}

/// Try to onboard a parachain that has a lease for the current lease period.
///
/// This function can be useful if there was some state issue with a para that should
/// have onboarded, but was unable to. As long as they have a lease period, we can
/// let them onboard from here.
///
/// Origin must be signed, but can be called by anyone.
class TriggerOnboard extends Call {
  const TriggerOnboard({required this.para});

  factory TriggerOnboard._decode(_i1.Input input) {
    return TriggerOnboard(para: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id para;

  @override
  Map<String, Map<String, int>> toJson() => {
        'trigger_onboard': {'para': para}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(para);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      para,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TriggerOnboard && other.para == para;

  @override
  int get hashCode => para.hashCode;
}
