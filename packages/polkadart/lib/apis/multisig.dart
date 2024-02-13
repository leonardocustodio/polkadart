part of apis;

class Multisig {
  /// KeyPair of the owner who is initiating the multisig transaction call.
  ///
  /// This keypair will be used to sign the transaction call and submit it to the chain.
  final KeyPair ownerKeypair;

  /// The number of signatories required to approve a transaction call to be executed.
  final int threshold;

  /// The address of the recipient to receive the funds when the transaction is approved by all the signatories.
  final String recipientAddress;

  /// The amount to be transferred to the recipient.
  final BigInt amount;

  /// The provider will be used to do the rpc calls for submitting the transaction to the chain.
  final Provider provider;

  late final List<Uint8List> _sortedSignatoriesList;

  /// The multisig address will be used to identify the multisig account on the chain.
  ///
  /// The multisig address is generated from the sorted list of signatories and the threshold.
  late final Uint8List multiSigAddressBytes;

  Multisig({
    required this.ownerKeypair,
    required List<String> otherSignatoriesAddressList,
    required this.threshold,
    required this.recipientAddress,
    required this.amount,
    required this.provider,
  }) {
    // create the multisig address and the sorted signatories list
    final result = createMultiSigBytes(
        [...otherSignatoriesAddressList, ownerKeypair.address], threshold);
    // assign the multisig address
    multiSigAddressBytes = result.$1;
    // assign the sorted signatories list
    _sortedSignatoriesList = result.$2;
  }

  Future<void> initiateMultiSig() async {
    final meta = await MultiSigMeta.fromProvider(provider: provider);

    final SigningPayload unsignedPayload = SigningPayload(
      method: transferKeepAlive(
        multiSigAddressBytes,
        meta.runtimeMetadata.chainInfo,
        amount,
      ),
      assetId: 0,
      blockHash: hex.encode(meta.blockHash),
      blockNumber: meta.blockNumber,
      eraPeriod: 0,
      genesisHash: hex.encode(meta.genesisHash),
      nonce: 0,
      specVersion: meta.specVersion,
      tip: 0,
      transactionVersion: meta.transactionVersion,
    );

    final Uint8List signingPayload = unsignedPayload
        .encode(meta.runtimeMetadata.chainInfo.scaleCodec.registry);
    print('Signing Payload: ${hex.encode(signingPayload)}');

    final Uint8List signature = ownerKeypair.sign(signingPayload);
    print('Signature: ${hex.encode(signature)}');

    final ExtrinsicPayload extrinsicPayload = ExtrinsicPayload.fromPayload(
        unsignedPayload,
        Address.decode(ownerKeypair.address).pubkey,
        signature);

    final Uint8List signedTx = extrinsicPayload.encode(
      meta.runtimeMetadata.chainInfo.scaleCodec.registry,
      SignatureType.sr25519,
    );
    print('Signed Tx: ${hex.encode(signedTx)}');

    /* final ByteInput input = ByteInput(signedTx);
    final Map<String, dynamic> decoded =
        ExtrinsicsCodec(chainInfo: meta.runtimeMetadata.chainInfo)
            .decode(input);
    print(decoded); */

    final expectedTxHash = Hasher.blake2b256.hash(signedTx);
    print('ExpectedTxHash: ${hex.encode(expectedTxHash)}');

    final author = AuthorApi(provider);
    final actualHash = await author.submitExtrinsic(signedTx);

    print(actualHash);
    print('\n\n---------------\n\n');
    print(hex.encode(expectedTxHash));
    print(hex.encode(actualHash));
    print('done');
    return;
  }

  static Uint8List transferKeepAlive(
      Uint8List destination, ChainInfo chainInfo, BigInt amount) {
    final transferArgument = MapEntry(
      'Balances',
      MapEntry(
        'transfer_keep_alive',
        {
          'dest': MapEntry('Id', destination),
          'value': amount,
        },
      ),
    );

    final ByteOutput output = ByteOutput();

    chainInfo.scaleCodec.registry.codecs['Call']!
        .encodeTo(transferArgument, output);
    return output.toBytes();
  }

  static (Uint8List multisig, List<Uint8List> sortedSignatories)
      createMultiSigBytes(List<String> totalSignatories, int threshold) {
    if (totalSignatories.length < 2 || totalSignatories.length > 100) {
      throw ArgumentError(
          'The total number of signatories can only be in range of [2, 100].');
    }
    if (threshold > totalSignatories.length) {
      throw ArgumentError(
          'The threshold should not exceed the number of signatories.');
    }
    if (threshold < 2) {
      throw ArgumentError('The threshold should be at least 2.');
    }

    // sort the signatories
    final sortedSignatories = List<Uint8List>.from(
        totalSignatories.toSet().map((e) => Address.decode(e).pubkey))
      ..sort(uint8ListCompare);

    // generate the multi output result
    final result = <int>[];

    // append the PREFIX
    result.addAll(PREFIX);

    // append the length
    result.addAll(CompactCodec.codec.encode(sortedSignatories.length));
    for (final who in sortedSignatories) {
      result.addAll(who);
    }
    // append the threshold
    result.addAll(bnToU8a(threshold, bitLength: 16));

    return (blake2bDigest(Uint8List.fromList(result)), sortedSignatories);
  }
}

int uint8ListCompare(Uint8List a, Uint8List b) {
  int i = 0;
  while (true) {
    final overA = i >= a.length;
    final overB = i >= b.length;
    if (overA && overB) {
      // both ends reached
      return 0;
    } else if (overA) {
      // a has no more data, b has data
      return -1;
    } else if (overB) {
      // b has no more data, a has data
      return 1;
    } else if (a[i] != b[i]) {
      // the number in this index doesn't match
      // (we don't use u8aa[i] - u8ab[i] since that doesn't match with localeCompare)
      return a[i] > b[i] ? 1 : -1;
    }
    i++;
  }
}

class MultiSigMeta {
  final int blockNumber;
  final Uint8List blockHash;
  final Uint8List genesisHash;
  final int specVersion;
  final int transactionVersion;
  final RuntimeMetadata runtimeMetadata;

  const MultiSigMeta({
    required this.blockNumber,
    required this.blockHash,
    required this.genesisHash,
    required this.specVersion,
    required this.transactionVersion,
    required this.runtimeMetadata,
  });

  static Future<MultiSigMeta> fromProvider({required Provider provider}) async {
    final ChainApi chainApi = ChainApi(provider);

    // Get the latest block number from the chain
    final int blockNumber = await chainApi.getChainHeader();

    // Get the blockhash of the latest block
    final Uint8List blockHash =
        await chainApi.getBlockHash(blockNumber: blockNumber);

    // Get the genesis hash of the chain from block number: 0
    final Uint8List genesisHash = await chainApi.getBlockHash(blockNumber: 0);

    final StateApi stateApi = StateApi(provider);
    final RuntimeMetadata runtimeMetadata = await stateApi.getMetadata();
    final RuntimeVersion stateRuntimeVersion =
        await stateApi.getRuntimeVersion();

    return MultiSigMeta(
      blockNumber: blockNumber,
      blockHash: blockHash,
      genesisHash: genesisHash,
      runtimeMetadata: runtimeMetadata,
      specVersion: stateRuntimeVersion.specVersion,
      transactionVersion: stateRuntimeVersion.transactionVersion,
    );
  }
}
