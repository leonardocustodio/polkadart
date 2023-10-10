// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i13;

import '../../../sp_arithmetic/per_things/perbill.dart' as _i12;
import '../../../sp_arithmetic/per_things/percent.dart' as _i6;
import '../../../sp_core/crypto/account_id32.dart' as _i7;
import '../../../sp_runtime/multiaddress/multi_address.dart' as _i5;
import '../../reward_destination.dart' as _i3;
import '../../validator_prefs.dart' as _i4;
import 'config_op_1.dart' as _i8;
import 'config_op_2.dart' as _i9;
import 'config_op_3.dart' as _i10;
import 'config_op_4.dart' as _i11;

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

  Map<String, dynamic> toJson();
}

class $Call {
  const $Call();

  Bond bond({
    required BigInt value,
    required _i3.RewardDestination payee,
  }) {
    return Bond(
      value: value,
      payee: payee,
    );
  }

  BondExtra bondExtra({required BigInt maxAdditional}) {
    return BondExtra(maxAdditional: maxAdditional);
  }

  Unbond unbond({required BigInt value}) {
    return Unbond(value: value);
  }

  WithdrawUnbonded withdrawUnbonded({required int numSlashingSpans}) {
    return WithdrawUnbonded(numSlashingSpans: numSlashingSpans);
  }

  Validate validate({required _i4.ValidatorPrefs prefs}) {
    return Validate(prefs: prefs);
  }

  Nominate nominate({required List<_i5.MultiAddress> targets}) {
    return Nominate(targets: targets);
  }

  Chill chill() {
    return Chill();
  }

  SetPayee setPayee({required _i3.RewardDestination payee}) {
    return SetPayee(payee: payee);
  }

  SetController setController() {
    return SetController();
  }

  SetValidatorCount setValidatorCount({required BigInt new_}) {
    return SetValidatorCount(new_: new_);
  }

  IncreaseValidatorCount increaseValidatorCount({required BigInt additional}) {
    return IncreaseValidatorCount(additional: additional);
  }

  ScaleValidatorCount scaleValidatorCount({required _i6.Percent factor}) {
    return ScaleValidatorCount(factor: factor);
  }

  ForceNoEras forceNoEras() {
    return ForceNoEras();
  }

  ForceNewEra forceNewEra() {
    return ForceNewEra();
  }

  SetInvulnerables setInvulnerables(
      {required List<_i7.AccountId32> invulnerables}) {
    return SetInvulnerables(invulnerables: invulnerables);
  }

  ForceUnstake forceUnstake({
    required _i7.AccountId32 stash,
    required int numSlashingSpans,
  }) {
    return ForceUnstake(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
  }

  ForceNewEraAlways forceNewEraAlways() {
    return ForceNewEraAlways();
  }

  CancelDeferredSlash cancelDeferredSlash({
    required int era,
    required List<int> slashIndices,
  }) {
    return CancelDeferredSlash(
      era: era,
      slashIndices: slashIndices,
    );
  }

  PayoutStakers payoutStakers({
    required _i7.AccountId32 validatorStash,
    required int era,
  }) {
    return PayoutStakers(
      validatorStash: validatorStash,
      era: era,
    );
  }

  Rebond rebond({required BigInt value}) {
    return Rebond(value: value);
  }

  ReapStash reapStash({
    required _i7.AccountId32 stash,
    required int numSlashingSpans,
  }) {
    return ReapStash(
      stash: stash,
      numSlashingSpans: numSlashingSpans,
    );
  }

  Kick kick({required List<_i5.MultiAddress> who}) {
    return Kick(who: who);
  }

  SetStakingConfigs setStakingConfigs({
    required _i8.ConfigOp minNominatorBond,
    required _i8.ConfigOp minValidatorBond,
    required _i9.ConfigOp maxNominatorCount,
    required _i9.ConfigOp maxValidatorCount,
    required _i10.ConfigOp chillThreshold,
    required _i11.ConfigOp minCommission,
  }) {
    return SetStakingConfigs(
      minNominatorBond: minNominatorBond,
      minValidatorBond: minValidatorBond,
      maxNominatorCount: maxNominatorCount,
      maxValidatorCount: maxValidatorCount,
      chillThreshold: chillThreshold,
      minCommission: minCommission,
    );
  }

  ChillOther chillOther({required _i7.AccountId32 controller}) {
    return ChillOther(controller: controller);
  }

  ForceApplyMinCommission forceApplyMinCommission(
      {required _i7.AccountId32 validatorStash}) {
    return ForceApplyMinCommission(validatorStash: validatorStash);
  }

  SetMinCommission setMinCommission({required _i12.Perbill new_}) {
    return SetMinCommission(new_: new_);
  }
}

class $CallCodec with _i1.Codec<Call> {
  const $CallCodec();

  @override
  Call decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Bond._decode(input);
      case 1:
        return BondExtra._decode(input);
      case 2:
        return Unbond._decode(input);
      case 3:
        return WithdrawUnbonded._decode(input);
      case 4:
        return Validate._decode(input);
      case 5:
        return Nominate._decode(input);
      case 6:
        return const Chill();
      case 7:
        return SetPayee._decode(input);
      case 8:
        return const SetController();
      case 9:
        return SetValidatorCount._decode(input);
      case 10:
        return IncreaseValidatorCount._decode(input);
      case 11:
        return ScaleValidatorCount._decode(input);
      case 12:
        return const ForceNoEras();
      case 13:
        return const ForceNewEra();
      case 14:
        return SetInvulnerables._decode(input);
      case 15:
        return ForceUnstake._decode(input);
      case 16:
        return const ForceNewEraAlways();
      case 17:
        return CancelDeferredSlash._decode(input);
      case 18:
        return PayoutStakers._decode(input);
      case 19:
        return Rebond._decode(input);
      case 20:
        return ReapStash._decode(input);
      case 21:
        return Kick._decode(input);
      case 22:
        return SetStakingConfigs._decode(input);
      case 23:
        return ChillOther._decode(input);
      case 24:
        return ForceApplyMinCommission._decode(input);
      case 25:
        return SetMinCommission._decode(input);
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
      case Bond:
        (value as Bond).encodeTo(output);
        break;
      case BondExtra:
        (value as BondExtra).encodeTo(output);
        break;
      case Unbond:
        (value as Unbond).encodeTo(output);
        break;
      case WithdrawUnbonded:
        (value as WithdrawUnbonded).encodeTo(output);
        break;
      case Validate:
        (value as Validate).encodeTo(output);
        break;
      case Nominate:
        (value as Nominate).encodeTo(output);
        break;
      case Chill:
        (value as Chill).encodeTo(output);
        break;
      case SetPayee:
        (value as SetPayee).encodeTo(output);
        break;
      case SetController:
        (value as SetController).encodeTo(output);
        break;
      case SetValidatorCount:
        (value as SetValidatorCount).encodeTo(output);
        break;
      case IncreaseValidatorCount:
        (value as IncreaseValidatorCount).encodeTo(output);
        break;
      case ScaleValidatorCount:
        (value as ScaleValidatorCount).encodeTo(output);
        break;
      case ForceNoEras:
        (value as ForceNoEras).encodeTo(output);
        break;
      case ForceNewEra:
        (value as ForceNewEra).encodeTo(output);
        break;
      case SetInvulnerables:
        (value as SetInvulnerables).encodeTo(output);
        break;
      case ForceUnstake:
        (value as ForceUnstake).encodeTo(output);
        break;
      case ForceNewEraAlways:
        (value as ForceNewEraAlways).encodeTo(output);
        break;
      case CancelDeferredSlash:
        (value as CancelDeferredSlash).encodeTo(output);
        break;
      case PayoutStakers:
        (value as PayoutStakers).encodeTo(output);
        break;
      case Rebond:
        (value as Rebond).encodeTo(output);
        break;
      case ReapStash:
        (value as ReapStash).encodeTo(output);
        break;
      case Kick:
        (value as Kick).encodeTo(output);
        break;
      case SetStakingConfigs:
        (value as SetStakingConfigs).encodeTo(output);
        break;
      case ChillOther:
        (value as ChillOther).encodeTo(output);
        break;
      case ForceApplyMinCommission:
        (value as ForceApplyMinCommission).encodeTo(output);
        break;
      case SetMinCommission:
        (value as SetMinCommission).encodeTo(output);
        break;
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Call value) {
    switch (value.runtimeType) {
      case Bond:
        return (value as Bond)._sizeHint();
      case BondExtra:
        return (value as BondExtra)._sizeHint();
      case Unbond:
        return (value as Unbond)._sizeHint();
      case WithdrawUnbonded:
        return (value as WithdrawUnbonded)._sizeHint();
      case Validate:
        return (value as Validate)._sizeHint();
      case Nominate:
        return (value as Nominate)._sizeHint();
      case Chill:
        return 1;
      case SetPayee:
        return (value as SetPayee)._sizeHint();
      case SetController:
        return 1;
      case SetValidatorCount:
        return (value as SetValidatorCount)._sizeHint();
      case IncreaseValidatorCount:
        return (value as IncreaseValidatorCount)._sizeHint();
      case ScaleValidatorCount:
        return (value as ScaleValidatorCount)._sizeHint();
      case ForceNoEras:
        return 1;
      case ForceNewEra:
        return 1;
      case SetInvulnerables:
        return (value as SetInvulnerables)._sizeHint();
      case ForceUnstake:
        return (value as ForceUnstake)._sizeHint();
      case ForceNewEraAlways:
        return 1;
      case CancelDeferredSlash:
        return (value as CancelDeferredSlash)._sizeHint();
      case PayoutStakers:
        return (value as PayoutStakers)._sizeHint();
      case Rebond:
        return (value as Rebond)._sizeHint();
      case ReapStash:
        return (value as ReapStash)._sizeHint();
      case Kick:
        return (value as Kick)._sizeHint();
      case SetStakingConfigs:
        return (value as SetStakingConfigs)._sizeHint();
      case ChillOther:
        return (value as ChillOther)._sizeHint();
      case ForceApplyMinCommission:
        return (value as ForceApplyMinCommission)._sizeHint();
      case SetMinCommission:
        return (value as SetMinCommission)._sizeHint();
      default:
        throw Exception(
            'Call: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// Take the origin account as a stash and lock up `value` of its balance. `controller` will
/// be the account that controls it.
///
/// `value` must be more than the `minimum_balance` specified by `T::Currency`.
///
/// The dispatch origin for this call must be _Signed_ by the stash account.
///
/// Emits `Bonded`.
/// ## Complexity
/// - Independent of the arguments. Moderate complexity.
/// - O(1).
/// - Three extra DB entries.
///
/// NOTE: Two of the storage writes (`Self::bonded`, `Self::payee`) are _never_ cleaned
/// unless the `origin` falls below _existential deposit_ and gets removed as dust.
class Bond extends Call {
  const Bond({
    required this.value,
    required this.payee,
  });

  factory Bond._decode(_i1.Input input) {
    return Bond(
      value: _i1.CompactBigIntCodec.codec.decode(input),
      payee: _i3.RewardDestination.codec.decode(input),
    );
  }

  /// BalanceOf<T>
  final BigInt value;

  /// RewardDestination<T::AccountId>
  final _i3.RewardDestination payee;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'bond': {
          'value': value,
          'payee': payee.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    size = size + _i3.RewardDestination.codec.sizeHint(payee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
    _i3.RewardDestination.codec.encodeTo(
      payee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Bond && other.value == value && other.payee == payee;

  @override
  int get hashCode => Object.hash(
        value,
        payee,
      );
}

/// Add some extra amount that have appeared in the stash `free_balance` into the balance up
/// for staking.
///
/// The dispatch origin for this call must be _Signed_ by the stash, not the controller.
///
/// Use this if there are additional funds in your stash account that you wish to bond.
/// Unlike [`bond`](Self::bond) or [`unbond`](Self::unbond) this function does not impose
/// any limitation on the amount that can be added.
///
/// Emits `Bonded`.
///
/// ## Complexity
/// - Independent of the arguments. Insignificant complexity.
/// - O(1).
class BondExtra extends Call {
  const BondExtra({required this.maxAdditional});

  factory BondExtra._decode(_i1.Input input) {
    return BondExtra(maxAdditional: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt maxAdditional;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'bond_extra': {'maxAdditional': maxAdditional}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(maxAdditional);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      maxAdditional,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is BondExtra && other.maxAdditional == maxAdditional;

  @override
  int get hashCode => maxAdditional.hashCode;
}

/// Schedule a portion of the stash to be unlocked ready for transfer out after the bond
/// period ends. If this leaves an amount actively bonded less than
/// T::Currency::minimum_balance(), then it is increased to the full amount.
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
///
/// Once the unlock period is done, you can call `withdraw_unbonded` to actually move
/// the funds out of management ready for transfer.
///
/// No more than a limited number of unlocking chunks (see `MaxUnlockingChunks`)
/// can co-exists at the same time. If there are no unlocking chunks slots available
/// [`Call::withdraw_unbonded`] is called to remove some of the chunks (if possible).
///
/// If a user encounters the `InsufficientBond` error when calling this extrinsic,
/// they should call `chill` first in order to free up their bonded funds.
///
/// Emits `Unbonded`.
///
/// See also [`Call::withdraw_unbonded`].
class Unbond extends Call {
  const Unbond({required this.value});

  factory Unbond._decode(_i1.Input input) {
    return Unbond(value: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'unbond': {'value': value}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Unbond && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// Remove any unlocked chunks from the `unlocking` queue from our management.
///
/// This essentially frees up that balance to be used by the stash account to do
/// whatever it wants.
///
/// The dispatch origin for this call must be _Signed_ by the controller.
///
/// Emits `Withdrawn`.
///
/// See also [`Call::unbond`].
///
/// ## Complexity
/// O(S) where S is the number of slashing spans to remove
/// NOTE: Weight annotation is the kill scenario, we refund otherwise.
class WithdrawUnbonded extends Call {
  const WithdrawUnbonded({required this.numSlashingSpans});

  factory WithdrawUnbonded._decode(_i1.Input input) {
    return WithdrawUnbonded(numSlashingSpans: _i1.U32Codec.codec.decode(input));
  }

  /// u32
  final int numSlashingSpans;

  @override
  Map<String, Map<String, int>> toJson() => {
        'withdraw_unbonded': {'numSlashingSpans': numSlashingSpans}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(numSlashingSpans);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numSlashingSpans,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is WithdrawUnbonded && other.numSlashingSpans == numSlashingSpans;

  @override
  int get hashCode => numSlashingSpans.hashCode;
}

/// Declare the desire to validate for the origin controller.
///
/// Effects will be felt at the beginning of the next era.
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
class Validate extends Call {
  const Validate({required this.prefs});

  factory Validate._decode(_i1.Input input) {
    return Validate(prefs: _i4.ValidatorPrefs.codec.decode(input));
  }

  /// ValidatorPrefs
  final _i4.ValidatorPrefs prefs;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'validate': {'prefs': prefs.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i4.ValidatorPrefs.codec.sizeHint(prefs);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i4.ValidatorPrefs.codec.encodeTo(
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
      other is Validate && other.prefs == prefs;

  @override
  int get hashCode => prefs.hashCode;
}

/// Declare the desire to nominate `targets` for the origin controller.
///
/// Effects will be felt at the beginning of the next era.
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
///
/// ## Complexity
/// - The transaction's complexity is proportional to the size of `targets` (N)
/// which is capped at CompactAssignments::LIMIT (T::MaxNominations).
/// - Both the reads and writes follow a similar pattern.
class Nominate extends Call {
  const Nominate({required this.targets});

  factory Nominate._decode(_i1.Input input) {
    return Nominate(
        targets:
            const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec)
                .decode(input));
  }

  /// Vec<AccountIdLookupOf<T>>
  final List<_i5.MultiAddress> targets;

  @override
  Map<String, Map<String, List<Map<String, dynamic>>>> toJson() => {
        'nominate': {'targets': targets.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec)
            .sizeHint(targets);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec).encodeTo(
      targets,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Nominate &&
          _i13.listsEqual(
            other.targets,
            targets,
          );

  @override
  int get hashCode => targets.hashCode;
}

/// Declare no desire to either validate or nominate.
///
/// Effects will be felt at the beginning of the next era.
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
///
/// ## Complexity
/// - Independent of the arguments. Insignificant complexity.
/// - Contains one read.
/// - Writes are limited to the `origin` account key.
class Chill extends Call {
  const Chill();

  @override
  Map<String, dynamic> toJson() => {'chill': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is Chill;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// (Re-)set the payment target for a controller.
///
/// Effects will be felt instantly (as soon as this function is completed successfully).
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
///
/// ## Complexity
/// - O(1)
/// - Independent of the arguments. Insignificant complexity.
/// - Contains a limited number of reads.
/// - Writes are limited to the `origin` account key.
/// ---------
class SetPayee extends Call {
  const SetPayee({required this.payee});

  factory SetPayee._decode(_i1.Input input) {
    return SetPayee(payee: _i3.RewardDestination.codec.decode(input));
  }

  /// RewardDestination<T::AccountId>
  final _i3.RewardDestination payee;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_payee': {'payee': payee.toJson()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i3.RewardDestination.codec.sizeHint(payee);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
    _i3.RewardDestination.codec.encodeTo(
      payee,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetPayee && other.payee == payee;

  @override
  int get hashCode => payee.hashCode;
}

/// (Re-)sets the controller of a stash to the stash itself. This function previously
/// accepted a `controller` argument to set the controller to an account other than the
/// stash itself. This functionality has now been removed, now only setting the controller
/// to the stash, if it is not already.
///
/// Effects will be felt instantly (as soon as this function is completed successfully).
///
/// The dispatch origin for this call must be _Signed_ by the stash, not the controller.
///
/// ## Complexity
/// O(1)
/// - Independent of the arguments. Insignificant complexity.
/// - Contains a limited number of reads.
/// - Writes are limited to the `origin` account key.
class SetController extends Call {
  const SetController();

  @override
  Map<String, dynamic> toJson() => {'set_controller': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is SetController;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Sets the ideal number of validators.
///
/// The dispatch origin must be Root.
///
/// ## Complexity
/// O(1)
class SetValidatorCount extends Call {
  const SetValidatorCount({required this.new_});

  factory SetValidatorCount._decode(_i1.Input input) {
    return SetValidatorCount(new_: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt new_;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'set_validator_count': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetValidatorCount && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}

/// Increments the ideal number of validators upto maximum of
/// `ElectionProviderBase::MaxWinners`.
///
/// The dispatch origin must be Root.
///
/// ## Complexity
/// Same as [`Self::set_validator_count`].
class IncreaseValidatorCount extends Call {
  const IncreaseValidatorCount({required this.additional});

  factory IncreaseValidatorCount._decode(_i1.Input input) {
    return IncreaseValidatorCount(
        additional: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// u32
  final BigInt additional;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'increase_validator_count': {'additional': additional}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(additional);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      additional,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is IncreaseValidatorCount && other.additional == additional;

  @override
  int get hashCode => additional.hashCode;
}

/// Scale up the ideal number of validators by a factor upto maximum of
/// `ElectionProviderBase::MaxWinners`.
///
/// The dispatch origin must be Root.
///
/// ## Complexity
/// Same as [`Self::set_validator_count`].
class ScaleValidatorCount extends Call {
  const ScaleValidatorCount({required this.factor});

  factory ScaleValidatorCount._decode(_i1.Input input) {
    return ScaleValidatorCount(factor: _i1.U8Codec.codec.decode(input));
  }

  /// Percent
  final _i6.Percent factor;

  @override
  Map<String, Map<String, int>> toJson() => {
        'scale_validator_count': {'factor': factor}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i6.PercentCodec().sizeHint(factor);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
    _i1.U8Codec.codec.encodeTo(
      factor,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ScaleValidatorCount && other.factor == factor;

  @override
  int get hashCode => factor.hashCode;
}

/// Force there to be no new eras indefinitely.
///
/// The dispatch origin must be Root.
///
/// # Warning
///
/// The election process starts multiple blocks before the end of the era.
/// Thus the election process may be ongoing when this is called. In this case the
/// election will continue until the next era is triggered.
///
/// ## Complexity
/// - No arguments.
/// - Weight: O(1)
class ForceNoEras extends Call {
  const ForceNoEras();

  @override
  Map<String, dynamic> toJson() => {'force_no_eras': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ForceNoEras;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Force there to be a new era at the end of the next session. After this, it will be
/// reset to normal (non-forced) behaviour.
///
/// The dispatch origin must be Root.
///
/// # Warning
///
/// The election process starts multiple blocks before the end of the era.
/// If this is called just before a new era is triggered, the election process may not
/// have enough blocks to get a result.
///
/// ## Complexity
/// - No arguments.
/// - Weight: O(1)
class ForceNewEra extends Call {
  const ForceNewEra();

  @override
  Map<String, dynamic> toJson() => {'force_new_era': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ForceNewEra;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Set the validators who cannot be slashed (if any).
///
/// The dispatch origin must be Root.
class SetInvulnerables extends Call {
  const SetInvulnerables({required this.invulnerables});

  factory SetInvulnerables._decode(_i1.Input input) {
    return SetInvulnerables(
        invulnerables:
            const _i1.SequenceCodec<_i7.AccountId32>(_i7.AccountId32Codec())
                .decode(input));
  }

  /// Vec<T::AccountId>
  final List<_i7.AccountId32> invulnerables;

  @override
  Map<String, Map<String, List<List<int>>>> toJson() => {
        'set_invulnerables': {
          'invulnerables': invulnerables.map((value) => value.toList()).toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i7.AccountId32>(_i7.AccountId32Codec())
            .sizeHint(invulnerables);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
    const _i1.SequenceCodec<_i7.AccountId32>(_i7.AccountId32Codec()).encodeTo(
      invulnerables,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetInvulnerables &&
          _i13.listsEqual(
            other.invulnerables,
            invulnerables,
          );

  @override
  int get hashCode => invulnerables.hashCode;
}

/// Force a current staker to become completely unstaked, immediately.
///
/// The dispatch origin must be Root.
class ForceUnstake extends Call {
  const ForceUnstake({
    required this.stash,
    required this.numSlashingSpans,
  });

  factory ForceUnstake._decode(_i1.Input input) {
    return ForceUnstake(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      numSlashingSpans: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i7.AccountId32 stash;

  /// u32
  final int numSlashingSpans;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'force_unstake': {
          'stash': stash.toList(),
          'numSlashingSpans': numSlashingSpans,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U32Codec.codec.sizeHint(numSlashingSpans);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numSlashingSpans,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ForceUnstake &&
          _i13.listsEqual(
            other.stash,
            stash,
          ) &&
          other.numSlashingSpans == numSlashingSpans;

  @override
  int get hashCode => Object.hash(
        stash,
        numSlashingSpans,
      );
}

/// Force there to be a new era at the end of sessions indefinitely.
///
/// The dispatch origin must be Root.
///
/// # Warning
///
/// The election process starts multiple blocks before the end of the era.
/// If this is called just before a new era is triggered, the election process may not
/// have enough blocks to get a result.
class ForceNewEraAlways extends Call {
  const ForceNewEraAlways();

  @override
  Map<String, dynamic> toJson() => {'force_new_era_always': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is ForceNewEraAlways;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Cancel enactment of a deferred slash.
///
/// Can be called by the `T::AdminOrigin`.
///
/// Parameters: era and indices of the slashes for that era to kill.
class CancelDeferredSlash extends Call {
  const CancelDeferredSlash({
    required this.era,
    required this.slashIndices,
  });

  factory CancelDeferredSlash._decode(_i1.Input input) {
    return CancelDeferredSlash(
      era: _i1.U32Codec.codec.decode(input),
      slashIndices: _i1.U32SequenceCodec.codec.decode(input),
    );
  }

  /// EraIndex
  final int era;

  /// Vec<u32>
  final List<int> slashIndices;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'cancel_deferred_slash': {
          'era': era,
          'slashIndices': slashIndices,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(era);
    size = size + _i1.U32SequenceCodec.codec.sizeHint(slashIndices);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      era,
      output,
    );
    _i1.U32SequenceCodec.codec.encodeTo(
      slashIndices,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is CancelDeferredSlash &&
          other.era == era &&
          _i13.listsEqual(
            other.slashIndices,
            slashIndices,
          );

  @override
  int get hashCode => Object.hash(
        era,
        slashIndices,
      );
}

/// Pay out all the stakers behind a single validator for a single era.
///
/// - `validator_stash` is the stash account of the validator. Their nominators, up to
///  `T::MaxNominatorRewardedPerValidator`, will also receive their rewards.
/// - `era` may be any era between `[current_era - history_depth; current_era]`.
///
/// The origin of this call must be _Signed_. Any account can call this function, even if
/// it is not one of the stakers.
///
/// ## Complexity
/// - At most O(MaxNominatorRewardedPerValidator).
class PayoutStakers extends Call {
  const PayoutStakers({
    required this.validatorStash,
    required this.era,
  });

  factory PayoutStakers._decode(_i1.Input input) {
    return PayoutStakers(
      validatorStash: const _i1.U8ArrayCodec(32).decode(input),
      era: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i7.AccountId32 validatorStash;

  /// EraIndex
  final int era;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'payout_stakers': {
          'validatorStash': validatorStash.toList(),
          'era': era,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.AccountId32Codec().sizeHint(validatorStash);
    size = size + _i1.U32Codec.codec.sizeHint(era);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      validatorStash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      era,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PayoutStakers &&
          _i13.listsEqual(
            other.validatorStash,
            validatorStash,
          ) &&
          other.era == era;

  @override
  int get hashCode => Object.hash(
        validatorStash,
        era,
      );
}

/// Rebond a portion of the stash scheduled to be unlocked.
///
/// The dispatch origin must be signed by the controller.
///
/// ## Complexity
/// - Time complexity: O(L), where L is unlocking chunks
/// - Bounded by `MaxUnlockingChunks`.
class Rebond extends Call {
  const Rebond({required this.value});

  factory Rebond._decode(_i1.Input input) {
    return Rebond(value: _i1.CompactBigIntCodec.codec.decode(input));
  }

  /// BalanceOf<T>
  final BigInt value;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'rebond': {'value': value}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.CompactBigIntCodec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i1.CompactBigIntCodec.codec.encodeTo(
      value,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rebond && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// Remove all data structures concerning a staker/stash once it is at a state where it can
/// be considered `dust` in the staking system. The requirements are:
///
/// 1. the `total_balance` of the stash is below existential deposit.
/// 2. or, the `ledger.total` of the stash is below existential deposit.
///
/// The former can happen in cases like a slash; the latter when a fully unbonded account
/// is still receiving staking rewards in `RewardDestination::Staked`.
///
/// It can be called by anyone, as long as `stash` meets the above requirements.
///
/// Refunds the transaction fees upon successful execution.
class ReapStash extends Call {
  const ReapStash({
    required this.stash,
    required this.numSlashingSpans,
  });

  factory ReapStash._decode(_i1.Input input) {
    return ReapStash(
      stash: const _i1.U8ArrayCodec(32).decode(input),
      numSlashingSpans: _i1.U32Codec.codec.decode(input),
    );
  }

  /// T::AccountId
  final _i7.AccountId32 stash;

  /// u32
  final int numSlashingSpans;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'reap_stash': {
          'stash': stash.toList(),
          'numSlashingSpans': numSlashingSpans,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.AccountId32Codec().sizeHint(stash);
    size = size + _i1.U32Codec.codec.sizeHint(numSlashingSpans);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      stash,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      numSlashingSpans,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ReapStash &&
          _i13.listsEqual(
            other.stash,
            stash,
          ) &&
          other.numSlashingSpans == numSlashingSpans;

  @override
  int get hashCode => Object.hash(
        stash,
        numSlashingSpans,
      );
}

/// Remove the given nominations from the calling validator.
///
/// Effects will be felt at the beginning of the next era.
///
/// The dispatch origin for this call must be _Signed_ by the controller, not the stash.
///
/// - `who`: A list of nominator stash accounts who are nominating this validator which
///  should no longer be nominating this validator.
///
/// Note: Making this call only makes sense if you first set the validator preferences to
/// block any further nominations.
class Kick extends Call {
  const Kick({required this.who});

  factory Kick._decode(_i1.Input input) {
    return Kick(
        who: const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec)
            .decode(input));
  }

  /// Vec<AccountIdLookupOf<T>>
  final List<_i5.MultiAddress> who;

  @override
  Map<String, Map<String, List<Map<String, dynamic>>>> toJson() => {
        'kick': {'who': who.map((value) => value.toJson()).toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size +
        const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec)
            .sizeHint(who);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
    const _i1.SequenceCodec<_i5.MultiAddress>(_i5.MultiAddress.codec).encodeTo(
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
      other is Kick &&
          _i13.listsEqual(
            other.who,
            who,
          );

  @override
  int get hashCode => who.hashCode;
}

/// Update the various staking configurations .
///
/// * `min_nominator_bond`: The minimum active bond needed to be a nominator.
/// * `min_validator_bond`: The minimum active bond needed to be a validator.
/// * `max_nominator_count`: The max number of users who can be a nominator at once. When
///  set to `None`, no limit is enforced.
/// * `max_validator_count`: The max number of users who can be a validator at once. When
///  set to `None`, no limit is enforced.
/// * `chill_threshold`: The ratio of `max_nominator_count` or `max_validator_count` which
///  should be filled in order for the `chill_other` transaction to work.
/// * `min_commission`: The minimum amount of commission that each validators must maintain.
///  This is checked only upon calling `validate`. Existing validators are not affected.
///
/// RuntimeOrigin must be Root to call this function.
///
/// NOTE: Existing nominators and validators will not be affected by this update.
/// to kick people under the new limits, `chill_other` should be called.
class SetStakingConfigs extends Call {
  const SetStakingConfigs({
    required this.minNominatorBond,
    required this.minValidatorBond,
    required this.maxNominatorCount,
    required this.maxValidatorCount,
    required this.chillThreshold,
    required this.minCommission,
  });

  factory SetStakingConfigs._decode(_i1.Input input) {
    return SetStakingConfigs(
      minNominatorBond: _i8.ConfigOp.codec.decode(input),
      minValidatorBond: _i8.ConfigOp.codec.decode(input),
      maxNominatorCount: _i9.ConfigOp.codec.decode(input),
      maxValidatorCount: _i9.ConfigOp.codec.decode(input),
      chillThreshold: _i10.ConfigOp.codec.decode(input),
      minCommission: _i11.ConfigOp.codec.decode(input),
    );
  }

  /// ConfigOp<BalanceOf<T>>
  final _i8.ConfigOp minNominatorBond;

  /// ConfigOp<BalanceOf<T>>
  final _i8.ConfigOp minValidatorBond;

  /// ConfigOp<u32>
  final _i9.ConfigOp maxNominatorCount;

  /// ConfigOp<u32>
  final _i9.ConfigOp maxValidatorCount;

  /// ConfigOp<Percent>
  final _i10.ConfigOp chillThreshold;

  /// ConfigOp<Perbill>
  final _i11.ConfigOp minCommission;

  @override
  Map<String, Map<String, Map<String, dynamic>>> toJson() => {
        'set_staking_configs': {
          'minNominatorBond': minNominatorBond.toJson(),
          'minValidatorBond': minValidatorBond.toJson(),
          'maxNominatorCount': maxNominatorCount.toJson(),
          'maxValidatorCount': maxValidatorCount.toJson(),
          'chillThreshold': chillThreshold.toJson(),
          'minCommission': minCommission.toJson(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i8.ConfigOp.codec.sizeHint(minNominatorBond);
    size = size + _i8.ConfigOp.codec.sizeHint(minValidatorBond);
    size = size + _i9.ConfigOp.codec.sizeHint(maxNominatorCount);
    size = size + _i9.ConfigOp.codec.sizeHint(maxValidatorCount);
    size = size + _i10.ConfigOp.codec.sizeHint(chillThreshold);
    size = size + _i11.ConfigOp.codec.sizeHint(minCommission);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
    _i8.ConfigOp.codec.encodeTo(
      minNominatorBond,
      output,
    );
    _i8.ConfigOp.codec.encodeTo(
      minValidatorBond,
      output,
    );
    _i9.ConfigOp.codec.encodeTo(
      maxNominatorCount,
      output,
    );
    _i9.ConfigOp.codec.encodeTo(
      maxValidatorCount,
      output,
    );
    _i10.ConfigOp.codec.encodeTo(
      chillThreshold,
      output,
    );
    _i11.ConfigOp.codec.encodeTo(
      minCommission,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetStakingConfigs &&
          other.minNominatorBond == minNominatorBond &&
          other.minValidatorBond == minValidatorBond &&
          other.maxNominatorCount == maxNominatorCount &&
          other.maxValidatorCount == maxValidatorCount &&
          other.chillThreshold == chillThreshold &&
          other.minCommission == minCommission;

  @override
  int get hashCode => Object.hash(
        minNominatorBond,
        minValidatorBond,
        maxNominatorCount,
        maxValidatorCount,
        chillThreshold,
        minCommission,
      );
}

/// Declare a `controller` to stop participating as either a validator or nominator.
///
/// Effects will be felt at the beginning of the next era.
///
/// The dispatch origin for this call must be _Signed_, but can be called by anyone.
///
/// If the caller is the same as the controller being targeted, then no further checks are
/// enforced, and this function behaves just like `chill`.
///
/// If the caller is different than the controller being targeted, the following conditions
/// must be met:
///
/// * `controller` must belong to a nominator who has become non-decodable,
///
/// Or:
///
/// * A `ChillThreshold` must be set and checked which defines how close to the max
///  nominators or validators we must reach before users can start chilling one-another.
/// * A `MaxNominatorCount` and `MaxValidatorCount` must be set which is used to determine
///  how close we are to the threshold.
/// * A `MinNominatorBond` and `MinValidatorBond` must be set and checked, which determines
///  if this is a person that should be chilled because they have not met the threshold
///  bond required.
///
/// This can be helpful if bond requirements are updated, and we need to remove old users
/// who do not satisfy these requirements.
class ChillOther extends Call {
  const ChillOther({required this.controller});

  factory ChillOther._decode(_i1.Input input) {
    return ChillOther(controller: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i7.AccountId32 controller;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'chill_other': {'controller': controller.toList()}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.AccountId32Codec().sizeHint(controller);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      controller,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is ChillOther &&
          _i13.listsEqual(
            other.controller,
            controller,
          );

  @override
  int get hashCode => controller.hashCode;
}

/// Force a validator to have at least the minimum commission. This will not affect a
/// validator who already has a commission greater than or equal to the minimum. Any account
/// can call this.
class ForceApplyMinCommission extends Call {
  const ForceApplyMinCommission({required this.validatorStash});

  factory ForceApplyMinCommission._decode(_i1.Input input) {
    return ForceApplyMinCommission(
        validatorStash: const _i1.U8ArrayCodec(32).decode(input));
  }

  /// T::AccountId
  final _i7.AccountId32 validatorStash;

  @override
  Map<String, Map<String, List<int>>> toJson() => {
        'force_apply_min_commission': {
          'validatorStash': validatorStash.toList()
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i7.AccountId32Codec().sizeHint(validatorStash);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
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
      other is ForceApplyMinCommission &&
          _i13.listsEqual(
            other.validatorStash,
            validatorStash,
          );

  @override
  int get hashCode => validatorStash.hashCode;
}

/// Sets the minimum amount of commission that each validators must maintain.
///
/// This call has lower privilege requirements than `set_staking_config` and can be called
/// by the `T::AdminOrigin`. Root can always call this.
class SetMinCommission extends Call {
  const SetMinCommission({required this.new_});

  factory SetMinCommission._decode(_i1.Input input) {
    return SetMinCommission(new_: _i1.U32Codec.codec.decode(input));
  }

  /// Perbill
  final _i12.Perbill new_;

  @override
  Map<String, Map<String, int>> toJson() => {
        'set_min_commission': {'new': new_}
      };

  int _sizeHint() {
    int size = 1;
    size = size + const _i12.PerbillCodec().sizeHint(new_);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      new_,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SetMinCommission && other.new_ == new_;

  @override
  int get hashCode => new_.hashCode;
}
