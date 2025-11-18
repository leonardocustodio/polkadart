part of balances_calls;

class _BalancesForceTransferHelper {
  const _BalancesForceTransferHelper();
  BalancesForceTransfer to({
    required String source,
    required String destination,
    required BigInt amount,
  }) => BalancesForceTransfer.to(source: source, destination: destination, amount: amount);

  BalancesForceTransfer toAccountId({
    required Uint8List source,
    required Uint8List destination,
    required BigInt amount,
  }) => BalancesForceTransfer.toAccountId(source: source, destination: destination, amount: amount);

  BalancesForceTransfer toMultiAddress({
    required MultiAddress source,
    required MultiAddress destination,
    required BigInt amount,
  }) => BalancesForceTransfer.toMultiAddress(
    source: source,
    destination: destination,
    amount: amount,
  );
}

/// Balances.force_transfer call (requires root/sudo)
///
/// Force a transfer to one account to another. This requires root privileges
/// (typically via sudo pallet).
///
/// Example:
/// ```dart
/// final call = Balances.forceTransfer.to(
///   source: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   destination: '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty',
///   amount: BigInt.from(1000000000000),
/// );
/// ```
class BalancesForceTransfer extends BalancesCallBuilder {
  final MultiAddress source;
  final MultiAddress dest;
  final BigInt amount;

  const BalancesForceTransfer._(this.source, this.dest, this.amount);

  /// Create force_transfer using SS58 addresses
  factory BalancesForceTransfer.to({
    required String source,
    required String destination,
    required BigInt amount,
  }) => BalancesForceTransfer._(
    _ss58ToMultiAddress(source),
    _ss58ToMultiAddress(destination),
    amount,
  );

  /// Create force_transfer using raw account IDs
  factory BalancesForceTransfer.toAccountId({
    required Uint8List source,
    required Uint8List destination,
    required BigInt amount,
  }) => BalancesForceTransfer._(MultiAddress.id(source), MultiAddress.id(destination), amount);

  /// Create force_transfer using MultiAddress
  factory BalancesForceTransfer.toMultiAddress({
    required MultiAddress source,
    required MultiAddress destination,
    required BigInt amount,
  }) => BalancesForceTransfer._(source, destination, amount);

  @override
  String get callName => 'force_transfer';

  @override
  Map<String, dynamic> buildArgs() => {
    'source': source.toJson(),
    'dest': dest.toJson(),
    'value': amount,
  };
}
