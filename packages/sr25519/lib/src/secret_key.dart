part of sr25519;

class SecretKey implements DerivableKey {
  final List<int> key = List<int>.filled(32, 0, growable: false);
  final List<int> nonce = List<int>.filled(32, 0, growable: false);

  SecretKey();

  factory SecretKey.copy(SecretKey sk) {
    return SecretKey()
      ..key.setAll(0, sk.key)
      ..nonce.setAll(0, sk.nonce);
  }

  SecretKey.from(List<int> key, List<int> nonce) {
    this.key.setRange(0, 32, key);
    this.nonce.setRange(0, 32, nonce);
  }

  factory SecretKey.fromEd25519Bytes(List<int> bytes) {
    if (bytes.length != 64) {
      throw ArgumentError('invalid bytes length');
    }

    final sk = SecretKey();
    sk.key.setRange(0, 32, bytes.sublist(0, 32));

    divideScalarByCofactor(sk.key);

    sk.nonce.setAll(0, bytes.sublist(32, 64));

    return sk;
  }

  /// decode creates a SecretKey from the given input
  @override
  void decode(List<int> bytes) {
    key.setAll(0, bytes.sublist(0, 32));
  }

  /// encode returns the SecretKey's underlying bytes
  @override
  List<int> encode() {
    return List<int>.from(key);
  }

  /// public gets the public key corresponding to this SecretKey
  PublicKey public() {
    final e = r255.Element.newElement();
    final sc = scalarFromBytes(key);
    return PublicKey()..key.set(e..scalarBaseMult(sc));
  }

  /// keypair returns the keypair corresponding to this SecretKey
  KeyPair keypair() {
    final pub = public();
    return KeyPair._(pub, this);
  }

  /// deriveKey derives a new secret key and chain code from an existing secret key and chain code
  @override
  ExtendedKey deriveKey(merlin.Transcript t, List<int> cc) {
    final pub = public();

    final (sc, dcc) = pub.deriveScalarAndChaincode(t, cc);

    // todo: need transcript RNG to match rust-schnorrkel
    // see: https://github.com/w3f/schnorrkel/blob/798ab3e0813aa478b520c5cf6dc6e02fd4e07f0a/src/derive.rs#L186
    final List<int> nonce =
        List<int>.generate(32, (_) => Random.secure().nextInt(256));

    final dsk = scalarFromBytes(key);

    dsk.add(dsk, sc);

    final List<int> dskBytes = List<int>.from(dsk.encode());
    if (dskBytes.length != 32) {
      throw Exception('invalid dskBytes length, expected 32');
    }

    return ExtendedKey(
      SecretKey.from(
        dskBytes,
        nonce,
      ),
      dcc,
    );
  }

  /// hardDeriveMiniSecretKey implements BIP-32 like 'hard' derivation of a mini secret from a secret key
  (MiniSecretKey, List<int>) hardDeriveMiniSecretKey(
      List<int> i, List<int> cc) {
    final t = merlin.Transcript('SchnorrRistrettoHDKD');
    t
      ..appendMessage(utf8.encode('sign-bytes'), i)
      ..appendMessage(utf8.encode('chain-code'), cc);
    final skenc = encode();
    t.appendMessage(utf8.encode('secret-key'), skenc);

    final mskBytes = t.extractBytes(utf8.encode('HDKD-hard'), 32);
    if (mskBytes.length != 32) {
      throw Exception('invalid mskBytes length, expected 32');
    }

    final ccBytes = t.extractBytes(utf8.encode('HDKD-chaincode'), 32);
    if (ccBytes.length != 32) {
      throw Exception('invalid ccBytes length, expected 32');
    }

    final miniSec = MiniSecretKey.fromRawKey(mskBytes);

    return (miniSec, List<int>.from(ccBytes));
  }

  /// sign uses the schnorr signature algorithm to sign a message
  /// See the following for the transcript message
  /// https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/sign.rs#L158
  /// Schnorr w/ transcript, secret key x:
  /// 1. choose random r from group
  /// 2. R = gr
  /// 3. k = scalar(transcript.extract_bytes())
  /// 4. s = kx + r
  /// signature: (R, s)
  /// public key used for verification: y = g^x
  Signature sign(merlin.Transcript t) {
    t.appendMessage(utf8.encode('proto-name'), utf8.encode('Schnorr-sig'));

    final PublicKey pub = public();

    final List<int> pubc = pub.encode();

    t.appendMessage(utf8.encode('sign:pk'), pubc);

    // note: todo: merlin library doesn't have build_rng yet.
    // see https://github.com/w3f/schnorrkel/blob/798ab3e0813aa478b520c5cf6dc6e02fd4e07f0a/src/context.rs#L153
    // r = t.extract_bytes('signing', 32);

    // choose random r (nonce)
    final r = newRandomScalar();

    final R = r255.Element.newElement()..scalarBaseMult(r);
    t.appendMessage(utf8.encode('sign:R'), R.encode());

    // form k
    final List<int> kb = t.extractBytes(utf8.encode('sign:c'), 64);
    final k = r255.Scalar();
    k.fromUniformBytes(kb);

    // form scalar from secret key x
    final x = scalarFromBytes(key);

    // s = kx + r
    final s = x
      ..multiply(x, k)
      ..add(x, r);

    return Signature.from(R, s);
  }
}
