// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../polkadot_runtime/runtime_call.dart' as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../sp_weights/weight_v2/weight.dart' as _i6;
import '../timepoint.dart' as _i5;

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

  AsMultiThreshold1 asMultiThreshold1({
    required List<_i3.AccountId32> otherSignatories,
    required _i4.RuntimeCall call,
  }) {
    return AsMultiThreshold1(
      otherSignatories: otherSignatories,
      call: call,
    );
  }

  AsMulti asMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    _i5.Timepoint? maybeTimepoint,
    required _i4.RuntimeCall call,
    required _i6.Weight maxWeight,
  }) {
    return AsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      call: call,
      maxWeight: maxWeight,
    );
  }

  ApproveAsMulti approveAsMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    _i5.Timepoint? maybeTimepoint,
    required List<int> callHash,
    required _i6.Weight maxWeight,
  }) {
    return ApproveAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      maybeTimepoint: maybeTimepoint,
      callHash: callHash,
      maxWeight: maxWeight,
    );
  }

  CancelAsMulti cancelAsMulti({
    required int threshold,
    required List<_i3.AccountId32> otherSignatories,
    required _i5.Timepoint timepoint,
    required List<int> callHash,
  }) {
    return CancelAsMulti(
      threshold: threshold,
      otherSignatories: otherSignatories,
      timepoint: timepoint,
      callHash: callHash,
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
        return AsMultiThreshold1._decode(input);
      case 1:
        return AsMulti._decode(input);
      case 2:
        return ApproveAsMulti._decode(input);
      case 3:
        return CancelAsMulti._decode(input);
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
      case AsMultiThreshold1:
        (value as AsMultiThreshold1).encodeTo(output);
        break;
      case AsMulti:
        (value as AsMulti).encodeTo(output);
        break;
      case ApproveAsMulti:
        (value as ApproveAsMulti).encodeTo(output);
        break;
      case CancelAsMulti:
        (value as CancelAsMulti).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case AsMultiThreshold1:
        return (value as AsMultiThreshold1)._sizeHint();
      case AsMulti:
        return (value as AsMulti)._sizeHint();
      case ApproveAsMulti:
        return (value as ApproveAsMulti)._sizeHint();
      case CancelAsMulti:
        return (value as CancelAsMulti)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Immediately dispatch a multi-signature call using a single approval from the caller.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `other_signatories`: The accounts (other than the sender) who are part of the
/// multi-signature, but do not participate in the approval process.
/// - `call`: The call to be executed.
///
/// Result is equivalent to the dispatched result.
///
/// ## Complexity
/// O(Z + C) where Z is the length of the call and C its execution weight.
class AsMultiThreshold1 extends Call {
  const AsMultiThreshold1({
    required this.otherSignatories,
    required this.call,
  });

  factory AsMultiThreshold1._decode(_i1.Input input) {
    return AsMultiThreshold1(
      otherSignatories:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
    );
  }

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> otherSignatories;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'as_multi_threshold_1': {
          'otherSignatories':
              otherSignatories.map((value) => value.toList()).toList(),
          'call': call.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(otherSignatories);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      otherSignatories,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AsMultiThreshold1 &&
          _i7.listsEqual(
            other.otherSignatories,
            otherSignatories,
          ) &&
          other.call == call;

  @override
  int get hashCode => Object.hash(
        otherSignatories,
        call,
      );
}

/// Register approval for a dispatch to be made from a deterministic composite account if
/// approved by a total of `threshold - 1` of `other_signatories`.
///
/// If there are enough, then dispatch the call.
///
/// Payment: `DepositBase` will be reserved if this is the first approval, plus
/// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
/// is cancelled.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `threshold`: The total number of approvals for this dispatch before it is executed.
/// - `other_signatories`: The accounts (other than the sender) who can approve this
/// dispatch. May not be empty.
/// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
/// not the first approval, then it must be `Some`, with the timepoint (block number and
/// transaction index) of the first approval transaction.
/// - `call`: The call to be executed.
///
/// NOTE: Unless this is the final approval, you will generally want to use
/// `approve_as_multi` instead, since it only requires a hash of the call.
///
/// Result is equivalent to the dispatched result if `threshold` is exactly `1`. Otherwise
/// on success, result is `Ok` and the result from the interior call, if it was executed,
/// may be found in the deposited `MultisigExecuted` event.
///
/// ## Complexity
/// - `O(S + Z + Call)`.
/// - Up to one balance-reserve or unreserve operation.
/// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
/// - One call encode & hash, both of complexity `O(Z)` where `Z` is tx-len.
/// - One encode & hash, both of complexity `O(S)`.
/// - Up to one binary search and insert (`O(logS + S)`).
/// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
/// - One event.
/// - The weight of the `call`.
/// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
class AsMulti extends Call {
  const AsMulti({
    required this.threshold,
    required this.otherSignatories,
    this.maybeTimepoint,
    required this.call,
    required this.maxWeight,
  });

  factory AsMulti._decode(_i1.Input input) {
    return AsMulti(
      threshold: _i1.U16Codec.codec.decode(input),
      otherSignatories:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
      maybeTimepoint: const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec)
          .decode(input),
      call: _i4.RuntimeCall.codec.decode(input),
      maxWeight: _i6.Weight.codec.decode(input),
    );
  }

  /// u16
  final int threshold;

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> otherSignatories;

  /// Option<Timepoint<BlockNumberFor<T>>>
  final _i5.Timepoint? maybeTimepoint;

  /// Box<<T as Config>::RuntimeCall>
  final _i4.RuntimeCall call;

  /// Weight
  final _i6.Weight maxWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'as_multi': {
          'threshold': threshold,
          'otherSignatories':
              otherSignatories.map((value) => value.toList()).toList(),
          'maybeTimepoint': maybeTimepoint?.toJson(),
          'call': call.toJson(),
          'maxWeight': maxWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(threshold);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(otherSignatories);
    size = size +
        const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec)
            .sizeHint(maybeTimepoint);
    size = size + _i4.RuntimeCall.codec.sizeHint(call);
    size = size + _i6.Weight.codec.sizeHint(maxWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      threshold,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      otherSignatories,
      output,
    );
    const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec).encodeTo(
      maybeTimepoint,
      output,
    );
    _i4.RuntimeCall.codec.encodeTo(
      call,
      output,
    );
    _i6.Weight.codec.encodeTo(
      maxWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AsMulti &&
          other.threshold == threshold &&
          _i7.listsEqual(
            other.otherSignatories,
            otherSignatories,
          ) &&
          other.maybeTimepoint == maybeTimepoint &&
          other.call == call &&
          other.maxWeight == maxWeight;

  @override
  int get hashCode => Object.hash(
        threshold,
        otherSignatories,
        maybeTimepoint,
        call,
        maxWeight,
      );
}

/// Register approval for a dispatch to be made from a deterministic composite account if
/// approved by a total of `threshold - 1` of `other_signatories`.
///
/// Payment: `DepositBase` will be reserved if this is the first approval, plus
/// `threshold` times `DepositFactor`. It is returned once this dispatch happens or
/// is cancelled.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `threshold`: The total number of approvals for this dispatch before it is executed.
/// - `other_signatories`: The accounts (other than the sender) who can approve this
/// dispatch. May not be empty.
/// - `maybe_timepoint`: If this is the first approval, then this must be `None`. If it is
/// not the first approval, then it must be `Some`, with the timepoint (block number and
/// transaction index) of the first approval transaction.
/// - `call_hash`: The hash of the call to be executed.
///
/// NOTE: If this is the final approval, you will want to use `as_multi` instead.
///
/// ## Complexity
/// - `O(S)`.
/// - Up to one balance-reserve or unreserve operation.
/// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
/// - One encode & hash, both of complexity `O(S)`.
/// - Up to one binary search and insert (`O(logS + S)`).
/// - I/O: 1 read `O(S)`, up to 1 mutate `O(S)`. Up to one remove.
/// - One event.
/// - Storage: inserts one item, value size bounded by `MaxSignatories`, with a deposit
///  taken for its lifetime of `DepositBase + threshold * DepositFactor`.
class ApproveAsMulti extends Call {
  const ApproveAsMulti({
    required this.threshold,
    required this.otherSignatories,
    this.maybeTimepoint,
    required this.callHash,
    required this.maxWeight,
  });

  factory ApproveAsMulti._decode(_i1.Input input) {
    return ApproveAsMulti(
      threshold: _i1.U16Codec.codec.decode(input),
      otherSignatories:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
      maybeTimepoint: const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec)
          .decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
      maxWeight: _i6.Weight.codec.decode(input),
    );
  }

  /// u16
  final int threshold;

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> otherSignatories;

  /// Option<Timepoint<BlockNumberFor<T>>>
  final _i5.Timepoint? maybeTimepoint;

  /// [u8; 32]
  final List<int> callHash;

  /// Weight
  final _i6.Weight maxWeight;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'approve_as_multi': {
          'threshold': threshold,
          'otherSignatories':
              otherSignatories.map((value) => value.toList()).toList(),
          'maybeTimepoint': maybeTimepoint?.toJson(),
          'callHash': callHash.toList(),
          'maxWeight': maxWeight.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(threshold);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(otherSignatories);
    size = size +
        const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec)
            .sizeHint(maybeTimepoint);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    size = size + _i6.Weight.codec.sizeHint(maxWeight);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      threshold,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      otherSignatories,
      output,
    );
    const _i1.OptionCodec<_i5.Timepoint>(_i5.Timepoint.codec).encodeTo(
      maybeTimepoint,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
    _i6.Weight.codec.encodeTo(
      maxWeight,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ApproveAsMulti &&
          other.threshold == threshold &&
          _i7.listsEqual(
            other.otherSignatories,
            otherSignatories,
          ) &&
          other.maybeTimepoint == maybeTimepoint &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          ) &&
          other.maxWeight == maxWeight;

  @override
  int get hashCode => Object.hash(
        threshold,
        otherSignatories,
        maybeTimepoint,
        callHash,
        maxWeight,
      );
}

/// Cancel a pre-existing, on-going multisig transaction. Any deposit reserved previously
/// for this operation will be unreserved on success.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `threshold`: The total number of approvals for this dispatch before it is executed.
/// - `other_signatories`: The accounts (other than the sender) who can approve this
/// dispatch. May not be empty.
/// - `timepoint`: The timepoint (block number and transaction index) of the first approval
/// transaction for this dispatch.
/// - `call_hash`: The hash of the call to be executed.
///
/// ## Complexity
/// - `O(S)`.
/// - Up to one balance-reserve or unreserve operation.
/// - One passthrough operation, one insert, both `O(S)` where `S` is the number of
///  signatories. `S` is capped by `MaxSignatories`, with weight being proportional.
/// - One encode & hash, both of complexity `O(S)`.
/// - One event.
/// - I/O: 1 read `O(S)`, one remove.
/// - Storage: removes one item.
class CancelAsMulti extends Call {
  const CancelAsMulti({
    required this.threshold,
    required this.otherSignatories,
    required this.timepoint,
    required this.callHash,
  });

  factory CancelAsMulti._decode(_i1.Input input) {
    return CancelAsMulti(
      threshold: _i1.U16Codec.codec.decode(input),
      otherSignatories:
          const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
              .decode(input),
      timepoint: _i5.Timepoint.codec.decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// u16
  final int threshold;

  /// Vec<T::AccountId>
  final List<_i3.AccountId32> otherSignatories;

  /// Timepoint<BlockNumberFor<T>>
  final _i5.Timepoint timepoint;

  /// [u8; 32]
  final List<int> callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'cancel_as_multi': {
          'threshold': threshold,
          'otherSignatories':
              otherSignatories.map((value) => value.toList()).toList(),
          'timepoint': timepoint.toJson(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U16Codec.codec.sizeHint(threshold);
    size = size +
        const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec())
            .sizeHint(otherSignatories);
    size = size + _i5.Timepoint.codec.sizeHint(timepoint);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U16Codec.codec.encodeTo(
      threshold,
      output,
    );
    const _i1.SequenceCodec<_i3.AccountId32>(_i3.AccountId32Codec()).encodeTo(
      otherSignatories,
      output,
    );
    _i5.Timepoint.codec.encodeTo(
      timepoint,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelAsMulti &&
          other.threshold == threshold &&
          _i7.listsEqual(
            other.otherSignatories,
            otherSignatories,
          ) &&
          other.timepoint == timepoint &&
          _i7.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        threshold,
        otherSignatories,
        timepoint,
        callHash,
      );
}
