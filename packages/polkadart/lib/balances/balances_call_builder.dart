part of balances_calls;

/// Base class for Balances pallet calls
sealed class BalancesCallBuilder extends CallBuilder {
  static const String palletName = 'Balances';
  const BalancesCallBuilder();

  String get callName;
  Map<String, dynamic> buildArgs();

  @override
  RuntimeCall toRuntimeCall(final ChainInfo chainInfo) {
    final lookup = CallIndicesLookup(chainInfo);
    return RuntimeCall(
      palletName: palletName,
      palletIndex: lookup.getPalletIndex(palletName),
      callName: callName,
      callIndex: lookup.getCallIndex(palletName, callName),
      args: buildArgs(),
    );
  }

  @override
  Uint8List encode(final ChainInfo chainInfo) {
    final call = toRuntimeCall(chainInfo);
    final output = ByteOutput();
    chainInfo.callsCodec.encodeTo(call, output);
    return output.toBytes();
  }
}
