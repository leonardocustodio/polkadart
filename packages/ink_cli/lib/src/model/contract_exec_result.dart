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

class ContractExecResultResult {
  final ContractExecResultOk? ok;
  final dynamic err;

  const ContractExecResultResult({
    required this.ok,
    required this.err,
  });

  static ContractExecResultResult fromJson(final Map<String, dynamic> json) {
    return ContractExecResultResult(
      ok: json['Ok'] != null ? ContractExecResultOk.fromJson(json['Ok']) : null,
      err: json['Err'],
    );
  }
}

class ContractExecResultOk {
  final int flags;
  final List<int> data;
  final List<int> accountId;

  const ContractExecResultOk({
    required this.flags,
    required this.data,
    required this.accountId,
  });

  static ContractExecResultOk fromJson(final Map<String, dynamic> json) {
    return ContractExecResultOk(
      flags: json['result']?['flags'] ?? 0,
      data: json['result']?['data']?.cast<int>() ?? <int>[],
      accountId: json['accountId']?.cast<int>() ?? <int>[],
    );
  }
}
