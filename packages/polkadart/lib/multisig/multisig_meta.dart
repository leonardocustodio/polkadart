part of multisig;

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
    final Uint8List blockHash = await chainApi.getBlockHash(blockNumber: blockNumber);

    // Get the genesis hash of the chain from block number: 0
    final Uint8List genesisHash = await chainApi.getBlockHash(blockNumber: 0);

    final StateApi stateApi = StateApi(provider);
    final RuntimeMetadata runtimeMetadata = await stateApi.getMetadata();
    final RuntimeVersion stateRuntimeVersion = await stateApi.getRuntimeVersion();

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
