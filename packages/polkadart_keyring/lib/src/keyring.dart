part of polkadart_keyring;

/// A manager for ed25519-based key pairs in the keyring.
///
/// The `Keyring` class provides a convenient interface to manage ed25519-based key pairs.
/// It allows you to create key pairs from BIP39 mnemonics, add them to the keyring,
/// retrieve key pairs by address or public key, and perform various operations on them.
///
/// Example usages for each function are provided below.
class Keyring {
  final Pairs pairs;

  // The default SS58 address format used by the keyring.
  int _ss58Format = 42;

  /// Create a new `Keyring` instance.
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
  Future<KeyPair> createKeyPairFromMnemonic(String mnemonic, KeyPairType type,
      {bool addToPairs = false}) async {
    late KeyPair pair;

    if (type == KeyPairType.ed25519) {
      pair = await KeyPair.ed25519.fromMnemonic(mnemonic);
    } else {
      pair = await KeyPair.sr25519.fromMnemonic(mnemonic);
    }
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
  /// final keyPair = KeyPair(); // Create or obtain a KeyPair by KeyPair.ed25519 or KeyPair.sr25519
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

  ///
  /// Encode a public key to an SS58 address.
  /// The default SS58 address format used by the keyring is 42.
  ///
  /// - [key]: The public key to be encoded.
  /// - [ss58Format]: The SS58 address format to be used by the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final publicKey = [1, 2, 3]; // Replace with an actual public key
  /// final address = keyring.encodeAddress(publicKey);
  /// ```
  String encodeAddress(List<int> key, [int ss58Format = 42]) {
    return Address(prefix: ss58Format, pubkey: Uint8List.fromList(key))
        .encode();
  }

  ///
  /// Decode an SS58 address to its public key.
  /// The default SS58 address format used by the keyring is 42.
  ///
  /// - [address]: The SS58 address to be decoded.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final address = "your_address";
  /// final publicKey = keyring.decodeAddress(address);
  /// ```
  Uint8List decodeAddress(String address) {
    return Uint8List.fromList(Address.decode(address).pubkey.toList(growable: false));
  }

  /// Set the SS58 address format used by the keyring.
  /// The default value is 42.
  ///
  /// - [ss58Format]: The SS58 address format to be used by the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// keyring.ss58Format = 42;
  /// ```
  set ss58Format(int ss58Format) {
    if (ss58Format < 0 || ss58Format > 16383) {
      throw Exception('Invalid SS58 format.');
    }
    _ss58Format = ss58Format;
  }

  /// Get the SS58 address format used by the keyring.
  /// The default value is 42.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final ss58Format = keyring.ss58Format;
  /// ```
  int get ss58Format {
    return _ss58Format;
  }

  /// Get all public keys in the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final publicKeys = keyring.publicKeys;
  /// ```
  List<List<int>> get publicKeys {
    return pairs.all.map((pair) => pair.bytes.toList(growable: false)).toList(growable: false);
  }

  /// Get all addresses in the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// final addresses = keyring.addresses;
  /// ```
  List<String> get addresses {
    return pairs.all.map((pair) => pair.address).toList(growable: false);
  }

  /// Remove all key pairs from the keyring.
  ///
  /// Example:
  /// ```dart
  /// final keyring = Keyring();
  /// keyring.clear();
  /// ```
  void clear() {
    pairs.clear();
  }
}
