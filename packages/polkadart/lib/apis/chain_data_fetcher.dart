part of apis;

/// Fetches chain data from a provider
///
/// This class handles all RPC calls to fetch chain data like genesis hash,
/// block information, runtime version, and account nonces. It provides both
/// individual fetch methods and a batch fetch method for efficiency.
class ChainDataFetcher {
  final Provider provider;

  ChainDataFetcher(this.provider);

  /// Fetch all standard chain data in parallel
  ///
  /// This method fetches commonly needed chain data in a single batch for efficiency.
  /// Returns null for any values that shouldn't be fetched (based on skipFlags).
  Future<ChainData> fetchStandardData({
    String? accountAddress,
    Set<String> skipFlags = const {},
  }) async {
    final ChainApi chainApi = ChainApi(provider);
    final SystemApi systemApi = SystemApi(provider);
    final StateApi stateApi = StateApi(provider);
    // Build list of futures, using null for skipped items
    final futures = <Future<dynamic>>[
      // Genesis hash (index 0)
      !skipFlags.contains('genesis') ? chainApi.getBlockHash(blockNumber: 0) : Future.value(null),

      // Latest block header (index 1)
      !skipFlags.contains('block') ? fetchLatestHeader() : Future.value(null),

      // Runtime version (index 2)
      !skipFlags.contains('runtime') ? stateApi.getRuntimeVersion() : Future.value(null),

      // Account nonce (index 3)
      accountAddress != null && !skipFlags.contains('nonce')
          ? systemApi.accountNextIndex(accountAddress)
          : Future.value(null),
    ];

    try {
      final results = await Future.wait(futures);

      // Parse genesis hash
      final genesisHash = results[0] as Uint8List?;

      // Parse block header
      final header = results[1] as BlockHeader?;

      // Parse runtime version
      final runtime = results[2] as RuntimeVersion?;

      // Parse nonce
      final nonce = results[3] as int?;

      return ChainData(
        genesisHash: genesisHash,
        blockHash: header?.hash,
        blockNumber: header?.number,
        specVersion: runtime?.specVersion,
        transactionVersion: runtime?.transactionVersion,
        nonce: nonce,
      );
    } catch (e) {
      throw FetchError('Failed to fetch chain data: $e');
    }
  }

  /// Fetch latest block header
  Future<BlockHeader> fetchLatestHeader() async {
    try {
      final latestBlockNumber = await ChainApi(provider).getChainHeader();
      final latestBlockHash = await ChainApi(provider).getBlockHash();

      return BlockHeader(
        hash: latestBlockHash,
        number: latestBlockNumber,
      );
    } catch (e) {
      throw FetchError('Failed to fetch latest header: $e');
    }
  }
}

/// Container for standard chain data
class ChainData {
  final Uint8List? genesisHash;
  final Uint8List? blockHash;
  final int? blockNumber;
  final int? specVersion;
  final int? transactionVersion;
  final int? nonce;

  const ChainData({
    this.genesisHash,
    this.blockHash,
    this.blockNumber,
    this.specVersion,
    this.transactionVersion,
    this.nonce,
  });

  /// Check if all required data is present
  bool get hasAllRequiredData =>
      genesisHash != null &&
      blockHash != null &&
      blockNumber != null &&
      specVersion != null &&
      transactionVersion != null;

  /// Get a summary of fetched data
  Map<String, dynamic> summary() {
    return {
      'genesisHash': genesisHash != null
          ? '0x${genesisHash!.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}'
          : null,
      'blockHash': blockHash != null
          ? '0x${blockHash!.map((b) => b.toRadixString(16).padLeft(2, '0')).join()}'
          : null,
      'blockNumber': blockNumber,
      'specVersion': specVersion,
      'transactionVersion': transactionVersion,
      'nonce': nonce,
    };
  }
}

/// Error thrown when fetching fails
class FetchError implements Exception {
  final String message;

  FetchError(this.message);

  @override
  String toString() => 'FetchError: $message';
}
