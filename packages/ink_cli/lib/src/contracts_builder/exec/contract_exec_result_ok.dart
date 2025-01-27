part of ink_cli;

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
