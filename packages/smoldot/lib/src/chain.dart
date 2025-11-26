import 'dart:async';
import 'bindings.dart';
import 'types.dart';
import 'json_rpc.dart';

/// Represents a blockchain chain managed by smoldot
///
/// A [Chain] instance provides methods for interacting with a specific
/// blockchain through JSON-RPC calls and subscriptions.
class Chain {
  /// Chain identifier (handle from Rust)
  final int chainId;

  /// Parent client instance (kept as reference)
  final Object client;

  /// FFI bindings
  final SmoldotBindings bindings;

  /// Native client handle (u64 from Rust)
  final int clientHandle;

  /// JSON-RPC handler for this chain
  late final JsonRpcHandler _jsonRpc;

  /// Whether the chain has been disposed
  bool _isDisposed = false;

  /// Creates a new Chain instance
  ///
  /// This is typically called internally by [SmoldotClient.addChain].
  Chain({
    required this.chainId,
    required this.client,
    required this.bindings,
    required this.clientHandle,
  }) {
    _jsonRpc = JsonRpcHandler(
      chainId: chainId,
      bindings: bindings,
      clientHandle: clientHandle,
    );
  }

  /// Whether this chain has been disposed
  bool get isDisposed => _isDisposed;

  /// Send a JSON-RPC request to the chain
  ///
  /// [method] is the RPC method name (e.g., 'system_chain').
  /// [params] is a list of parameters for the method.
  ///
  /// Returns a [Future] that completes with the response.
  /// Throws [JsonRpcException] if the request fails.
  ///
  /// Example:
  /// ```dart
  /// final response = await chain.request('system_chain', []);
  /// print(response.result);
  /// ```
  Future<JsonRpcResponse> request(String method, List<dynamic> params) async {
    _ensureNotDisposed();
    return _jsonRpc.request(method, params);
  }

  /// Subscribe to JSON-RPC notifications
  ///
  /// [method] is the subscription method name (e.g., 'chain_subscribeNewHeads').
  /// [params] is a list of parameters for the subscription.
  ///
  /// Returns a [Stream] of responses.
  /// The stream will emit [JsonRpcException] if errors occur.
  ///
  /// Example:
  /// ```dart
  /// final subscription = await chain.subscribe('chain_subscribeNewHeads', []);
  /// await for (final response in subscription) {
  ///   print('New block: ${response.result}');
  /// }
  /// ```
  Stream<JsonRpcResponse> subscribe(String method, List<dynamic> params) {
    _ensureNotDisposed();
    return _jsonRpc.subscribe(method, params);
  }

  /// Unsubscribe from a JSON-RPC subscription
  ///
  /// [subscriptionId] is the ID returned by the subscribe method.
  Future<void> unsubscribe(String subscriptionId) async {
    _ensureNotDisposed();
    await _jsonRpc.unsubscribe(subscriptionId);
  }

  /// Get information about this chain
  Future<ChainInfo> getInfo() async {
    _ensureNotDisposed();

    // Gather chain information using JSON-RPC
    final chainName = await request('system_chain', []);
    final health = await request('system_health', []);

    // Get finalized head to get block number
    final finalizedHeadResponse = await request('chain_getFinalizedHead', []);
    final finalizedHash = finalizedHeadResponse.result as String;

    // Get the header for the finalized block
    final headerResponse = await request('chain_getHeader', [finalizedHash]);
    final header = headerResponse.result as Map<String, dynamic>;
    final blockNumberHex = header['number'] as String;

    // Convert hex block number to int
    final blockNumber = int.parse(blockNumberHex.substring(2), radix: 16);

    // Parse health info
    final healthData = health.result as Map<String, dynamic>;
    final peerCount = healthData['peers'] as int? ?? 0;
    final isSyncing = healthData['isSyncing'] as bool? ?? false;

    return ChainInfo(
      chainId: chainId,
      name: chainName.result as String,
      status: isSyncing ? ChainStatus.syncing : ChainStatus.synced,
      peerCount: peerCount,
      bestBlockNumber: blockNumber,
      bestBlockHash: finalizedHash,
    );
  }

  /// Get the current best block number
  Future<int?> getBestBlockNumber() async {
    _ensureNotDisposed();

    final finalizedHeadResponse = await request('chain_getFinalizedHead', []);
    final finalizedHash = finalizedHeadResponse.result as String;

    final headerResponse = await request('chain_getHeader', [finalizedHash]);
    final header = headerResponse.result as Map<String, dynamic>;
    final blockNumberHex = header['number'] as String;

    return int.parse(blockNumberHex.substring(2), radix: 16);
  }

  /// Get the current best block hash
  Future<String?> getBestBlockHash() async {
    _ensureNotDisposed();

    final response = await request('chain_getFinalizedHead', []);
    return response.result as String;
  }

  /// Get the number of connected peers
  Future<int> getPeerCount() async {
    _ensureNotDisposed();

    final health = await request('system_health', []);
    final healthData = health.result as Map<String, dynamic>;
    return healthData['peers'] as int? ?? 0;
  }

  /// Get the chain status
  Future<ChainStatus> getStatus() async {
    _ensureNotDisposed();

    final health = await request('system_health', []);
    final healthData = health.result as Map<String, dynamic>;
    final isSyncing = healthData['isSyncing'] as bool? ?? false;

    return isSyncing ? ChainStatus.syncing : ChainStatus.synced;
  }

  /// Wait until the chain is synced
  Future<void> waitUntilSynced({
    Duration timeout = const Duration(minutes: 5),
    Duration pollInterval = const Duration(seconds: 1),
  }) async {
    _ensureNotDisposed();

    final stopwatch = Stopwatch()..start();

    while (stopwatch.elapsed < timeout) {
      final status = await getStatus();

      if (status == ChainStatus.synced) {
        return;
      }

      await Future<void>.delayed(pollInterval);
    }

    throw TimeoutException(
      'Chain did not sync within ${timeout.inSeconds} seconds',
      timeout,
    );
  }

  /// Get the database content for this chain
  /// Note: This is not yet implemented in smoldot FFI
  Future<String?> getDatabaseContent() async {
    _ensureNotDisposed();
    // This would require additional FFI support from smoldot
    // For now, return null
    return null;
  }

  /// Dispose of this chain and free resources
  Future<void> dispose() async {
    if (_isDisposed) {
      return;
    }

    _jsonRpc.dispose();
    _isDisposed = true;
  }

  /// Ensure the chain is not disposed
  void _ensureNotDisposed() {
    if (_isDisposed) {
      throw SmoldotException('Chain $chainId has been disposed');
    }
  }

  @override
  String toString() => 'Chain(chainId: $chainId, isDisposed: $_isDisposed)';
}
