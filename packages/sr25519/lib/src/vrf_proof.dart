part of sr25519;

class VrfProof {
  r255.Scalar c;
  r255.Scalar s;

  VrfProof(this.c, this.s);

  /// Encode returns a 64-byte encoded VrfProof
  Uint8List encode() {
    final Uint8List enc = Uint8List(64);
    enc
      ..setAll(0, c.encode())
      ..setAll(32, s.encode());
    return enc;
  }

  /// Decode sets the VrfProof to the decoded input
  void decode(Uint8List list) {
    final r255.Scalar newC = r255.Scalar();
    newC.decode(list.sublist(0, 32));
    c = newC;

    final r255.Scalar newS = r255.Scalar();
    newS.decode(list.sublist(32));
    s = newS;
  }
}
