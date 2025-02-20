part of sr25519;

class MiniSecretKey implements DerivableKey {
  final List<int> key = List<int>.filled(32, 0, growable: false);

  MiniSecretKey();

  MiniSecretKey.fromRawKey(List<int> key) {
    this.key.setRange(0, 32, key);
  }

  /// newMiniSecretKey derives a mini secret key from a seed
  factory MiniSecretKey.fromSeed(List<int> seed) {
    final s = r255.Scalar()..fromUniformBytes(seed);
    return MiniSecretKey.fromRawKey(s.encode());
  }

  /// MiniSecretKey.fromHex returns a new MiniSecretKey from the given hex-encoded string
  factory MiniSecretKey.fromHex(String s) {
    final bytes = hex.decode(s);
    if (bytes.length < 32) {
      throw ArgumentError('invalid length');
    }
    final key = bytes.sublist(0, 32).toList();

    return MiniSecretKey.fromRawKey(key);
  }

  /// GenerateMiniSecretKey generates a mini secret key from random
  factory MiniSecretKey.generateMiniSecretKey([Random? random]) {
    final s =
        List<int>.generate(32, (i) => (random ?? Random.secure()).nextInt(256));

    return MiniSecretKey.fromRawKey(s);
  }

  /// decodes and creates a MiniSecretKey from the given input
  @override
  void decode(List<int> b) {
    final msc = MiniSecretKey.fromRawKey(b);

    key.setAll(0, msc.key);
  }

  /// Encode returns the MiniSecretKey's underlying bytes
  @override
  List<int> encode() {
    return List<int>.from(key);
  }

  /// ExpandUniform expands a MiniSecretKey into a SecretKey
  SecretKey expandUniform() {
    final t = merlin.Transcript('ExpandSecretKeys');
    t.appendMessage(utf8.encode('mini'), key);
    final scalarBytes = t.extractBytes(utf8.encode('sk'), 64);
    final scalar = r255.Scalar();
    scalar.fromUniformBytes(scalarBytes);
    final nonce = t.extractBytes(utf8.encode('no'), 32);

    final List<int> key32 = List<int>.filled(32, 0, growable: false);
    key32.setAll(0, scalar.encode());
    final List<int> nonce32 = List<int>.filled(32, 0, growable: false);
    nonce32.setAll(0, nonce);

    return SecretKey.from(key32, nonce32);
  }

  /// expandEd25519 expands a MiniSecretKey into a SecretKey using ed25519-style bit clamping
  /// https://github.com/w3f/schnorrkel/blob/43f7fc00724edd1ef53d5ae13d82d240ed6202d5/src/keys.rs#L196
  SecretKey expandEd25519() {
    final h = const DartSha512().hashSync(key).bytes;
    final sk = SecretKey();

    sk.key.setAll(0, h.sublist(0, 32));

    sk.key[0] &= 248;
    sk.key[31] &= 63;
    sk.key[31] |= 64;

    final t = divideScalarByCofactor(sk.key);

    sk.key.setAll(0, t);
    sk.nonce.setAll(0, h.sublist(32, 64));
    return sk;
  }

  /// Public returns the PublicKey expanded from this MiniSecretKey using ExpandEd25519
  PublicKey public() {
    final e = r255.Element.newElement();
    final sk = expandEd25519();
    final skey = scalarFromBytes(sk.key);
    return PublicKey()..key.set(e..scalarBaseMult(skey));
  }

  /// HardDeriveMiniSecretKey implements BIP-32 like 'hard' derivation of a mini
  /// secret from a mini secret key
  (MiniSecretKey, List<int>) hardDeriveMiniSecretKey(
      List<int> i, List<int> cc) {
    return expandEd25519().hardDeriveMiniSecretKey(i, cc);
  }

  /// DeriveKey derives an Extended Key from the Mini Secret Key
  @override
  ExtendedKey deriveKey(merlin.Transcript t, List<int> cc) {
    return expandEd25519().deriveKey(t, cc);
  }
}
