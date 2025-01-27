part of ink_cli;

class InkCliContract {
  final Provider provider;
  final RuntimeMetadata runtimeMetadata;
  final ScaleCodec codec;

  InkCliContract(this.provider, this.runtimeMetadata, this.codec);

  static Future<InkCliContract> from({required final Provider provider}) async {
    final runtimeMetadata = await StateApi(provider).getMetadata();
    final codec = runtimeMetadata.chainInfo.scaleCodec;
    codec.registry.registerCustomCodec(_contractDefinitions);
    return InkCliContract(provider, runtimeMetadata, codec);
  }

  Future<dynamic> deployContract({
    required final Uint8List code,
    required final String selector,
    required final KeyPair keypair,
    required final List<dynamic> args,
    final InkAbi? inkAbi,
    final Map<String, dynamic> extraOptions = const <String, dynamic>{},
    Uint8List? salt,
    GasLimit? gasLimit,
  }) async {
    late Uint8List encodedAbiSelector;
    if (inkAbi != null) {
      encodedAbiSelector = inkAbi.encodeConstructorInput(selector, args);
    } else {
      encodedAbiSelector = decodeHex(selector);
    }

    final ByteOutput output = ByteOutput();
    output.write(encodedAbiSelector);
    // TODO: Revert this salt thing.
    //salt ??= getSalt();
    salt = decodeHex('6791c0b0');

    // estimate gas-limit
    final execResult = await instantiateRequest(
      keypair: keypair,
      code: code,
      salt: salt,
      input: output.toBytes(),
    );

    gasLimit ??= GasLimit.from(execResult.gasRequired);

    return;

    /* 
    late final Option storageDepositLimit;
    if (extraOptions.containsKey('storageDepositLimit')) {
      if (extraOptions['storageDepositLimit'] is Option) {
        storageDepositLimit = extraOptions['storageDepositLimit'];
      } else {
        storageDepositLimit = Option.some(extraOptions['storageDepositLimit']);
      }
    } else {
      storageDepositLimit = Option.some(BigInt.zero);
    }

    final objectToDecode = MapEntry(
      'instantiate_with_code',
      <String, dynamic>{
        'value': BigInt.zero,
        'gas_limit': gasLimit,
        'storage_deposit_limit': storageDepositLimit,
        'code': code,
        'data': output.toBytes(),
        'salt': salt,
      },
    );

    final ByteOutput result = ByteOutput();
    _contractCodec.encodeTo(objectToDecode, result);

    return InstantiateRequest(
      execResult.result.ok!.accountId,
      result,
    ); */
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
    codec.encodeTo('Balance', BigInt.zero, data);
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
    final Uint8List result = await StateApi(provider)
        .call('ContractsApi_instantiate', data.toBytes());

    {
      final file = File(
          '/Users/kawal/Desktop/git_projects/polkadart/packages/ink_cli/example/calculated.txt');
      file.createSync(recursive: true);
      file.writeAsStringSync(encodeHex(result));
    }

    final res =
        codec.decode('ContractInstantiateResult', ByteInput.fromBytes(result));
    final value = ToJson(res).toJson();
    return ContractExecResult.fromJson(value);
  }

  /*  Future<dynamic> signAndBuildExtrinsic({
    required Uint8List encodedCall,
  }) async {
    final multiSigMeta = await MultiSigMeta.fromProvider(provider: provider);

    final genesisHash = multiSigMeta.genesisHash;
    final runtimeVersion = multiSigMeta.
  } */
}
