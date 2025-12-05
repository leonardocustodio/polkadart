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

  /// Parse from decoded SCALE data
  ///
  /// Structure: `{ result: { flags: int, data: List<int> }, accountId: List<int> }`
  static ContractExecResultOk fromJson(final dynamic json) {
    if (json is! Map) {
      throw ArgumentError('Expected Map, got ${json.runtimeType}');
    }

    final resultField = json['result'];
    int flags = 0;
    List<int> data = [];

    if (resultField is Map) {
      flags = resultField['flags'] ?? 0;
      final dataField = resultField['data'];
      if (dataField is List) {
        data = dataField.cast<int>();
      }
    }

    List<int> accountId = [];
    final accountIdField = json['accountId'];
    if (accountIdField is List) {
      accountId = accountIdField.cast<int>();
    }

    return ContractExecResultOk(
      flags: flags,
      data: data,
      accountId: accountId,
    );
  }
}
