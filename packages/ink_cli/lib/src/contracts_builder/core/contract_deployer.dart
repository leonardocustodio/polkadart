part of ink_cli;

class ContractDeployer {
  final Provider provider;
  final RuntimeMetadata runtimeMetadata;
  final ScaleCodec codec;

  const ContractDeployer(this.provider, this.runtimeMetadata, this.codec);

  static Future<ContractDeployer> from({
    required final Provider provider,
  }) async {
    final runtimeMetadata = await StateApi(provider).getMetadata();
    runtimeMetadata.chainInfo.scaleCodec.registry.registerCustomCodec(_contractDefinitions);
    return ContractDeployer(provider, runtimeMetadata, runtimeMetadata.chainInfo.scaleCodec);
  }

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
    late Uint8List encodedAbiSelector;
    if (inkAbi != null && constructorArgs.isNotEmpty) {
      encodedAbiSelector = inkAbi.encodeConstructorInput(selector, constructorArgs);
    } else {
      encodedAbiSelector = decodeHex(selector);
    }

    final ByteOutput output = ByteOutput();
    output.write(encodedAbiSelector);
    salt ??= getSalt();

    // estimate gas-limit
    final execResult = await instantiateRequest(
      keypair: keypair,
      code: code,
      salt: salt,
      input: output.toBytes(),
    );
    if (execResult.result.ok == null) {
      throw Exception('Exception occurend when instantiating request: ${execResult.result.err}');
    }

    gasLimit ??= GasLimit.from(execResult.gasRequired);

    final args = InstantiateWithCodeArgs(
      value: storageDepositLimit ?? BigInt.zero,
      gasLimit: gasLimit,
      storageDepositLimit: Option.none(),
      code: code,
      data: encodedAbiSelector,
      salt: salt,
    );

    final extrinsic = await ContractBuilder.signAndBuildExtrinsic(
      provider: provider,
      signer: keypair,
      methodArgs: args,
      registry: codec.registry,
      tip: tip,
      eraPeriod: eraPeriod,
    );

    final Uint8List expectedTxHash = Hasher.blake2b256.hash(extrinsic);
    final Uint8List actualHash = await ContractBuilder.submitExtrinsic(provider, extrinsic);

    final bool isMatched = encodeHex(expectedTxHash) == encodeHex(actualHash);
    assertion(isMatched,
        'The expected hash and the actual hash of the approval transaction does not match.');

    return InstantiateRequest(
      execResult.result.ok!.accountId,
      extrinsic,
    );
  }

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

    final Uint8List result =
        await StateApi(provider).call('ContractsApi_instantiate', data.toBytes());

    final res = codec.decode('ContractInstantiateResult', ByteInput.fromBytes(result));
    return ContractExecResult.fromJson(ToJson(res).toJson());
  }
}
