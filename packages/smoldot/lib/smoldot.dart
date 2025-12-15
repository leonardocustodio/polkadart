/// A Dart wrapper for smoldot-light, providing a lightweight Polkadot/Substrate client
///
/// This library provides idiomatic Dart bindings for the smoldot-light Rust library,
/// enabling lightweight blockchain client functionality without requiring a full node.
///
/// ## Features
///
/// - **Lightweight**: No need for a full node, runs entirely in-process
/// - **Multi-chain**: Support for multiple chains simultaneously (relay + parachains)
/// - **Async/Await**: Idiomatic Dart async APIs for all operations
/// - **JSON-RPC**: Full JSON-RPC support with subscriptions
/// - **Type-safe**: Comprehensive type definitions and error handling
/// - **Cross-platform**: Works on Android, iOS, macOS, Linux, and Windows
///
/// ## Usage
///
/// ```dart
/// import 'package:smoldot_light/smoldot_light.dart';
///
/// void main() async {
///   // Create and initialize the client
///   final client = SmoldotClient(
///     config: SmoldotConfig(
///       maxLogLevel: 3,
///       maxChains: 8,
///     ),
///   );
///
///   await client.initialize();
///
///   // Add a chain
///   final chain = await client.addChain(
///     AddChainConfig(
///       chainSpec: polkadotChainSpec,
///     ),
///   );
///
///   // Wait for sync
///   await chain.waitUntilSynced();
///
///   // Make JSON-RPC calls
///   final chainName = await chain.request('system_chain', []);
///   print('Connected to: ${chainName.result}');
///
///   // Subscribe to new blocks
///   final subscription = chain.subscribe('chain_subscribeNewHeads', []);
///   await for (final response in subscription) {
///     print('New block: ${response.result}');
///   }
///
///   // Clean up
///   await client.dispose();
/// }
/// ```
///
/// ## Adding Multiple Chains
///
/// ```dart
/// // Add Polkadot relay chain
/// final polkadot = await client.addChain(
///   AddChainConfig(chainSpec: polkadotSpec),
/// );
///
/// // Add a parachain
/// final statemint = await client.addChain(
///   AddChainConfig(
///     chainSpec: statemintSpec,
///     potentialRelayChains: [polkadot.chainId],
///   ),
/// );
/// ```
///
/// ## Logging
///
/// ```dart
/// // Listen to logs
/// client.logs.listen((log) {
///   print('${log.level}: ${log.message}');
/// });
///
/// // Change log level
/// client.setLogLevel(LogLevel.debug);
/// ```
///
/// ## Persistence
///
/// ```dart
/// // Get database content for persistence
/// final dbContent = await chain.getDatabaseContent();
/// await saveToFile(dbContent);
///
/// // Restore from database
/// final chain = await client.addChain(
///   AddChainConfig(
///     chainSpec: spec,
///     databaseContent: await loadFromFile(),
///   ),
/// );
/// ```
///
/// ## Error Handling
///
/// ```dart
/// try {
///   final response = await chain.request('system_chain', []);
///   print(response.result);
/// } on JsonRpcException catch (e) {
///   print('RPC error: ${e.error}');
/// } on ChainException catch (e) {
///   print('Chain error: ${e.message}');
/// } on SmoldotException catch (e) {
///   print('Smoldot error: ${e.message}');
/// }
/// ```
library smoldot;

export 'src/chain.dart' show Chain;
export 'src/client.dart' show SmoldotClient;
export 'src/json_rpc.dart' show JsonRpcHandler, SubstrateRpcMethods;
export 'src/platform.dart' show SmoldotPlatform;
export 'src/types.dart'
    show
        SmoldotConfig,
        AddChainConfig,
        JsonRpcResponse,
        JsonRpcError,
        ChainStatus,
        ChainInfo,
        LogLevel,
        LogMessage,
        SmoldotException,
        SmoldotFfiException,
        ChainException,
        JsonRpcException;
