part of balances_calls;

class _BalancesForceSetBalanceHelper {
  const _BalancesForceSetBalanceHelper();
  BalancesForceSetBalance to({required String who, required BigInt newFree}) =>
      BalancesForceSetBalance.to(who: who, newFree: newFree);

  BalancesForceSetBalance toAccountId({required Uint8List who, required BigInt newFree}) =>
      BalancesForceSetBalance.toAccountId(who: who, newFree: newFree);

  BalancesForceSetBalance toMultiAddress({required MultiAddress who, required BigInt newFree}) =>
      BalancesForceSetBalance.toMultiAddress(who: who, newFree: newFree);
}

/// Balances.force_set_balance call (requires root/sudo)
///
/// Set the free balance of an account to a specific value. This requires root
/// privileges (typically via sudo pallet). Available on newer chains.
///
/// Example:
/// ```dart
/// final call = Balances.forceSetBalance.to(
///   who: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   newFree: BigInt.from(1000000000000),
/// );
/// ```
class BalancesForceSetBalance extends BalancesCallBuilder {
  final MultiAddress who;
  final BigInt newFree;
  const BalancesForceSetBalance._(this.who, this.newFree);

  /// Create force_set_balance using SS58 address
  factory BalancesForceSetBalance.to({required String who, required BigInt newFree}) =>
      BalancesForceSetBalance._(_ss58ToMultiAddress(who), newFree);

  /// Create force_set_balance using raw account ID
  factory BalancesForceSetBalance.toAccountId({required Uint8List who, required BigInt newFree}) =>
      BalancesForceSetBalance._(MultiAddress.id(who), newFree);

  /// Create force_set_balance using MultiAddress
  factory BalancesForceSetBalance.toMultiAddress({
    required MultiAddress who,
    required BigInt newFree,
  }) => BalancesForceSetBalance._(who, newFree);

  @override
  String get callName => 'force_set_balance';

  @override
  Map<String, dynamic> buildArgs() => {'who': who.toJson(), 'new_free': newFree};
}
