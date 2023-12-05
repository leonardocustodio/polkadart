part of polkadart_keyring;

/// Represents a cryptographic key pair for signing and verifying data.
///
/// This class provides methods for creating key pairs from seeds or BIP39
/// mnemonics, signing messages, and verifying message signatures. It also
/// includes a method to obtain the Substrate address encoded in SS58 format.
///
/// Example usages are provided for each function below.
abstract class KeyPair {
  static Ed25519KeyPair get ed25519 => Ed25519KeyPair();
  static Sr25519KeyPair get sr25519 => Sr25519KeyPair();

  final KeyPairType keyPairType;
  bool _isLocked = false;

  /// constructor
  KeyPair(this.keyPairType);

  Uint8List get bytes;

  /// Create a new `KeyPair` from a given seed.
  ///
  /// The [seed] is used to generate both the private and public keys.
  ///
  /// Example:
  /// ```dart
  /// final seed = Uint8List(32); // Replace with your actual seed
  /// final keyPair = KeyPair.sr25519.fromSeed(seed);
  /// ```
  KeyPair fromSeed(Uint8List seed);

  /// Generate a `KeyPair` from a BIP39 mnemonic.
  ///
  /// The [mnemonic] is used to derive the seed, which in turn is used to generate
  /// the private and public keys.
  ///
  /// Example:
  /// ```dart
  /// final mnemonic = "your mnemonic phrase"; // Replace with your actual mnemonic
  /// final keyPair = await KeyPair.sr25519.fromMnemonic(mnemonic);
  /// ```
  Future<KeyPair> fromMnemonic(String mnemonic, [String? password]);

  /// Sign a given message with the private key.
  ///
  /// The [message] is a Uint8List representing the data to be signed.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.sr25519.fromSeed(seed); // Replace with your actual seed
  /// final message = Uint8List.fromList([1, 2, 3, 4, 5]);
  /// final signature = keyPair.sign(message);
  /// ```
  Uint8List sign(Uint8List message);

  /// Verify a message's signature using the public key.
  ///
  /// The [message] is the original message data, and the [signature] is the
  /// signature to be verified.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.sr25519.fromSeed(seed); // Replace with your actual seed
  /// final message = Uint8List.fromList([1, 2, 3, 4, 5]);
  /// final signature = keyPair.sign(message);
  /// final isVerified = keyPair.verify(message, signature);
  /// print('Signature Verification: $isVerified');
  /// ```
  bool verify(Uint8List message, Uint8List signature);

  /// Unlock a `KeyPair` from a given [seed].
  ///
  /// This method unlocks the `KeyPair` by adding the private key.
  ///
  /// Example:
  /// ```dart
  /// final seed = Uint8List(32); // Replace with your actual seed
  /// final keyPair = KeyPair.sr25519.fromSeed(seed);
  /// keyPair.lock();
  /// keyPair.sign(message); // Throws an error
  /// keyPair.unlockFromSeed(seed);
  /// keyPair.sign(message); // Works
  /// ```
  void unlockFromSeed(Uint8List seed);

  /// Unlock a `KeyPair` from a given BIP39 mnemonic.
  ///
  /// This method unlocks the `KeyPair` by adding the private key.
  ///
  /// Example:
  /// ```dart
  /// final mnemonic = "your mnemonic phrase"; // Replace with your actual mnemonic
  /// final keyPair = await KeyPair.sr25519.fromMnemonic(mnemonic);
  /// keyPair.lock();
  /// keyPair.sign(message); // Throws an error
  /// keyPair.unlockFromMemonic(mnemonic);
  /// keyPair.sign(message); // Works
  /// ```
  Future<void> unlockFromMemonic(String mnemonic, [String? password]);

  /// Get the Substrate address encoded in SS58 format.
  ///
  /// This method uses the SS58 package to encode the public key with a default
  /// prefix of 42.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.sr25519.fromSeed(seed); // Replace with your actual seed
  /// print('Substrate Address: ${keyPair.address}');
  /// ```
  String get address;

  /// Add lock functionality to a `KeyPair`.
  ///
  /// This method locks the `KeyPair` by removing the private key.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.sr25519.fromSeed(seed);
  /// keyPair.lock();
  /// ```
  void lock();

  ///
  /// Returns `true` if the `KeyPair` is locked.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = KeyPair.sr25519.fromSeed(seed); // Replace with your actual seed
  /// keyPair.lock();
  /// print('Is locked: ${keyPair.isLocked}');
  /// ```
  bool get isLocked => _isLocked;

  @override
  String toString() {
    return bytes.toString();
  }

  ///
  /// Returns `true` if the `KeyPair` matches with the other object.
  @override
  bool operator ==(Object other) {
    return const ListEquality().equals(bytes.toList(growable: false),
        (other as KeyPair).bytes.toList(growable: false));
  }

  ///
  /// Returns the hash code of the `KeyPair`.
  @override
  int get hashCode => bytes.hashCode;
}
