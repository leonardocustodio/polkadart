part of ink_cli;

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
