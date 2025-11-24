part of balances_calls;

/// Top-level namespace for Balances pallet calls
///
/// Usage:
/// ```dart
/// // Transfer allowing death
/// final call = Balances.transfer.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   amount: BigInt.from(1000000000000),
/// );
///
/// // Transfer keep alive
/// final call = Balances.transferKeepAlive.toAccountId(
///   destination: receiverAccountId,
///   amount: BigInt.from(1000000000000),
/// );
///
/// // Transfer all
/// final call = Balances.transferAll.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   keepAlive: true,
/// );
/// ```
class Balances {
  /// Transfer allowing sender to go below existential deposit (may reap account)
  static const transfer = _BalancesTransferHelper();

  /// Transfer while keeping sender above existential deposit
  static const transferKeepAlive = _BalancesTransferKeepAliveHelper();

  /// Transfer all free balance
  static const transferAll = _BalancesTransferAllHelper();

  /// Force transfer (requires root/sudo)
  static const forceTransfer = _BalancesForceTransferHelper();

  /// Force set balance (requires root/sudo, newer chains)
  static const forceSetBalance = _BalancesForceSetBalanceHelper();

  /// Set balance deprecated (requires root/sudo, older chains)
  static const setBalanceDeprecated = _BalancesSetBalanceDeprecatedHelper();
}
