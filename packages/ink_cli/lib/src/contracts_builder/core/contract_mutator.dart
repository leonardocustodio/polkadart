part of ink_cli;

/// ContractMutator handles calling mutable contract functions.
///
/// This class has been updated to use polkadart's ExtrinsicBuilder for extrinsic
/// construction, removing the need for manual nonce fetching and extrinsic building.
class ContractMutator {
  final Provider provider;
  final ChainInfo chainInfo;
  const ContractMutator({required this.provider, required this.chainInfo});

  /// Creates a ContractMutator instance from a provider.
  ///
  /// This fetches the runtime metadata and builds the ChainInfo
  /// for use with the new typed metadata approach.
  static Future<ContractMutator> fromProvider({required final Provider provider}) async {
    final runtimeMetadata = await StateApi(provider).getMetadata();
    final chainInfo = runtimeMetadata.buildChainInfo();
    return ContractMutator(provider: provider, chainInfo: chainInfo);
  }

  /// Calls a mutable contract function and submits the transaction.
  ///
  /// This method:
  /// 1. Decodes the dry-run execution result
  /// 2. Extracts or estimates the gas limit
  /// 3. Builds the contract call extrinsic
  /// 4. Signs and submits the transaction using ExtrinsicBuilder
  ///
  /// Parameters:
  /// - [keypair]: The signing keypair for the transaction
  /// - [contractAddress]: The deployed contract's address (32 bytes)
  /// - [input]: The encoded function selector and arguments
  /// - [result]: The dry-run execution result (for gas estimation)
  /// - [storageDepositLimit]: Optional deposit limit (defaults to 0)
  /// - [gasLimit]: Optional gas limit (extracted from result if not provided)
  /// - [tip]: Transaction tip for prioritization
  /// - [eraPeriod]: Era period for transaction mortality (0 = immortal)
  ///
  /// Returns an [InstantiateRequest] containing the contract address and extrinsic bytes.
  ///
  /// Throws an [Exception] if the contract execution fails or returns an error.
  ///
  /// Example:
  /// ```dart
  /// final mutator = await ContractMutator.fromProvider(provider: provider);
  /// final result = await mutator.mutate(
  ///   keypair: keypair,
  ///   contractAddress: contractAddress,
  ///   input: encodedInput,
  ///   result: dryRunResult,
  ///   tip: BigInt.from(1000),
  ///   eraPeriod: 64,
  /// );
  /// ```
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
    // Decode and deserialize the dry-run execution result
    final execResult = decodeAndDeserialize(result: result);

    if (execResult.result.ok == null) {
      throw Exception('Exception occurred when executing contract call: ${execResult.result.err}');
    }

    // Use provided gas limit or extract from execution result
    gasLimit ??= GasLimit.from(execResult.gasRequired);

    // Build the contract call arguments
    final args = ContractCallArgs(
      address: contractAddress,
      value: storageDepositLimit ?? BigInt.zero,
      gasLimit: gasLimit,
      storageDepositLimit: null,
      data: input,
    );

    // Encode the method call using ChainInfo
    final methodCall = ContractsMethod.methodCall(args: args).encode(chainInfo);

    // Build and sign the extrinsic using the updated ContractBuilder
    // which now uses ExtrinsicBuilder internally
    final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
      provider: provider,
      signer: keypair,
      methodCall: methodCall,
      tip: tip,
      eraPeriod: eraPeriod,
    );

    // Submit the extrinsic and verify hash
    final Uint8List expectedTxHash = Hasher.blake2b256.hash(extrinsic);
    final Uint8List actualHash = await ContractBuilder.submitExtrinsic(provider, extrinsic);

    final bool isMatched = encodeHex(expectedTxHash) == encodeHex(actualHash);
    assertion(isMatched,
        'The expected hash and the actual hash of the contract call transaction does not match.');

    return InstantiateRequest(
      execResult.result.ok!.accountId,
      extrinsic,
    );
  }

  /// Decodes and deserializes a contract execution result.
  ///
  /// Takes the raw bytes from a ContractsApi_call RPC response and converts
  /// it into a structured [ContractExecResult] object.
  ///
  /// This uses [ContractsApiResponseCodec] which properly handles Runtime API
  /// responses for both V14 and V15 metadata.
  ///
  /// Parameters:
  /// - [result]: The raw SCALE-encoded result bytes
  ///
  /// Returns a [ContractExecResult] with execution details.
  ContractExecResult decodeAndDeserialize({required final Uint8List result}) {
    // Use ContractsApiResponseCodec to properly decode Runtime API responses
    final apiCodec = ContractsApiResponseCodec(chainInfo.registry);
    return apiCodec.decodeCallResult(ByteInput.fromBytes(result));
  }
}
