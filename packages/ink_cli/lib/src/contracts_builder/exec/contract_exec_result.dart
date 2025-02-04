part of ink_cli;

class ContractExecResult {
  final Map<String, dynamic> gasConsumed;
  final Map<String, dynamic> gasRequired;
  final Map<String, dynamic> storageDeposit;
  final String debugMessage;
  final ContractExecResultResult result;

  const ContractExecResult({
    required this.gasConsumed,
    required this.gasRequired,
    required this.storageDeposit,
    required this.debugMessage,
    required this.result,
  });

  static ContractExecResult fromJson(final Map<String, dynamic> json) {
    return ContractExecResult(
      gasConsumed: json['gasConsumed'],
      gasRequired: json['gasRequired'],
      storageDeposit: json['StorageDeposit'] ?? <String, dynamic>{},
      debugMessage: json['debugMessage'],
      result: ContractExecResultResult.fromJson(json['result']),
    );
  }
}
