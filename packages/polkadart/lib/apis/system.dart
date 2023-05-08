part of apis;

/// Substrate system RPC API
class SystemApi<P extends Provider, H, N> {
  final P _provider;

  const SystemApi(this._provider);

  /// Retrieves the node name
  Future<String> name() async {
    final response = await _provider.send('system_name', []);
    return response.result as String;
  }

  /// Retrieves the version of the node
  Future<String> version() async {
    final response = await _provider.send('system_version', []);
    return response.result as String;
  }

  /// Retrieves the chain
  Future<String> chain() async {
    final response = await _provider.send('system_chain', []);
    return response.result as String;
  }

  /// Retrieves the chain type
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
}
