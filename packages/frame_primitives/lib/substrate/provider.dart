part of substrate_core;

abstract class Provider {
  const Provider();

  /// Query storage entries (by key) starting at block hash given as the second parameter.
  Future<List<Uint8List?>> queryStorage(List<Uint8List> keys,
      {Uint8List? block});

  Future<Map<String, dynamic>> send(String method, List<String> params);
}

class WsProvider extends Provider {
  int sequence = 0;
  late WebSocketChannel channel;
  late Map<int, Completer<Map<String, dynamic>>> subscriptions = {};

  WsProvider(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));

    channel.stream.listen((message) {
      final data = jsonDecode(message) as Map<String, dynamic>;
      final id = data['id'] as int;
      subscriptions.remove(id)!.complete(data);
    });
  }

  @override
  Future<List<Uint8List?>> queryStorage(List<Uint8List> keys,
      {Uint8List? block}) async {
    final result =
        await send('state_getStorage', <String>['0x${hex.encode(keys.first)}']);
    final data = result['result'] as String?;
    if (data != null) {
      return [Uint8List.fromList(hex.decode(data.substring(2)))];
    }
    return [null];
  }

  @override
  Future<Map<String, dynamic>> send(String method, List<String> params) async {
    final id = sequence++;
    final completer = Completer<Map<String, dynamic>>();
    subscriptions[id] = completer;

    channel.sink.add(jsonEncode({
      'id': id,
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    }));

    return completer.future;
  }

  void close() {
    channel.sink.close(status.goingAway);
  }

  // @override
  // Future<StreamSubscription<StorageChangeSet>> subscribeStorage(List<Uint8List> keys) {
  //   // TODO: implement subscribeStorage
  //   throw UnimplementedError();
  // }
}
