import 'package:polkadart_keyring/src/pairs.dart';

import '../polkadart_keyring.dart';

///
/// Creates a new Keyring object for ed25519-based key pairs.
class Keyring {
  final Pairs pairs;

  Keyring() : pairs = Pairs();

  Future<KeyPair> createKeyPairFromMnemonic(String mnemonic,
      {bool addToPairs = false}) async {
    final pair = await KeyPair.fromMnemonic(mnemonic);
    if (addToPairs) {
      pairs.add(pair);
    }
    return pair;
  }

  ///
  /// Add a [KeyPair] to the keyring.
  void add(KeyPair pair) {
    pairs.add(pair);
  }

  ///
  /// Get all [KeyPair]s in the keyring.
  List<KeyPair> get all {
    return pairs.all;
  }

  ///
  /// Get a [KeyPair] from the keyring by [address]
  /// If the [pair] does not exist, it will throw an error.
  KeyPair getByAddress(String address) {
    return pairs.getByAddress(address);
  }

  KeyPair getByPublicKey(List<int> publicKey) {
    return pairs.getByPublicKey(publicKey);
  }

  ///
  /// Remove a [KeyPair] from the keyring by [address].
  void remove(String address) {
    pairs.remove(address);
  }

  ///
  /// Get all public keys in the keyring.
  List<List<int>> get publicKeys {
    return pairs.all
        .map((pair) => List<int>.from(pair.publicKey.bytes))
        .toList();
  }

  ///
  /// Get all addresses in the keyring.
  List<String> get addresses {
    return pairs.all.map((pair) => pair.address).toList();
  }
}
