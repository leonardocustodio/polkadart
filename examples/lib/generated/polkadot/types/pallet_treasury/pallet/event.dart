// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:typed_data' as _i2;

import 'package:polkadart/scale_codec.dart' as _i1;
import 'package:quiver/collection.dart' as _i6;

import '../../polkadot_runtime_common/impls/versioned_locatable_asset.dart'
    as _i4;
import '../../sp_core/crypto/account_id32.dart' as _i3;
import '../../xcm/versioned_location.dart' as _i5;

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

  Spending spending({required BigInt budgetRemaining}) {
    return Spending(budgetRemaining: budgetRemaining);
  }

  Awarded awarded({
    required int proposalIndex,
    required BigInt award,
    required _i3.AccountId32 account,
  }) {
    return Awarded(
      proposalIndex: proposalIndex,
      award: award,
      account: account,
    );
  }

  Burnt burnt({required BigInt burntFunds}) {
    return Burnt(burntFunds: burntFunds);
  }

  Rollover rollover({required BigInt rolloverBalance}) {
    return Rollover(rolloverBalance: rolloverBalance);
  }

  Deposit deposit({required BigInt value}) {
    return Deposit(value: value);
  }

  SpendApproved spendApproved({
    required int proposalIndex,
    required BigInt amount,
    required _i3.AccountId32 beneficiary,
  }) {
    return SpendApproved(
      proposalIndex: proposalIndex,
      amount: amount,
      beneficiary: beneficiary,
    );
  }

  UpdatedInactive updatedInactive({
    required BigInt reactivated,
    required BigInt deactivated,
  }) {
    return UpdatedInactive(
      reactivated: reactivated,
      deactivated: deactivated,
    );
  }

  AssetSpendApproved assetSpendApproved({
    required int index,
    required _i4.VersionedLocatableAsset assetKind,
    required BigInt amount,
    required _i5.VersionedLocation beneficiary,
    required int validFrom,
    required int expireAt,
  }) {
    return AssetSpendApproved(
      index: index,
      assetKind: assetKind,
      amount: amount,
      beneficiary: beneficiary,
      validFrom: validFrom,
      expireAt: expireAt,
    );
  }

  AssetSpendVoided assetSpendVoided({required int index}) {
    return AssetSpendVoided(index: index);
  }

  Paid paid({
    required int index,
    required BigInt paymentId,
  }) {
    return Paid(
      index: index,
      paymentId: paymentId,
    );
  }

  PaymentFailed paymentFailed({
    required int index,
    required BigInt paymentId,
  }) {
    return PaymentFailed(
      index: index,
      paymentId: paymentId,
    );
  }

  SpendProcessed spendProcessed({required int index}) {
    return SpendProcessed(index: index);
  }
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Spending._decode(input);
      case 1:
        return Awarded._decode(input);
      case 2:
        return Burnt._decode(input);
      case 3:
        return Rollover._decode(input);
      case 4:
        return Deposit._decode(input);
      case 5:
        return SpendApproved._decode(input);
      case 6:
        return UpdatedInactive._decode(input);
      case 7:
        return AssetSpendApproved._decode(input);
      case 8:
        return AssetSpendVoided._decode(input);
      case 9:
        return Paid._decode(input);
      case 10:
        return PaymentFailed._decode(input);
      case 11:
        return SpendProcessed._decode(input);
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
      case Spending:
        (value as Spending).encodeTo(output);
        break;
      case Awarded:
        (value as Awarded).encodeTo(output);
        break;
      case Burnt:
        (value as Burnt).encodeTo(output);
        break;
      case Rollover:
        (value as Rollover).encodeTo(output);
        break;
      case Deposit:
        (value as Deposit).encodeTo(output);
        break;
      case SpendApproved:
        (value as SpendApproved).encodeTo(output);
        break;
      case UpdatedInactive:
        (value as UpdatedInactive).encodeTo(output);
        break;
      case AssetSpendApproved:
        (value as AssetSpendApproved).encodeTo(output);
        break;
      case AssetSpendVoided:
        (value as AssetSpendVoided).encodeTo(output);
        break;
      case Paid:
        (value as Paid).encodeTo(output);
        break;
      case PaymentFailed:
        (value as PaymentFailed).encodeTo(output);
        break;
      case SpendProcessed:
        (value as SpendProcessed).encodeTo(output);
        break;
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Spending:
        return (value as Spending)._sizeHint();
      case Awarded:
        return (value as Awarded)._sizeHint();
      case Burnt:
        return (value as Burnt)._sizeHint();
      case Rollover:
        return (value as Rollover)._sizeHint();
      case Deposit:
        return (value as Deposit)._sizeHint();
      case SpendApproved:
        return (value as SpendApproved)._sizeHint();
      case UpdatedInactive:
        return (value as UpdatedInactive)._sizeHint();
      case AssetSpendApproved:
        return (value as AssetSpendApproved)._sizeHint();
      case AssetSpendVoided:
        return (value as AssetSpendVoided)._sizeHint();
      case Paid:
        return (value as Paid)._sizeHint();
      case PaymentFailed:
        return (value as PaymentFailed)._sizeHint();
      case SpendProcessed:
        return (value as SpendProcessed)._sizeHint();
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// We have ended a spend period and will now allocate funds.
class Spending extends Event {
  const Spending({required this.budgetRemaining});

  factory Spending._decode(_i1.Input input) {
    return Spending(budgetRemaining: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T, I>
  final BigInt budgetRemaining;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Spending': {'budgetRemaining': budgetRemaining}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(budgetRemaining);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      budgetRemaining,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Spending && other.budgetRemaining == budgetRemaining;

  @override
  int get hashCode => budgetRemaining.hashCode;
}

/// Some funds have been allocated.
class Awarded extends Event {
  const Awarded({
    required this.proposalIndex,
    required this.award,
    required this.account,
  });

  factory Awarded._decode(_i1.Input input) {
    return Awarded(
      proposalIndex: _i1.U32Codec.codec.decode(input),
      award: _i1.U128Codec.codec.decode(input),
      account: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ProposalIndex
  final int proposalIndex;

  /// BalanceOf<T, I>
  final BigInt award;

  /// T::AccountId
  final _i3.AccountId32 account;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Awarded': {
          'proposalIndex': proposalIndex,
          'award': award,
          'account': account.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + _i1.U128Codec.codec.sizeHint(award);
    size = size + const _i3.AccountId32Codec().sizeHint(account);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      1,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      award,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      account,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Awarded &&
          other.proposalIndex == proposalIndex &&
          other.award == award &&
          _i6.listsEqual(
            other.account,
            account,
          );

  @override
  int get hashCode => Object.hash(
        proposalIndex,
        award,
        account,
      );
}

/// Some of our funds have been burnt.
class Burnt extends Event {
  const Burnt({required this.burntFunds});

  factory Burnt._decode(_i1.Input input) {
    return Burnt(burntFunds: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T, I>
  final BigInt burntFunds;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Burnt': {'burntFunds': burntFunds}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(burntFunds);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      2,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      burntFunds,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Burnt && other.burntFunds == burntFunds;

  @override
  int get hashCode => burntFunds.hashCode;
}

/// Spending has finished; this is the amount that rolls over until next spend.
class Rollover extends Event {
  const Rollover({required this.rolloverBalance});

  factory Rollover._decode(_i1.Input input) {
    return Rollover(rolloverBalance: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T, I>
  final BigInt rolloverBalance;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Rollover': {'rolloverBalance': rolloverBalance}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(rolloverBalance);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      rolloverBalance,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rollover && other.rolloverBalance == rolloverBalance;

  @override
  int get hashCode => rolloverBalance.hashCode;
}

/// Some funds have been deposited.
class Deposit extends Event {
  const Deposit({required this.value});

  factory Deposit._decode(_i1.Input input) {
    return Deposit(value: _i1.U128Codec.codec.decode(input));
  }

  /// BalanceOf<T, I>
  final BigInt value;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'Deposit': {'value': value}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(value);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      4,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
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
      other is Deposit && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

/// A new spend proposal has been approved.
class SpendApproved extends Event {
  const SpendApproved({
    required this.proposalIndex,
    required this.amount,
    required this.beneficiary,
  });

  factory SpendApproved._decode(_i1.Input input) {
    return SpendApproved(
      proposalIndex: _i1.U32Codec.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      beneficiary: const _i1.U8ArrayCodec(32).decode(input),
    );
  }

  /// ProposalIndex
  final int proposalIndex;

  /// BalanceOf<T, I>
  final BigInt amount;

  /// T::AccountId
  final _i3.AccountId32 beneficiary;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'SpendApproved': {
          'proposalIndex': proposalIndex,
          'amount': amount,
          'beneficiary': beneficiary.toList(),
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size + const _i3.AccountId32Codec().sizeHint(beneficiary);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      5,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    const _i1.U8ArrayCodec(32).encodeTo(
      beneficiary,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpendApproved &&
          other.proposalIndex == proposalIndex &&
          other.amount == amount &&
          _i6.listsEqual(
            other.beneficiary,
            beneficiary,
          );

  @override
  int get hashCode => Object.hash(
        proposalIndex,
        amount,
        beneficiary,
      );
}

/// The inactive funds of the pallet have been updated.
class UpdatedInactive extends Event {
  const UpdatedInactive({
    required this.reactivated,
    required this.deactivated,
  });

  factory UpdatedInactive._decode(_i1.Input input) {
    return UpdatedInactive(
      reactivated: _i1.U128Codec.codec.decode(input),
      deactivated: _i1.U128Codec.codec.decode(input),
    );
  }

  /// BalanceOf<T, I>
  final BigInt reactivated;

  /// BalanceOf<T, I>
  final BigInt deactivated;

  @override
  Map<String, Map<String, BigInt>> toJson() => {
        'UpdatedInactive': {
          'reactivated': reactivated,
          'deactivated': deactivated,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U128Codec.codec.sizeHint(reactivated);
    size = size + _i1.U128Codec.codec.sizeHint(deactivated);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      6,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      reactivated,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      deactivated,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is UpdatedInactive &&
          other.reactivated == reactivated &&
          other.deactivated == deactivated;

  @override
  int get hashCode => Object.hash(
        reactivated,
        deactivated,
      );
}

/// A new asset spend proposal has been approved.
class AssetSpendApproved extends Event {
  const AssetSpendApproved({
    required this.index,
    required this.assetKind,
    required this.amount,
    required this.beneficiary,
    required this.validFrom,
    required this.expireAt,
  });

  factory AssetSpendApproved._decode(_i1.Input input) {
    return AssetSpendApproved(
      index: _i1.U32Codec.codec.decode(input),
      assetKind: _i4.VersionedLocatableAsset.codec.decode(input),
      amount: _i1.U128Codec.codec.decode(input),
      beneficiary: _i5.VersionedLocation.codec.decode(input),
      validFrom: _i1.U32Codec.codec.decode(input),
      expireAt: _i1.U32Codec.codec.decode(input),
    );
  }

  /// SpendIndex
  final int index;

  /// T::AssetKind
  final _i4.VersionedLocatableAsset assetKind;

  /// AssetBalanceOf<T, I>
  final BigInt amount;

  /// T::Beneficiary
  final _i5.VersionedLocation beneficiary;

  /// BlockNumberFor<T>
  final int validFrom;

  /// BlockNumberFor<T>
  final int expireAt;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'AssetSpendApproved': {
          'index': index,
          'assetKind': assetKind.toJson(),
          'amount': amount,
          'beneficiary': beneficiary.toJson(),
          'validFrom': validFrom,
          'expireAt': expireAt,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i4.VersionedLocatableAsset.codec.sizeHint(assetKind);
    size = size + _i1.U128Codec.codec.sizeHint(amount);
    size = size + _i5.VersionedLocation.codec.sizeHint(beneficiary);
    size = size + _i1.U32Codec.codec.sizeHint(validFrom);
    size = size + _i1.U32Codec.codec.sizeHint(expireAt);
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
    _i4.VersionedLocatableAsset.codec.encodeTo(
      assetKind,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      amount,
      output,
    );
    _i5.VersionedLocation.codec.encodeTo(
      beneficiary,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      validFrom,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      expireAt,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is AssetSpendApproved &&
          other.index == index &&
          other.assetKind == assetKind &&
          other.amount == amount &&
          other.beneficiary == beneficiary &&
          other.validFrom == validFrom &&
          other.expireAt == expireAt;

  @override
  int get hashCode => Object.hash(
        index,
        assetKind,
        amount,
        beneficiary,
        validFrom,
        expireAt,
      );
}

/// An approved spend was voided.
class AssetSpendVoided extends Event {
  const AssetSpendVoided({required this.index});

  factory AssetSpendVoided._decode(_i1.Input input) {
    return AssetSpendVoided(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'AssetSpendVoided': {'index': index}
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
      other is AssetSpendVoided && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

/// A payment happened.
class Paid extends Event {
  const Paid({
    required this.index,
    required this.paymentId,
  });

  factory Paid._decode(_i1.Input input) {
    return Paid(
      index: _i1.U32Codec.codec.decode(input),
      paymentId: _i1.U64Codec.codec.decode(input),
    );
  }

  /// SpendIndex
  final int index;

  /// <T::Paymaster as Pay>::Id
  final BigInt paymentId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Paid': {
          'index': index,
          'paymentId': paymentId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U64Codec.codec.sizeHint(paymentId);
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
    _i1.U64Codec.codec.encodeTo(
      paymentId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Paid && other.index == index && other.paymentId == paymentId;

  @override
  int get hashCode => Object.hash(
        index,
        paymentId,
      );
}

/// A payment failed and can be retried.
class PaymentFailed extends Event {
  const PaymentFailed({
    required this.index,
    required this.paymentId,
  });

  factory PaymentFailed._decode(_i1.Input input) {
    return PaymentFailed(
      index: _i1.U32Codec.codec.decode(input),
      paymentId: _i1.U64Codec.codec.decode(input),
    );
  }

  /// SpendIndex
  final int index;

  /// <T::Paymaster as Pay>::Id
  final BigInt paymentId;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'PaymentFailed': {
          'index': index,
          'paymentId': paymentId,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
    size = size + _i1.U64Codec.codec.sizeHint(paymentId);
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
    _i1.U64Codec.codec.encodeTo(
      paymentId,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is PaymentFailed &&
          other.index == index &&
          other.paymentId == paymentId;

  @override
  int get hashCode => Object.hash(
        index,
        paymentId,
      );
}

/// A spend was processed and removed from the storage. It might have been successfully
/// paid or it may have expired.
class SpendProcessed extends Event {
  const SpendProcessed({required this.index});

  factory SpendProcessed._decode(_i1.Input input) {
    return SpendProcessed(index: _i1.U32Codec.codec.decode(input));
  }

  /// SpendIndex
  final int index;

  @override
  Map<String, Map<String, int>> toJson() => {
        'SpendProcessed': {'index': index}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(index);
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
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is SpendProcessed && other.index == index;

  @override
  int get hashCode => index.hashCode;
}
