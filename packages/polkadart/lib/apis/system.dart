part of apis;

/// Substrate system RPC API
class SystemApi<P extends Provider, H, N> {
  final P _provider;

  const SystemApi(this._provider);

  /// Get the node's implementation name. Plain old string.
  Future<String> name() async {
    final response = await _provider.send('system_name', []);
    return response.result as String;
  }

  /// Get the node implementation's version. Should be a semver string.
  Future<String> version() async {
    final response = await _provider.send('system_version', []);
    return response.result as String;
  }

  /// Get the chain's name. Given as a string identifier.
  Future<String> chain() async {
    final response = await _provider.send('system_chain', []);
    return response.result as String;
  }

  /// Get the chain's type.
  Future<ChainType> chainType() async {
    final response = await _provider.send('system_chainType', []);
    final value = response.result as String;
    if (value.startsWith('0x')) {
      final bytes = Uint8List.fromList(hex.decode(value.substring(2)));
      return ChainType.decode(ByteInput(bytes));
    }
    return ChainType.fromJson(jsonDecode(value));
  }

  /// Return health status of the node.
	///
	/// Node is considered healthy if it is:
	/// - connected to some peers (unless running in dev mode)
	/// - not performing a major sync
  Future<Health> health() async {
    final response = await _provider.send('system_health', []);
    final value = response.result as String;
    if (value.startsWith('0x')) {
      final bytes = Uint8List.fromList(hex.decode(value.substring(2)));
      return Health.decode(ByteInput(bytes));
    }
    return Health.fromJson(jsonDecode(value));
  }

  /// Returns the base58-encoded PeerId of the node.
  Future<String> localPeerId() async {
    final response = await _provider.send('system_localPeerId', []);
    return response.result as String;
  }

  /// Returns the multi-addresses that the local node is listening on
  ///
  /// The addresses include a trailing `/p2p/` with the local PeerId, and are thus suitable to
  /// be passed to `addReservedPeer` or as a bootnode address for example.
  Future<List<String>> localListenAddresses() async {
    final response = await _provider.send('system_localListenAddresses', []);
    return (response.result as List).cast<String>().toList();
  }

  /// Returns currently connected peers
  ///
  /// unsafe: This method is only active with appropriate flags
  Future<List<PeerInfo<H, N>>> peers() async {
    final response = await _provider.send('system_peers', []);
    return (response.result as List)
        .cast<Map<String, dynamic>>()
        .map((json) => PeerInfo<H, N>.fromJson(json))
        .toList();
  }

  /// Returns the next valid index (aka nonce) for given account.
	///
	/// This method takes into consideration all pending transactions
	/// currently in the pool and if no transactions are found in the pool
	/// it fallbacks to query the index from the runtime (aka. state nonce).
  Future<int> accountNextIndex() async {
    final response = await _provider.send('system_accountNextIndex', []);
    return response.result as int;
  }

  /// Dry run an extrinsic at a given block. Return SCALE encoded ApplyExtrinsicResult.
  Future<Uint8List> dryRun(Uint8List extrinsic, {BlockHash? at}) async {
    final List<String> params = ['0x${hex.encode(extrinsic)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('system_dryRun', params);
    final data = response.result as String;
    return Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Returns the roles the node is running as.
  Future<List<String>> nodeRoles() async {
    final response = await _provider.send('system_nodeRoles', []);
    return (response.result as List).cast<String>().toList();
  }

  /// Get a custom set of properties as a JSON object, defined in the chain spec.
  Future<Map<String, dynamic>> properties() async {
    final response = await _provider.send('system_properties', []);
    return response.result as Map<String, dynamic>;
  }

  /// Adds a reserved peer. Returns the empty string or an error. The string
	/// parameter should encode a `p2p` multiaddr.
	///
	/// `/ip4/198.51.100.19/tcp/30333/p2p/QmSk5HQbn6LhUwDiNMseVUjuRYhEtYj4aUZ6WfWoGURpdV`
	/// is an example of a valid, passing multiaddr with PeerId attached.
  /// 
  /// unsafe: This method is only active with appropriate flags
  Future<String?> addReservedPeer(String peer) async {
    final response = await _provider.send('system_addReservedPeer', [peer]);
    return response.result as String?;
  }

  /// Remove a reserved peer. Returns the empty string or an error. The string
	/// should encode only the PeerId e.g. `QmSk5HQbn6LhUwDiNMseVUjuRYhEtYj4aUZ6WfWoGURpdV`.
  /// 
  /// unsafe: This method is only active with appropriate flags
  Future<String?> removeReservedPeer(String peerId) async {
    final response = await _provider.send('system_removeReservedPeer', [peerId]);
    return response.result as String?;
  }

  /// Returns the list of reserved peers
  Future<List<String>> reservedPeers() async {
    final response = await _provider.send('system_reservedPeers', []);
    return (response.result as List).cast<String>().toList();
  }

  /// Adds the supplied directives to the current log filter
	///
	/// unsafe: This method is only active with appropriate flags
  Future<dynamic> addLogFilter(String directives) async {
    final response = await _provider.send('system_addLogFilter', [directives]);
    return response.result;
  }

  /// Resets the log filter to Substrate defaults
  /// 
  /// unsafe: This method is only active with appropriate flags
  Future<dynamic> resetLogFilter() async {
    final response = await _provider.send('system_resetLogFilter', []);
    return response.result;
  }

  /// Returns the state of the syncing of the node: starting block, current best block, highest
	/// known block.
  Future<SyncState> syncState() async {
    final response = await _provider.send('system_syncState', []);
    final data = response.result as Map<String, dynamic>;
    return SyncState.fromJson(data);
  }
}
