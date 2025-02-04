// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;

import 'defensive_error.dart' as _i3;

/// The `Error` enum of this pallet.
abstract class Error {
  const Error();

  factory Error.decode(_i1.Input input) {
    return codec.decode(input);
  }

  static const $ErrorCodec codec = $ErrorCodec();

  static const $Error values = $Error();

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

class $Error {
  const $Error();

  PoolNotFound poolNotFound() {
    return PoolNotFound();
  }

  PoolMemberNotFound poolMemberNotFound() {
    return PoolMemberNotFound();
  }

  RewardPoolNotFound rewardPoolNotFound() {
    return RewardPoolNotFound();
  }

  SubPoolsNotFound subPoolsNotFound() {
    return SubPoolsNotFound();
  }

  AccountBelongsToOtherPool accountBelongsToOtherPool() {
    return AccountBelongsToOtherPool();
  }

  FullyUnbonding fullyUnbonding() {
    return FullyUnbonding();
  }

  MaxUnbondingLimit maxUnbondingLimit() {
    return MaxUnbondingLimit();
  }

  CannotWithdrawAny cannotWithdrawAny() {
    return CannotWithdrawAny();
  }

  MinimumBondNotMet minimumBondNotMet() {
    return MinimumBondNotMet();
  }

  OverflowRisk overflowRisk() {
    return OverflowRisk();
  }

  NotDestroying notDestroying() {
    return NotDestroying();
  }

  NotNominator notNominator() {
    return NotNominator();
  }

  NotKickerOrDestroying notKickerOrDestroying() {
    return NotKickerOrDestroying();
  }

  NotOpen notOpen() {
    return NotOpen();
  }

  MaxPools maxPools() {
    return MaxPools();
  }

  MaxPoolMembers maxPoolMembers() {
    return MaxPoolMembers();
  }

  CanNotChangeState canNotChangeState() {
    return CanNotChangeState();
  }

  DoesNotHavePermission doesNotHavePermission() {
    return DoesNotHavePermission();
  }

  MetadataExceedsMaxLen metadataExceedsMaxLen() {
    return MetadataExceedsMaxLen();
  }

  Defensive defensive(_i3.DefensiveError value0) {
    return Defensive(value0);
  }

  PartialUnbondNotAllowedPermissionlessly
      partialUnbondNotAllowedPermissionlessly() {
    return PartialUnbondNotAllowedPermissionlessly();
  }

  MaxCommissionRestricted maxCommissionRestricted() {
    return MaxCommissionRestricted();
  }

  CommissionExceedsMaximum commissionExceedsMaximum() {
    return CommissionExceedsMaximum();
  }

  CommissionExceedsGlobalMaximum commissionExceedsGlobalMaximum() {
    return CommissionExceedsGlobalMaximum();
  }

  CommissionChangeThrottled commissionChangeThrottled() {
    return CommissionChangeThrottled();
  }

  CommissionChangeRateNotAllowed commissionChangeRateNotAllowed() {
    return CommissionChangeRateNotAllowed();
  }

  NoPendingCommission noPendingCommission() {
    return NoPendingCommission();
  }

  NoCommissionCurrentSet noCommissionCurrentSet() {
    return NoCommissionCurrentSet();
  }

  PoolIdInUse poolIdInUse() {
    return PoolIdInUse();
  }

  InvalidPoolId invalidPoolId() {
    return InvalidPoolId();
  }

  BondExtraRestricted bondExtraRestricted() {
    return BondExtraRestricted();
  }

  NothingToAdjust nothingToAdjust() {
    return NothingToAdjust();
  }

  NothingToSlash nothingToSlash() {
    return NothingToSlash();
  }

  AlreadyMigrated alreadyMigrated() {
    return AlreadyMigrated();
  }

  NotMigrated notMigrated() {
    return NotMigrated();
  }

  NotSupported notSupported() {
    return NotSupported();
  }
}

class $ErrorCodec with _i1.Codec<Error> {
  const $ErrorCodec();

  @override
  Error decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return const PoolNotFound();
      case 1:
        return const PoolMemberNotFound();
      case 2:
        return const RewardPoolNotFound();
      case 3:
        return const SubPoolsNotFound();
      case 4:
        return const AccountBelongsToOtherPool();
      case 5:
        return const FullyUnbonding();
      case 6:
        return const MaxUnbondingLimit();
      case 7:
        return const CannotWithdrawAny();
      case 8:
        return const MinimumBondNotMet();
      case 9:
        return const OverflowRisk();
      case 10:
        return const NotDestroying();
      case 11:
        return const NotNominator();
      case 12:
        return const NotKickerOrDestroying();
      case 13:
        return const NotOpen();
      case 14:
        return const MaxPools();
      case 15:
        return const MaxPoolMembers();
      case 16:
        return const CanNotChangeState();
      case 17:
        return const DoesNotHavePermission();
      case 18:
        return const MetadataExceedsMaxLen();
      case 19:
        return Defensive._decode(input);
      case 20:
        return const PartialUnbondNotAllowedPermissionlessly();
      case 21:
        return const MaxCommissionRestricted();
      case 22:
        return const CommissionExceedsMaximum();
      case 23:
        return const CommissionExceedsGlobalMaximum();
      case 24:
        return const CommissionChangeThrottled();
      case 25:
        return const CommissionChangeRateNotAllowed();
      case 26:
        return const NoPendingCommission();
      case 27:
        return const NoCommissionCurrentSet();
      case 28:
        return const PoolIdInUse();
      case 29:
        return const InvalidPoolId();
      case 30:
        return const BondExtraRestricted();
      case 31:
        return const NothingToAdjust();
      case 32:
        return const NothingToSlash();
      case 33:
        return const AlreadyMigrated();
      case 34:
        return const NotMigrated();
      case 35:
        return const NotSupported();
      default:
        throw Exception('Error: Invalid variant index: "$index"');
    }
  }

  @override
  void encodeTo(
    Error value,
    _i1.Output output,
  ) {
    switch (value.runtimeType) {
      case PoolNotFound:
        (value as PoolNotFound).encodeTo(output);
        break;
      case PoolMemberNotFound:
        (value as PoolMemberNotFound).encodeTo(output);
        break;
      case RewardPoolNotFound:
        (value as RewardPoolNotFound).encodeTo(output);
        break;
      case SubPoolsNotFound:
        (value as SubPoolsNotFound).encodeTo(output);
        break;
      case AccountBelongsToOtherPool:
        (value as AccountBelongsToOtherPool).encodeTo(output);
        break;
      case FullyUnbonding:
        (value as FullyUnbonding).encodeTo(output);
        break;
      case MaxUnbondingLimit:
        (value as MaxUnbondingLimit).encodeTo(output);
        break;
      case CannotWithdrawAny:
        (value as CannotWithdrawAny).encodeTo(output);
        break;
      case MinimumBondNotMet:
        (value as MinimumBondNotMet).encodeTo(output);
        break;
      case OverflowRisk:
        (value as OverflowRisk).encodeTo(output);
        break;
      case NotDestroying:
        (value as NotDestroying).encodeTo(output);
        break;
      case NotNominator:
        (value as NotNominator).encodeTo(output);
        break;
      case NotKickerOrDestroying:
        (value as NotKickerOrDestroying).encodeTo(output);
        break;
      case NotOpen:
        (value as NotOpen).encodeTo(output);
        break;
      case MaxPools:
        (value as MaxPools).encodeTo(output);
        break;
      case MaxPoolMembers:
        (value as MaxPoolMembers).encodeTo(output);
        break;
      case CanNotChangeState:
        (value as CanNotChangeState).encodeTo(output);
        break;
      case DoesNotHavePermission:
        (value as DoesNotHavePermission).encodeTo(output);
        break;
      case MetadataExceedsMaxLen:
        (value as MetadataExceedsMaxLen).encodeTo(output);
        break;
      case Defensive:
        (value as Defensive).encodeTo(output);
        break;
      case PartialUnbondNotAllowedPermissionlessly:
        (value as PartialUnbondNotAllowedPermissionlessly).encodeTo(output);
        break;
      case MaxCommissionRestricted:
        (value as MaxCommissionRestricted).encodeTo(output);
        break;
      case CommissionExceedsMaximum:
        (value as CommissionExceedsMaximum).encodeTo(output);
        break;
      case CommissionExceedsGlobalMaximum:
        (value as CommissionExceedsGlobalMaximum).encodeTo(output);
        break;
      case CommissionChangeThrottled:
        (value as CommissionChangeThrottled).encodeTo(output);
        break;
      case CommissionChangeRateNotAllowed:
        (value as CommissionChangeRateNotAllowed).encodeTo(output);
        break;
      case NoPendingCommission:
        (value as NoPendingCommission).encodeTo(output);
        break;
      case NoCommissionCurrentSet:
        (value as NoCommissionCurrentSet).encodeTo(output);
        break;
      case PoolIdInUse:
        (value as PoolIdInUse).encodeTo(output);
        break;
      case InvalidPoolId:
        (value as InvalidPoolId).encodeTo(output);
        break;
      case BondExtraRestricted:
        (value as BondExtraRestricted).encodeTo(output);
        break;
      case NothingToAdjust:
        (value as NothingToAdjust).encodeTo(output);
        break;
      case NothingToSlash:
        (value as NothingToSlash).encodeTo(output);
        break;
      case AlreadyMigrated:
        (value as AlreadyMigrated).encodeTo(output);
        break;
      case NotMigrated:
        (value as NotMigrated).encodeTo(output);
        break;
      case NotSupported:
        (value as NotSupported).encodeTo(output);
        break;
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Error value) {
    switch (value.runtimeType) {
      case PoolNotFound:
        return 1;
      case PoolMemberNotFound:
        return 1;
      case RewardPoolNotFound:
        return 1;
      case SubPoolsNotFound:
        return 1;
      case AccountBelongsToOtherPool:
        return 1;
      case FullyUnbonding:
        return 1;
      case MaxUnbondingLimit:
        return 1;
      case CannotWithdrawAny:
        return 1;
      case MinimumBondNotMet:
        return 1;
      case OverflowRisk:
        return 1;
      case NotDestroying:
        return 1;
      case NotNominator:
        return 1;
      case NotKickerOrDestroying:
        return 1;
      case NotOpen:
        return 1;
      case MaxPools:
        return 1;
      case MaxPoolMembers:
        return 1;
      case CanNotChangeState:
        return 1;
      case DoesNotHavePermission:
        return 1;
      case MetadataExceedsMaxLen:
        return 1;
      case Defensive:
        return (value as Defensive)._sizeHint();
      case PartialUnbondNotAllowedPermissionlessly:
        return 1;
      case MaxCommissionRestricted:
        return 1;
      case CommissionExceedsMaximum:
        return 1;
      case CommissionExceedsGlobalMaximum:
        return 1;
      case CommissionChangeThrottled:
        return 1;
      case CommissionChangeRateNotAllowed:
        return 1;
      case NoPendingCommission:
        return 1;
      case NoCommissionCurrentSet:
        return 1;
      case PoolIdInUse:
        return 1;
      case InvalidPoolId:
        return 1;
      case BondExtraRestricted:
        return 1;
      case NothingToAdjust:
        return 1;
      case NothingToSlash:
        return 1;
      case AlreadyMigrated:
        return 1;
      case NotMigrated:
        return 1;
      case NotSupported:
        return 1;
      default:
        throw Exception(
            'Error: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// A (bonded) pool id does not exist.
class PoolNotFound extends Error {
  const PoolNotFound();

  @override
  Map<String, dynamic> toJson() => {'PoolNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is PoolNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// An account is not a member.
class PoolMemberNotFound extends Error {
  const PoolMemberNotFound();

  @override
  Map<String, dynamic> toJson() => {'PoolMemberNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is PoolMemberNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A reward pool does not exist. In all cases this is a system logic error.
class RewardPoolNotFound extends Error {
  const RewardPoolNotFound();

  @override
  Map<String, dynamic> toJson() => {'RewardPoolNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is RewardPoolNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A sub pool does not exist.
class SubPoolsNotFound extends Error {
  const SubPoolsNotFound();

  @override
  Map<String, dynamic> toJson() => {'SubPoolsNotFound': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is SubPoolsNotFound;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// An account is already delegating in another pool. An account may only belong to one
/// pool at a time.
class AccountBelongsToOtherPool extends Error {
  const AccountBelongsToOtherPool();

  @override
  Map<String, dynamic> toJson() => {'AccountBelongsToOtherPool': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AccountBelongsToOtherPool;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The member is fully unbonded (and thus cannot access the bonded and reward pool
/// anymore to, for example, collect rewards).
class FullyUnbonding extends Error {
  const FullyUnbonding();

  @override
  Map<String, dynamic> toJson() => {'FullyUnbonding': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is FullyUnbonding;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The member cannot unbond further chunks due to reaching the limit.
class MaxUnbondingLimit extends Error {
  const MaxUnbondingLimit();

  @override
  Map<String, dynamic> toJson() => {'MaxUnbondingLimit': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MaxUnbondingLimit;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// None of the funds can be withdrawn yet because the bonding duration has not passed.
class CannotWithdrawAny extends Error {
  const CannotWithdrawAny();

  @override
  Map<String, dynamic> toJson() => {'CannotWithdrawAny': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      7,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CannotWithdrawAny;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The amount does not meet the minimum bond to either join or create a pool.
///
/// The depositor can never unbond to a value less than `Pallet::depositor_min_bond`. The
/// caller does not have nominating permissions for the pool. Members can never unbond to a
/// value below `MinJoinBond`.
class MinimumBondNotMet extends Error {
  const MinimumBondNotMet();

  @override
  Map<String, dynamic> toJson() => {'MinimumBondNotMet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      8,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MinimumBondNotMet;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The transaction could not be executed due to overflow risk for the pool.
class OverflowRisk extends Error {
  const OverflowRisk();

  @override
  Map<String, dynamic> toJson() => {'OverflowRisk': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      9,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is OverflowRisk;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// A pool must be in [`PoolState::Destroying`] in order for the depositor to unbond or for
/// other members to be permissionlessly unbonded.
class NotDestroying extends Error {
  const NotDestroying();

  @override
  Map<String, dynamic> toJson() => {'NotDestroying': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      10,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotDestroying;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The caller does not have nominating permissions for the pool.
class NotNominator extends Error {
  const NotNominator();

  @override
  Map<String, dynamic> toJson() => {'NotNominator': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      11,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotNominator;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Either a) the caller cannot make a valid kick or b) the pool is not destroying.
class NotKickerOrDestroying extends Error {
  const NotKickerOrDestroying();

  @override
  Map<String, dynamic> toJson() => {'NotKickerOrDestroying': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      12,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotKickerOrDestroying;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The pool is not open to join
class NotOpen extends Error {
  const NotOpen();

  @override
  Map<String, dynamic> toJson() => {'NotOpen': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      13,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotOpen;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The system is maxed out on pools.
class MaxPools extends Error {
  const MaxPools();

  @override
  Map<String, dynamic> toJson() => {'MaxPools': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      14,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MaxPools;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Too many members in the pool or system.
class MaxPoolMembers extends Error {
  const MaxPoolMembers();

  @override
  Map<String, dynamic> toJson() => {'MaxPoolMembers': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      15,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MaxPoolMembers;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The pools state cannot be changed.
class CanNotChangeState extends Error {
  const CanNotChangeState();

  @override
  Map<String, dynamic> toJson() => {'CanNotChangeState': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      16,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CanNotChangeState;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The caller does not have adequate permissions.
class DoesNotHavePermission extends Error {
  const DoesNotHavePermission();

  @override
  Map<String, dynamic> toJson() => {'DoesNotHavePermission': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      17,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is DoesNotHavePermission;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Metadata exceeds [`Config::MaxMetadataLen`]
class MetadataExceedsMaxLen extends Error {
  const MetadataExceedsMaxLen();

  @override
  Map<String, dynamic> toJson() => {'MetadataExceedsMaxLen': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      18,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MetadataExceedsMaxLen;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Some error occurred that should never happen. This should be reported to the
/// maintainers.
class Defensive extends Error {
  const Defensive(this.value0);

  factory Defensive._decode(_i1.Input input) {
    return Defensive(_i3.DefensiveError.codec.decode(input));
  }

  /// DefensiveError
  final _i3.DefensiveError value0;

  @override
  Map<String, String> toJson() => {'Defensive': value0.toJson()};

  int _sizeHint() {
    int size = 1;
    size = size + _i3.DefensiveError.codec.sizeHint(value0);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      19,
      output,
    );
    _i3.DefensiveError.codec.encodeTo(
      value0,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Defensive && other.value0 == value0;

  @override
  int get hashCode => value0.hashCode;
}

/// Partial unbonding now allowed permissionlessly.
class PartialUnbondNotAllowedPermissionlessly extends Error {
  const PartialUnbondNotAllowedPermissionlessly();

  @override
  Map<String, dynamic> toJson() =>
      {'PartialUnbondNotAllowedPermissionlessly': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      20,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is PartialUnbondNotAllowedPermissionlessly;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The pool's max commission cannot be set higher than the existing value.
class MaxCommissionRestricted extends Error {
  const MaxCommissionRestricted();

  @override
  Map<String, dynamic> toJson() => {'MaxCommissionRestricted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      21,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is MaxCommissionRestricted;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The supplied commission exceeds the max allowed commission.
class CommissionExceedsMaximum extends Error {
  const CommissionExceedsMaximum();

  @override
  Map<String, dynamic> toJson() => {'CommissionExceedsMaximum': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      22,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CommissionExceedsMaximum;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The supplied commission exceeds global maximum commission.
class CommissionExceedsGlobalMaximum extends Error {
  const CommissionExceedsGlobalMaximum();

  @override
  Map<String, dynamic> toJson() => {'CommissionExceedsGlobalMaximum': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      23,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CommissionExceedsGlobalMaximum;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Not enough blocks have surpassed since the last commission update.
class CommissionChangeThrottled extends Error {
  const CommissionChangeThrottled();

  @override
  Map<String, dynamic> toJson() => {'CommissionChangeThrottled': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      24,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CommissionChangeThrottled;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The submitted changes to commission change rate are not allowed.
class CommissionChangeRateNotAllowed extends Error {
  const CommissionChangeRateNotAllowed();

  @override
  Map<String, dynamic> toJson() => {'CommissionChangeRateNotAllowed': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      25,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is CommissionChangeRateNotAllowed;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// There is no pending commission to claim.
class NoPendingCommission extends Error {
  const NoPendingCommission();

  @override
  Map<String, dynamic> toJson() => {'NoPendingCommission': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      26,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NoPendingCommission;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// No commission current has been set.
class NoCommissionCurrentSet extends Error {
  const NoCommissionCurrentSet();

  @override
  Map<String, dynamic> toJson() => {'NoCommissionCurrentSet': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      27,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NoCommissionCurrentSet;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Pool id currently in use.
class PoolIdInUse extends Error {
  const PoolIdInUse();

  @override
  Map<String, dynamic> toJson() => {'PoolIdInUse': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      28,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is PoolIdInUse;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Pool id provided is not correct/usable.
class InvalidPoolId extends Error {
  const InvalidPoolId();

  @override
  Map<String, dynamic> toJson() => {'InvalidPoolId': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      29,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is InvalidPoolId;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// Bonding extra is restricted to the exact pending reward amount.
class BondExtraRestricted extends Error {
  const BondExtraRestricted();

  @override
  Map<String, dynamic> toJson() => {'BondExtraRestricted': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      30,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is BondExtraRestricted;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// No imbalance in the ED deposit for the pool.
class NothingToAdjust extends Error {
  const NothingToAdjust();

  @override
  Map<String, dynamic> toJson() => {'NothingToAdjust': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      31,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NothingToAdjust;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// No slash pending that can be applied to the member.
class NothingToSlash extends Error {
  const NothingToSlash();

  @override
  Map<String, dynamic> toJson() => {'NothingToSlash': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      32,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NothingToSlash;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The pool or member delegation has already migrated to delegate stake.
class AlreadyMigrated extends Error {
  const AlreadyMigrated();

  @override
  Map<String, dynamic> toJson() => {'AlreadyMigrated': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      33,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is AlreadyMigrated;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// The pool or member delegation has not migrated yet to delegate stake.
class NotMigrated extends Error {
  const NotMigrated();

  @override
  Map<String, dynamic> toJson() => {'NotMigrated': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      34,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotMigrated;

  @override
  int get hashCode => runtimeType.hashCode;
}

/// This call is not allowed in the current state of the pallet.
class NotSupported extends Error {
  const NotSupported();

  @override
  Map<String, dynamic> toJson() => {'NotSupported': null};

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      35,
      output,
    );
  }

  @override
  bool operator ==(Object other) => other is NotSupported;

  @override
  int get hashCode => runtimeType.hashCode;
}
