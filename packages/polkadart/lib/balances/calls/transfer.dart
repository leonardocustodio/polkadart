part of balances_calls;

// Helper classes - compact forwarding to implementation classes
class _BalancesTransferHelper {
  const _BalancesTransferHelper();
  BalancesTransfer to({
    required String destination,
    required BigInt amount,
  }) =>
      BalancesTransfer.to(destination: destination, amount: amount);

  BalancesTransfer toAccountId({
    required Uint8List destination,
    required BigInt amount,
  }) =>
      BalancesTransfer.toAccountId(destination: destination, amount: amount);

  BalancesTransfer toMultiAddress({
    required MultiAddress destination,
    required BigInt amount,
  }) =>
      BalancesTransfer.toMultiAddress(destination: destination, amount: amount);
}

/// Balances.transfer_allow_death call (commonly just "transfer")
///
/// Transfers funds to the sender to the destination, allowing the sender
/// to go below existential deposit (which will reap the account).
///
/// Example:
/// ```dart
/// // Using SS58 address (most user-friendly)
/// final call = BalancesTransfer.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   amount: BigInt.from(1000000000000), // 1 DOT (12 decimals)
/// );
///
/// // Using raw account ID
/// final call = BalancesTransfer.toAccountId(
///   destination: receiverAccountId,
///   amount: BigInt.from(1000000000000),
/// );
///
/// // Using MultiAddress (advanced)
/// final call = BalancesTransfer.toMultiAddress(
///   destination: MultiAddress.id(receiverAccountId),
///   amount: BigInt.from(1000000000000),
/// );
/// ```
class BalancesTransfer extends BalancesCallBuilder {
  final MultiAddress dest;
  final BigInt amount;

  const BalancesTransfer._(this.dest, this.amount);

  /// Create transfer using SS58 address (e.g., "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY")
  factory BalancesTransfer.to({
    required String destination,
    required BigInt amount,
  }) =>
      BalancesTransfer._(_ss58ToMultiAddress(destination), amount);

  /// Create transfer using raw account ID (32-byte public key)
  factory BalancesTransfer.toAccountId({
    required Uint8List destination,
    required BigInt amount,
  }) =>
      BalancesTransfer._(MultiAddress.id(destination), amount);

  /// Create transfer using MultiAddress (for advanced use cases like account indices)
  factory BalancesTransfer.toMultiAddress({
    required MultiAddress destination,
    required BigInt amount,
  }) =>
      BalancesTransfer._(destination, amount);

  @override
  String get callName => 'transfer_allow_death';

  @override
  Map<String, dynamic> buildArgs() => {'dest': dest.toJson(), 'value': amount};
}
