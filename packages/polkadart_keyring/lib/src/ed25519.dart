part of polkadart_keyring;

class Ed25519KeyPair extends KeyPair {
  late ed.PublicKey _publicKey;
  late ed.PrivateKey _privateKey;

  @override
  int ss58Format = 42;

  Ed25519KeyPair() : super(KeyPairType.ed25519);

  @override
  KeyPair fromSeed(Uint8List seed) {
    _privateKey = ed.newKeyFromSeed(seed);
    _publicKey = ed.public(_privateKey);
    return this;
  }

  @override
  Future<KeyPair> fromUri(String uri, [String? password]) async {
    final seed =
        await SubstrateBip39.ed25519.seedFromUri(uri, password: password);
    return fromSeed(Uint8List.fromList(seed));
  }

  @override
  Future<KeyPair> fromMnemonic(String uri, [String? password]) {
    return fromUri(uri, password);
  }

  @override
  Uint8List sign(Uint8List message) {
    if (_isLocked) {
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
    return Address(prefix: ss58Format, pubkey: bytes()).encode();
  }

  @override
  Future<void> unlockFromMnemonic(String mnemonic, [String? password]) async {
    final seed =
        await SubstrateBip39.ed25519.seedFromUri(mnemonic, password: password);
    _unlock(ed.newKeyFromSeed(Uint8List.fromList(seed)));
  }

  @override
  Future<void> unlockFromUri(String uri, [String? password]) async {
    await unlockFromMnemonic(uri, password);
  }

  @override
  void unlockFromSeed(Uint8List seed) {
    _unlock(ed.newKeyFromSeed(seed));
  }

  void _unlock(ed.PrivateKey privateKey) {
    if (ed.public(privateKey).bytes.toString() != bytes().toString()) {
      throw Exception('Public_Key_Mismatch: Invalid seed for given KeyPair.');
    }
    _privateKey = privateKey;
    _isLocked = false;
  }

  @override
  PublicKey get publicKey => PublicKey(_publicKey.bytes);

  @override
  void lock() {
    _isLocked = true;
    _privateKey = ed.PrivateKey(Uint8List(0));
  }

  @override
  Uint8List bytes([bool compressed = true]) =>
      Uint8List.fromList(_publicKey.bytes);

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
