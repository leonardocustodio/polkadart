import 'dart:async' show Future, Completer, StreamController, FutureOr;
import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart'
    show WebSocketChannel;

class RpcResponse<R, T> {
  final int id;
  final R? result;
  final T? error;

  RpcResponse({required this.id, this.result, this.error});
}

class SubscriptionResponse<R> {
  final String id;
  final Stream<SubscriptionMessage<R>> stream;

  SubscriptionResponse({required this.id, required this.stream});
}

class SubscriptionMessage<R> {
  final String method;
  final String subscription;
  final R result;

  SubscriptionMessage(
      {required this.method, required this.subscription, required this.result});
}

// Generic transport providers to handle the transport of method calls to and from Polkadot clients from applications interacting with it.
abstract class Provider {
  const Provider();

  factory Provider.fromUri(Uri uri) {
    if (uri.scheme == 'http' || uri.scheme == 'https') {
      return HttpProvider(uri);
    }
    if (uri.scheme == 'ws' || uri.scheme == 'wss') {
      return WsProvider(uri);
    }
    throw Exception('Invalid url: $uri');
  }

  // Whether the node is connected or not (ws/sc has connection logic)
  bool isConnected();

  // Manually connect
  Future connect();

  // Manually disconnect from the connection, clearing auto-connect logic
  Future disconnect();

  /// Send arbitrary message to RPC node
  Future<RpcResponse> send(String method, List<dynamic> params);

  /// Send subscribe message to RPC node
  Future<SubscriptionResponse> subscribe(String method, List<dynamic> params,
      {FutureOr<void> Function(String subscription)? onCancel});
}

/// The HTTP Provider allows sending requests using HTTP to a HTTP RPC server TCP port.
/// It does not support subscriptions so you won't be able to listen to events such as new blocks or balance changes.
/// It is usually preferable using the [[WsProvider]]
class HttpProvider extends Provider {
  HttpProvider(this.url) : super();

  //  uri to connect to
  final Uri url;

  // Sequence used to generate unique query ids
  int _sequence = 0;

  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    final response = await http.post(url,
        body: jsonEncode(
          {
            'id': (++_sequence).toString(),
            'jsonrpc': '2.0',
            'method': method,
            'params': params,
          },
        ),
        headers: {'Content-Type': 'application/json'});
    final data = jsonDecode(response.body);

    return RpcResponse(
      id: int.tryParse(data['id'].toString()) ?? -1,
      result: data['result'],
    );
  }

  @override
  Future<SubscriptionResponse> subscribe(String method, List params,
      {FutureOr<void> Function(String subscription)? onCancel}) {
    throw Exception('HttpProvider does not support subscriptions');
  }

  @override
  Future connect() {
    return Future.value();
  }

  @override
  Future disconnect() {
    return Future.value();
  }

  @override
  bool isConnected() {
    return true;
  }
}

/// The WebSocket Provider allows sending requests using WebSocket to a WebSocket RPC server TCP port. Unlike the [[HttpProvider]],
/// it does support subscriptions and allows listening to events such as new blocks or balance changes.
class WsProvider extends Provider {
  /// Creates a new websocket connection, connects automatically by default
  WsProvider(this.url, {bool autoConnect = true}) : super() {
    if (autoConnect) {
      connect();
    }
  }

  /// The endpoint url
  final Uri url;

  /// Maps the query id to the completer that will resolve the query
  final Map<int, Completer<RpcResponse>> queries = {};

  /// Maps the subscription id to the stream controller that will emit the subscription data
  final Map<String, StreamController<SubscriptionMessage>> subscriptions = {};

  /// WebSocket connection
  WebSocketChannel? channel;

  /// Sequence used to generate unique query ids
  int _sequence = 0;

  bool get isOpen => channel != null;

  /// Promise that resolves the first time we are connected and loaded
  Future<bool> ready() async {
    if (channel != null) {
      await channel!.ready;
      return true;
    }
    return false;
  }

  /// Open websocket channel
  @override
  Future connect() async {
    if (this.channel != null) {
      throw Exception('Already connected');
    }

    _sequence = 0;
    final WebSocketChannel channel = WebSocketChannel.connect(url);
    final jsonStream = channel.stream.map((response) {
      if (response == null) {
        throw Exception('Invalid jsonrpc field in decoded object');
      }

      final Map<String, dynamic> json;
      try {
        json = jsonDecode(response);
      } catch (e) {
        throw Exception('The response is not a valid json object');
      }

      if (!json.containsKey('jsonrpc') || json['jsonrpc'] != '2.0') {
        throw Exception('Invalid jsonrpc field in decoded object');
      }

      return json;
    }).asBroadcastStream();

    // Commands
    jsonStream.where((message) => message.containsKey('id')).map((message) {
      final id = message['id'] as int;
      final result = message.containsKey('result') ? message['result'] : null;
      final error = message.containsKey('error') ? message['error'] : null;
      return RpcResponse(id: id, result: result, error: error);
    }).listen((message) {
      queries.remove(message.id)!.complete(message);
    });

    // Subscriptions
    jsonStream
        .where((message) =>
            !message.containsKey('id') &&
            message.containsKey('params') &&
            (message['params'] as Map<String, dynamic>)
                .containsKey('subscription'))
        .map((message) {
      final method = message['method'] as String;
      final params = message['params'] as Map<String, dynamic>;
      final subscription = params['subscription'] as String;
      final result = params.containsKey('result') ? params['result'] : null;

      return SubscriptionMessage(
          method: method, subscription: subscription, result: result);
    }).listen((message) {
      final StreamController? controller =
          getSubscriptionController(message.subscription);
      controller?.add(message);
    });

    this.channel = channel;
    await channel.ready;
  }

  // Close websocket channel
  @override
  Future disconnect() async {
    if (channel == null) {
      throw Exception('Channel is already close');
    }
    for (final controller in subscriptions.values) {
      await controller.close();
    }
    subscriptions.clear();
    await channel!.sink.close(status.goingAway);
    channel = null;
  }

  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    if (channel == null) {
      throw Exception('WebsocketChannel is closed');
    }
    await channel!.ready;

    final id = _sequence++;
    final completer = Completer<RpcResponse>();
    queries[id] = completer;

    channel!.sink.add(jsonEncode({
      'id': id,
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    }));

    return completer.future;
  }

  /// Send arbitrary message to RPC node
  @override
  Future<SubscriptionResponse> subscribe(String method, List<dynamic> params,
      {FutureOr<void> Function(String subscription)? onCancel}) async {
    final result = await send(method, params);

    if (result.error != null) {
      throw Exception(result.error.toString());
    }

    final subscription = result.result as String;
    final controller = getOrCreateSubscriptionController(subscription);
    return SubscriptionResponse(
      id: subscription,
      stream: controller.stream,
    );
  }

  StreamController<SubscriptionMessage>? getSubscriptionController(
      String subscriptionId) {
    if (subscriptions.containsKey(subscriptionId)) {
      return subscriptions[subscriptionId]!;
    } else {
      return null;
    }
  }

  // Returns an existing StreamController, or create a new one if it doesn't exist
  StreamController<SubscriptionMessage> getOrCreateSubscriptionController(
      String subscription,
      [FutureOr<void> Function(String subscription)? onCancel]) {
    if (subscriptions.containsKey(subscription)) {
      return subscriptions[subscription]!;
    } else {
      final controller =
          StreamController<SubscriptionMessage>.broadcast(onCancel: () async {
        if (onCancel != null) {
          await onCancel(subscription);
        }
        if (subscriptions.containsKey(subscription)) {
          subscriptions.remove(subscription);
        }
      });
      subscriptions[subscription] = controller;
      return controller;
    }
  }

  @override
  bool isConnected() {
    return channel != null && channel!.closeCode == null;
  }
}
