part of secp256k1;

// secp256k1 is short weierstrass curve
final B256 = BigInt.from(2).pow(256);

/// curve's field prime
final P = B256 - BigInt.from(0x1000003d1);

/// curve (group) order
final N = B256 - BigInt.parse('14551231950b75fc4402da1732fc9bebf', radix: 16);

/// base point x
final Gx =
    BigInt.parse('79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798', radix: 16);

/// base point y
final Gy =
    BigInt.parse('483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8', radix: 16);

/// field / group byte length
final fLen = 32;

/// precomputes for base point G
final List<Point> Gpows = <Point>[];

/// Precomputes-related code. W = window size
const W = 8;
