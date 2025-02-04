// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i7;

import '../../frame_support/traits/preimages/bounded.dart' as _i3;
import '../../pallet_conviction_voting/types/tally.dart' as _i5;
import '../../primitive_types/h256.dart' as _i6;
import '../../sp_core/crypto/account_id32.dart' as _i4;

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

  Submitted submitted({
    required int index,
    required int track,
    required _i3.Bounded proposal,
  }) {
    return Submitted(
      index: index,
      track: track,
      proposal: proposal,
    );
  }

  DecisionDepositPlaced decisionDepositPlaced({
    required int index,
    required _i4.AccountId32 who,
    required BigInt amount,
  }) {
    return DecisionDepositPlaced(
      index: index,
      who: who,
      amount: amount,
    );
  }

  DecisionDepositRefunded decisionDepositRefunded({
    required int index,
    required _i4.AccountId32 who,
    required BigInt amount,
  }) {
    return DecisionDepositRefunded(
      index: index,
      who: who,
      amount: amount,
    );
  }

  DepositSlashed depositSlashed({
    required _i4.AccountId32 who,
    required BigInt amount,
  }) {
    return DepositSlashed(
      who: who,
      amount: amount,
    );
  }

  DecisionStarted decisionStarted({
    required int index,
    required int track,
    required _i3.Bounded proposal,
    required _i5.Tally tally,
  }) {
    return DecisionStarted(
      index: index,
      track: track,
      proposal: proposal,
      tally: tally,
    );
  }

  ConfirmStarted confirmStarted({required int index}) {
    return ConfirmStarted(index: index);
  }

  ConfirmAborted confirmAborted({required int index}) {
    return ConfirmAborted(index: index);
  }

  Confirmed confirmed({
    required int index,
    required _i5.Tally tally,
  }) {
    return Confirmed(
      index: index,
      tally: tally,
    );
  }

  Approved approved({required int index}) {
    return Approved(index: index);
  }

  Rejected rejected({
    required int index,
    required _i5.Tally tally,
  }) {
    return Rejected(
      index: index,
      tally: tally,
    );
  }

  TimedOut timedOut({
    required int index,
    required _i5.Tally tally,
  }) {
    return TimedOut(
      index: index,
      tally: tally,
    );
  }

  Cancelled cancelled({
    required int index,
    required _i5.Tally tally,
  }) {
    return Cancelled(
      index: index,
      tally: tally,
    );
  }

  Killed killed({
    required int index,
    required _i5.Tally tally,
  }) {
    return Killed(
      index: index,
      tally: tally,
    );
  }

  SubmissionDepositRefunded submissionDepositRefunded({
    required int index,
    required _i4.AccountId32 who,
    required BigInt amount,
  }) {
    return SubmissionDepositRefunded(
      index: index,
      who: who,
      amount: amount,
    );
  }

  MetadataSet metadataSet({
    required int index,
    required _i6.H256 hash,
  }) {
    return MetadataSet(
      index: index,
      hash: hash,
    );
  }

  MetadataCleared metadataCleared({
    required int index,
    required _i6.H256 hash,
  }) {
    return MetadataCleared(
      index: index,
      hash: hash,
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
        return Submitted._decode(input);
      case 1:
        return DecisionDepositPlaced._decode(input);
      case 2:
        return DecisionDepositRefunded._decode(input);
      case 3:
        return DepositSlashed._decode(input);
      case 4:
        return DecisionStarted._decode(input);
      case 5:
        return ConfirmStarted._decode(input);
      case 6:
        return ConfirmAborted._decode(input);
      case 7:
        return Confirmed._decode(input);
      case 8:
        return Approved._decode(input);
      case 9:
        return Rejected._decode(input);
      case 10:
        return TimedOut._decode(input);
      case 11:
        return Cancelled._decode(input);
      case 12:
        return Killed._decode(input);
      case 13:
        return SubmissionDepositRefunded._decode(input);
      case 14:
        return MetadataSet._decode(input);
      case 15:
        return MetadataCleared._decode(input);
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
      case Submitted:
        (value as Submitted).encodeTo(output);
        break;
      case DecisionDepositPlaced:
        (value as DecisionDepositPlaced).encodeTo(output);
        break;
      case DecisionDepositRefunded:
        (value as DecisionDepositRefunded).encodeTo(output);
        break;
      case DepositSlashed:
        (value as DepositSlashed).encodeTo(output);
        break;
      case DecisionStarted:
        (value as DecisionStarted).encodeTo(output);
        break;
      case ConfirmStarted:
        (value as ConfirmStarted).encodeTo(output);
        break;
      case ConfirmAborted:
        (value as ConfirmAborted).encodeTo(output);
        break;
      case Confirmed:
        (value as Confirmed).encodeTo(output);
        break;
      case Approved:
        (value as Approved).encodeTo(output);
        break;
      case Rejected:
        (value as Rejected).encodeTo(output);
        break;
      case TimedOut:
        (value as TimedOut).encodeTo(output);
        break;
      case Cancelled:
        (value as Cancelled).encodeTo(output);
        break;
      case Killed:
        (value as Killed).encodeTo(output);
        break;
      case SubmissionDepositRefunded:
        (value as SubmissionDepositRefunded).encodeTo(output);
        break;
      case MetadataSet:
        (value as MetadataSet).encodeTo(output);
        break;
      case MetadataCleared:
        (value as MetadataCleared).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Submitted:
        return (value as Submitted)._sizeHint();
      case DecisionDepositPlaced:
        return (value as DecisionDepositPlaced)._sizeHint();
      case DecisionDepositRefunded:
        return (value as DecisionDepositRefunded)._sizeHint();
      case DepositSlashed:
        return (value as DepositSlashed)._sizeHint();
      case DecisionStarted:
        return (value as DecisionStarted)._sizeHint();
      case ConfirmStarted:
        return (value as ConfirmStarted)._sizeHint();
      case ConfirmAborted:
        return (value as ConfirmAborted)._sizeHint();
      case Confirmed:
        return (value as Confirmed)._sizeHint();
      case Approved:
        return (value as Approved)._sizeHint();
      case Rejected:
        return (value as Rejected)._sizeHint();
      case TimedOut:
        return (value as TimedOut)._sizeHint();
      case Cancelled:
        return (value as Cancelled)._sizeHint();
      case Killed:
        return (value as Killed)._sizeHint();
      case SubmissionDepositRefunded:
        return (value as SubmissionDepositRefunded)._sizeHint();
      case MetadataSet:
        return (value as MetadataSet)._sizeHint();
      case MetadataCleared:
        return (value as MetadataCleared)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A referendum has been submitted.
class Submitted extends Event {
  const Submitted({
    required this.index,
    required this.track,
    required this.proposal,
  });

  factory Submitted._decode(_i1.Input input) {
    return Submitted(
      index: _i1.U32Codec.codec.decode(input),
      track: _i1.U16Codec.codec.decode(input),
      proposal: _i3.Bounded.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// TrackIdOf<T, I>
  /// The track (and by extension proposal dispatch origin) of this referendum.
  final int track;

  /// BoundedCallOf<T, I>
  /// The proposal for the referendum.
  final _i3.Bounded proposal;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Submitted': {
          'index': index,
          'track': track,
          'proposal': proposal.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U16Codec.codec.sizeHint(track);
    size = size + _i3.Bounded.codec.sizeHint(proposal);
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
    _i1.U16Codec.codec.encodeTo(
      track,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Submitted &&
          other.index == index &&
          other.track == track &&
          other.proposal == proposal;

  @override
  int get hashCode => Object.hash(
        index,
        track,
        proposal,
      );
}

/// The decision deposit has been placed.
class DecisionDepositPlaced extends Event {
  const DecisionDepositPlaced({
    required this.index,
    required this.who,
    required this.amount,
  });

  factory DecisionDepositPlaced._decode(_i1.Input input) {
    return DecisionDepositPlaced(
      index: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::AccountId
  /// The account who placed the deposit.
  final _i4.AccountId32 who;

  /// BalanceOf<T, I>
  /// The amount placed by the account.
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DecisionDepositPlaced': {
          'index': index,
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
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
      other is DecisionDepositPlaced &&
          other.index == index &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        index,
        who,
        amount,
      );
}

/// The decision deposit has been refunded.
class DecisionDepositRefunded extends Event {
  const DecisionDepositRefunded({
    required this.index,
    required this.who,
    required this.amount,
  });

  factory DecisionDepositRefunded._decode(_i1.Input input) {
    return DecisionDepositRefunded(
      index: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::AccountId
  /// The account who placed the deposit.
  final _i4.AccountId32 who;

  /// BalanceOf<T, I>
  /// The amount placed by the account.
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DecisionDepositRefunded': {
          'index': index,
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
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
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
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
      other is DecisionDepositRefunded &&
          other.index == index &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        index,
        who,
        amount,
      );
}

/// A deposit has been slashed.
class DepositSlashed extends Event {
  const DepositSlashed({
    required this.who,
    required this.amount,
  });

  factory DepositSlashed._decode(_i1.Input input) {
    return DepositSlashed(
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  /// The account who placed the deposit.
  final _i4.AccountId32 who;

  /// BalanceOf<T, I>
  /// The amount placed by the account.
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DepositSlashed': {
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
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
      other is DepositSlashed &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        who,
        amount,
      );
}

/// A referendum has moved into the deciding phase.
class DecisionStarted extends Event {
  const DecisionStarted({
    required this.index,
    required this.track,
    required this.proposal,
    required this.tally,
  });

  factory DecisionStarted._decode(_i1.Input input) {
    return DecisionStarted(
      index: _i1.U32Codec.codec.decode(input),
      track: _i1.U16Codec.codec.decode(input),
      proposal: _i3.Bounded.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// TrackIdOf<T, I>
  /// The track (and by extension proposal dispatch origin) of this referendum.
  final int track;

  /// BoundedCallOf<T, I>
  /// The proposal for the referendum.
  final _i3.Bounded proposal;

  /// T::Tally
  /// The current tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'DecisionStarted': {
          'index': index,
          'track': track,
          'proposal': proposal.toJson(),
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U16Codec.codec.sizeHint(track);
    size = size + _i3.Bounded.codec.sizeHint(proposal);
    size = size + _i5.Tally.codec.sizeHint(tally);
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
    _i1.U16Codec.codec.encodeTo(
      track,
      output,
    );
    _i3.Bounded.codec.encodeTo(
      proposal,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is DecisionStarted &&
          other.index == index &&
          other.track == track &&
          other.proposal == proposal &&
          other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        track,
        proposal,
        tally,
      );
}

class ConfirmStarted extends Event {
  const ConfirmStarted({required this.index});

  factory ConfirmStarted._decode(_i1.Input input) {
    return ConfirmStarted(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ConfirmStarted': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
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
      other is ConfirmStarted && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

class ConfirmAborted extends Event {
  const ConfirmAborted({required this.index});

  factory ConfirmAborted._decode(_i1.Input input) {
    return ConfirmAborted(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ConfirmAborted': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
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
      other is ConfirmAborted && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A referendum has ended its confirmation phase and is ready for approval.
class Confirmed extends Event {
  const Confirmed({
    required this.index,
    required this.tally,
  });

  factory Confirmed._decode(_i1.Input input) {
    return Confirmed(
      index: _i1.U32Codec.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Tally
  /// The final tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Confirmed': {
          'index': index,
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i5.Tally.codec.sizeHint(tally);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Confirmed && other.index == index && other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        tally,
      );
}

/// A referendum has been approved and its proposal has been scheduled.
class Approved extends Event {
  const Approved({required this.index});

  factory Approved._decode(_i1.Input input) {
    return Approved(index: _i1.U32Codec.codec.decode(input));
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Approved': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
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
      other is Approved && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A proposal has been rejected by referendum.
class Rejected extends Event {
  const Rejected({
    required this.index,
    required this.tally,
  });

  factory Rejected._decode(_i1.Input input) {
    return Rejected(
      index: _i1.U32Codec.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Tally
  /// The final tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Rejected': {
          'index': index,
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i5.Tally.codec.sizeHint(tally);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rejected && other.index == index && other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        tally,
      );
}

/// A referendum has been timed out without being decided.
class TimedOut extends Event {
  const TimedOut({
    required this.index,
    required this.tally,
  });

  factory TimedOut._decode(_i1.Input input) {
    return TimedOut(
      index: _i1.U32Codec.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Tally
  /// The final tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'TimedOut': {
          'index': index,
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i5.Tally.codec.sizeHint(tally);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is TimedOut && other.index == index && other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        tally,
      );
}

/// A referendum has been cancelled.
class Cancelled extends Event {
  const Cancelled({
    required this.index,
    required this.tally,
  });

  factory Cancelled._decode(_i1.Input input) {
    return Cancelled(
      index: _i1.U32Codec.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Tally
  /// The final tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Cancelled': {
          'index': index,
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i5.Tally.codec.sizeHint(tally);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Cancelled && other.index == index && other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        tally,
      );
}

/// A referendum has been killed.
class Killed extends Event {
  const Killed({
    required this.index,
    required this.tally,
  });

  factory Killed._decode(_i1.Input input) {
    return Killed(
      index: _i1.U32Codec.codec.decode(input),
      tally: _i5.Tally.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Tally
  /// The final tally of votes in this referendum.
  final _i5.Tally tally;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Killed': {
          'index': index,
          'tally': tally.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i5.Tally.codec.sizeHint(tally);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    _i5.Tally.codec.encodeTo(
      tally,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Killed && other.index == index && other.tally == tally;

  @override
  int get hashCode => Object.hash(
        index,
        tally,
      );
}

/// The submission deposit has been refunded.
class SubmissionDepositRefunded extends Event {
  const SubmissionDepositRefunded({
    required this.index,
    required this.who,
    required this.amount,
  });

  factory SubmissionDepositRefunded._decode(_i1.Input input) {
    return SubmissionDepositRefunded(
      index: _i1.U32Codec.codec.decode(input),
      who: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::AccountId
  /// The account who placed the deposit.
  final _i4.AccountId32 who;

  /// BalanceOf<T, I>
  /// The amount placed by the account.
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubmissionDepositRefunded': {
          'index': index,
          'who': who.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i4.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
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
      other is SubmissionDepositRefunded &&
          other.index == index &&
          _i7.listsEqual(
            other.who,
            who,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        index,
        who,
        amount,
      );
}

/// Metadata for a referendum has been set.
class MetadataSet extends Event {
  const MetadataSet({
    required this.index,
    required this.hash,
  });

  factory MetadataSet._decode(_i1.Input input) {
    return MetadataSet(
      index: _i1.U32Codec.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Hash
  /// Preimage hash.
  final _i6.H256 hash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataSet': {
          'index': index,
          'hash': hash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i6.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
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
      other is MetadataSet &&
          other.index == index &&
          _i7.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => Object.hash(
        index,
        hash,
      );
}

/// Metadata for a referendum has been cleared.
class MetadataCleared extends Event {
  const MetadataCleared({
    required this.index,
    required this.hash,
  });

  factory MetadataCleared._decode(_i1.Input input) {
    return MetadataCleared(
      index: _i1.U32Codec.codec.decode(input),
      hash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ReferendumIndex
  /// Index of the referendum.
  final int index;

  /// T::Hash
  /// Preimage hash.
  final _i6.H256 hash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'MetadataCleared': {
          'index': index,
          'hash': hash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + const _i6.H256Codec().sizeHint(hash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      index,
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
      other is MetadataCleared &&
          other.index == index &&
          _i7.listsEqual(
            other.hash,
            hash,
          );

  @override
  int get hashCode => Object.hash(
        index,
        hash,
      );
}
