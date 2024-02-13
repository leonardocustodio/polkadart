part of apis;

/// Substrate state API
class ChainApi<P extends Provider> {
  final P _provider;

  ChainApi(this._provider);

  /// Returns the BlockHash for the given block number.
  ///
  /// If no block number is provided, it will return the hash of the latest block at chain height.
  Future<BlockHash> getBlockHash({int? blockNumber}) async {
    final List<dynamic> params = <dynamic>[];
    if (blockNumber != null) {
      params.add(blockNumber);
    }

    final response = await _provider.send('chain_getBlockHash', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    return Uint8List.fromList(
        hex.decode((response.result as String).substring(2)));
  }

  ///
  Future<int> getChainHeader({BlockHash? at}) async {
    final List<String> params = <String>[];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('chain_getHeader', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }
    return int.parse(response.result['number']!);
  }
}
