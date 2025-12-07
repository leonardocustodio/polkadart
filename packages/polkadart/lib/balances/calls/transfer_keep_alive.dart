part of balances_calls;

class _BalancesTransferKeepAliveHelper {
  const _BalancesTransferKeepAliveHelper();
  BalancesTransferKeepAlive to({required String destination, required BigInt amount}) =>
      BalancesTransferKeepAlive.to(destination: destination, amount: amount);

  BalancesTransferKeepAlive toAccountId({required Uint8List destination, required BigInt amount}) =>
      BalancesTransferKeepAlive.toAccountId(destination: destination, amount: amount);

  BalancesTransferKeepAlive toMultiAddress({
    required MultiAddress destination,
    required BigInt amount,
  }) => BalancesTransferKeepAlive.toMultiAddress(destination: destination, amount: amount);
}

/// Balances.transfer_keep_alive call
///
/// Transfers funds while ensuring the sender stays above existential deposit.
/// This prevents the sender's account from being reaped.
///
/// Example:
/// ```dart
/// final call = BalancesTransferKeepAlive.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   amount: BigInt.from(1000000000000),
/// );
/// ```
class BalancesTransferKeepAlive extends BalancesCallBuilder {
  final MultiAddress dest;
  final BigInt amount;

  const BalancesTransferKeepAlive._(this.dest, this.amount);

  /// Create transfer_keep_alive using SS58 address
  factory BalancesTransferKeepAlive.to({required String destination, required BigInt amount}) =>
      BalancesTransferKeepAlive._(_ss58ToMultiAddress(destination), amount);

  /// Create transfer_keep_alive using raw account ID
  factory BalancesTransferKeepAlive.toAccountId({
    required Uint8List destination,
    required BigInt amount,
  }) => BalancesTransferKeepAlive._(MultiAddress.id(destination), amount);

  /// Create transfer_keep_alive using MultiAddress
  factory BalancesTransferKeepAlive.toMultiAddress({
    required MultiAddress destination,
    required BigInt amount,
  }) => BalancesTransferKeepAlive._(destination, amount);

  @override
  String get callName => 'transfer_keep_alive';

  @override
  Map<String, dynamic> buildArgs() => {'dest': dest.toJson(), 'value': amount};
}
