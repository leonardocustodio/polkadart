part of ink_cli;

class ContractsMethod {
  final String method;
  final ContractArgs args;

  const ContractsMethod._({required this.method, required this.args});

  static ContractsMethod methodCall({required final ContractArgs args}) {
    return ContractsMethod._(method: 'call', args: args);
  }

  static ContractsMethod instantiateWithCode({required final ContractArgs args}) {
    return ContractsMethod._(method: 'instantiate_with_code', args: args);
  }

  /// Encodes the contract method call using the new typed metadata approach.
  ///
  /// Uses ChainInfo's RuntimeCallCodec for proper encoding with portable types.
  Uint8List encode(final ChainInfo chainInfo) {
    // Use CallIndicesLookup to get pallet and call indices
    final indices = CallIndicesLookup(
      chainInfo,
    ).getPalletAndCallIndex(palletName: 'Contracts', callName: method);

    // Create RuntimeCall object
    final runtimeCall = RuntimeCall(
      palletName: 'Contracts',
      palletIndex: indices.palletIndex,
      callName: method,
      callIndex: indices.callIndex,
      args: args.toMap(),
    );

    final Uint8List result = chainInfo.callsCodec.encode(runtimeCall);
    return result;
  }
}
