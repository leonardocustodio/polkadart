part of ink_cli;

class ContractMeta {
  final int blockNumber;
  final Uint8List blockHash;
  final Uint8List genesisHash;
  final int specVersion;
  final int transactionVersion;
  final RuntimeMetadata runtimeMetadata;

  const ContractMeta({
    required this.blockNumber,
    required this.blockHash,
    required this.genesisHash,
    required this.specVersion,
    required this.transactionVersion,
    required this.runtimeMetadata,
  });

  static Future<ContractMeta> fromProvider({required Provider provider}) async {
    final ChainApi chainApi = ChainApi(provider);

    // Get the latest block number from the chain
    final int blockNumber = await chainApi.getChainHeader();

    // Get the genesis hash of the chain from block number: 0
    final Uint8List genesisHash = await chainApi.getBlockHash(blockNumber: 0);

    final StateApi stateApi = StateApi(provider);
    final RuntimeMetadata runtimeMetadata = await stateApi.getMetadata();
    final RuntimeVersion stateRuntimeVersion =
        await stateApi.getRuntimeVersion();

    return ContractMeta(
      blockNumber: blockNumber,
      // This is intentionally done
      blockHash: genesisHash,
      genesisHash: genesisHash,
      runtimeMetadata: runtimeMetadata,
      specVersion: stateRuntimeVersion.specVersion,
      transactionVersion: stateRuntimeVersion.transactionVersion,
    );
  }
}
