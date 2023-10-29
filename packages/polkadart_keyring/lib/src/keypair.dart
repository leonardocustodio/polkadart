part of polkadart_keyring;

/// Represents a cryptographic key pair for signing and verifying data.
///
/// This class provides methods for creating key pairs from seeds or BIP39
/// mnemonics, signing messages, and verifying message signatures. It also
/// includes a method to obtain the Substrate address encoded in SS58 format.
///
/// Example usages are provided for each function below.
class KeyPair {
  late ed.PublicKey publicKey;
  late ed.PrivateKey _privateKey;
  bool _locked = false;

  /// Create a new `KeyPair` from a given seed.
  ///
  /// The [seed] is used to generate both the private and public keys.
  ///
  /// Example:
  /// ```dart
  /// final seed = Uint8List(32); // Replace with your actual seed
  /// final keyPair = KeyPair.fromSeed(seed);
  /// ```
  KeyPair.fromSeed(Uint8List seed) {
    _privateKey = ed.newKeyFromSeed(seed);
    publicKey = ed.public(_privateKey);
  }

  /// Generate a `KeyPair` from a BIP39 mnemonic.
  ///
  /// The [mnemonic] is used to derive the seed, which in turn is used to generate
  /// the private and public keys.
  ///
  /// Example:
  /// ```dart
  /// final mnemonic = "your mnemonic phrase"; // Replace with your actual mnemonic
  /// final keyPair = await KeyPair.fromMnemonic(mnemonic);
  /// ```
  static Future<KeyPair> fromMnemonic(String mnemonic) async {
    final seed = await SubstrateBip39.ed25519.seedFromUri(mnemonic);
    return KeyPair.fromSeed(Uint8List.fromList(seed));
  }

  /// Sign a given message with the private key.
  ///
  /// The [message] is a Uint8List representing the data to be signed.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.fromSeed(seed); // Replace with your actual seed
  /// final message = Uint8List.fromList([1, 2, 3, 4, 5]);
  /// final signature = keyPair.sign(message);
  /// ```
  Uint8List sign(Uint8List message) {
    if (_locked) {
      throw Exception('KeyPair is locked. Unlock it before signing.');
    }
    return ed.sign(_privateKey, message);
  }

  /// Verify a message's signature using the public key.
  ///
  /// The [message] is the original message data, and the [signature] is the
  /// signature to be verified.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.fromSeed(seed); // Replace with your actual seed
  /// final message = Uint8List.fromList([1, 2, 3, 4, 5]);
  /// final signature = keyPair.sign(message);
  /// final isVerified = keyPair.verify(message, signature);
  /// print('Signature Verification: $isVerified');
  /// ```
  bool verify(Uint8List message, Uint8List signature) {
    return ed.verify(publicKey, message, signature);
  }

  /// Get the Substrate address encoded in SS58 format.
  ///
  /// This method uses the SS58 package to encode the public key with a default
  /// prefix of 42.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.fromSeed(seed); // Replace with your actual seed
  /// print('Substrate Address: ${keyPair.address}');
  /// ```
  String get address {
    return Address(prefix: 42, pubkey: Uint8List.fromList(publicKey.bytes))
        .encode();
  }

  ///
  /// Returns `true` if the `KeyPair` is locked.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.fromSeed(seed); // Replace with your actual seed
  /// keyPair.lock();
  /// print('Is locked: ${keyPair.isLocked}');
  /// ```
  bool get isLocked => _locked;

  /// Add lock functionality to a `KeyPair`.
  ///
  /// This method locks the `KeyPair` by removing the private key.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.fromSeed(seed);
  /// keyPair.lock();
  /// ```
  void lock() {
    _privateKey = ed.PrivateKey(Uint8List(32));
    _locked = true;
  }

  /// Unlock a `KeyPair` from a given BIP39 mnemonic.
  ///
  /// This method unlocks the `KeyPair` by adding the private key.
  ///
  /// Example:
  /// ```dart
  /// final mnemonic = "your mnemonic phrase"; // Replace with your actual mnemonic
  /// final keyPair = await KeyPair.fromMnemonic(mnemonic);
  /// keyPair.lock();
  /// keyPair.sign(message); // Throws an error
  /// keyPair.unlockFromMemonic(mnemonic);
  /// keyPair.sign(message); // Works
  /// ```
  Future<void> unlockFromMemonic(String mnemonic) async {
    final seed = await SubstrateBip39.ed25519.seedFromUri(mnemonic);
    _unlock(ed.newKeyFromSeed(Uint8List.fromList(seed)));
  }

  /// Unlock a `KeyPair` from a given [seed].
  ///
  /// This method unlocks the `KeyPair` by adding the private key.
  ///
  /// Example:
  /// ```dart
  /// final seed = Uint8List(32); // Replace with your actual seed
  /// final keyPair = KeyPair.fromSeed(seed);
  /// keyPair.lock();
  /// keyPair.sign(message); // Throws an error
  /// keyPair.unlockFromSeed(seed);
  /// keyPair.sign(message); // Works
  /// ```
  void unlockFromSeed(Uint8List seed) {
    _unlock(ed.newKeyFromSeed(seed));
  }

  void _unlock(ed.PrivateKey privateKey) {
    if (ed.public(privateKey).bytes.toString() != publicKey.bytes.toString()) {
      throw Exception('Public_Key_Mismatch: Invalid seed for given KeyPair.');
    }
    _privateKey = privateKey;
    _locked = false;
  }

  ///
  /// Returns `true` if the `KeyPair` matches with the other object.
  @override
  bool operator ==(Object other) {
    if (other is KeyPair) {
      return publicKey.bytes == other.publicKey.bytes;
    }
    return false;
  }

  ///
  /// Returns the hash code of the `KeyPair`.
  @override
  int get hashCode => publicKey.bytes.hashCode;
}
