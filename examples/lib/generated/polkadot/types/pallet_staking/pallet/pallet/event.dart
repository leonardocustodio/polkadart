// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i8;

import '../../../sp_arithmetic/per_things/perbill.dart' as _i5;
import '../../../sp_core/crypto/account_id32.dart' as _i3;
import '../../forcing.dart' as _i7;
import '../../reward_destination.dart' as _i4;
import '../../validator_prefs.dart' as _i6;

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

  Map<String, dynamic> toJson();
}

class $Event {
  const $Event();

  EraPaid eraPaid({
    required int eraIndex,
    required BigInt validatorPayout,
    required BigInt remainder,
  }) {
    return EraPaid(
      eraIndex: eraIndex,
      validatorPayout: validatorPayout,
      remainder: remainder,
    );
  }

  Rewarded rewarded({
    required _i3.AccountId32 stash,
    required _i4.RewardDestination dest,
    required BigInt amount,
  }) {
    return Rewarded(
      stash: stash,
      dest: dest,
      amount: amount,
    );
  }

  Slashed slashed({
    required _i3.AccountId32 staker,
    required BigInt amount,
  }) {
    return Slashed(
      staker: staker,
      amount: amount,
    );
  }

  SlashReported slashReported({
    required _i3.AccountId32 validator,
    required _i5.Perbill fraction,
    required int slashEra,
  }) {
    return SlashReported(
      validator: validator,
      fraction: fraction,
      slashEra: slashEra,
    );
  }

  OldSlashingReportDiscarded oldSlashingReportDiscarded(
      {required int sessionIndex}) {
    return OldSlashingReportDiscarded(sessionIndex: sessionIndex);
  }

  StakersElected stakersElected() {
    return StakersElected();
  }

  Bonded bonded({
    required _i3.AccountId32 stash,
    required BigInt amount,
  }) {
    return Bonded(
      stash: stash,
      amount: amount,
    );
  }

  Unbonded unbonded({
    required _i3.AccountId32 stash,
    required BigInt amount,
  }) {
    return Unbonded(
      stash: stash,
      amount: amount,
    );
  }

  Withdrawn withdrawn({
    required _i3.AccountId32 stash,
    required BigInt amount,
  }) {
    return Withdrawn(
      stash: stash,
      amount: amount,
    );
  }

  Kicked kicked({
    required _i3.AccountId32 nominator,
    required _i3.AccountId32 stash,
  }) {
    return Kicked(
      nominator: nominator,
      stash: stash,
    );
  }

  StakingElectionFailed stakingElectionFailed() {
    return StakingElectionFailed();
  }

  Chilled chilled({required _i3.AccountId32 stash}) {
    return Chilled(stash: stash);
  }

  PayoutStarted payoutStarted({
    required int eraIndex,
    required _i3.AccountId32 validatorStash,
  }) {
    return PayoutStarted(
      eraIndex: eraIndex,
      validatorStash: validatorStash,
    );
  }

  ValidatorPrefsSet validatorPrefsSet({
    required _i3.AccountId32 stash,
    required _i6.ValidatorPrefs prefs,
  }) {
    return ValidatorPrefsSet(
      stash: stash,
      prefs: prefs,
    );
  }

  SnapshotVotersSizeExceeded snapshotVotersSizeExceeded({required int size}) {
    return SnapshotVotersSizeExceeded(size: size);
  }

  SnapshotTargetsSizeExceeded snapshotTargetsSizeExceeded({required int size}) {
    return SnapshotTargetsSizeExceeded(size: size);
  }

  ForceEra forceEra({required _i7.Forcing mode}) {
    return ForceEra(mode: mode);
  }

  ControllerBatchDeprecated controllerBatchDeprecated({required int failures}) {
    return ControllerBatchDeprecated(failures: failures);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return EraPaid._decode(input);
      case 1:
        return Rewarded._decode(input);
      case 2:
        return Slashed._decode(input);
      case 3:
        return SlashReported._decode(input);
      case 4:
        return OldSlashingReportDiscarded._decode(input);
      case 5:
        return const StakersElected();
      case 6:
        return Bonded._decode(input);
      case 7:
        return Unbonded._decode(input);
      case 8:
        return Withdrawn._decode(input);
      case 9:
        return Kicked._decode(input);
      case 10:
        return const StakingElectionFailed();
      case 11:
        return Chilled._decode(input);
      case 12:
        return PayoutStarted._decode(input);
      case 13:
        return ValidatorPrefsSet._decode(input);
      case 14:
        return SnapshotVotersSizeExceeded._decode(input);
      case 15:
        return SnapshotTargetsSizeExceeded._decode(input);
      case 16:
        return ForceEra._decode(input);
      case 17:
        return ControllerBatchDeprecated._decode(input);
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
      case EraPaid:
        (value as EraPaid).encodeTo(output);
        break;
      case Rewarded:
        (value as Rewarded).encodeTo(output);
        break;
      case Slashed:
        (value as Slashed).encodeTo(output);
        break;
      case SlashReported:
        (value as SlashReported).encodeTo(output);
        break;
      case OldSlashingReportDiscarded:
        (value as OldSlashingReportDiscarded).encodeTo(output);
        break;
      case StakersElected:
        (value as StakersElected).encodeTo(output);
        break;
      case Bonded:
        (value as Bonded).encodeTo(output);
        break;
      case Unbonded:
        (value as Unbonded).encodeTo(output);
        break;
      case Withdrawn:
        (value as Withdrawn).encodeTo(output);
        break;
      case Kicked:
        (value as Kicked).encodeTo(output);
        break;
      case StakingElectionFailed:
        (value as StakingElectionFailed).encodeTo(output);
        break;
      case Chilled:
        (value as Chilled).encodeTo(output);
        break;
      case PayoutStarted:
        (value as PayoutStarted).encodeTo(output);
        break;
      case ValidatorPrefsSet:
        (value as ValidatorPrefsSet).encodeTo(output);
        break;
      case SnapshotVotersSizeExceeded:
        (value as SnapshotVotersSizeExceeded).encodeTo(output);
        break;
      case SnapshotTargetsSizeExceeded:
        (value as SnapshotTargetsSizeExceeded).encodeTo(output);
        break;
      case ForceEra:
        (value as ForceEra).encodeTo(output);
        break;
      case ControllerBatchDeprecated:
        (value as ControllerBatchDeprecated).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case EraPaid:
        return (value as EraPaid)._sizeHint();
      case Rewarded:
        return (value as Rewarded)._sizeHint();
      case Slashed:
        return (value as Slashed)._sizeHint();
      case SlashReported:
        return (value as SlashReported)._sizeHint();
      case OldSlashingReportDiscarded:
        return (value as OldSlashingReportDiscarded)._sizeHint();
      case StakersElected:
        return 1;
      case Bonded:
        return (value as Bonded)._sizeHint();
      case Unbonded:
        return (value as Unbonded)._sizeHint();
      case Withdrawn:
        return (value as Withdrawn)._sizeHint();
      case Kicked:
        return (value as Kicked)._sizeHint();
      case StakingElectionFailed:
        return 1;
      case Chilled:
        return (value as Chilled)._sizeHint();
      case PayoutStarted:
        return (value as PayoutStarted)._sizeHint();
      case ValidatorPrefsSet:
        return (value as ValidatorPrefsSet)._sizeHint();
      case SnapshotVotersSizeExceeded:
        return (value as SnapshotVotersSizeExceeded)._sizeHint();
      case SnapshotTargetsSizeExceeded:
        return (value as SnapshotTargetsSizeExceeded)._sizeHint();
      case ForceEra:
        return (value as ForceEra)._sizeHint();
      case ControllerBatchDeprecated:
        return (value as ControllerBatchDeprecated)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// The era payout has been set; the first balance is the validator-payout; the second is
/// the remainder from the maximum amount of reward.
class EraPaid extends Event {
  const EraPaid({
    required this.eraIndex,
    required this.validatorPayout,
    required this.remainder,
  });

  factory EraPaid._decode(_i1.Input input) {
    return EraPaid(
      eraIndex: _i1.U32Codec.codec.decode(input),
      validatorPayout: _i1.U128Codec.codec.decode(input),
      remainder: _i1.U128Codec.codec.decode(input),
    );
  }

  /// EraIndex
  final int eraIndex;

  /// BalanceOf<T>
  final BigInt validatorPayout;

  /// BalanceOf<T>
  final BigInt remainder;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'EraPaid': {
          'eraIndex': eraIndex,
          'validatorPayout': validatorPayout,
          'remainder': remainder,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(eraIndex);
    size = size + _i1.U128Codec.codec.sizeHint(validatorPayout);
    size = size + _i1.U128Codec.codec.sizeHint(remainder);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      eraIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      validatorPayout,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      remainder,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is EraPaid &&
          other.eraIndex == eraIndex &&
          other.validatorPayout == validatorPayout &&
          other.remainder == remainder;

  @override
  int get hashCode => Object.hash(
        eraIndex,
        validatorPayout,
        remainder,
      );
}

/// The nominator has been rewarded by this amount to this destination.
class Rewarded extends Event {
  const Rewarded({
    required this.stash,
    required this.dest,
    required this.amount,
  });

  factory Rewarded._decode(_i1.Input input) {
    return Rewarded(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      dest: _i4.RewardDestination.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// RewardDestination<T::AccountId>
  final _i4.RewardDestination dest;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Rewarded': {
          'stash': stash.toList(),
          'dest': dest.toJson(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i4.RewardDestination.codec.sizeHint(dest);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
    _i4.RewardDestination.codec.encodeTo(
      dest,
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
      other is Rewarded &&
          _i8.listsEqual(
            other.stash,
            stash,
          ) &&
          other.dest == dest &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        stash,
        dest,
        amount,
      );
}

/// A staker (validator or nominator) has been slashed by the given amount.
class Slashed extends Event {
  const Slashed({
    required this.staker,
    required this.amount,
  });

  factory Slashed._decode(_i1.Input input) {
    return Slashed(
      staker: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 staker;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Slashed': {
          'staker': staker.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(staker);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      staker,
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
      other is Slashed &&
          _i8.listsEqual(
            other.staker,
            staker,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        staker,
        amount,
      );
}

/// A slash for the given validator, for the given percentage of their stake, at the given
/// era as been reported.
class SlashReported extends Event {
  const SlashReported({
    required this.validator,
    required this.fraction,
    required this.slashEra,
  });

  factory SlashReported._decode(_i1.Input input) {
    return SlashReported(
      validator: const _i1.U8ArrayCodec(32).decode(input),
      fraction: _i1.U32Codec.codec.decode(input),
      slashEra: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 validator;

  /// Perbill
  final _i5.Perbill fraction;

  /// EraIndex
  final int slashEra;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SlashReported': {
          'validator': validator.toList(),
          'fraction': fraction,
          'slashEra': slashEra,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(validator);
    size = size + const _i5.PerbillCodec().sizeHint(fraction);
    size = size + _i1.U32Codec.codec.sizeHint(slashEra);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validator,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      fraction,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      slashEra,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SlashReported &&
          _i8.listsEqual(
            other.validator,
            validator,
          ) &&
          other.fraction == fraction &&
          other.slashEra == slashEra;

  @override
  int get hashCode => Object.hash(
        validator,
        fraction,
        slashEra,
      );
}

/// An old slashing report from a prior era was discarded because it could
/// not be processed.
class OldSlashingReportDiscarded extends Event {
  const OldSlashingReportDiscarded({required this.sessionIndex});

  factory OldSlashingReportDiscarded._decode(_i1.Input input) {
    return OldSlashingReportDiscarded(
        sessionIndex: _i1.U32Codec.codec.decode(input));
  }

  /// SessionIndex
  final int sessionIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'OldSlashingReportDiscarded': {'sessionIndex': sessionIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(sessionIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      sessionIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is OldSlashingReportDiscarded && other.sessionIndex == sessionIndex;

  @override
  int get hashCode => sessionIndex.hashCode;
}

/// A new set of stakers was elected.
class StakersElected extends Event {
  const StakersElected();

  @override
  Map<String, dynamic> toJson() => {'StakersElected': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is StakersElected;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// An account has bonded this amount. \[stash, amount\]
///
/// NOTE: This event is only emitted when funds are bonded via a dispatchable. Notably,
/// it will not be emitted for staking rewards when they are added to stake.
class Bonded extends Event {
  const Bonded({
    required this.stash,
    required this.amount,
  });

  factory Bonded._decode(_i1.Input input) {
    return Bonded(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Bonded': {
          'stash': stash.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
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
      other is Bonded &&
          _i8.listsEqual(
            other.stash,
            stash,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        stash,
        amount,
      );
}

/// An account has unbonded this amount.
class Unbonded extends Event {
  const Unbonded({
    required this.stash,
    required this.amount,
  });

  factory Unbonded._decode(_i1.Input input) {
    return Unbonded(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Unbonded': {
          'stash': stash.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
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
      other is Unbonded &&
          _i8.listsEqual(
            other.stash,
            stash,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        stash,
        amount,
      );
}

/// An account has called `withdraw_unbonded` and removed unbonding chunks worth `Balance`
/// from the unlocking queue.
class Withdrawn extends Event {
  const Withdrawn({
    required this.stash,
    required this.amount,
  });

  factory Withdrawn._decode(_i1.Input input) {
    return Withdrawn(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      amount: _i1.U128Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// BalanceOf<T>
  final BigInt amount;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Withdrawn': {
          'stash': stash.toList(),
          'amount': amount,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
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
      other is Withdrawn &&
          _i8.listsEqual(
            other.stash,
            stash,
          ) &&
          other.amount == amount;

  @override
  int get hashCode => Object.hash(
        stash,
        amount,
      );
}

/// A nominator has been kicked from a validator.
class Kicked extends Event {
  const Kicked({
    required this.nominator,
    required this.stash,
  });

  factory Kicked._decode(_i1.Input input) {
    return Kicked(
      nominator: const _i1.U8ArrayCodec(32).decode(input),
      stash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 nominator;

  /// T::AccountId
  final _i3.AccountId32 stash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Kicked': {
          'nominator': nominator.toList(),
          'stash': stash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(nominator);
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      nominator,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Kicked &&
          _i8.listsEqual(
            other.nominator,
            nominator,
          ) &&
          _i8.listsEqual(
            other.stash,
            stash,
          );

  @override
  int get hashCode => Object.hash(
        nominator,
        stash,
      );
}

/// The election failed. No new era is planned.
class StakingElectionFailed extends Event {
  const StakingElectionFailed();

  @override
  Map<String, dynamic> toJson() => {'StakingElectionFailed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is StakingElectionFailed;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// An account has stopped participating as either a validator or nominator.
class Chilled extends Event {
  const Chilled({required this.stash});

  factory Chilled._decode(_i1.Input input) {
    return Chilled(stash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'Chilled': {'stash': stash.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Chilled &&
          _i8.listsEqual(
            other.stash,
            stash,
          );

  @override
  int get hashCode => stash.hashCode;
}

/// The stakers' rewards are getting paid.
class PayoutStarted extends Event {
  const PayoutStarted({
    required this.eraIndex,
    required this.validatorStash,
  });

  factory PayoutStarted._decode(_i1.Input input) {
    return PayoutStarted(
      eraIndex: _i1.U32Codec.codec.decode(input),
      validatorStash: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// EraIndex
  final int eraIndex;

  /// T::AccountId
  final _i3.AccountId32 validatorStash;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PayoutStarted': {
          'eraIndex': eraIndex,
          'validatorStash': validatorStash.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(eraIndex);
    size = size + const _i3.AccountId32Codec().sizeHint(validatorStash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      eraIndex,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validatorStash,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PayoutStarted &&
          other.eraIndex == eraIndex &&
          _i8.listsEqual(
            other.validatorStash,
            validatorStash,
          );

  @override
  int get hashCode => Object.hash(
        eraIndex,
        validatorStash,
      );
}

/// A validator has set their preferences.
class ValidatorPrefsSet extends Event {
  const ValidatorPrefsSet({
    required this.stash,
    required this.prefs,
  });

  factory ValidatorPrefsSet._decode(_i1.Input input) {
    return ValidatorPrefsSet(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      prefs: _i6.ValidatorPrefs.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i3.AccountId32 stash;

  /// ValidatorPrefs
  final _i6.ValidatorPrefs prefs;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'ValidatorPrefsSet': {
          'stash': stash.toList(),
          'prefs': prefs.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i3.AccountId32Codec().sizeHint(stash);
    size = size + _i6.ValidatorPrefs.codec.sizeHint(prefs);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
    _i6.ValidatorPrefs.codec.encodeTo(
      prefs,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ValidatorPrefsSet &&
          _i8.listsEqual(
            other.stash,
            stash,
          ) &&
          other.prefs == prefs;

  @override
  int get hashCode => Object.hash(
        stash,
        prefs,
      );
}

/// Voters size limit reached.
class SnapshotVotersSizeExceeded extends Event {
  const SnapshotVotersSizeExceeded({required this.size});

  factory SnapshotVotersSizeExceeded._decode(_i1.Input input) {
    return SnapshotVotersSizeExceeded(size: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int size;

  @override
  Map<String, Map<String, int>> toJson() => {
        'SnapshotVotersSizeExceeded': {'size': size}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(this.size);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      size,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SnapshotVotersSizeExceeded && other.size == size;

  @override
  int get hashCode => size.hashCode;
}

/// Targets size limit reached.
class SnapshotTargetsSizeExceeded extends Event {
  const SnapshotTargetsSizeExceeded({required this.size});

  factory SnapshotTargetsSizeExceeded._decode(_i1.Input input) {
    return SnapshotTargetsSizeExceeded(size: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int size;

  @override
  Map<String, Map<String, int>> toJson() => {
        'SnapshotTargetsSizeExceeded': {'size': size}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(this.size);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      size,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SnapshotTargetsSizeExceeded && other.size == size;

  @override
  int get hashCode => size.hashCode;
}

/// A new force era mode was set.
class ForceEra extends Event {
  const ForceEra({required this.mode});

  factory ForceEra._decode(_i1.Input input) {
    return ForceEra(mode: _i7.Forcing.codec.decode(input));
  }

  /// Forcing
  final _i7.Forcing mode;

  @override
  Map<String, Map<String, String>> toJson() => {
        'ForceEra': {'mode': mode.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i7.Forcing.codec.sizeHint(mode);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
    _i7.Forcing.codec.encodeTo(
      mode,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceEra && other.mode == mode;

  @override
  int get hashCode => mode.hashCode;
}

/// Report of a controller batch deprecation.
class ControllerBatchDeprecated extends Event {
  const ControllerBatchDeprecated({required this.failures});

  factory ControllerBatchDeprecated._decode(_i1.Input input) {
    return ControllerBatchDeprecated(
        failures: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int failures;

  @override
  Map<String, Map<String, int>> toJson() => {
        'ControllerBatchDeprecated': {'failures': failures}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(failures);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      failures,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ControllerBatchDeprecated && other.failures == failures;

  @override
  int get hashCode => failures.hashCode;
}
