// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../../polkadot_parachain_primitives/primitives/id.dart' as _i3;
import '../../../sp_core/crypto/account_id32.dart' as _i4;
import '../../../sp_runtime/dispatch_error.dart' as _i5;

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

  Created created({required _i3.Id paraId}) {
    return Created(paraId: paraId);
  }

  Contributed contributed({
    required _i4.AccountId32 who,
    required _i3.Id fundIndex,
    required BigInt amount,
  }) {
    return Contributed(
      who: who,
      fundIndex: fundIndex,
      amount: amount,
    );
  }

  Withdrew withdrew({
    required _i4.AccountId32 who,
    required _i3.Id fundIndex,
    required BigInt amount,
  }) {
    return Withdrew(
      who: who,
      fundIndex: fundIndex,
      amount: amount,
    );
  }

  PartiallyRefunded partiallyRefunded({required _i3.Id paraId}) {
    return PartiallyRefunded(paraId: paraId);
  }

  AllRefunded allRefunded({required _i3.Id paraId}) {
    return AllRefunded(paraId: paraId);
  }

  Dissolved dissolved({required _i3.Id paraId}) {
    return Dissolved(paraId: paraId);
  }

  HandleBidResult handleBidResult({
    required _i3.Id paraId,
    required _i1.Result<dynamic, _i5.DispatchError> result,
  }) {
    return HandleBidResult(
      paraId: paraId,
      result: result,
    );
  }

  Edited edited({required _i3.Id paraId}) {
    return Edited(paraId: paraId);
  }

  MemoUpdated memoUpdated({
    required _i4.AccountId32 who,
    required _i3.Id paraId,
    required List<int> memo,
  }) {
    return MemoUpdated(
      who: who,
      paraId: paraId,
      memo: memo,
    );
  }

  AddedToNewRaise addedToNewRaise({required _i3.Id paraId}) {
    return AddedToNewRaise(paraId: paraId);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Created._decode(input);
      case 1:
        return Contributed._decode(input);
      case 2:
        return Withdrew._decode(input);
      case 3:
        return PartiallyRefunded._decode(input);
      case 4:
        return AllRefunded._decode(input);
      case 5:
        return Dissolved._decode(input);
      case 6:
        return HandleBidResult._decode(input);
      case 7:
        return Edited._decode(input);
      case 8:
        return MemoUpdated._decode(input);
      case 9:
        return AddedToNewRaise._decode(input);
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
      case Created:
        (value as Created).encodeTo(output);
        break;
      case Contributed:
        (value as Contributed).encodeTo(output);
        break;
      case Withdrew:
        (value as Withdrew).encodeTo(output);
        break;
      case PartiallyRefunded:
        (value as PartiallyRefunded).encodeTo(output);
        break;
      case AllRefunded:
        (value as AllRefunded).encodeTo(output);
        break;
      case Dissolved:
        (value as Dissolved).encodeTo(output);
        break;
      case HandleBidResult:
        (value as HandleBidResult).encodeTo(output);
        break;
      case Edited:
        (value as Edited).encodeTo(output);
        break;
      case MemoUpdated:
        (value as MemoUpdated).encodeTo(output);
        break;
      case AddedToNewRaise:
        (value as AddedToNewRaise).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Created:
        return (value as Created)._sizeHint();
      case Contributed:
        return (value as Contributed)._sizeHint();
      case Withdrew:
        return (value as Withdrew)._sizeHint();
      case PartiallyRefunded:
        return (value as PartiallyRefunded)._sizeHint();
      case AllRefunded:
        return (value as AllRefunded)._sizeHint();
      case Dissolved:
        return (value as Dissolved)._sizeHint();
      case HandleBidResult:
        return (value as HandleBidResult)._sizeHint();
      case Edited:
        return (value as Edited)._sizeHint();
      case MemoUpdated:
        return (value as MemoUpdated)._sizeHint();
      case AddedToNewRaise:
        return (value as AddedToNewRaise)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Create a new crowdloaning campaign.
class Created extends Event {
  const Created({required this.paraId});

  factory Created._decode(_i1.Input input) {
    return Created(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Created': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Created && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

/// Contributed to a crowd sale.
class Contributed extends Event {
  const Contributed({
    required this.who,
    required this.fundIndex,
    required this.amount,
  });

  factory Contributed._decode(_i1.Input input) {
    return Contributed(
      who: const _i1.U8ArrayCodec(32).decode(input),
      fundIndex: _i1.U32Codec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// ParaId
  final _i3.Id fundIndex;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Contributed': {
          'who': who.toList(),
          'fundIndex': fundIndex,
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + const _i3.IdCodec().sizeHint(fundIndex);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      fundIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Contributed &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.fundIndex == fundIndex &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        fundIndex,
        amount,
      );
}

/// Withdrew full balance of a contributor.
class Withdrew extends Event {
  const Withdrew({
    required this.who,
    required this.fundIndex,
    required this.amount,
  });

  factory Withdrew._decode(_i1.Input input) {
    return Withdrew(
      who: const _i1.U8ArrayCodec(32).decode(input),
      fundIndex: _i1.U32Codec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// ParaId
  final _i3.Id fundIndex;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Withdrew': {
          'who': who.toList(),
          'fundIndex': fundIndex,
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + const _i3.IdCodec().sizeHint(fundIndex);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      fundIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Withdrew &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.fundIndex == fundIndex &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        fundIndex,
        amount,
      );
}

/// The loans in a fund have been partially dissolved, i.e. there are some left
/// over child keys that still need to be killed.
class PartiallyRefunded extends Event {
  const PartiallyRefunded({required this.paraId});

  factory PartiallyRefunded._decode(_i1.Input input) {
    return PartiallyRefunded(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'PartiallyRefunded': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PartiallyRefunded && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

/// All loans in a fund have been refunded.
class AllRefunded extends Event {
  const AllRefunded({required this.paraId});

  factory AllRefunded._decode(_i1.Input input) {
    return AllRefunded(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AllRefunded': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AllRefunded && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

/// Fund is dissolved.
class Dissolved extends Event {
  const Dissolved({required this.paraId});

  factory Dissolved._decode(_i1.Input input) {
    return Dissolved(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Dissolved': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Dissolved && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

/// The result of trying to submit a new bid to the Slots pallet.
class HandleBidResult extends Event {
  const HandleBidResult({
    required this.paraId,
    required this.result,
  });

  factory HandleBidResult._decode(_i1.Input input) {
    return HandleBidResult(
      paraId: _i1.U32Codec.codec.decode(input),
      result: const _i1.ResultCodec<dynamic, _i5.DispatchError>(
        _i1.NullCodec.codec,
        _i5.DispatchError.codec,
      ).decode(input),
    );
  }

  /// ParaId
  final _i3.Id paraId;

  /// DispatchResult
  final _i1.Result<dynamic, _i5.DispatchError> result;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'HandleBidResult': {
          'paraId': paraId,
          'result': result.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size +
        const _i1.ResultCodec<dynamic, _i5.DispatchError>(
          _i1.NullCodec.codec,
          _i5.DispatchError.codec,
        ).sizeHint(result);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
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
      other is HandleBidResult &&
          other.paraId == paraId &&
          other.result == result;

  @override
  int get hashCode => Object.hash(
        paraId,
        result,
      );
}

/// The configuration to a crowdloan has been edited.
class Edited extends Event {
  const Edited({required this.paraId});

  factory Edited._decode(_i1.Input input) {
    return Edited(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Edited': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Edited && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}

/// A memo has been updated.
class MemoUpdated extends Event {
  const MemoUpdated({
    required this.who,
    required this.paraId,
    required this.memo,
  });

  factory MemoUpdated._decode(_i1.Input input) {
    return MemoUpdated(
      who: const _i1.U8ArrayCodec(32).decode(input),
      paraId: _i1.U32Codec.codec.decode(input),
      memo: _i1.U8SequenceCodec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i4.AccountId32 who;

  /// ParaId
  final _i3.Id paraId;

  /// Vec<u8>
  final List<int> memo;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MemoUpdated': {
          'who': who.toList(),
          'paraId': paraId,
          'memo': memo,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + const _i3.IdCodec().sizeHint(paraId);
    size = size + _i1.U8SequenceCodec.codec.sizeHint(memo);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
    _i1.U8SequenceCodec.codec.encodeTo(
      memo,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MemoUpdated &&
          _i6.listsEqual(
            other.who,
            who,
          ) &&
          other.paraId == paraId &&
          _i6.listsEqual(
            other.memo,
            memo,
          );

  @override
  int get hashCode => Object.hash(
        who,
        paraId,
        memo,
      );
}

/// A parachain has been moved to `NewRaise`
class AddedToNewRaise extends Event {
  const AddedToNewRaise({required this.paraId});

  factory AddedToNewRaise._decode(_i1.Input input) {
    return AddedToNewRaise(paraId: _i1.U32Codec.codec.decode(input));
  }

  /// ParaId
  final _i3.Id paraId;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AddedToNewRaise': {'paraId': paraId}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.IdCodec().sizeHint(paraId);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      paraId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AddedToNewRaise && other.paraId == paraId;

  @override
  int get hashCode => paraId.hashCode;
}
