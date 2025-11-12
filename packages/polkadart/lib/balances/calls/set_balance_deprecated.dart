part of balances_calls;

class _BalancesSetBalanceDeprecatedHelper {
  const _BalancesSetBalanceDeprecatedHelper();
  BalancesSetBalanceDeprecated to({
    required String who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated.to(who: who, newFree: newFree, newReserved: newReserved);

  BalancesSetBalanceDeprecated toAccountId({
    required Uint8List who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated.toAccountId(
          who: who, newFree: newFree, newReserved: newReserved);

  BalancesSetBalanceDeprecated toMultiAddress({
    required MultiAddress who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated.toMultiAddress(
          who: who, newFree: newFree, newReserved: newReserved);
}

// Shared helper to decode SS58 address to MultiAddress
MultiAddress _ss58ToMultiAddress(String address) => MultiAddress.id(Address.decode(address).pubkey);

/// Balances.set_balance_deprecated call (requires root/sudo, older chains)
///
/// Set both free and reserved balance of an account. This is deprecated on newer
/// chains in favor of force_set_balance. Requires root privileges.
///
/// Example:
/// ```dart
/// final call = Balances.setBalanceDeprecated.to(
///   who: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   newFree: BigInt.from(1000000000000),
///   newReserved: BigInt.from(100000000000),
/// );
/// ```
class BalancesSetBalanceDeprecated extends BalancesCallBuilder {
  final MultiAddress who;
  final BigInt newFree;
  final BigInt newReserved;

  const BalancesSetBalanceDeprecated._(this.who, this.newFree, this.newReserved);

  /// Create set_balance_deprecated using SS58 address
  factory BalancesSetBalanceDeprecated.to({
    required String who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated._(_ss58ToMultiAddress(who), newFree, newReserved);

  /// Create set_balance_deprecated using raw account ID
  factory BalancesSetBalanceDeprecated.toAccountId({
    required Uint8List who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated._(MultiAddress.id(who), newFree, newReserved);

  /// Create set_balance_deprecated using MultiAddress
  factory BalancesSetBalanceDeprecated.toMultiAddress({
    required MultiAddress who,
    required BigInt newFree,
    required BigInt newReserved,
  }) =>
      BalancesSetBalanceDeprecated._(who, newFree, newReserved);

  @override
  String get callName => 'set_balance_deprecated';

  @override
  Map<String, dynamic> buildArgs() =>
      {'who': who.toJson(), 'new_free': newFree, 'new_reserved': newReserved};
}
