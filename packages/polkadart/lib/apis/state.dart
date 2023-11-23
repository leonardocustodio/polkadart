part of apis;

/// Substrate state API
class StateApi<P extends Provider> {
  final P _provider;

  StateApi(this._provider);

  late RuntimeMetadata latestRuntimeMetadata;

  /// Call a contract at a block's state.
  Future<Uint8List> call(String method, Uint8List bytes,
      {BlockHash? at}) async {
    final List<String> params = [method, '0x${hex.encode(bytes)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_call', params);
    final data = response.result as String;
    return Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Returns the keys with prefix, leave empty to get all the keys
  Future<List<KeyValue>> getPairs(StorageKey prefix, {BlockHash? at}) async {
    final List<String> params = ['0x${hex.encode(prefix)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }

    final response = await _provider.send('state_getPairs', params);
    return (response.result as List)
        .cast<List>()
        .map((keyValue) => KeyValue.fromJson(keyValue))
        .toList();
  }

  /// Returns the keys with prefix with pagination support.
  /// Up to `count` keys will be returned.
  /// If `startKey` is passed, return next keys in storage in lexicographic order.
  Future<List<StorageKey>> getKeysPaged(
      {required StorageKey key,
      required int count,
      StorageKey? startKey,
      BlockHash? at}) async {
    final List<dynamic> params = ['0x${hex.encode(key)}', count];
    if (startKey != null) {
      params.add('0x${hex.encode(startKey)}');
    }
    if (at != null) {
      if (startKey == null) {
        params.add(null);
      }
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_getKeysPaged', params);
    return (response.result as List)
        .cast<String>()
        .map((key) => Uint8List.fromList(hex.decode(key.substring(2))))
        .toList();
  }

  /// Returns a storage entry at a specific block's state.
  Future<StorageData?> getStorage(StorageKey key, {BlockHash? at}) async {
    final List<String> params = ['0x${hex.encode(key)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_getStorage', params);
    final data = response.result as String?;
    return data == null
        ? null
        : Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Returns the hash of a storage entry at a block's state.
  Future<BlockHash?> getStorageHash(StorageKey key, {BlockHash? at}) async {
    final List<String> params = ['0x${hex.encode(key)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_getStorageHash', params);
    final data = response.result as String?;
    return data == null
        ? null
        : Uint8List.fromList(hex.decode(data.substring(2)));
  }

  /// Returns the size of a storage entry at a block's state.
  Future<int?> getStorageSize(StorageKey key, {BlockHash? at}) async {
    final List<String> params = ['0x${hex.encode(key)}'];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_getStorageSize', params);
    return response.result as int?;
  }

  /// Query historical storage entries (by key) starting from a block given as the second
  /// parameter.
  ///
  /// NOTE This first returned result contains the initial state of storage for all keys.
  /// Subsequent values in the vector represent changes to the previous state (diffs).
  Future<List<StorageChangeSet>> queryStorage(
      List<StorageKey> keys, BlockHash fromBlock,
      {BlockHash? toBlock}) async {
    final List<dynamic> params = [
      keys.map((key) => '0x${hex.encode(key)}').toList(),
      '0x${hex.encode(fromBlock)}'
    ];
    if (toBlock != null) {
      params.add('0x${hex.encode(toBlock)}');
    }
    final response = await _provider.send('state_queryStorage', params);
    return (response.result as List)
        .cast<Map<String, dynamic>>()
        .map((changeSet) => StorageChangeSet.fromJson(changeSet))
        .toList();
  }

  /// Query storage entries (by key) starting at block hash given as the second parameter.
  Future<List<StorageChangeSet>> queryStorageAt(List<StorageKey> keys,
      {BlockHash? at}) async {
    final List<dynamic> params = [
      keys.map((key) => '0x${hex.encode(key)}').toList()
    ];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_queryStorageAt', params);
    return (response.result as List)
        .cast<Map<String, dynamic>>()
        .map((changeSet) => StorageChangeSet.fromJson(changeSet))
        .toList();
  }

  /// Returns proof of storage entries at a specific block's state.
  Future<ReadProof> getReadProof(List<StorageKey> keys, {BlockHash? at}) async {
    final List<dynamic> params = [
      keys.map((key) => '0x${hex.encode(key)}').toList()
    ];
    if (at != null) {
      params.add('0x${hex.encode(at)}');
    }
    final response = await _provider.send('state_getReadProof', params);
    return ReadProof.fromJson(response.result);
  }

  /// Returns the runtime metadata
  Future<RuntimeMetadata> getMetadata({BlockHash? at}) async {
    final List<String> params = at != null ? ['0x${hex.encode(at)}'] : const [];
    final response = await _provider.send('state_getMetadata', params);
    return RuntimeMetadata.fromHex(response.result);
  }

  /// Get the runtime version.
  Future<RuntimeVersion> getRuntimeVersion({BlockHash? at}) async {
    final List<String> params = at != null ? ['0x${hex.encode(at)}'] : const [];
    final response = await _provider.send('state_getRuntimeVersion', params);
    return RuntimeVersion.fromJson(response.result);
  }

  /// Retrieves the runtime version via subscription
  Future<StreamSubscription<RuntimeVersion>> subscribeRuntimeVersion(
      Function(RuntimeVersion) onData) async {
    final subscription = await _provider
        .subscribe('state_subscribeRuntimeVersion', const [],
            onCancel: (subscription) async {
      await _provider.send('state_unsubscribeRuntimeVersion', [subscription]);
    });

    return subscription.stream
        .map((response) => RuntimeVersion.fromJson(response.result))
        .listen(onData);
  }

  Future<StreamSubscription<Events>> subscribeEvents(
      BlockHash at, Function(Events) onData) async {
    latestRuntimeMetadata = await getMetadata();

    final subscription = await _provider.subscribe('state_subscribeStorage', [
      ['0x${hex.encode(at)}']
    ], onCancel: (subscription) async {
      await _provider.send('state_unsubscribeStorage', [subscription]);
    });

    return subscription.stream.map((response) {
      return Events.fromJson(response.result, latestRuntimeMetadata.chainInfo);
    }).listen(onData);
  }

  /// Subscribes to storage changes for the provided keys
  Future<StreamSubscription<StorageChangeSet>> subscribeStorage(
      List<Uint8List> storageKeys,
      Function(StorageChangeSet) onData) async {
    final subscription = await _provider.subscribe(
        'state_subscribeStorage', [storageKeys], onCancel: (subscription) async {
      await _provider.send('state_unsubscribeStorage', [subscription]);
    });

    return subscription.stream
        .map((response) => StorageChangeSet.fromJson(response.result))
        .listen(onData);
  }
}
