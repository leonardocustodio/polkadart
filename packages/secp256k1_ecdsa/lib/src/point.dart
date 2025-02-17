part of secp256k1;

// Point in 3d xyz projective coordinates
class Point {
  // x = px / pz², y = py / pz³
  final BigInt px;
  final BigInt py;
  final BigInt pz;

  /// 3d=less inversions
  const Point(this.px, this.py, this.pz);

  /// Make a copy of the point
  Point copy() => Point(px, py, pz);

  /// Generator / base point
  static final Point BASE = Point(Gx, Gy, BigInt.one);

  /// Identity / zero point
  static final Point ZERO = Point(BigInt.zero, BigInt.one, BigInt.zero);

  /// Alias for base point
  static final Point G = BASE;

  /// Alias for identity point
  static final Point I = ZERO;

  /// Create a point from a AffinePoint
  static Point fromAffine(AffinePoint p) => Point(p.x, p.y, BigInt.one);

  /// Create a point from Hex
  static Point fromHex(String hex) {
    return fromBytes(Utilities.hexToBytes(hex));
  }

  static Point fromBytes(Uint8List bytes) {
    // first byte is prefix, rest is data
    final int head = bytes[0];
    final Uint8List tail = bytes.sublist(1);

    final BigInt x = Utilities.sliceBytes(tail, 0, fLen);
    final int len = bytes.length;

    Point? p;
    // next 32 bytes are x coordinate
    if (len == 33 && [0x02, 0x03].contains(head)) {
      // compressed points: 33b, start
      if (!Utilities.fe(x)) {
        // with byte 0x02 or 0x03. Check if 0<x<P
        throw Exception('Point hex invalid: x not FE');
      }
      // x³ + ax + b is right side of equation

      BigInt y = Utilities.sqrt(Utilities.crv(x));
      // y² is equivalent left-side. Calculate y²:
      final bool isYOdd = (y & BigInt.one) == BigInt.one;
      // y = √y²; there are two solutions: y, -y
      final bool headOdd = (head & 1) == 1;

      // determine proper solution
      if (headOdd != isYOdd) {
        y = Utilities.mod(-y);
      }
      // create point
      p = Point(x, y, BigInt.one);
    }

    // Uncompressed points: 65b, start with 0x04
    if (len == 65 && head == 0x04) {
      p = Point(x, Utilities.sliceBytes(tail, fLen, 2 * fLen), BigInt.one);
    }

    if (p != null) {
      // Verify the result
      return p.ok();
    }
    throw Exception('Point is not on curve');
  }

  /// Create point from a private key
  static Point fromPrivateKey(BigInt k) {
    if (Utilities.ge(k)) {
      return G.mul(k);
    }
    // must be 0 < k < CURVE.n
    throw Exception('private key out of range');
  }

  /// Equality check: compare points
  bool equals(Point other) {
    final (BigInt X1, BigInt Y1, BigInt Z1) = (px, py, pz);

    final (BigInt X2, BigInt Y2, BigInt Z2) = (other.px, other.py, other.pz);

    final BigInt X1Z2 = Utilities.mod(X1 * Z2);
    final BigInt X2Z1 = Utilities.mod(X2 * Z1);

    final BigInt Y1Z2 = Utilities.mod(Y1 * Z2);
    final BigInt Y2Z1 = Utilities.mod(Y2 * Z1);
    return X1Z2 == X2Z1 && Y1Z2 == Y2Z1;
  }

  /// Flip point over y coord
  Point negate() => Point(px, Utilities.mod(-py), pz);

  /// Point doubling: P+P, complete formula.
  Point double() => add(this);

  /// Point addition: P+Q, complete, exception
  Point add(Point other) {
    final (BigInt X1, BigInt Y1, BigInt Z1) = (px, py, pz);

    final (BigInt X2, BigInt Y2, BigInt Z2) = (other.px, other.py, other.pz);

    final a = Curve.secp256k1.a;
    final b = Curve.secp256k1.b;
    var X3 = BigInt.zero, Y3 = BigInt.zero, Z3 = BigInt.zero;
    final b3 = Utilities.mod(b * BigInt.from(3));
    // step 1
    var t0 = Utilities.mod(X1 * X2),
        t1 = Utilities.mod(Y1 * Y2),
        t2 = Utilities.mod(Z1 * Z2),
        t3 = Utilities.mod(X1 + Y1),
        t4 = Utilities.mod(X2 + Y2); // step 5

    t3 = Utilities.mod(t3 * t4);
    t4 = Utilities.mod(t0 + t1);
    t3 = Utilities.mod(t3 - t4);
    t4 = Utilities.mod(X1 + Z1);
    // step 10
    var t5 = Utilities.mod(X2 + Z2);
    t4 = Utilities.mod(t4 * t5);
    t5 = Utilities.mod(t0 + t2);
    t4 = Utilities.mod(t4 - t5);
    t5 = Utilities.mod(Y1 + Z1);
    // step 15
    X3 = Utilities.mod(Y2 + Z2);
    t5 = Utilities.mod(t5 * X3);
    X3 = Utilities.mod(t1 + t2);
    t5 = Utilities.mod(t5 - X3);
    Z3 = Utilities.mod(a * t4);
    // step 20
    X3 = Utilities.mod(b3 * t2);
    Z3 = Utilities.mod(X3 + Z3);
    X3 = Utilities.mod(t1 - Z3);
    Z3 = Utilities.mod(t1 + Z3);
    Y3 = Utilities.mod(X3 * Z3);
    // step 25
    t1 = Utilities.mod(t0 + t0);
    t1 = Utilities.mod(t1 + t0);
    t2 = Utilities.mod(a * t2);
    t4 = Utilities.mod(b3 * t4);
    t1 = Utilities.mod(t1 + t2);
    // step 30
    t2 = Utilities.mod(t0 - t2);
    t2 = Utilities.mod(a * t2);
    t4 = Utilities.mod(t4 + t2);
    t0 = Utilities.mod(t1 * t4);
    Y3 = Utilities.mod(Y3 + t0);
    // step 35
    t0 = Utilities.mod(t5 * t4);
    X3 = Utilities.mod(t3 * X3);
    X3 = Utilities.mod(X3 - t0);
    t0 = Utilities.mod(t3 * t1);
    Z3 = Utilities.mod(t5 * Z3);
    // step 40
    Z3 = Utilities.mod(Z3 + t0);
    return Point(X3, Y3, Z3);
  }

  /// Point scalar multiplication.
  Point mul(BigInt n, [bool safe = true]) {
    if (!safe && n == BigInt.zero) {
      // in unsafe mode, allow zero
      return I;
    }
    if (!Utilities.ge(n)) {
      // must be 0 < n < CURVE.n
      throw Exception('invalid scalar');
    }
    if (equals(G)) {
      // use precomputes for base point
      return WNAF.wNAF(n).p;
    }
    // init result point & fake point
    var p = I, f = G;
    for (var d = this; n > BigInt.zero; d = d.double(), n >>= 1) {
      // double-and-add ladder
      if ((n & BigInt.one) == BigInt.one) {
        // if bit is present, add to point
        p = p.add(d);
      } else if (safe) {
        // if not, add to fake for timing safety
        f = f.add(d);
      }
    }
    return p;
  }

  /// to private keys. Doesn't use Shamir trick
  /// Unsafe: do NOT use for stuff related
  Point mulAddQUns(Point R, BigInt u1, BigInt u2) {
    // Double scalar mult. Q = u1⋅G + u2⋅R.
    return mul(u1, false).add(R.mul(u2, false)).ok();
  }

  /// Convert point to 2d xy affine point.
  AffinePoint affinePoint() {
    final (BigInt x, BigInt y, BigInt z) = (px, py, pz);
    if (equals(I)) {
      return AffinePoint(BigInt.zero, BigInt.zero);
    }
    if (z == BigInt.one) {
      return AffinePoint(x, y);
    }
    // z^-1: invert z
    final iz = Utilities.inverse(z);
    if (Utilities.mod(z * iz) != BigInt.one) {
      // (z * z^-1) must be 1, otherwise bad math
      throw Exception('invalid inverse');
    }
    return AffinePoint(Utilities.mod(x * iz), Utilities.mod(y * iz)); // x = x*z^-1; y = y*z^-1
  }

  /// Checks if the point is valid and on-curve
  Point assertValidity() {
    // convert to 2d xy affine point.
    final affinePointValue = affinePoint();
    // convert to 2d xy affine point.
    final (BigInt x, BigInt y) = (affinePointValue.x, affinePointValue.y);
    if (!Utilities.fe(x) || !Utilities.fe(y)) {
      // x and y must be in range 0 < n < P
      throw Exception('Point invalid: x or y');
    }
    // y² = x³ + ax + b, must be equal
    if (Utilities.mod(y * y) == Utilities.crv(x)) {
      return this;
    }
    throw Exception('Point invalid: not on curve');
  }

  /// Aliases to compress code
  Point multiply(BigInt n) => mul(n);

  Point ok() => assertValidity();

  /// Encode point to hex string.
  String toHex([bool isCompressed = true]) {
    // convert to 2d xy affine point
    final affinePointValue = affinePoint();
    final (BigInt x, BigInt y) = (affinePointValue.x, affinePointValue.y);
    // 0x02, 0x03, 0x04 prefix
    final head = isCompressed ? ((y & BigInt.one) == BigInt.zero ? '02' : '03') : '04';
    // prefix||x and ||y
    return head + Utilities.bigIntToHex(x) + (isCompressed ? '' : Utilities.bigIntToHex(y));
  }

  /// Encode point to Uint8Array.
  Uint8List toRawBytes([bool isCompressed = true]) {
    // re-use toHex(), convert hex to bytes
    return Utilities.hexToBytes(toHex(isCompressed));
  }
}
