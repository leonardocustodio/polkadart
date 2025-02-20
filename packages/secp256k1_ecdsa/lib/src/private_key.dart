part of secp256k1;

class PrivateKey {
  final BigInt _privateKey;
  final Point point;

  /// Create PrivateKey from BigInt
  PrivateKey(this._privateKey) : point = Point.fromPrivateKey(_privateKey);

  PrivateKey.fromPoint(this.point) : _privateKey = point.affinePoint().x;

  /// Create PrivateKey from bytes
  PrivateKey.fromBytes(Uint8List bytes) : this(Utilities.bytesToBigInt(bytes));

  /// Create PrivateKey from hex
  PrivateKey.fromHex(String hex) : this.fromBytes(Utilities.hexToBytes(hex));

  /// Make public key from priv
  PublicKey getPublicKey([bool isCompressed = true]) {
    // 33b or 65b output
    return PublicKey(point.toRawBytes(isCompressed));
  }

  /// Generates Shared Secret
  Uint8List getSharedSecret(PublicKey publicKey, [bool isCompressed = true]) {
    // ECDH
    return Point.fromBytes(publicKey.bytes)
        .mul(_privateKey)
        .toRawBytes(isCompressed);
  }

  Uint8List bytes() => Utilities.bigIntToBytes(_privateKey);

  AffinePoint get affinePoint => point.affinePoint();

  /* static Uint8List fromHash(String hash) {
    // FIPS 186 B.4.1 compliant key generation
    final Uint8List hashBytes =
        Utilities.hexToBytes(hash); // produces private keys with modulo bias
    final minLen = fLen + 8; // being neglible.
    if (hashBytes.length < minLen || hashBytes.length > 1024) {
      throw Exception('expected proper params');
    }
    final num =
        Utilities.mod(Utilities.bytesToBigInt(hashBytes), N - BigInt.one) +
            BigInt.one;
    // takes at least n+8 bytes
    return n2b(num);
  } */

  Signature sign(Uint8List message,
      {HmacFnSync? hmacFnSync,
      RandomBytesFunc? randomBytesFunc,
      bool? lowS,
      Uint8List? extraEntropy}) {
    hmacFnSync ??= (key, msgs) => hmacSha256(key, Utilities.concatBytes(msgs));
    final (seed, k2sig) = Utilities.prepSig(message, _privateKey,
        randomBytesFunc: randomBytesFunc,
        lowS: lowS,
        extraEntropy: extraEntropy); // Extract arguments for hmac-drbg
    return Utilities.hmacDrbg(hmacFnSync)(
        seed, k2sig); // Re-run drbg until k2sig returns ok
  }
}
