part of ink_cli;

class ContractExecResultResult {
  final ContractExecResultOk? ok;
  final dynamic err;

  const ContractExecResultResult({required this.ok, required this.err});

  /// Parse result from decoded SCALE data
  ///
  /// Handles both:
  /// - `Result<T, E>` object from ResultCodec
  /// - `Map` with 'Ok' or 'Err' keys (from ToJson conversion)
  static ContractExecResultResult fromJson(final dynamic json) {
    // Handle Result object directly from ResultCodec
    if (json is Result) {
      if (json.isOk) {
        final okValue = json.okValue;
        return ContractExecResultResult(
          ok: okValue != null ? ContractExecResultOk.fromJson(okValue) : null,
          err: null,
        );
      } else {
        return ContractExecResultResult(ok: null, err: json.errValue);
      }
    }

    // Handle Map format (from ToJson or V15 decoding)
    if (json is Map<String, dynamic>) {
      return ContractExecResultResult(
        ok: json['Ok'] != null ? ContractExecResultOk.fromJson(json['Ok']) : null,
        err: json['Err'],
      );
    }

    throw ArgumentError('Unexpected type for result: ${json.runtimeType}');
  }
}
