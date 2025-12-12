part of secp256k1;

class Utilities {
  /// x³ + ax + b weierstrass formula; a=0
  static BigInt crv(BigInt x) => mod(mod(x * x) * x + Curve.secp256k1.b);

  /// is field element (invertible)
  static bool fe(BigInt n) => (BigInt.zero < n) && n < P;

  /// is group element
  static bool ge(BigInt n) => (BigInt.zero < n) && n < N;

  static Uint8List matchLength(Uint8List a, [int? number]) {
    if (number != null && number > 0 && a.length != number) {
      throw Exception('Uint8List not of specific length: $number');
    }
    return a;
  }

  static BigInt generateRandomBigInt(BigInt min, BigInt max, [Random? random]) {
    random ??= Random.secure();
    final maxBytes = (max.bitLength + 7) >> 3;
    final result = Uint8List(maxBytes);
    for (int i = 0; i < maxBytes; i++) {
      result[i] = random.nextInt(256);
    }
    BigInt bigInt = BigInt.parse(
      result.reversed.toList().map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(''),
      radix: 16,
    );
    bigInt &= max; // Ensures the number is within the range.

    return bigInt < min ? min : bigInt; // Ensures the number is not below the minimum.
  }

  /// Hexadecimal to bytes
  static Uint8List hexToBytes(String hex) {
    // hex to bytes
    final l = hex.length;

    if (l > 1 && l % 2 != 0) {
      // or has odd length like 3, 5.
      throw Exception('hex invalid 1');
    }
    // create result array
    final arr = Uint8List(l ~/ 2);
    for (var i = 0; i < arr.length; i++) {
      final j = i * 2;
      // hexByte. slice is faster than substr
      final h = hex.substring(j, j + 2);
      // byte, created from string part
      final b = int.parse(h, radix: 16);
      if (b.isNaN || b < 0) {
        // byte must be valid 0 <= byte < 256
        throw Exception('hex invalid 2');
      }
      arr[i] = b;
    }
    return arr;
  }

  // modular inversion
  static BigInt inverse(BigInt num, [BigInt? md]) {
    md ??= P;
    if (num == BigInt.zero || md <= BigInt.zero) {
      // no neg exponent for now
      throw Exception('no inverse n=$num mod=$md');
    }
    BigInt a = mod(num, md);
    BigInt b = md;
    BigInt x = BigInt.zero;
    BigInt y = BigInt.one;
    BigInt u = BigInt.one;
    BigInt v = BigInt.zero;
    while (a != BigInt.zero) {
      // uses euclidean gcd algorithm
      final q = b ~/ a, r = b % a; // not constant-time
      final m = x - u * q, n = y - v * q;
      b = a;
      a = r;
      x = u;
      y = v;
      u = m;
      v = n;
    }
    if (b == BigInt.one) {
      return mod(x, md);
    }
    // b is gcd at this point
    throw Exception('no inverse');
  }

  /// Bytes to BigInt
  static BigInt bytesToBigInt(Uint8List bytes) {
    if (bytes.isEmpty) {
      return BigInt.zero;
    }
    return BigInt.parse('0x${bytesToHex(bytes)}');
  }

  /// BigInt to Bytes
  static Uint8List bigIntToBytes(BigInt num) {
    // number to 32b. Must be 0 <= num < B256
    if (num >= BigInt.zero && num < B256) {
      return hexToBytes(padhBigInt(num, 2 * fLen));
    }
    throw Exception('BigInt not in range 0 <= num < B256');
  }

  /// Slice bytes and convert to BigInt
  static BigInt sliceBytes(Uint8List b, int from, int to) {
    return bytesToBigInt(b.sublist(from, to));
  }

  /// number to 32b hex
  static String bigIntToHex(BigInt num) => bytesToHex(bigIntToBytes(num));

  /// Bytes to Hex
  static String bytesToHex(Uint8List b) => b.map((e) => padhInt(e, 2)).join('');

  /// Mod division
  static BigInt mod(BigInt a, [BigInt? b]) {
    b ??= P;
    final r = a % b;
    if (r >= BigInt.zero) {
      return r;
    }
    return b + r;
  }

  /// if a number is bigger than CURVE.n/2
  static bool moreThanHalfN(BigInt n) => n > (N >> 1);

  static String _padh(dynamic n, int pad) => n.toRadixString(16).padLeft(pad, '0');

  static String padhBigInt(BigInt n, int pad) => _padh(n, pad);

  static String padhInt(int n, int pad) => _padh(n, pad);

  /// Concatenate Uint8List Bytes
  static Uint8List concatBytes(List<Uint8List> arrs) {
    final r = Uint8List(arrs.fold<int>(0, (sum, a) => sum + a.length));
    // create u8a of summed length
    int pad = 0;
    // walk through each array,
    for (final a in arrs) {
      r.setRange(pad, pad + a.length, a);
      // ensure they have proper type
      pad += a.length;
    }
    return r;
  }

  /// HMAC-DRBG
  static HmacDrbgFunction hmacDrbg(HmacFnSync hashFuncSync) {
    // Minimal non-full-spec HMAC-DRBG from NIST 800-90 for RFC6979 sigs.
    Uint8List v = Uint8List(fLen);
    // Steps B, C of RFC6979 3.2: set hashLen, in our case always same
    Uint8List k = Uint8List(fLen);
    // Iterations counter, will throw when over 1000
    int i = 0;
    void reset() {
      v.fillRange(0, v.length, 1);
      k.fillRange(0, k.length, 0);
      i = 0;
    }

    const e = 'drbg: tried 1000 values';
    h(List<Uint8List> b) {
      return hashFuncSync(k, <Uint8List>[v, ...b]);
    }

    // HMAC-DRBG reseed() function. Steps D-G
    void reseed([Uint8List? seed]) {
      seed ??= Uint8List(0);
      // k = hmac(k || v || 0x00 || seed)
      k = h([
        Uint8List.fromList(<int>[0x00]),
        seed,
      ]);
      // v = hmac(k || v)
      v = h([]);
      if (seed.isEmpty) {
        return;
      }
      // k = hmac(k || v || 0x01 || seed)
      k = h([
        Uint8List.fromList(<int>[0x01]),
        seed,
      ]);
      // v = hmac(k || v)
      v = h([]);
    }

    Uint8List gen() {
      // HMAC-DRBG generate() function
      if (i++ >= 1000) {
        throw Exception(e);
      }
      v = h([]); // v = hmac(k || v)
      return v;
    }

    return (Uint8List seed, K2SigFunc pred) {
      reset();
      reseed(seed); // Steps D-G
      Signature? res; // Step H: grind until k is in [1..n-1]
      while ((res = pred(gen())) == null) {
        reseed();
      } // test predicate until it returns ok
      reset();
      return res!;
    };
  }

  /// RFC6979: ensure ECDSA msg is X bytes.
  static BigInt bits2int(Uint8List bytes) {
    // RFC suggests optional truncating via bits2octets
    final int delta = bytes.length * 8 - 256;
    // FIPS 186-4 4.6 suggests the leftmost min(nBitLen, outLen) bits, which
    final BigInt bigInt = bytesToBigInt(bytes);
    // matches bits2int. bits2int can produce res>N.
    return delta > 0 ? bigInt >> delta : bigInt;
  }

  /// int2octets can't be used; pads small msgs
  static BigInt bits2int_modN(Uint8List bytes) {
    // with 0: BAD for trunc as per RFC vectors
    return mod(bits2int(bytes), N);
  }

  static Uint8List randomBytes(int length) {
    final random = Random.secure();
    final Uint8List bytes = Uint8List(length);
    for (var i = 0; i < length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return bytes;
  }

  static (Uint8List seed, K2SigFunc k2sig) prepSig(
    Uint8List message,
    BigInt privateKey, {
    RandomBytesFunc? randomBytesFunc,
    bool? lowS,
    Uint8List? extraEntropy,
  }) {
    // RFC6979 3.2: we skip step A
    lowS ??= true;
    // msg bigint
    final BigInt h1i = bits2int_modN(message);
    // msg octets
    final Uint8List h1o = bigIntToBytes(h1i);
    // Step D of RFC6979 3.2
    final List<Uint8List> seed = [bigIntToBytes(privateKey), h1o];
    // RFC6979 3.6: additional k' (optional)
    if (extraEntropy != null && extraEntropy.isNotEmpty) {
      if (extraEntropy.length != fLen) {
        // Expected 32 bytes of extra data
        throw Exception('extraEntropy not provided');
      }
      seed.add(extraEntropy);
    }
    // convert msg to bigint
    final BigInt m = h1i;

    // Transform k => Signature.
    Signature? k2sig(Uint8List kBytes) {
      // RFC6979 method.
      final k = bits2int(kBytes);
      // Check 0 < k < CURVE.n
      if (!ge(k)) {
        return null;
      }
      // k^-1 mod n, NOT mod P
      final ik = inverse(k, N);
      // q = Gk
      final AffinePoint q = Point.G.mul(k).affinePoint();
      // r = q.x mod n
      final r = mod(q.x, N);
      if (r == BigInt.zero) {
        // r=0 invalid
        return null;
      }
      // s = k^-1(m + rd) mod n
      final s = mod(ik * mod(m + mod(privateKey * r, N), N), N);
      if (s == BigInt.zero) {
        return null;
      } // s=0 invalid
      BigInt normS = s; // normalized S
      int rec = (q.x == r ? 0 : 2) | (q.y & BigInt.one).toInt(); // recovery bit
      if (lowS! && moreThanHalfN(s)) {
        // if lowS was passed, ensure s is always
        normS = mod(-s, N); // in the bottom half of CURVE.n
        rec ^= 1;
      }
      return Signature(r: r, s: normS, recovery: rec); // use normS, not s
    }

    return (concatBytes(seed), k2sig); // return Bytes+Checker
  }

  // √n = n^((p+1)/4) for fields p = 3 mod 4
  static BigInt sqrt(BigInt n) {
    // So, a special, fast case. Paper: "Square Roots from 1;24,51,10 to Dan Shanks".
    var r = BigInt.one;
    // powMod: modular exponentiation.
    for (var num = n, e = (P + BigInt.one) ~/ BigInt.from(4); e > BigInt.zero; e >>= 1) {
      // Uses exponentiation by squaring.
      if ((e & BigInt.one) == BigInt.one) {
        r = (r * num) % P;
      }
      // Not constant-time.
      num = (num * num) % P;
    }
    /* return mod(r * r) == n ? r : err('sqrt invalid'); */ // check if result is valid
    if (mod(r * r) == n) {
      return r;
    }
    throw Exception('sqrt invalid');
  }

  // They give 12x faster getPublicKey(),
  static List<Point> precompute() {
    // 10x sign(), 2x verify(). To achieve this,
    final List<Point> points = <Point>[];
    // app needs to spend 40ms+ to calculate
    const windows = 256 / W + 1;
    // a lot of points related to base point G.
    var p = Point.G, b = p;

    // Points are stored in array and used
    for (int w = 0; w < windows; w++) {
      // any time Gx multiplication is done.
      b = p;
      // They consume 16-32 MiB of RAM.
      points.add(b);
      // Precomputes don't speed-up getSharedKey,
      for (int i = 1; i < pow(2, (W - 1)); i++) {
        // which multiplies user point by scalar,
        b = b.add(p);
        points.add(b);
      }
      p = b.double();
    }
    // when precomputes are using base point
    return points;
  }
}
