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
    // debugMessage can be a String or List<int> (from Vec<u8> decoding)
    final debugMsg = json['debugMessage'];
    final String debugMessageStr;
    if (debugMsg is String) {
      debugMessageStr = debugMsg;
    } else if (debugMsg is List) {
      // Convert List<int> (bytes) to UTF-8 string
      debugMessageStr = String.fromCharCodes(debugMsg.cast<int>());
    } else {
      debugMessageStr = '';
    }

    // StorageDeposit can be:
    // - MapEntry (from ComplexEnumCodec) - e.g., MapEntry('Charge', 0)
    // - Map (from ToJson) - e.g., {'Charge': 0}
    final storageDepositRaw = json['StorageDeposit'] ?? json['storageDeposit'];
    Map<String, dynamic> storageDeposit;
    if (storageDepositRaw is MapEntry) {
      storageDeposit = {storageDepositRaw.key.toString(): storageDepositRaw.value};
    } else if (storageDepositRaw is Map) {
      storageDeposit = Map<String, dynamic>.from(storageDepositRaw);
    } else {
      storageDeposit = <String, dynamic>{};
    }

    return ContractExecResult(
      gasConsumed: _normalizeMap(json['gasConsumed']),
      gasRequired: _normalizeMap(json['gasRequired']),
      storageDeposit: storageDeposit,
      debugMessage: debugMessageStr,
      result: ContractExecResultResult.fromJson(json['result']),
    );
  }

  /// Normalize field names in a map (e.g., ref_time -> refTime)
  static Map<String, dynamic> _normalizeMap(dynamic value) {
    if (value is! Map) return <String, dynamic>{};
    return Map<String, dynamic>.from(value);
  }
}
