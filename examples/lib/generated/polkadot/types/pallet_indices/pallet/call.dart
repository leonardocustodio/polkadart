// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import '../../sp_runtime/multiaddress/multi_address.dart' as _i3;

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

  Claim claim({required int index}) {
    return Claim(index: index);
  }

  Transfer transfer({
    required _i3.MultiAddress new_,
    required int index,
  }) {
    return Transfer(
      new_: new_,
      index: index,
    );
  }

  Free free({required int index}) {
    return Free(index: index);
  }

  ForceTransfer forceTransfer({
    required _i3.MultiAddress new_,
    required int index,
    required bool freeze,
  }) {
    return ForceTransfer(
      new_: new_,
      index: index,
      freeze: freeze,
    );
  }

  Freeze freeze({required int index}) {
    return Freeze(index: index);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Claim._decode(input);
      case 1:
        return Transfer._decode(input);
      case 2:
        return Free._decode(input);
      case 3:
        return ForceTransfer._decode(input);
      case 4:
        return Freeze._decode(input);
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
      case Claim:
        (value as Claim).encodeTo(output);
        break;
      case Transfer:
        (value as Transfer).encodeTo(output);
        break;
      case Free:
        (value as Free).encodeTo(output);
        break;
      case ForceTransfer:
        (value as ForceTransfer).encodeTo(output);
        break;
      case Freeze:
        (value as Freeze).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Claim:
        return (value as Claim)._sizeHint();
      case Transfer:
        return (value as Transfer)._sizeHint();
      case Free:
        return (value as Free)._sizeHint();
      case ForceTransfer:
        return (value as ForceTransfer)._sizeHint();
      case Freeze:
        return (value as Freeze)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Assign an previously unassigned index.
///
/// Payment: `Deposit` is reserved from the sender account.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `index`: the index to be claimed. This must not be in use.
///
/// Emits `IndexAssigned` if successful.
///
/// ## Complexity
/// - `O(1)`.
class Claim extends Call {
  const Claim({required this.index});

  factory Claim._decode(_i1.Input input) {
    return Claim(index: _i1.U32Codec.codec.decode(input));
  }

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'claim': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Claim && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Assign an index already owned by the sender to another account. The balance reservation
/// is effectively transferred to the new account.
///
/// The dispatch origin for this call must be _Signed_.
///
/// - `index`: the index to be re-assigned. This must be owned by the sender.
/// - `new`: the new owner of the index. This function is a no-op if it is equal to sender.
///
/// Emits `IndexAssigned` if successful.
///
/// ## Complexity
/// - `O(1)`.
class Transfer extends Call {
  const Transfer({
    required this.new_,
    required this.index,
  });

  factory Transfer._decode(_i1.Input input) {
    return Transfer(
      new_: _i3.MultiAddress.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress new_;

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'transfer': {
          'new': new_.toJson(),
          'index': index,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(new_);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      new_,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Transfer && other.new_ == new_ && other.index == index;

  @override
  int get hashCode => Object.hash(
        new_,
        index,
      );
}

/// Free up an index owned by the sender.
///
/// Payment: Any previous deposit placed for the index is unreserved in the sender account.
///
/// The dispatch origin for this call must be _Signed_ and the sender must own the index.
///
/// - `index`: the index to be freed. This must be owned by the sender.
///
/// Emits `IndexFreed` if successful.
///
/// ## Complexity
/// - `O(1)`.
class Free extends Call {
  const Free({required this.index});

  factory Free._decode(_i1.Input input) {
    return Free(index: _i1.U32Codec.codec.decode(input));
  }

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'free': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Free && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// Force an index to an account. This doesn't require a deposit. If the index is already
/// held, then any deposit is reimbursed to its current owner.
///
/// The dispatch origin for this call must be _Root_.
///
/// - `index`: the index to be (re-)assigned.
/// - `new`: the new owner of the index. This function is a no-op if it is equal to sender.
/// - `freeze`: if set to `true`, will freeze the index so it cannot be transferred.
///
/// Emits `IndexAssigned` if successful.
///
/// ## Complexity
/// - `O(1)`.
class ForceTransfer extends Call {
  const ForceTransfer({
    required this.new_,
    required this.index,
    required this.freeze,
  });

  factory ForceTransfer._decode(_i1.Input input) {
    return ForceTransfer(
      new_: _i3.MultiAddress.codec.decode(input),
      index: _i1.U32Codec.codec.decode(input),
      freeze: _i1.BoolCodec.codec.decode(input),
    );
  }

  /// AccountIdLookupOf<T>
  final _i3.MultiAddress new_;

  /// T::AccountIndex
  final int index;

  /// bool
  final bool freeze;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_transfer': {
          'new': new_.toJson(),
          'index': index,
          'freeze': freeze,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.MultiAddress.codec.sizeHint(new_);
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.BoolCodec.codec.sizeHint(freeze);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i3.MultiAddress.codec.encodeTo(
      new_,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i1.BoolCodec.codec.encodeTo(
      freeze,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceTransfer &&
          other.new_ == new_ &&
          other.index == index &&
          other.freeze == freeze;

  @override
  int get hashCode => Object.hash(
        new_,
        index,
        freeze,
      );
}

/// Freeze an index so it will always point to the sender account. This consumes the
/// deposit.
///
/// The dispatch origin for this call must be _Signed_ and the signing account must have a
/// non-frozen account `index`.
///
/// - `index`: the index to be frozen in place.
///
/// Emits `IndexFrozen` if successful.
///
/// ## Complexity
/// - `O(1)`.
class Freeze extends Call {
  const Freeze({required this.index});

  factory Freeze._decode(_i1.Input input) {
    return Freeze(index: _i1.U32Codec.codec.decode(input));
  }

  /// T::AccountIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'freeze': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Freeze && other.index == index;

  @override
  int get hashCode => index.hashCode;
}
