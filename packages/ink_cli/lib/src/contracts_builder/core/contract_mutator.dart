part of ink_cli;

class ContractMutator {
  final Provider provider;
  final RuntimeMetadata runtimeMetadata;
  final ScaleCodec codec;

  const ContractMutator._(this.provider, this.runtimeMetadata, this.codec);

  static Future<ContractMutator> fromProvider({
    required final Provider provider,
  }) async {
    final runtimeMetadata = await StateApi(provider).getMetadata();
    runtimeMetadata.chainInfo.scaleCodec.registry
        .registerCustomCodec(_contractDefinitions);
    return ContractMutator._(
        provider, runtimeMetadata, runtimeMetadata.chainInfo.scaleCodec);
  }

  Future<dynamic> mutate({
    required final KeyPair keypair,
    required final Uint8List contractAddress,
    required final Uint8List input,
    required final Uint8List result,
    BigInt? storageDepositLimit,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    // estimate gas-limit
    final execResult = decodeAndDeserialize(
      result: result,
    );
    if (execResult.result.ok == null) {
      throw Exception(
          'Exception occurend when instantiating request: ${execResult.result.err}');
    }

    gasLimit ??= GasLimit.from(execResult.gasRequired);

    final args = ContractCallArgs(
      address: contractAddress.toList(),
      value: storageDepositLimit ?? BigInt.zero,
      gasLimit: gasLimit,
      storageDepositLimit: Option.none(),
      data: input,
    );

    final methodCall =
        ContractsMethod.methodCall(args: args).encode(codec.registry);

    final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
      provider: provider,
      signer: keypair,
      methodCall: methodCall,
      tip: tip,
      eraPeriod: eraPeriod,
    );

    final Uint8List expectedTxHash = Hasher.blake2b256.hash(extrinsic);
    final Uint8List actualHash =
        await ContractBuilder.submitExtrinsic(provider, extrinsic);

    final bool isMatched = encodeHex(expectedTxHash) == encodeHex(actualHash);
    assertion(isMatched,
        'The expected hash and the actual hash of the approval transaction does not match.');

    return InstantiateRequest(
      execResult.result.ok!.accountId,
      extrinsic,
    );
  }

  ContractExecResult decodeAndDeserialize({
    required final Uint8List result,
  }) {
    final res = codec.decode('ContractExecResult', ByteInput.fromBytes(result));
    return ContractExecResult.fromJson(ToJson(res).toJson());
  }
}
