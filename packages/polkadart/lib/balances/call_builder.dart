part of balances_calls;

sealed class CallBuilder {
  const CallBuilder();

  /// Encode the call to bytes
  Uint8List encode(final ChainInfo chainInfo);

  /// Get the RuntimeCall representation
  RuntimeCall toRuntimeCall(final ChainInfo chainInfo);
}
