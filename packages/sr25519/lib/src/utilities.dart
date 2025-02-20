part of sr25519;

final List<int> zeroList = List<int>.filled(32, 0, growable: false);

final publicKeyAtInfinity = r255.Element.newElement()
  ..scalarBaseMult(r255.Scalar());

/// NewRandomScalar returns a random ristretto scalar
r255.Scalar newRandomScalar([Random? random]) {
  final List<int> s = List<int>.generate(
      64, (_) => (random ?? Random.secure()).nextInt(256),
      growable: false);

  final ss = r255.Scalar();
  ss.fromUniformBytes(s);
  if (ss.equal(r255.Scalar()) == 1) {
    throw ArgumentError('scalar generated was zero');
  }

  return ss;
}

r255.Scalar challengeScalar(merlin.Transcript t, List<int> msg) {
  final sc = r255.Scalar()..fromUniformBytes(t.extractBytes(msg, 64));
  return sc;
}

/// https://github.com/w3f/schnorrkel/blob/718678e51006d84c7d8e4b6cde758906172e74f8/src/scalars.rs#L18
List<int> divideScalarByCofactor(List<int> scalar) {
  int low = 0;
  for (int i = scalar.length - 1; i >= 0; i--) {
    int r = scalar[i] & 0x07; // save remainder
    scalar[i] >>= 3; // divide by 8
    scalar[i] += low;
    low = r << 5;
  }

  return scalar;
}

List<int> multiplyScalarBytesByCofactor(List<int> scalar) {
  int high = 0;
  for (int i = 0; i < scalar.length; i++) {
    int r = scalar[i] & 224; // carry bits
    scalar[i] <<= 3; // multiply by 8
    scalar[i] += high;
    high = r >> 5;
  }
  return scalar;
}

/// NewRandomElement returns a random ristretto element
r255.Element newRandomElement([Random? random]) {
  final s = List.generate(64, (_) => (random ?? Random.secure()).nextInt(256),
      growable: false);
  final e = r255.Element.newElement()..fromUniformBytes(Uint8List.fromList(s));
  return e;
}

/// ScalarFromBytes returns a ristretto scalar from the input bytes
/// performs input mod l where l is the group order
r255.Scalar scalarFromBytes(List<int> b) {
  assert(b.length == 32, 'Assertion failed: b.length == 32');
  final s = r255.Scalar();
  s.decode(b);
  return s;
}

/// TranscriptWithMalleabilityAddressed returns the input transcript with the public key commited to it,
/// addressing VRF output malleability.
merlin.Transcript transcriptWithMalleabilityAddressed(
    merlin.Transcript t, PublicKey pk) {
  final List<int> enc = pk.encode();
  t.appendMessage(utf8.encode('vrf-nm-pk'), enc);
  return t;
}
