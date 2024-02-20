part of polkadart_keyring;

class Sr25519KeyPair extends KeyPair {
  late sr25519.PublicKey _publicKey;
  late sr25519.SecretKey _privateKey;

  @override
  int ss58Format = 42;

  Sr25519KeyPair() : super(KeyPairType.sr25519);

  @override
  KeyPair fromSeed(Uint8List seed) {
    _privateKey = _extractSecretKeyFromSeed(seed);
    _publicKey = _privateKey.public();
    return this;
  }

  Future<List<int>> seedFromUri(String uri, [String? password]) async {
    return (await _fromUri(uri, password)).$1;
  }

  Future<(List<int>, SecretUri)> _fromUri(String uri,
      [String? password]) async {
    if (uri.startsWith('//')) {
      uri = '$DEV_PHRASE$uri';
    }

    final secretUri = SecretUri.fromStr(uri);

    late List<int> seed;

    // The phrase is hex encoded secret seed
    if (secretUri.phrase.startsWith('0x')) {
      try {
        seed = hex.decode(secretUri.phrase.substring(2));
        return (seed, secretUri);
      } catch (e) {
        throw SubstrateBip39Exception.invalidSeed();
      }
    }

    final passwordOverride = password ?? secretUri.password;

    final List<int> entropy;
    try {
      entropy =
          Mnemonic.fromSentence(secretUri.phrase, Language.english).entropy;
    } on Exception catch (e) {
      throw SubstrateBip39Exception.fromException(e);
    }

    seed =
        await CryptoScheme.seedFromEntropy(entropy, password: passwordOverride);
    return (seed, secretUri);
  }

  sr25519.SecretKey _extractSecretKeyFromSeed(List<int> seed) {
    final sr25519.MiniSecretKey miniSecretKey =
        sr25519.MiniSecretKey.fromRawKey(seed);

    return miniSecretKey.expandEd25519();
  }

  @override
  Future<KeyPair> fromUri(String uri, [String? password]) async {
    final (seed, secretUri) = await _fromUri(uri, password);

    sr25519.SecretKey secretKey = _extractSecretKeyFromSeed(seed);

    for (final junction in secretUri.junctions) {
      secretKey = deriveHardSoft(junction.isHard, secretKey, junction).secret();
    }
    _privateKey = secretKey;
    _publicKey = _privateKey.public();
    return this;
  }

  @override
  Future<KeyPair> fromMnemonic(String uri, [String? password]) {
    return fromUri(uri, password);
  }

  /// deriveCommon provides common functions for testing Soft and Hard key derivation
  sr25519.ExtendedKey deriveHardSoft(
      bool hard, sr25519.DerivableKey key, DeriveJunction junction) {
    final List<int> ccBytes =
        List.from(junction.junctionId.sublist(0, 32), growable: false);

    if (hard) {
      return sr25519.ExtendedKey.deriveKeyHard(key, [], ccBytes);
    } else {
      return sr25519.ExtendedKey.deriveKeySimple(key, [], ccBytes);
    }
  }

  @override
  PublicKey get publicKey => PublicKey(_publicKey.encode());

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
    return Address(prefix: ss58Format, pubkey: bytes()).encode();
  }

  @override
  String get rawAddress => address;

  @override
  Future<void> unlockFromMnemonic(String mnemonic, [String? password]) async {
    final seed = await SubstrateBip39.ed25519.seedFromUri(mnemonic);
    _unlock(sr25519.SecretKey.fromEd25519Bytes(seed));
  }

  @override
  Future<void> unlockFromUri(String uri, [String? password]) {
    return unlockFromMnemonic(uri, password);
  }

  @override
  void unlockFromSeed(Uint8List seed) {
    _unlock(sr25519.SecretKey.fromEd25519Bytes(seed));
  }

  void _unlock(sr25519.SecretKey privateKey) {
    if (privateKey.public().encode().toString() != bytes().toString()) {
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
  Uint8List bytes([bool compressed = true]) =>
      Uint8List.fromList(_publicKey.encode());

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
