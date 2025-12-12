part of secp256k1;

class Signature {
  // ECDSA Signature class
  BigInt r;
  BigInt s;
  int? recovery;

  Signature({required this.r, required this.s, this.recovery}) {
    // recovery bit is optional when
    assertValidity();
  }
  // create signature from 64b compact repr
  static Signature fromCompactBytes(Uint8List bytes) {
    int? recovery;
    if (bytes.length == 65) {
      recovery = bytes[64];
      bytes = bytes.sublist(0, 64);
    }
    bytes = Utilities.matchLength(bytes, 64); // compact repr is (32b r)||(32b s)
    return Signature(
      recovery: recovery,
      r: Utilities.sliceBytes(bytes, 0, fLen),
      s: Utilities.sliceBytes(bytes, fLen, 2 * fLen),
    );
  }

  static Signature fromCompactHex(String hex) {
    return fromCompactBytes(Utilities.hexToBytes(hex));
  }

  Signature assertValidity() {
    if (Utilities.ge(r) && Utilities.ge(s)) {
      return this;
    }
    throw Exception('0 < r or s < CURVE.n');
  }

  Signature addRecoveryBit(int rec) {
    return Signature(r: r, s: s, recovery: rec);
  }

  bool hasHighS() => Utilities.moreThanHalfN(s);

  // ECDSA public key recovery
  PublicKey recoverPublicKey(Uint8List message) {
    if (![0, 1, 2, 3].contains(recovery)) {
      // check recovery id
      throw Exception('recovery id invalid');
    }
    // Truncate hash
    final BigInt h = Utilities.bits2int_modN(Utilities.matchLength(message, 32));
    final BigInt radj = recovery == 2 || recovery == 3 ? r + N : r;
    // If rec was 2 or 3, q.x is bigger than n
    if (radj >= P) {
      // ensure q.x is still a field element
      throw Exception('q.x invalid');
    }
    // head is 0x02 or 0x03
    final String head = (recovery! & 1) == 0 ? '02' : '03';
    // concat head + hex repr of r
    final Point R = Point.fromHex(head + Utilities.bigIntToHex(radj));
    // r^-1
    final ir = Utilities.inverse(radj, N);
    // -hr^-1
    final u1 = Utilities.mod(-h * ir, N);
    // sr^-1
    final u2 = Utilities.mod(s * ir, N);
    // (sr^-1)R-(hr^-1)G = -(hr^-1)G + (sr^-1)
    return PublicKey.fromPoint(Point.G.mulAddQUns(R, u1, u2));
  }

  /// Uint8Array 64b compact repr
  Uint8List toCompactRawBytes() => Utilities.hexToBytes(toCompactHex());

  /// hex 64b compact repr
  String toCompactHex() => Utilities.bigIntToHex(r) + Utilities.bigIntToHex(s);

  @override
  String toString() {
    return 'Signature{r: $r, s: $s, recovery: $recovery}';
  }
}
