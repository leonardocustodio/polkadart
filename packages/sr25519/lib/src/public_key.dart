part of sr25519;

class PublicKey implements DerivableKey {
  final r255.Element key = r255.Element.newElement();
  final List<int> compressedKey = List<int>.filled(32, 0);

  PublicKey();

  factory PublicKey.from(PublicKey pk) {
    final result = PublicKey();
    result
      ..key.set(pk.key)
      ..compressedKey.setAll(0, pk.compressedKey);
    return result;
  }

  /// PublicKey.newPublicKey creates a new public key from input bytes
  factory PublicKey.newPublicKey(List<int> b) {
    final e = r255.Element.newElement();
    e.decode(Uint8List.fromList(b));
    return PublicKey()..key.set(e);
  }

  /// returns a PublicKey from a hex-encoded string
  factory PublicKey.fromHex(String s) {
    final b = hex.decode(s);

    if (b.length < 32) {
      throw ArgumentError('invalid length');
    }

    final bytes = b.sublist(0, 32).toList();

    final pub = PublicKey();
    pub.decode(bytes);

    return pub;
  }

  /// decode creates a PublicKey from the given input
  @override
  void decode(List<int> bytes) {
    key
      ..set(r255.Element.newElement())
      ..decode(Uint8List.fromList(bytes));
  }

  /// encode returns the encoded point underlying the public key
  @override
  List<int> encode() {
    if (const ListEquality().equals(compressedKey, zeroList) == false) {
      return List<int>.from(compressedKey);
    }
    final b = key.encode();
    final enc = List<int>.filled(32, 0);
    enc.setAll(0, b);
    compressedKey.setAll(0, enc);
    return enc;
  }

  @override
  ExtendedKey deriveKey(merlin.Transcript t, List<int> cc) {
    final (sc, dcc) = deriveScalarAndChaincode(t, cc);

    // derivedPk = pk + (sc * g)
    final p1 = r255.Element.newElement()..scalarBaseMult(sc);
    final p2 = r255.Element.newElement();
    p2.add(key, p1);

    final pub = PublicKey();
    pub.key.set(p2);

    return ExtendedKey(pub, dcc);
  }

  /// deriveScalarAndChaincode derives a new scalar and chain code from an existing public key and chain code
  (r255.Scalar, List<int>) deriveScalarAndChaincode(
      merlin.Transcript t, List<int> cc) {
    t.appendMessage(utf8.encode('chain-code'), cc);
    final pkenc = encode();
    t.appendMessage(utf8.encode('public-key'), pkenc);

    final scBytes = t.extractBytes(utf8.encode('HDKD-scalar'), 64);
    final sc = r255.Scalar();
    sc.fromUniformBytes(scBytes);

    final ccBytes = t.extractBytes(utf8.encode('HDKD-chaincode'), 32);
    if (ccBytes.length != 32) {
      throw Exception('derived chain code is not 32 bytes');
    }
    return (sc, List<int>.from(ccBytes));
  }

  /// Verify verifies a schnorr signature with format: (R, s) where y is the public key
  /// 1. k = scalar(transcript.extractBytes())
  /// 2. R' = -ky + gs
  /// 3. return R' == R
  (bool, Exception?) verify(Signature s, merlin.Transcript t) {
    if (key.equal(publicKeyAtInfinity) == 1) {
      return (false, Exception('public key is the point at infinity'));
    }

    t.appendMessage(utf8.encode('proto-name'), utf8.encode('Schnorr-sig'));
    final pubc = encode();
    t
      ..appendMessage(utf8.encode('sign:pk'), pubc)
      ..appendMessage(utf8.encode('sign:R'), s.r.encode());

    final List<int> kb = t.extractBytes(utf8.encode('sign:c'), 64);
    final r255.Scalar k = r255.Scalar();
    k.fromUniformBytes(kb);

    final rp = r255.Element.newElement()
      ..varTimeDoubleScalarBaseMult(
          k, r255.Element.newElement()..negate(key), s.s);

    return (rp.equal(s.r) == 1, null);
  }
}
