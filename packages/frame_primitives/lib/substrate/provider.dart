part of substrate_core;

abstract class Provider {
  const Provider();

  /// Query storage entries (by key) starting at block hash given as the second parameter.
  Future<List<Uint8List?>> queryStorage(List<Uint8List> keys,
      {Uint8List? block});

  Future<Map<String, dynamic>> send(String method, List<String> params);

  /// New storage subscription
  // Future<StreamSubscription<StorageChangeSet>> subscribeStorage(List<Uint8List> keys);
}

class WsProvider extends Provider {
  final String url;

  const WsProvider({required this.url});

  @override
  Future<List<Uint8List?>> queryStorage(List<Uint8List> keys,
      {Uint8List? block}) async {
    final result =
        await send('state_getStorage', <String>['0x${HEX.encode(keys.first)}']);
    final data = result['result'] as String?;
    if (data != null) {
      return [Uint8List.fromList(HEX.decode(data.substring(2)))];
    }
    return [null];
  }

  @override
  Future<Map<String, dynamic>> send(String method, List<String> params) async {
    final url = Uri.https(this.url);
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': 1,
          'jsonrpc': '2.0',
          'method': method,
          'params': params,
        }));

    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  // @override
  // Future<StreamSubscription<StorageChangeSet>> subscribeStorage(List<Uint8List> keys) {
  //   // TODO: implement subscribeStorage
  //   throw UnimplementedError();
  // }
}
