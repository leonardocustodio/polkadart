import 'dart:async' show Future, FutureOr;
import 'package:polkadart/polkadart.dart'
    show Provider, RpcResponse, SubscriptionResponse;

/// The Mock Provider allows mock requests.
class MockProvider<S> extends Provider {
  MockProvider(this._state) : super();

  /// Custom State
  final S _state;

  /// Maps the methods to the mock responses
  final Map<String, dynamic Function(List<dynamic>, S)> _callbacks = {};

  // Sequence used to generate unique query ids
  int _sequence = 0;

  void setMethodCallback(
      String method, dynamic Function(List<dynamic>, S) callback) {
    _callbacks[method] = callback;
  }

  @override
  Future<RpcResponse> send(String method, List<dynamic> params) async {
    if (_callbacks[method] == null) {
      throw Exception(
          'MockProvider: The callback for the method "$method" isn\'t defined');
    }

    final response = _callbacks[method]!(params, _state);
    return RpcResponse(
      id: ++_sequence,
      result: response,
    );
  }

  @override
  Future<SubscriptionResponse> subscribe(String method, List params,
      {FutureOr<void> Function(String subscription)? onCancel}) {
    throw Exception('MockProvider does not support subscriptions');
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
