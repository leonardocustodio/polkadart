// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../primitive_types/h256.dart' as _i4;
import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

/// Contains one variant per dispatchable that can be called by an extrinsic.
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

  ReportAwesome reportAwesome({
    required List<int> reason,
    required _i3.MultiAddress who,
  }) {
    return ReportAwesome(
      reason: reason,
      who: who,
    );
  }

  RetractTip retractTip({required _i4.H256 hash}) {
    return RetractTip(hash: hash);
  }

  TipNew tipNew({
    required List<int> reason,
    required _i3.MultiAddress who,
    required BigInt tipValue,
  }) {
    return TipNew(
      reason: reason,
      who: who,
      tipValue: tipValue,
    );
  }

  Tip tip({
    required _i4.H256 hash,
    required BigInt tipValue,
  }) {
    return Tip(
      hash: hash,
      tipValue: tipValue,
    );
  }

  CloseTip closeTip({required _i4.H256 hash}) {
    return CloseTip(hash: hash);
  }

  SlashTip slashTip({required _i4.H256 hash}) {
    return SlashTip(hash: hash);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return ReportAwesome._decode(input);
      case 1:
        return RetractTip._decode(input);
      case 2:
        return TipNew._decode(input);
      case 3:
        return Tip._decode(input);
      case 4:
        return CloseTip._decode(input);
      case 5:
        return SlashTip._decode(input);
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
      case ReportAwesome:
        (value as ReportAwesome).encodeTo(output);
        break;
      case RetractTip:
        (value as RetractTip).encodeTo(output);
        break;
      case TipNew:
        (value as TipNew).encodeTo(output);
        break;
      case Tip:
        (value as Tip).encodeTo(output);
        break;
      case CloseTip:
        (value as CloseTip).encodeTo(output);
        break;
      case SlashTip:
        (value as SlashTip).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case ReportAwesome:
        return (value as ReportAwesome)._sizeHint();
      case RetractTip:
        return (value as RetractTip)._sizeHint();
      case TipNew:
        return (value as TipNew)._sizeHint();
      case Tip:
        return (value as Tip)._sizeHint();
      case CloseTip:
        return (value as CloseTip)._sizeHint();
      case SlashTip:
        return (value as SlashTip)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

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
class ReportAwesome extends Call {
  const ReportAwesome({
    required this.reason,
    required this.who,
  });

  factory ReportAwesome._decode(_i1.Input input) {
    return ReportAwesome(
      reason: _i1.U8SequenceCodec.codec.decode(input),
      who: _i3.MultiAddress.codec.decode(input),
    );
  }

  /// Vec<u8>
  final List<int> reason;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress who;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'report_awesome': {
          'reason': reason,
          'who': who.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(reason);
    size = size + _i3.MultiAddress.codec.sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      reason,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      who,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReportAwesome &&
          _i5.listsEqual(
            other.reason,
            reason,
          ) &&
          other.who == who;

  @override
  int get hashCode => Object.hash(
        reason,
        who,
      );
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
class RetractTip extends Call {
  const RetractTip({required this.hash});

  factory RetractTip._decode(_i1.Input input) {
    return RetractTip(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i4.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'retract_tip': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RetractTip &&
          _i5.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
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
class TipNew extends Call {
  const TipNew({
    required this.reason,
    required this.who,
    required this.tipValue,
  });

  factory TipNew._decode(_i1.Input input) {
    return TipNew(
      reason: _i1.U8SequenceCodec.codec.decode(input),
      who: _i3.MultiAddress.codec.decode(input),
      tipValue: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// Vec<u8>
  final List<int> reason;

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress who;

  /// BalanceOf<T, I>
  final BigInt tipValue;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'tip_new': {
          'reason': reason,
          'who': who.toJson(),
          'tipValue': tipValue,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U8SequenceCodec.codec.sizeHint(reason);
    size = size + _i3.MultiAddress.codec.sizeHint(who);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(tipValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      reason,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      who,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      tipValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TipNew &&
          _i5.listsEqual(
            other.reason,
            reason,
          ) &&
          other.who == who &&
          other.tipValue == tipValue;

  @override
  int get hashCode => Object.hash(
        reason,
        who,
        tipValue,
      );
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
class Tip extends Call {
  const Tip({
    required this.hash,
    required this.tipValue,
  });

  factory Tip._decode(_i1.Input input) {
    return Tip(
      hash: const _i1.U8ArrayCodec(32).decode(input),
      tipValue: _i1.CompactBigIntCodec.codec.decode(input),
    );
  }

  /// T::Hash
  final _i4.H256 hash;

  /// BalanceOf<T, I>
  final BigInt tipValue;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'tip': {
          'hash': hash.toList(),
          'tipValue': tipValue,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.H256Codec().sizeHint(hash);
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(tipValue);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      tipValue,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Tip &&
          _i5.listsEqual(
            other.hash,
            hash,
          ) &&
          other.tipValue == tipValue;

  @override
  int get hashCode => Object.hash(
        hash,
        tipValue,
      );
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
class CloseTip extends Call {
  const CloseTip({required this.hash});

  factory CloseTip._decode(_i1.Input input) {
    return CloseTip(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i4.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'close_tip': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CloseTip &&
          _i5.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
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
class SlashTip extends Call {
  const SlashTip({required this.hash});

  factory SlashTip._decode(_i1.Input input) {
    return SlashTip(hash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::Hash
  final _i4.H256 hash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'slash_tip': {'hash': hash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      hash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SlashTip &&
          _i5.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => hash.hashCode;
}
