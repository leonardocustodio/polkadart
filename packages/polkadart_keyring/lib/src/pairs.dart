part of polkadart_keyring;

/// A collection of key pairs for managing ed25519-based cryptographic operations.
///
/// The `Pairs` class provides a way to manage key pairs by allowing you to add, remove, and retrieve
/// key pairs by address or public key. It also offers methods to get lists of all key pairs, public keys,
/// and addresses within the collection.
///
/// Example usages and function descriptions are provided below.
class Pairs {
  final Map<String, KeyPair> _pairs = <String, KeyPair>{};

  /// Add a [KeyPair] to the collection of pairs.
  ///
  /// - [pair]: The key pair to add to the collection.
  void add(KeyPair pair) {
    _pairs[Address.decode(pair.address).pubkey.toList().toString()] = pair;
  }

  /// Get a [KeyPair] from the collection by its address.
  ///
  /// - [address]: The address of the key pair to retrieve.
  ///
  /// Throws an exception if the key pair associated with the provided [address] is not found.
  KeyPair getByAddress(String address) {
    return getByPublicKey(Address.decode(address).pubkey.toList());
  }

  /// Get a [KeyPair] from the collection by its public key.
  ///
  /// - [publicKey]: The public key (as a list of integers) of the key pair to retrieve.
  ///
  /// Example:
  /// ```dart
  /// final publicKey = [1, 2, 3]; // Replace with an actual public key
  /// final keyPair = pairs.getByPublicKey(publicKey);
  /// ```
  KeyPair getByPublicKey(List<int> publicKey) {
    if (_pairs[publicKey.toString()] == null) {
      throw ArgumentError('KeyPair with provided key, not found.');
    }
    return _pairs[publicKey.toString()]!;
  }

  /// Remove a [KeyPair] from the collection by its address.
  ///
  /// - [address]: The address of the key pair to remove.
  ///
  /// If the key pair exists, it will be removed.
  void remove(String address) {
    removeByPublicKey(Address.decode(address).pubkey);
  }

  /// Remove all [KeyPair]s from the collection.
  void clear() {
    _pairs.clear();
  }

  /// Remove a [KeyPair] from the collection by its public key.
  ///
  /// - [publicKey]: The public key (as a list of integers) of the key pair to remove.
  void removeByPublicKey(List<int> publicKey) {
    _pairs.remove(publicKey.toString());
  }

  /// Get all [KeyPair]s in the collection.
  List<KeyPair> get all {
    return List<KeyPair>.from(_pairs.values.toList());
  }

  /// Get a list of all public keys from the collection.
  List<List<int>> get publicKeys {
    return all.map((pair) => pair.publicKey.bytes).toList();
  }

  /// Get a list of all addresses from the collection.
  List<String> get addresses {
    return all.map((pair) => pair.address).toList();
  }
}
