part of sr25519;

final List<int> zeroList = List<int>.filled(32, 0);

final publicKeyAtInfinity = r255.Element.newElement()
  ..scalarBaseMult(r255.Scalar());

/// NewRandomScalar returns a random ristretto scalar
r255.Scalar newRandomScalar() {
  final List<int> s =
      List<int>.generate(64, (_) => Random.secure().nextInt(256));

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

// https://github.com/w3f/schnorrkel/blob/718678e51006d84c7d8e4b6cde758906172e74f8/src/scalars.rs#L18
List<int> divideScalarByCofactor(List<int> s) {
  final l = s.length - 1;
  int low = 0;
  for (int i = 0; i < s.length; i++) {
    final r = s[l - i] & 0x07; // remainder
    s[l - i] >>= 3;
    s[l - i] += low;
    low = r << 5;
  }

  return s;
}

// NewRandomElement returns a random ristretto element
r255.Element newRandomElement() {
  //s := [64]byte{}
  final s = List.generate(64, (_) => Random.secure().nextInt(256));
  final e = r255.Element.newElement()..fromUniformBytes(Uint8List.fromList(s));
  return e;
}

// ScalarFromBytes returns a ristretto scalar from the input bytes
// performs input mod l where l is the group order
r255.Scalar scalarFromBytes(List<int> b) {
  assert(b.length == 32, 'Assertion failed: b.length == 32');
  final s = r255.Scalar();
  s.decode(b);
  return s;
}
