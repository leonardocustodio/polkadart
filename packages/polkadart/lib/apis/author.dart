part of apis;

/// Substrate state API
class AuthorApi<P extends Provider> {
  final P _provider;

  const AuthorApi(this._provider);

  /// Submit a fully formatted extrinsic for block inclusion.
  /// The type will be changed to Extrinsic later
  Future<Uint8List> submitExtrinsic(Uint8List extrinsic) async {
    final List<dynamic> params = ['0x${hex.encode(extrinsic)}'];

    final response = await _provider.send('author_submitExtrinsic', params);

    if (response.error != null) {
      throw Exception(response.error.toString());
    }

    final data = response.result as String;
    return Uint8List.fromList(hex.decode(data.substring(2)));
  }
}
