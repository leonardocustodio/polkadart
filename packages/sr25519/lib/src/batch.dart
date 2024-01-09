part of sr25519;

/// VerifyBatch batch verifies the given signatures
bool verifyBatch(List<merlin.Transcript> transcripts,
    List<Signature> signatures, List<PublicKey> pubkeys) {
  if (transcripts.length != signatures.length ||
      signatures.length != pubkeys.length ||
      pubkeys.length != transcripts.length) {
    throw ArgumentError(
        'the number of transcripts, signatures, and public keys must be equal');
  }

  if (transcripts.isEmpty) {
    return true;
  }

  //var err error
  final zero = r255.Element.newElement()..zero();
  final zs =
      List<r255.Scalar>.generate(transcripts.length, (_) => r255.Scalar());
  for (int i = 0; i < transcripts.length; i++) {
    try {
      zs[i] = newRandomScalar();
    } catch (_) {
      return false;
    }
  }

  // compute H(R_i || P_i || m_i)
  final hs =
      List<r255.Scalar>.generate(transcripts.length, (_) => r255.Scalar());
  final s =
      List<r255.Scalar>.generate(transcripts.length, (_) => r255.Scalar());
  for (int i = 0; i < transcripts.length; i++) {
    final t = transcripts[i];

    t.appendMessage(utf8.encode('proto-name'), utf8.encode('Schnorr-sig'));
    final pubc = pubkeys[i].encode();
    t.appendMessage(utf8.encode('sign:pk'), pubc);
    t.appendMessage(utf8.encode('sign:R'), signatures[i].r.encode());

    final h = t.extractBytes(utf8.encode('sign:c'), 64);
    s[i] = r255.Scalar();
    hs[i] = s[i];
    hs[i].fromUniformBytes(h);
  }

  // compute ∑ z_i P_i H(R_i || P_i || m_i)
  final ps = List<r255.Element>.generate(
      pubkeys.length, (_) => r255.Element.newElement());
  for (int i = 0; i < pubkeys.length; i++) {
    final p = pubkeys[i];

    ps[i] = r255.Element.newElement()..scalarMult(zs[i], p.key);
  }
  final phs = r255.Element.newElement()..varTimeMultiScalarMult(hs, ps);

  // compute ∑ z_i s_i and ∑ z_i R_i
  final ss = r255.Scalar();
  final rs = r255.Element.newElement();
  for (int i = 0; i < signatures.length; i++) {
    final s = signatures[i];

    final zsi = r255.Scalar()..multiply(s.s, zs[i]);
    ss.add(ss, zsi);
    final zri = r255.Element.newElement()..scalarMult(zs[i], s.r);
    rs.add(rs, zri);
  }

  // ∑ z_i P_i H(R_i || P_i || m_i) + ∑ R_i
  final z = r255.Element.newElement()..add(phs, rs);

  // B ∑ z_i  s_i
  final sb = r255.Element.newElement()..scalarBaseMult(ss);

  // check  -B ∑ z_i s_i + ∑ z_i P_i H(R_i || P_i || m_i) + ∑ z_i R_i = 0
  final sbNeg = r255.Element.newElement()..negate(sb);
  final res = r255.Element.newElement()..add(sbNeg, z);

  return res.equal(zero) == 1;
}

class BatchVerifier {
  /// Transcript scalar
  final List<r255.Scalar> hs = <r255.Scalar>[];

  /// Sum of signature.S: ∑ z_i s_i
  final r255.Scalar ss = r255.Scalar();

  /// Sum of signature.R: ∑ z_i R_i
  final r255.Element rs = r255.Element.newElement();

  /// z_i P_i
  final List<r255.Element> pubkeys = <r255.Element>[];

  void add(merlin.Transcript t, Signature sig, PublicKey pubkey) {
    final z = newRandomScalar();

    t.appendMessage(utf8.encode('proto-name'), utf8.encode('Schnorr-sig'));
    final pubc = pubkey.encode();
    t.appendMessage(utf8.encode('sign:pk'), pubc);
    t.appendMessage(utf8.encode('sign:R'), sig.r.encode());

    final h = t.extractBytes(utf8.encode('sign:c'), 64);
    final s = r255.Scalar();
    s.fromUniformBytes(h);
    hs.add(s);

    final zs = r255.Scalar()..multiply(z, sig.s);
    ss.add(ss, zs);
    final zr = r255.Element.newElement()..scalarMult(z, sig.r);
    rs.add(rs, zr);

    final p = r255.Element.newElement()..scalarMult(z, pubkey.key);
    pubkeys.add(p);
  }

  bool verify() {
    final zero = r255.Element.newElement()..zero();

    // compute ∑ z_i P_i H(R_i || P_i || m_i)
    final phs = r255.Element.newElement()..varTimeMultiScalarMult(hs, pubkeys);

    // ∑ z_i P_i H(R_i || P_i || m_i) + ∑ z_i R_i
    final z = r255.Element.newElement()..add(phs, rs);

    // B ∑ z_i s_i
    final sb = r255.Element.newElement()..scalarBaseMult(ss);

    // check  -B ∑ z_i s_i + ∑ z_i P_i H(R_i || P_i || m_i) + ∑ z_i R_i = 0
    final sbNeg = r255.Element.newElement()..negate(sb);
    final res = r255.Element.newElement()..add(sbNeg, z);

    return res.equal(zero) == 1;
  }
}
