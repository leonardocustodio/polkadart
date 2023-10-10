// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i4;

import '../../sp_core/crypto/account_id32.dart' as _i3;

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

  Map<String, Map<String, dynamic>> toJson();
}

class $Event {
  const $Event();

  IdentitySet identitySet({required _i3.AccountId32 who}) {
    return IdentitySet(who: who);
  }

  IdentityCleared identityCleared({
    required _i3.AccountId32 who,
    required BigInt deposit,
  }) {
    return IdentityCleared(
      who: who,
      deposit: deposit,
    );
  }

  IdentityKilled identityKilled({
    required _i3.AccountId32 who,
    required BigInt deposit,
  }) {
    return IdentityKilled(
      who: who,
      deposit: deposit,
    );
  }

  JudgementRequested judgementRequested({
    required _i3.AccountId32 who,
    required int registrarIndex,
  }) {
    return JudgementRequested(
      who: who,
      registrarIndex: registrarIndex,
    );
  }

  JudgementUnrequested judgementUnrequested({
    required _i3.AccountId32 who,
    required int registrarIndex,
  }) {
    return JudgementUnrequested(
      who: who,
      registrarIndex: registrarIndex,
    );
  }

  JudgementGiven judgementGiven({
    required _i3.AccountId32 target,
    required int registrarIndex,
  }) {
    return JudgementGiven(
      target: target,
      registrarIndex: registrarIndex,
    );
  }

  RegistrarAdded registrarAdded({required int registrarIndex}) {
    return RegistrarAdded(registrarIndex: registrarIndex);
  }

  SubIdentityAdded subIdentityAdded({
    required _i3.AccountId32 sub,
    required _i3.AccountId32 main,
    required BigInt deposit,
  }) {
    return SubIdentityAdded(
      sub: sub,
      main: main,
      deposit: deposit,
    );
  }

  SubIdentityRemoved subIdentityRemoved({
    required _i3.AccountId32 sub,
    required _i3.AccountId32 main,
    required BigInt deposit,
  }) {
    return SubIdentityRemoved(
      sub: sub,
      main: main,
      deposit: deposit,
    );
  }

  SubIdentityRevoked subIdentityRevoked({
    required _i3.AccountId32 sub,
    required _i3.AccountId32 main,
    required BigInt deposit,
  }) {
    return SubIdentityRevoked(
      sub: sub,
      main: main,
      deposit: deposit,
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
        return IdentitySet._decode(input);
      case 1:
        return IdentityCleared._decode(input);
      case 2:
        return IdentityKilled._decode(input);
      case 3:
        return JudgementRequested._decode(input);
      case 4:
        return JudgementUnrequested._decode(input);
      case 5:
        return JudgementGiven._decode(input);
      case 6:
        return RegistrarAdded._decode(input);
      case 7:
        return SubIdentityAdded._decode(input);
      case 8:
        return SubIdentityRemoved._decode(input);
      case 9:
        return SubIdentityRevoked._decode(input);
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
      case IdentitySet:
        (value as IdentitySet).encodeTo(output);
        break;
      case IdentityCleared:
        (value as IdentityCleared).encodeTo(output);
        break;
      case IdentityKilled:
        (value as IdentityKilled).encodeTo(output);
        break;
      case JudgementRequested:
        (value as JudgementRequested).encodeTo(output);
        break;
      case JudgementUnrequested:
        (value as JudgementUnrequested).encodeTo(output);
        break;
      case JudgementGiven:
        (value as JudgementGiven).encodeTo(output);
        break;
      case RegistrarAdded:
        (value as RegistrarAdded).encodeTo(output);
        break;
      case SubIdentityAdded:
        (value as SubIdentityAdded).encodeTo(output);
        break;
      case SubIdentityRemoved:
        (value as SubIdentityRemoved).encodeTo(output);
        break;
      case SubIdentityRevoked:
        (value as SubIdentityRevoked).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case IdentitySet:
        return (value as IdentitySet)._sizeHint();
      case IdentityCleared:
        return (value as IdentityCleared)._sizeHint();
      case IdentityKilled:
        return (value as IdentityKilled)._sizeHint();
      case JudgementRequested:
        return (value as JudgementRequested)._sizeHint();
      case JudgementUnrequested:
        return (value as JudgementUnrequested)._sizeHint();
      case JudgementGiven:
        return (value as JudgementGiven)._sizeHint();
      case RegistrarAdded:
        return (value as RegistrarAdded)._sizeHint();
      case SubIdentityAdded:
        return (value as SubIdentityAdded)._sizeHint();
      case SubIdentityRemoved:
        return (value as SubIdentityRemoved)._sizeHint();
      case SubIdentityRevoked:
        return (value as SubIdentityRevoked)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A name was set or reset (which will remove all judgements).
class IdentitySet extends Event {
  const IdentitySet({required this.who});

  factory IdentitySet._decode(_i1.Input input) {
    return IdentitySet(who: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'IdentitySet': {'who': who.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
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
      other is IdentitySet &&
          _i4.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => who.hashCode;
}

/// A name was cleared, and the given balance returned.
class IdentityCleared extends Event {
  const IdentityCleared({
    required this.who,
    required this.deposit,
  });

  factory IdentityCleared._decode(_i1.Input input) {
    return IdentityCleared(
      who: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'IdentityCleared': {
          'who': who.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
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
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IdentityCleared &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        who,
        deposit,
      );
}

/// A name was removed and the given balance slashed.
class IdentityKilled extends Event {
  const IdentityKilled({
    required this.who,
    required this.deposit,
  });

  factory IdentityKilled._decode(_i1.Input input) {
    return IdentityKilled(
      who: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'IdentityKilled': {
          'who': who.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
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
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IdentityKilled &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        who,
        deposit,
      );
}

/// A judgement was asked from a registrar.
class JudgementRequested extends Event {
  const JudgementRequested({
    required this.who,
    required this.registrarIndex,
  });

  factory JudgementRequested._decode(_i1.Input input) {
    return JudgementRequested(
      who: const _i1.U8ArrayCodec(32).decode(input),
      registrarIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// RegistrarIndex
  final int registrarIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'JudgementRequested': {
          'who': who.toList(),
          'registrarIndex': registrarIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U32Codec.codec.sizeHint(registrarIndex);
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
    _i1.U32Codec.codec.encodeTo(
      registrarIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is JudgementRequested &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.registrarIndex == registrarIndex;

  @override
  int get hashCode => Object.hash(
        who,
        registrarIndex,
      );
}

/// A judgement request was retracted.
class JudgementUnrequested extends Event {
  const JudgementUnrequested({
    required this.who,
    required this.registrarIndex,
  });

  factory JudgementUnrequested._decode(_i1.Input input) {
    return JudgementUnrequested(
      who: const _i1.U8ArrayCodec(32).decode(input),
      registrarIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 who;

  /// RegistrarIndex
  final int registrarIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'JudgementUnrequested': {
          'who': who.toList(),
          'registrarIndex': registrarIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(who);
    size = size + _i1.U32Codec.codec.sizeHint(registrarIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      who,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      registrarIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is JudgementUnrequested &&
          _i4.listsEqual(
            other.who,
            who,
          ) &&
          other.registrarIndex == registrarIndex;

  @override
  int get hashCode => Object.hash(
        who,
        registrarIndex,
      );
}

/// A judgement was given by a registrar.
class JudgementGiven extends Event {
  const JudgementGiven({
    required this.target,
    required this.registrarIndex,
  });

  factory JudgementGiven._decode(_i1.Input input) {
    return JudgementGiven(
      target: const _i1.U8ArrayCodec(32).decode(input),
      registrarIndex: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 target;

  /// RegistrarIndex
  final int registrarIndex;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'JudgementGiven': {
          'target': target.toList(),
          'registrarIndex': registrarIndex,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(target);
    size = size + _i1.U32Codec.codec.sizeHint(registrarIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      target,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      registrarIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is JudgementGiven &&
          _i4.listsEqual(
            other.target,
            target,
          ) &&
          other.registrarIndex == registrarIndex;

  @override
  int get hashCode => Object.hash(
        target,
        registrarIndex,
      );
}

/// A registrar was added.
class RegistrarAdded extends Event {
  const RegistrarAdded({required this.registrarIndex});

  factory RegistrarAdded._decode(_i1.Input input) {
    return RegistrarAdded(registrarIndex: _i1.U32Codec.codec.decode(input));
  }

  /// RegistrarIndex
  final int registrarIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'RegistrarAdded': {'registrarIndex': registrarIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(registrarIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      registrarIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is RegistrarAdded && other.registrarIndex == registrarIndex;

  @override
  int get hashCode => registrarIndex.hashCode;
}

/// A sub-identity was added to an identity and the deposit paid.
class SubIdentityAdded extends Event {
  const SubIdentityAdded({
    required this.sub,
    required this.main,
    required this.deposit,
  });

  factory SubIdentityAdded._decode(_i1.Input input) {
    return SubIdentityAdded(
      sub: const _i1.U8ArrayCodec(32).decode(input),
      main: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 sub;

  /// T::AccountId
  final _i3.AccountId32 main;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubIdentityAdded': {
          'sub': sub.toList(),
          'main': main.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(sub);
    size = size + const _i3.AccountId32Codec().sizeHint(main);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sub,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      main,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubIdentityAdded &&
          _i4.listsEqual(
            other.sub,
            sub,
          ) &&
          _i4.listsEqual(
            other.main,
            main,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        sub,
        main,
        deposit,
      );
}

/// A sub-identity was removed from an identity and the deposit freed.
class SubIdentityRemoved extends Event {
  const SubIdentityRemoved({
    required this.sub,
    required this.main,
    required this.deposit,
  });

  factory SubIdentityRemoved._decode(_i1.Input input) {
    return SubIdentityRemoved(
      sub: const _i1.U8ArrayCodec(32).decode(input),
      main: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 sub;

  /// T::AccountId
  final _i3.AccountId32 main;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubIdentityRemoved': {
          'sub': sub.toList(),
          'main': main.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(sub);
    size = size + const _i3.AccountId32Codec().sizeHint(main);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sub,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      main,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubIdentityRemoved &&
          _i4.listsEqual(
            other.sub,
            sub,
          ) &&
          _i4.listsEqual(
            other.main,
            main,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        sub,
        main,
        deposit,
      );
}

/// A sub-identity was cleared, and the given deposit repatriated from the
/// main identity account to the sub-identity account.
class SubIdentityRevoked extends Event {
  const SubIdentityRevoked({
    required this.sub,
    required this.main,
    required this.deposit,
  });

  factory SubIdentityRevoked._decode(_i1.Input input) {
    return SubIdentityRevoked(
      sub: const _i1.U8ArrayCodec(32).decode(input),
      main: const _i1.U8ArrayCodec(32).decode(input),
      deposit: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 sub;

  /// T::AccountId
  final _i3.AccountId32 main;

  /// BalanceOf<T>
  final BigInt deposit;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SubIdentityRevoked': {
          'sub': sub.toList(),
          'main': main.toList(),
          'deposit': deposit,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(sub);
    size = size + const _i3.AccountId32Codec().sizeHint(main);
    size = size + _i1.U128Codec.codec.sizeHint(deposit);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      sub,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      main,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deposit,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SubIdentityRevoked &&
          _i4.listsEqual(
            other.sub,
            sub,
          ) &&
          _i4.listsEqual(
            other.main,
            main,
          ) &&
          other.deposit == deposit;

  @override
  int get hashCode => Object.hash(
        sub,
        main,
        deposit,
      );
}
