part of polkadart_keyring;

class Ed25519KeyPair extends KeyPair {
  late ed.PublicKey _publicKey;
  late ed.PrivateKey _privateKey;
  bool _locked = false;

  Ed25519KeyPair() : super(KeyPairType.ed25519);

  @override
  KeyPair fromSeed(Uint8List seed) {
    _privateKey = ed.newKeyFromSeed(seed);
    _publicKey = ed.public(_privateKey);
    return this;
  }

  @override
  Future<KeyPair> fromMnemonic(String mnemonic, [String? password]) async {
    final seed =
        await SubstrateBip39.ed25519.seedFromUri(mnemonic, password: password);
    return KeyPair.ed25519.fromSeed(Uint8List.fromList(seed));
  }

  @override
  Uint8List sign(Uint8List message) {
    if (_locked) {
      throw Exception('KeyPair is locked. Unlock it before signing.');
    }
    return ed.sign(_privateKey, message);
  }

  @override
  bool verify(Uint8List message, Uint8List signature) {
    return ed.verify(_publicKey, message, signature);
  }

  @override
  String get address {
    return Address(prefix: 42, pubkey: bytes).encode();
  }

  @override
  Future<void> unlockFromMemonic(String mnemonic, [String? password]) async {
    final seed =
        await SubstrateBip39.ed25519.seedFromUri(mnemonic, password: password);
    _unlock(ed.newKeyFromSeed(Uint8List.fromList(seed)));
  }

  @override
  void unlockFromSeed(Uint8List seed) {
    _unlock(ed.newKeyFromSeed(seed));
  }

  void _unlock(ed.PrivateKey privateKey) {
    if (ed.public(privateKey).bytes.toString() != bytes.toString()) {
      throw Exception('Public_Key_Mismatch: Invalid seed for given KeyPair.');
    }
    _privateKey = privateKey;
    _locked = false;
  }

  @override
  void lock() {
    _isLocked = true;
    _privateKey = ed.PrivateKey(Uint8List(0));
  }

  @override
  Uint8List get bytes => Uint8List.fromList(_publicKey.bytes);

  ///
  /// Returns `true` if the `KeyPair` matches with the other object.
  @override
  bool operator ==(Object other) {
    if (other is KeyPair) {
      return bytes == other.bytes;
    }
    return false;
  }

  ///
  /// Returns the hash code of the `KeyPair`.
  @override
  int get hashCode => bytes.hashCode;
}