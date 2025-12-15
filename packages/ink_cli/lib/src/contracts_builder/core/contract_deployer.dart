part of ink_cli;

/// ContractDeployer handles deployment of smart contracts to the blockchain.
///
/// This class has been updated to use polkadart's ExtrinsicBuilder for extrinsic
/// construction, removing the need for manual nonce fetching and extrinsic building.
class ContractDeployer {
  final Provider provider;
  final RuntimeMetadataPrefixed runtimeMetadata;
  final ChainInfo chainInfo;

  const ContractDeployer(this.provider, this.runtimeMetadata, this.chainInfo);

  /// Creates a ContractDeployer instance from a provider.
  ///
  /// This fetches the runtime metadata and builds the ChainInfo
  /// for use with the new typed metadata approach.
  static Future<ContractDeployer> from({required final Provider provider}) async {
    final runtimeMetadata = await StateApi(provider).getMetadata();
    final chainInfo = runtimeMetadata.buildChainInfo();
    return ContractDeployer(provider, runtimeMetadata, chainInfo);
  }

  /// Deploys a contract to the blockchain.
  ///
  /// This method:
  /// 1. Encodes the constructor input with provided arguments
  /// 2. Estimates gas limit via RPC if not provided
  /// 3. Builds the instantiate_with_code extrinsic
  /// 4. Signs and submits the transaction using ExtrinsicBuilder
  ///
  /// Parameters:
  /// - [code]: The compiled WASM bytecode of the contract
  /// - [selector]: The constructor selector (hex string or bytes)
  /// - [keypair]: The signing keypair for the deployment
  /// - [constructorArgs]: Arguments to pass to the constructor
  /// - [storageDepositLimit]: Optional deposit limit (defaults to 0)
  /// - [inkAbi]: Optional ABI for encoding constructor args
  /// - [extraOptions]: Additional options (currently unused)
  /// - [salt]: Optional salt for deterministic address (auto-generated if not provided)
  /// - [gasLimit]: Optional gas limit (estimated if not provided)
  /// - [tip]: Transaction tip for prioritization
  /// - [eraPeriod]: Era period for transaction mortality (0 = immortal)
  ///
  /// Returns an [InstantiateRequest] containing the deployed contract address
  /// and the extrinsic bytes.
  ///
  /// Throws an [Exception] if instantiation fails or contract execution errors occur.
  Future<InstantiateRequest> deployContract({
    required final Uint8List code,
    required final String selector,
    required final KeyPair keypair,
    required final List<dynamic> constructorArgs,
    BigInt? storageDepositLimit,
    final InkAbi? inkAbi,
    final Map<String, dynamic> extraOptions = const <String, dynamic>{},
    Uint8List? salt,
    GasLimit? gasLimit,
    final dynamic tip = 0,
    final int eraPeriod = 0,
  }) async {
    // Encode constructor selector with arguments
    late Uint8List encodedAbiSelector;
    if (inkAbi != null && constructorArgs.isNotEmpty) {
      encodedAbiSelector = inkAbi.encodeConstructorInput(selector, constructorArgs);
    } else {
      encodedAbiSelector = decodeHex(selector);
    }

    final ByteOutput output = ByteOutput();
    output.write(encodedAbiSelector);
    salt ??= getSalt();

    // Estimate gas limit via RPC call
    final execResult = await instantiateRequest(
      keypair: keypair,
      code: code,
      salt: salt,
      input: output.toBytes(),
    );

    if (execResult.result.ok == null) {
      throw Exception('Exception occurred when instantiating request: ${execResult.result.err}');
    }

    gasLimit ??= GasLimit.from(execResult.gasRequired);

    // Build the contract instantiation arguments
    final args = InstantiateWithCodeArgs(
      value: storageDepositLimit ?? BigInt.zero,
      gasLimit: gasLimit,
      storageDepositLimit: null,
      code: code,
      data: encodedAbiSelector,
      salt: salt,
    );

    // Encode the method call using ChainInfo
    final Uint8List methodCall = ContractsMethod.instantiateWithCode(args: args).encode(chainInfo);

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
    assertion(
      isMatched,
      'The expected hash and the actual hash of the deployment transaction does not match.',
    );

    return InstantiateRequest(execResult.result.ok!.accountId, extrinsic);
  }

  /// Performs a dry-run instantiation request to estimate gas and validate the contract.
  ///
  /// This calls the ContractsApi_instantiate RPC method to simulate contract
  /// instantiation without actually deploying it. Useful for:
  /// - Estimating gas requirements
  /// - Validating constructor arguments
  /// - Checking if deployment will succeed
  ///
  /// Parameters match the corresponding fields in the actual deployment.
  ///
  /// Returns a [ContractExecResult] with execution details including gas required.
  Future<ContractExecResult> instantiateRequest({
    required final KeyPair keypair,
    required final Uint8List code,
    required final Uint8List input,
    required final Uint8List salt,
  }) async {
    final ByteOutput data = ByteOutput();
    // signer
    data.write(keypair.publicKey.bytes);
    U128Codec.codec.encodeTo(BigInt.zero, data);
    // gas_limit
    data.pushByte(0);
    // proof_size
    data.pushByte(0);
    // storage_deposit_limit
    data.pushByte(0);

    final bytesCodec = SequenceCodec(U8Codec.codec);
    // code
    bytesCodec.encodeTo(code, data);
    // input
    bytesCodec.encodeTo(input, data);
    // salt
    bytesCodec.encodeTo(salt, data);

    final Uint8List result = await StateApi(
      provider,
    ).call('ContractsApi_instantiate', data.toBytes());

    // Use ContractsApiResponseCodec to properly decode Runtime API responses
    final apiCodec = ContractsApiResponseCodec(chainInfo.registry);
    return apiCodec.decodeInstantiateResult(ByteInput.fromBytes(result));
  }
}
