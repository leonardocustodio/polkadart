// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i5;

import '../../sp_core/crypto/account_id32.dart' as _i4;
import '../../tuples.dart' as _i3;

///
///			The [event](https://docs.substrate.io/main-docs/build/events-errors/) emitted
///			by this pallet.
///
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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  NewTerm newTerm(
      {required List<_i3.Tuple2<_i4.AccountId32, BigInt>> newMembers}) {
    return NewTerm(newMembers: newMembers);
  }

  EmptyTerm emptyTerm() {
    return EmptyTerm();
  }

  ElectionError electionError() {
    return ElectionError();
  }

  MemberKicked memberKicked({required _i4.AccountId32 member}) {
    return MemberKicked(member: member);
  }

  Renounced renounced({required _i4.AccountId32 candidate}) {
    return Renounced(candidate: candidate);
  }

  CandidateSlashed candidateSlashed({
    required _i4.AccountId32 candidate,
    required BigInt amount,
  }) {
    return CandidateSlashed(
      candidate: candidate,
      amount: amount,
    );
  }

  SeatHolderSlashed seatHolderSlashed({
    required _i4.AccountId32 seatHolder,
    required BigInt amount,
  }) {
    return SeatHolderSlashed(
      seatHolder: seatHolder,
      amount: amount,
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
        return NewTerm._decode(input);
      case 1:
        return const EmptyTerm();
      case 2:
        return const ElectionError();
      case 3:
        return MemberKicked._decode(input);
      case 4:
        return Renounced._decode(input);
      case 5:
        return CandidateSlashed._decode(input);
      case 6:
        return SeatHolderSlashed._decode(input);
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
      case NewTerm:
        (value as NewTerm).encodeTo(output);
        break;
      case EmptyTerm:
        (value as EmptyTerm).encodeTo(output);
        break;
      case ElectionError:
        (value as ElectionError).encodeTo(output);
        break;
      case MemberKicked:
        (value as MemberKicked).encodeTo(output);
        break;
      case Renounced:
        (value as Renounced).encodeTo(output);
        break;
      case CandidateSlashed:
        (value as CandidateSlashed).encodeTo(output);
        break;
      case SeatHolderSlashed:
        (value as SeatHolderSlashed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case NewTerm:
        return (value as NewTerm)._sizeHint();
      case EmptyTerm:
        return 1;
      case ElectionError:
        return 1;
      case MemberKicked:
        return (value as MemberKicked)._sizeHint();
      case Renounced:
        return (value as Renounced)._sizeHint();
      case CandidateSlashed:
        return (value as CandidateSlashed)._sizeHint();
      case SeatHolderSlashed:
        return (value as SeatHolderSlashed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A new term with new_members. This indicates that enough candidates existed to run
/// the election, not that enough have has been elected. The inner value must be examined
/// for this purpose. A `NewTerm(\[\])` indicates that some candidates got their bond
/// slashed and none were elected, whilst `EmptyTerm` means that no candidates existed to
/// begin with.
class NewTerm extends Event {
  const NewTerm({required this.newMembers});

  factory NewTerm._decode(_i1.Input input) {
    return NewTerm(
        newMembers:
            const _i1.SequenceCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
                _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
      _i4.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).decode(input));
  }

  /// Vec<(<T as frame_system::Config>::AccountId, BalanceOf<T>)>
  final List<_i3.Tuple2<_i4.AccountId32, BigInt>> newMembers;

  @override
  Map<String, Map<String, List<List<dynamic>>>> toJson() => {
        'NewTerm': {
          'newMembers': newMembers
              .map((value) => [
                    value.value0.toList(),
                    value.value1,
                  ])
              .toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
            _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
          _i4.AccountId32Codec(),
          _i1.U128Codec.codec,
        )).sizeHint(newMembers);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.SequenceCodec<_i3.Tuple2<_i4.AccountId32, BigInt>>(
        _i3.Tuple2Codec<_i4.AccountId32, BigInt>(
      _i4.AccountId32Codec(),
      _i1.U128Codec.codec,
    )).encodeTo(
      newMembers,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is NewTerm &&
          _i5.listsEqual(
            other.newMembers,
            newMembers,
          );

  @override
  int get hashCode => newMembers.hashCode;
}

/// No (or not enough) candidates existed for this round. This is different from
/// `NewTerm(\[\])`. See the description of `NewTerm`.
class EmptyTerm extends Event {
  const EmptyTerm();

  @override
  Map<String, dynamic> toJson() => {'EmptyTerm': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is EmptyTerm;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Internal error happened while trying to perform election.
class ElectionError extends Event {
  const ElectionError();

  @override
  Map<String, dynamic> toJson() => {'ElectionError': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ElectionError;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A member has been removed. This should always be followed by either `NewTerm` or
/// `EmptyTerm`.
class MemberKicked extends Event {
  const MemberKicked({required this.member});

  factory MemberKicked._decode(_i1.Input input) {
    return MemberKicked(member: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 member;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'MemberKicked': {'member': member.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(member);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      member,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is MemberKicked &&
          _i5.listsEqual(
            other.member,
            member,
          );

  @override
  int get hashCode => member.hashCode;
}

/// Someone has renounced their candidacy.
class Renounced extends Event {
  const Renounced({required this.candidate});

  factory Renounced._decode(_i1.Input input) {
    return Renounced(candidate: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 candidate;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Renounced': {'candidate': candidate.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(candidate);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      candidate,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Renounced &&
          _i5.listsEqual(
            other.candidate,
            candidate,
          );

  @override
  int get hashCode => candidate.hashCode;
}

/// A candidate was slashed by amount due to failing to obtain a seat as member or
/// runner-up.
///
/// Note that old members and runners-up are also candidates.
class CandidateSlashed extends Event {
  const CandidateSlashed({
    required this.candidate,
    required this.amount,
  });

  factory CandidateSlashed._decode(_i1.Input input) {
    return CandidateSlashed(
      candidate: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 candidate;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'CandidateSlashed': {
          'candidate': candidate.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(candidate);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      candidate,
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
      other is CandidateSlashed &&
          _i5.listsEqual(
            other.candidate,
            candidate,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        candidate,
        amount,
      );
}

/// A seat holder was slashed by amount by being forcefully removed from the set.
class SeatHolderSlashed extends Event {
  const SeatHolderSlashed({
    required this.seatHolder,
    required this.amount,
  });

  factory SeatHolderSlashed._decode(_i1.Input input) {
    return SeatHolderSlashed(
      seatHolder: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// <T as frame_system::Config>::AccountId
  final _i4.AccountId32 seatHolder;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SeatHolderSlashed': {
          'seatHolder': seatHolder.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i4.AccountId32Codec().sizeHint(seatHolder);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      seatHolder,
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
      other is SeatHolderSlashed &&
          _i5.listsEqual(
            other.seatHolder,
            seatHolder,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        seatHolder,
        amount,
      );
}
