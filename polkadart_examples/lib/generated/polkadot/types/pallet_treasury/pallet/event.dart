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

  Proposed proposed({required int proposalIndex}) {
    return Proposed(proposalIndex: proposalIndex);
  }

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

  Rejected rejected({
    required int proposalIndex,
    required BigInt slashed,
  }) {
    return Rejected(
      proposalIndex: proposalIndex,
      slashed: slashed,
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
}

class $EventCodec with _i1.Codec<Event> {
  const $EventCodec();

  @override
  Event decode(_i1.Input input) {
    final index = _i1.U8Codec.codec.decode(input);
    switch (index) {
      case 0:
        return Proposed._decode(input);
      case 1:
        return Spending._decode(input);
      case 2:
        return Awarded._decode(input);
      case 3:
        return Rejected._decode(input);
      case 4:
        return Burnt._decode(input);
      case 5:
        return Rollover._decode(input);
      case 6:
        return Deposit._decode(input);
      case 7:
        return SpendApproved._decode(input);
      case 8:
        return UpdatedInactive._decode(input);
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
      case Proposed:
        (value as Proposed).encodeTo(output);
        break;
      case Spending:
        (value as Spending).encodeTo(output);
        break;
      case Awarded:
        (value as Awarded).encodeTo(output);
        break;
      case Rejected:
        (value as Rejected).encodeTo(output);
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
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }

  @override
  int sizeHint(Event value) {
    switch (value.runtimeType) {
      case Proposed:
        return (value as Proposed)._sizeHint();
      case Spending:
        return (value as Spending)._sizeHint();
      case Awarded:
        return (value as Awarded)._sizeHint();
      case Rejected:
        return (value as Rejected)._sizeHint();
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
      default:
        throw Exception(
            'Event: Unsupported "$value" of type "${value.runtimeType}"');
    }
  }
}

/// New proposal.
class Proposed extends Event {
  const Proposed({required this.proposalIndex});

  factory Proposed._decode(_i1.Input input) {
    return Proposed(proposalIndex: _i1.U32Codec.codec.decode(input));
  }

  /// ProposalIndex
  final int proposalIndex;

  @override
  Map<String, Map<String, int>> toJson() => {
        'Proposed': {'proposalIndex': proposalIndex}
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      0,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Proposed && other.proposalIndex == proposalIndex;

  @override
  int get hashCode => proposalIndex.hashCode;
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
      1,
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
      2,
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
          _i4.listsEqual(
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

/// A proposal was rejected; funds were slashed.
class Rejected extends Event {
  const Rejected({
    required this.proposalIndex,
    required this.slashed,
  });

  factory Rejected._decode(_i1.Input input) {
    return Rejected(
      proposalIndex: _i1.U32Codec.codec.decode(input),
      slashed: _i1.U128Codec.codec.decode(input),
    );
  }

  /// ProposalIndex
  final int proposalIndex;

  /// BalanceOf<T, I>
  final BigInt slashed;

  @override
  Map<String, Map<String, dynamic>> toJson() => {
        'Rejected': {
          'proposalIndex': proposalIndex,
          'slashed': slashed,
        }
      };

  int _sizeHint() {
    int size = 1;
    size = size + _i1.U32Codec.codec.sizeHint(proposalIndex);
    size = size + _i1.U128Codec.codec.sizeHint(slashed);
    return size;
  }

  void encodeTo(_i1.Output output) {
    _i1.U8Codec.codec.encodeTo(
      3,
      output,
    );
    _i1.U32Codec.codec.encodeTo(
      proposalIndex,
      output,
    );
    _i1.U128Codec.codec.encodeTo(
      slashed,
      output,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(
        this,
        other,
      ) ||
      other is Rejected &&
          other.proposalIndex == proposalIndex &&
          other.slashed == slashed;

  @override
  int get hashCode => Object.hash(
        proposalIndex,
        slashed,
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
      4,
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
      5,
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
      6,
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
      7,
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
          _i4.listsEqual(
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
      8,
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
