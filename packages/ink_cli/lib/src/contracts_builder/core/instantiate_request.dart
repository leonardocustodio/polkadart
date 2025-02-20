part of ink_cli;

class InstantiateRequest {
  final List<int> _contractAddress;
  final dynamic _result;

  const InstantiateRequest(this._contractAddress, this._result) : assert(_result != null);

  List<int> get contractAddress => _contractAddress;

  get result => _result;

  String getTransactionHash() {
    if (_result is! String) {
      throw Exception('result is InstantiateRequest not a String, Try calling getInBlockHash()');
    }
    return _result;
  }

  String getInBlockHash() {
    if (_result is! Map) {
      throw Exception('result is transaction-hash, Try calling getTransactionHash()');
    }
    if (_result['params']?['result']?['inBlock'] == null) {
      throw Exception('inBlock is not available in the result');
    }
    if (_result['params']['result']['inBlock'] is! String) {
      throw Exception('inBlock is not a String');
    }
    return _result['params']['result']['inBlock'];
  }
}
