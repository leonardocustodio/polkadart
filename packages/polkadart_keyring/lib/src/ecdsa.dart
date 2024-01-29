part of polkadart_keyring;

class EcdsaKeyPair extends KeyPair {
  late secp256k1.PublicKey _publicKey;
  late secp256k1.PrivateKey _privateKey;

  @override
  int ss58Format = 42;

  EcdsaKeyPair() : super(KeyPairType.ecdsa);

  @override
  KeyPair fromSeed(Uint8List seed) {
    _privateKey = secp256k1.PrivateKey.fromBytes(seed);
    _publicKey = _privateKey.getPublicKey();
    return this;
  }

  @override
  Future<KeyPair> fromUri(String uri, [String? password]) async {
    final seed =
        await SubstrateBip39.ecdsa.seedFromUri(uri, password: password);
    return fromSeed(Uint8List.fromList(seed));
  }

  @override
  Future<KeyPair> fromMnemonic(String uri, [String? password]) {
    return fromUri(uri, password);
  }

  /// Returns the seed of the `KeyPair` as a hex string.
  String seedHex() => secp256k1.Utilities.bytesToHex(_privateKey.bytes());

  @override
  Uint8List sign(Uint8List message) {
    if (_isLocked) {
      throw Exception('KeyPair is locked. Unlock it before signing.');
    }
    message = blake2bDigest(message);
    final signature = _privateKey.sign(message);
    return Uint8List.fromList(signature.toCompactRawBytes());
  }

  @override
  bool verify(Uint8List message, Uint8List signature) {
    message = blake2bDigest(message);
    final signatureObject = secp256k1.Signature.fromCompactBytes(signature);
    return _publicKey.verify(signatureObject, message);
  }

  @override
  String get address {
    Uint8List bytesValue = bytes();
    if (bytesValue.length > 32) {
      bytesValue = blake2bDigest(bytesValue);
    }
    return Address(prefix: ss58Format, pubkey: bytesValue).encode();
  }

  secp256k1.PrivateKey _privateKeyFromSeed(Uint8List seed) {
    return secp256k1.PrivateKey.fromBytes(seed);
  }

  @override
  Future<void> unlockFromMnemonic(String mnemonic, [String? password]) async {
    final seed =
        await SubstrateBip39.ecdsa.seedFromUri(mnemonic, password: password);
    _unlock(_privateKeyFromSeed(Uint8List.fromList(seed)));
  }

  @override
  Future<void> unlockFromUri(String uri, [String? password]) async {
    await unlockFromMnemonic(uri, password);
  }

  @override
  void unlockFromSeed(Uint8List seed) {
    _unlock(_privateKeyFromSeed(seed));
  }

  void _unlock(secp256k1.PrivateKey privateKey) {
    if (privateKey.getPublicKey().toBytes().toString() != bytes.toString()) {
      throw Exception('Public_Key_Mismatch: Invalid seed for given KeyPair.');
    }
    privateKey = privateKey;
    _isLocked = false;
  }

  @override
  PublicKey get publicKey => PublicKey(_publicKey.toBytes());

  /// Returns the public key of the `KeyPair` as a hex string.
  String publicKeyHex([bool compressed = true]) =>
      secp256k1.Utilities.bytesToHex(_publicKey.toBytes(compressed));

  @override
  void lock() {
    _isLocked = true;
    _privateKey =
        secp256k1.PrivateKey.fromBytes(Uint8List.fromList(List.filled(32, 0)));
  }

  @override
  Uint8List bytes([bool compressed = true]) =>
      Uint8List.fromList(_publicKey.toBytes(compressed));

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
