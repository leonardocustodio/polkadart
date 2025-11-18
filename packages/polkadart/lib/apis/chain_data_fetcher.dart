part of apis;

/// Fetches chain data from a provider
///
/// This class handles all RPC calls to fetch chain data like genesis hash,
/// block information, runtime version, and account nonces. It provides both
/// individual fetch methods and a batch fetch method for efficiency.
class ChainDataFetcher {
  final Provider provider;
  final ChainApi _chainApi;
  final SystemApi _systemApi;
  final StateApi _stateApi;
  ChainDataFetcher(this.provider)
    : _chainApi = ChainApi(provider),
      _systemApi = SystemApi(provider),
      _stateApi = StateApi(provider);

  /// Fetch all standard chain data in parallel
  ///
  /// This method fetches commonly needed chain data in a single batch for efficiency.
  /// Returns null for any values that shouldn't be fetched (based on skipFlags).
  Future<ChainData> fetchStandardData({final String? accountAddress}) async {
    final futures = <Future<dynamic>>[
      _chainApi.getBlockHash(blockNumber: 0),
      fetchLatestHeader(),
      _stateApi.getRuntimeVersion(),
      accountAddress != null ? _systemApi.accountNextIndex(accountAddress) : Future.value(null),
    ];

    try {
      final results = await Future.wait(futures);

      final genesisHash = results[0] as Uint8List;
      final header = results[1] as BlockHeader;
      final runtime = results[2] as RuntimeVersion;
      final nonce = results[3] as int?;

      return ChainData(
        genesisHash: genesisHash,
        blockHash: header.hash,
        blockNumber: header.number,
        specVersion: runtime.specVersion,
        transactionVersion: runtime.transactionVersion,
        nonce: nonce,
      );
    } catch (e) {
      throw FetchError('Failed to fetch chain data: $e');
    }
  }

  /// Fetch latest block header
  Future<BlockHeader> fetchLatestHeader() async {
    try {
      final latestBlockNumber = await _chainApi.getChainHeader();
      final latestBlockHash = await _chainApi.getBlockHash(blockNumber: latestBlockNumber);

      return BlockHeader(hash: latestBlockHash, number: latestBlockNumber);
    } catch (e) {
      throw FetchError('Failed to fetch latest header: $e');
    }
  }
}

/// Error thrown when fetching fails
class FetchError implements Exception {
  final String message;

  FetchError(this.message);

  @override
  String toString() => 'FetchError: $message';
}
