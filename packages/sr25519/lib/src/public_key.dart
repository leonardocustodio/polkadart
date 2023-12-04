part of sr25519;

class PublicKey implements DerivableKey {
  final r255.Element key = r255.Element.newElement();
  final List<int> compressedKey = List<int>.filled(32, 0, growable: false);

  PublicKey();

  bool kusamaVRF = true;

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
    final enc = List<int>.filled(32, 0, growable: false);
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

  bool verifySimplePreAuditDeprecated(
      String context, List<int> msg, Uint8List sigature) {
    merlin.Transcript t = Sr25519.newSigningContext(utf8.encode(context), msg);

    late final Signature signature;

    try {
      signature = Signature.fromBytes(sigature);
      return verify(signature, t).$1;
    } catch (_) {
      signature = Signature.decodeNotDistinguishedFromEd25519(sigature);
    }

    t = merlin.Transcript(context);
    t.appendMessage(utf8.encode('sign-bytes'), msg);
    t.appendMessage(utf8.encode('proto-name'), utf8.encode('Schnorr-sig'));
    final pubc = encode();
    t
      ..appendMessage(utf8.encode('pk'), pubc)
      ..appendMessage(utf8.encode('no'), signature.r.encode());

    final List<int> kb = t.extractBytes(utf8.encode(''), 64);
    final r255.Scalar k = r255.Scalar();
    k.fromUniformBytes(kb);

    final rp = r255.Element.newElement()
      ..varTimeDoubleScalarBaseMult(
          k, r255.Element.newElement()..negate(key), signature.s);

    return (rp.equal(signature.r) == 1);
  }

  /// VrfVerify verifies that the proof and output created are valid given the public key and transcript.
  bool vrfVerify(merlin.Transcript t, VrfOutput out, VrfProof proof) {
    if (key.equal(publicKeyAtInfinity) == 1) {
      return false;
    }

    final VrfInOut inout = out.attachInput(this, t);

    final merlin.Transcript t0 = merlin.Transcript(VRFLabel);
    return dleqVerify(t0, inout, proof);
  }

  /// dleqVerify verifies the corresponding dleq proof.
  bool dleqVerify(merlin.Transcript t, VrfInOut p, VrfProof proof) {
    t
      ..appendMessage(utf8.encode('proto-name'), utf8.encode('DLEQProof'))
      ..appendMessage(utf8.encode('vrf:h'), p.input.encode());
    if (kusamaVRF == false) {
      t.appendMessage(utf8.encode('vrf:pk'), key.encode());
    }

    // R = proof.c*pk + proof.s*g
    final r255.Element R = r255.Element.newElement();
    R.varTimeDoubleScalarBaseMult(proof.c, key, proof.s);
    t.appendMessage(utf8.encode('vrf:R=g^r'), R.encode());

    // hr = proof.c * p.output + proof.s * p.input
    final hr = r255.Element.newElement()
      ..varTimeMultiScalarMult(
          <r255.Scalar>[proof.c, proof.s], <r255.Element>[p.output, p.input]);
    t.appendMessage(utf8.encode('vrf:h^r'), hr.encode());
    if (kusamaVRF) {
      t.appendMessage(utf8.encode('vrf:pk'), key.encode());
    }
    t.appendMessage(utf8.encode('vrf:h^sk'), p.output.encode());

    final r255.Scalar cexpected = challengeScalar(t, utf8.encode('prove'));
    if (cexpected.equal(proof.c) == 1) {
      return true;
    }

    return false;
  }

  /// vrfHash hashes the transcript to a point.
  r255.Element vrfHash(merlin.Transcript t) {
    final merlin.Transcript mt = transcriptWithMalleabilityAddressed(t, this);
    final Uint8List hash = mt.extractBytes(utf8.encode('VRFHash'), 64);
    final r255.Element point = r255.Element.newElement();
    point.fromUniformBytes(hash);
    return point;
  }
}
