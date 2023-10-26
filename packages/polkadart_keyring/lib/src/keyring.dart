import 'package:polkadart_keyring/src/pairs.dart';

import '../polkadart_keyring.dart';

/// A manager for ed25519-based key pairs in the keyring.
///
/// The `Keyring` class provides a convenient interface to manage ed25519-based key pairs.
/// It allows you to create key pairs from BIP39 mnemonics, add them to the keyring,
/// retrieve key pairs by address or public key, and perform various operations on them.
///
/// Example usages for each function are provided below.
class Keyring {
  final Pairs pairs;

  Keyring() : pairs = Pairs();

  /// Create a new [KeyPair] from a BIP39 mnemonic and optionally add it to the keyring.
  ///
  /// This method generates a key pair from the provided [mnemonic].
  ///
  /// - [mnemonic]: The BIP39 mnemonic phrase used to derive the key pair.
  /// - [addToPairs]: If set to `true`, the key pair will be added to the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final mnemonic = "your mnemonic phrase";
  /// final keyPair = await keyring.createKeyPairFromMnemonic(mnemonic, addToPairs: true);
  /// ```
  Future<KeyPair> createKeyPairFromMnemonic(String mnemonic,
      {bool addToPairs = false}) async {
    final pair = await KeyPair.fromMnemonic(mnemonic);
    if (addToPairs) {
      pairs.add(pair);
    }
    return pair;
  }

  /// Add a [KeyPair] to the keyring.
  ///
  /// - [pair]: The key pair to be added to the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final keyPair = KeyPair(); // Create or obtain a KeyPair
  /// keyring.add(keyPair);
  /// ```
  void add(KeyPair pair) {
    pairs.add(pair);
  }

  /// Get all [KeyPair]s in the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final allKeyPairs = keyring.all;
  /// ```
  List<KeyPair> get all {
    return pairs.all;
  }

  /// Get a [KeyPair] from the keyring by address.
  /// If the [pair] does not exist, it will throw an error.
  ///
  /// - [address]: The address of the key pair to retrieve.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final address = "your_address";
  /// final keyPair = keyring.getByAddress(address);
  /// ```
  KeyPair getByAddress(String address) {
    return pairs.getByAddress(address);
  }

  /// Get a [KeyPair] from the keyring by public key.
  ///
  /// - [publicKey]: The public key (as a list of integers) of the key pair to retrieve.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final publicKey = [1, 2, 3]; // Replace with an actual public key
  /// final keyPair = keyring.getByPublicKey(publicKey);
  /// ```
  KeyPair getByPublicKey(List<int> publicKey) {
    return pairs.getByPublicKey(publicKey);
  }

  /// Remove a [KeyPair] from the keyring by address.
  ///
  /// - [address]: The address of the key pair to remove.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final address = "your_address";
  /// keyring.remove(address);
  /// ```
  void remove(String address) {
    pairs.remove(address);
  }

  /// Get all public keys in the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final publicKeys = keyring.publicKeys;
  /// ```
  List<List<int>> get publicKeys {
    return pairs.all
        .map((pair) => List<int>.from(pair.publicKey.bytes))
        .toList();
  }

  /// Get all addresses in the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final addresses = keyring.addresses;
  /// ```
  List<String> get addresses {
    return pairs.all.map((pair) => pair.address).toList();
  }
}
