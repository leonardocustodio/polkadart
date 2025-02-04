// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../sp_runtime/dispatch_error.dart' as _i5;
import '../timepoint.dart' as _i4;

/// The `Event` enum of this pallet
abstract class Event {
  const Event();

  factory Event.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $EventCodec codec = $EventCodec();

  static const $Event values = $Event();

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

class $Event {
  const $Event();

  NewMultisig newMultisig({
    required _i3.AccountId32 approving,
    required _i3.AccountId32 multisig,
    required List<int> callHash,
  }) {
    return NewMultisig(
      approving: approving,
      multisig: multisig,
      callHash: callHash,
    );
  }

  MultisigApproval multisigApproval({
    required _i3.AccountId32 approving,
    required _i4.Timepoint timepoint,
    required _i3.AccountId32 multisig,
    required List<int> callHash,
  }) {
    return MultisigApproval(
      approving: approving,
      timepoint: timepoint,
      multisig: multisig,
      callHash: callHash,
    );
  }

  MultisigExecuted multisigExecuted({
    required _i3.AccountId32 approving,
    required _i4.Timepoint timepoint,
    required _i3.AccountId32 multisig,
    required List<int> callHash,
    required _i1.Result<dynamic, _i5.DispatchError> result,
  }) {
    return MultisigExecuted(
      approving: approving,
      timepoint: timepoint,
      multisig: multisig,
      callHash: callHash,
      result: result,
    );
  }

  MultisigCancelled multisigCancelled({
    required _i3.AccountId32 cancelling,
    required _i4.Timepoint timepoint,
    required _i3.AccountId32 multisig,
    required List<int> callHash,
  }) {
    return MultisigCancelled(
      cancelling: cancelling,
      timepoint: timepoint,
      multisig: multisig,
      callHash: callHash,
    );
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return NewMultisig._decode(input);
      case 1:
        return MultisigApproval._decode(input);
      case 2:
        return MultisigExecuted._decode(input);
      case 3:
        return MultisigCancelled._decode(input);
      default:
        throw Exception('Event: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Event value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case NewMultisig:
        (value as NewMultisig).encodeTo(output);
        break;
      case MultisigApproval:
        (value as MultisigApproval).encodeTo(output);
        break;
      case MultisigExecuted:
        (value as MultisigExecuted).encodeTo(output);
        break;
      case MultisigCancelled:
        (value as MultisigCancelled).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewMultisig:
        return (value as NewMultisig)._sizeHint();
      case MultisigApproval:
        return (value as MultisigApproval)._sizeHint();
      case MultisigExecuted:
        return (value as MultisigExecuted)._sizeHint();
      case MultisigCancelled:
        return (value as MultisigCancelled)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new multisig operation has begun.
class NewMultisig extends Event {
  const NewMultisig({
    required this.approving,
    required this.multisig,
    required this.callHash,
  });

  factory NewMultisig._decode(_i1.Input input) {
    return NewMultisig(
      approving: const _i1.U8ArrayCodec(32).decode(input),
      multisig: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 approving;

  /// T::AccountId
  final _i3.AccountId32 multisig;

  /// CallHash
  final List<int> callHash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'NewMultisig': {
          'approving': approving.toList(),
          'multisig': multisig.toList(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(approving);
    size = size + const _i3.AccountId32Codec().sizeHint(multisig);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      approving,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      multisig,
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
      other is NewMultisig &&
          _i6.listsEqual(
            other.approving,
            approving,
          ) &&
          _i6.listsEqual(
            other.multisig,
            multisig,
          ) &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        approving,
        multisig,
        callHash,
      );
}

/// A multisig operation has been approved by someone.
class MultisigApproval extends Event {
  const MultisigApproval({
    required this.approving,
    required this.timepoint,
    required this.multisig,
    required this.callHash,
  });

  factory MultisigApproval._decode(_i1.Input input) {
    return MultisigApproval(
      approving: const _i1.U8ArrayCodec(32).decode(input),
      timepoint: _i4.Timepoint.codec.decode(input),
      multisig: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 approving;

  /// Timepoint<BlockNumberFor<T>>
  final _i4.Timepoint timepoint;

  /// T::AccountId
  final _i3.AccountId32 multisig;

  /// CallHash
  final List<int> callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MultisigApproval': {
          'approving': approving.toList(),
          'timepoint': timepoint.toJson(),
          'multisig': multisig.toList(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(approving);
    size = size + _i4.Timepoint.codec.sizeHint(timepoint);
    size = size + const _i3.AccountId32Codec().sizeHint(multisig);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      approving,
      output,
    );
    _i4.Timepoint.codec.encodeTo(
      timepoint,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      multisig,
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
      other is MultisigApproval &&
          _i6.listsEqual(
            other.approving,
            approving,
          ) &&
          other.timepoint == timepoint &&
          _i6.listsEqual(
            other.multisig,
            multisig,
          ) &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        approving,
        timepoint,
        multisig,
        callHash,
      );
}

/// A multisig operation has been executed.
class MultisigExecuted extends Event {
  const MultisigExecuted({
    required this.approving,
    required this.timepoint,
    required this.multisig,
    required this.callHash,
    required this.result,
  });

  factory MultisigExecuted._decode(_i1.Input input) {
    return MultisigExecuted(
      approving: const _i1.U8ArrayCodec(32).decode(input),
      timepoint: _i4.Timepoint.codec.decode(input),
      multisig: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
      result: const _i1.ResultCodec<dynamic, _i5.DispatchError>(
        _i1.NullCodec.codec,
        _i5.DispatchError.codec,
      ).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 approving;

  /// Timepoint<BlockNumberFor<T>>
  final _i4.Timepoint timepoint;

  /// T::AccountId
  final _i3.AccountId32 multisig;

  /// CallHash
  final List<int> callHash;

  /// DispatchResult
  final _i1.Result<dynamic, _i5.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MultisigExecuted': {
          'approving': approving.toList(),
          'timepoint': timepoint.toJson(),
          'multisig': multisig.toList(),
          'callHash': callHash.toList(),
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(approving);
    size = size + _i4.Timepoint.codec.sizeHint(timepoint);
    size = size + const _i3.AccountId32Codec().sizeHint(multisig);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    size = size +
        const _i1.ResultCodec<dynamic, _i5.DispatchError>(
          _i1.NullCodec.codec,
          _i5.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      approving,
      output,
    );
    _i4.Timepoint.codec.encodeTo(
      timepoint,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      multisig,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      callHash,
      output,
    );
    const _i1.ResultCodec<dynamic, _i5.DispatchError>(
      _i1.NullCodec.codec,
      _i5.DispatchError.codec,
    ).encodeTo(
      result,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MultisigExecuted &&
          _i6.listsEqual(
            other.approving,
            approving,
          ) &&
          other.timepoint == timepoint &&
          _i6.listsEqual(
            other.multisig,
            multisig,
          ) &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          ) &&
          other.result == result;

  @override
  int get hashCode => Object.hash(
        approving,
        timepoint,
        multisig,
        callHash,
        result,
      );
}

/// A multisig operation has been cancelled.
class MultisigCancelled extends Event {
  const MultisigCancelled({
    required this.cancelling,
    required this.timepoint,
    required this.multisig,
    required this.callHash,
  });

  factory MultisigCancelled._decode(_i1.Input input) {
    return MultisigCancelled(
      cancelling: const _i1.U8ArrayCodec(32).decode(input),
      timepoint: _i4.Timepoint.codec.decode(input),
      multisig: const _i1.U8ArrayCodec(32).decode(input),
      callHash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 cancelling;

  /// Timepoint<BlockNumberFor<T>>
  final _i4.Timepoint timepoint;

  /// T::AccountId
  final _i3.AccountId32 multisig;

  /// CallHash
  final List<int> callHash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MultisigCancelled': {
          'cancelling': cancelling.toList(),
          'timepoint': timepoint.toJson(),
          'multisig': multisig.toList(),
          'callHash': callHash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(cancelling);
    size = size + _i4.Timepoint.codec.sizeHint(timepoint);
    size = size + const _i3.AccountId32Codec().sizeHint(multisig);
    size = size + const _i1.U8ArrayCodec(32).sizeHint(callHash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      cancelling,
      output,
    );
    _i4.Timepoint.codec.encodeTo(
      timepoint,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      multisig,
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
      other is MultisigCancelled &&
          _i6.listsEqual(
            other.cancelling,
            cancelling,
          ) &&
          other.timepoint == timepoint &&
          _i6.listsEqual(
            other.multisig,
            multisig,
          ) &&
          _i6.listsEqual(
            other.callHash,
            callHash,
          );

  @override
  int get hashCode => Object.hash(
        cancelling,
        timepoint,
        multisig,
        callHash,
      );
}
