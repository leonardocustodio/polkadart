part of polkadart_keyring;

final context = merlin.Transcript('susbtrate');

class Sr25519KeyPair extends KeyPair {
  late sr25519.PublicKey _publicKey;
  late sr25519.SecretKey _privateKey;

  Sr25519KeyPair() : super(KeyPairType.sr25519);

  @override
  KeyPair fromSeed(Uint8List seed) {
    _privateKey = sr25519.SecretKey.fromEd25519Bytes(seed);
    _publicKey = _privateKey.public();
    return this;
  }

  @override
  Future<KeyPair> fromMnemonic(String mnemonic, [String? password]) async {
    final seed = await sr25519.Bip39.seedFromMnemonic(mnemonic, password);
    return fromSeed(Uint8List.fromList(seed));
  }

  @override
  Uint8List sign(Uint8List message) {
    if (_isLocked) {
      throw Exception('KeyPair is locked. Unlock it before signing.');
    }
    return sr25519.Sr25519.sign(_privateKey, message).encode();
  }

  @override
  bool verify(Uint8List message, Uint8List signature) {
    final (verified, exception) = sr25519.Sr25519.verify(
        _publicKey, sr25519.Signature.fromBytes(signature), message);
    if (exception != null) {
      throw exception;
    }
    return verified;
  }

  @override
  String get address {
    return Address(prefix: 42, pubkey: bytes).encode();
  }

  @override
  Future<void> unlockFromMemonic(String mnemonic, [String? password]) async {
    final seed = await SubstrateBip39.ed25519.seedFromUri(mnemonic);
    _unlock(sr25519.SecretKey.fromEd25519Bytes(seed));
  }

  @override
  void unlockFromSeed(Uint8List seed) {
    _unlock(sr25519.SecretKey.fromEd25519Bytes(seed));
  }

  void _unlock(sr25519.SecretKey privateKey) {
    if (privateKey.public().encode().toString() != bytes.toString()) {
      throw Exception('Public_Key_Mismatch: Invalid seed for given KeyPair.');
    }
    _privateKey = privateKey;
    _isLocked = false;
  }

  @override
  void lock() {
    _isLocked = true;
    _privateKey = sr25519.SecretKey.fromEd25519Bytes(Uint8List(0));
  }

  @override
  Uint8List get bytes => Uint8List.fromList(_publicKey.encode());

  ///
  /// Returns `true` if the `KeyPair` matches with the other object.
  @override
  bool operator ==(Object other) {
    return super == (other);
  }

  ///
  /// Returns the hash code of the `KeyPair`.
  @override
  int get hashCode => super.hashCode;
}
