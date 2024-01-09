part of polkadart_keyring;

class PublicKey {
  final List<int> _bytes;
  const PublicKey(this._bytes);

  /// Returns the bytes of the public key
  List<int> get bytes => List<int>.from(_bytes);
}
