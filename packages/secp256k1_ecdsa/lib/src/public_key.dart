part of secp256k1;

class PublicKey {
  final Uint8List bytes;
  final Point _point;

  /// Create PublicKey from bytes
  PublicKey(this.bytes) : _point = Point.fromBytes(bytes);

  /// Create PublicKey from hex
  PublicKey.fromHex(String hex) : this(Utilities.hexToBytes(hex));

  /// Create PublicKey from Point
  PublicKey.fromPoint(this._point) : bytes = _point.toRawBytes(false);

  /// compressed bytes
  Uint8List toBytes([bool compressed = true]) => _point.toRawBytes(compressed);

  /// Compressed Hex
  String toHex([bool compressed = true]) => _point.toHex(compressed);

  bool verify(Signature sig, Uint8List message, {bool? lowS}) {
    // Default lowS=true
    lowS ??= true;

    late BigInt h;
    // secg.org/sec1-v2.pdf 4.1.4
    late Point P;

    try {
      sig = sig.assertValidity();
      // Truncate hash
      h = Utilities.bits2int_modN(Utilities.matchLength(message, fLen));
      // Validate public key
      P = Point.fromBytes(bytes);
    } catch (e) {
      // Check sig for validity in both cases
      return false;
    }
    // lowS bans sig.s >= CURVE.n/2
    if (lowS && Utilities.moreThanHalfN(sig.s)) {
      return false;
    }
    late Point? R;
    try {
      // s^-1
      final inverse = Utilities.inverse(sig.s, N);
      // u1 = hs^-1 mod n
      final u1 = Utilities.mod(h * inverse, N);
      // u2 = rs^-1 mod n
      final u2 = Utilities.mod(sig.r * inverse, N);
      // R = u1⋅G + u2⋅P
      R = Point.G.mulAddQUns(P, u1, u2);
    } catch (error) {
      return false;
    }
    // stop if R is identity / zero point
    // todo: check if this condition checking is necessary or not!!
    if (R.equals(Point.BASE) || R.equals(Point.ZERO)) {
      return false;
    }

    // <== The weird ECDSA part. R.x must be in N's field, not P's
    final v = Utilities.mod(R.affinePoint().x, N);
    return v == sig.r;
  }
}
