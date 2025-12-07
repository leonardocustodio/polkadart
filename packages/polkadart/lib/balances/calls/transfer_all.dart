part of balances_calls;

class _BalancesTransferAllHelper {
  const _BalancesTransferAllHelper();
  BalancesTransferAll to({required String destination, required bool keepAlive}) =>
      BalancesTransferAll.to(destination: destination, keepAlive: keepAlive);

  BalancesTransferAll toAccountId({required Uint8List destination, required bool keepAlive}) =>
      BalancesTransferAll.toAccountId(destination: destination, keepAlive: keepAlive);

  BalancesTransferAll toMultiAddress({
    required MultiAddress destination,
    required bool keepAlive,
  }) => BalancesTransferAll.toMultiAddress(destination: destination, keepAlive: keepAlive);
}

/// Balances.transfer_all call
///
/// Transfers all free balance to the destination. The `keepAlive` parameter
/// determines whether to keep the sender account alive (stay above ED) or
/// allow it to be reaped.
///
/// Example:
/// ```dart
/// // Transfer all and keep sender alive
/// final call = Balances.transferAll.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   keepAlive: true,
/// );
///
/// // Transfer all and reap sender account
/// final call = Balances.transferAll.to(
///   destination: '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY',
///   keepAlive: false,
/// );
/// ```
class BalancesTransferAll extends BalancesCallBuilder {
  final MultiAddress dest;
  final bool keepAlive;

  const BalancesTransferAll._(this.dest, this.keepAlive);

  /// Create transfer_all using SS58 address
  factory BalancesTransferAll.to({required String destination, required bool keepAlive}) =>
      BalancesTransferAll._(_ss58ToMultiAddress(destination), keepAlive);

  /// Create transfer_all using raw account ID
  factory BalancesTransferAll.toAccountId({
    required Uint8List destination,
    required bool keepAlive,
  }) => BalancesTransferAll._(MultiAddress.id(destination), keepAlive);

  /// Create transfer_all using MultiAddress
  factory BalancesTransferAll.toMultiAddress({
    required MultiAddress destination,
    required bool keepAlive,
  }) => BalancesTransferAll._(destination, keepAlive);

  @override
  String get callName => 'transfer_all';

  @override
  Map<String, dynamic> buildArgs() => {'dest': dest.toJson(), 'keep_alive': keepAlive};
}
