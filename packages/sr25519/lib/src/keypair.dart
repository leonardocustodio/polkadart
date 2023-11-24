part of sr25519;

class KeyPair {
  final PublicKey publicKey;
  final SecretKey secretKey;

  const KeyPair._(this.publicKey, this.secretKey);

  /// GenerateKeypair generates a new schnorrkel secret key and public key
  factory KeyPair.generateKeypair() {
    // decodes priv bytes as little-endian
    final msc = MiniSecretKey.generateMiniSecretKey();
    return KeyPair._(msc.public(), msc.expandEd25519());
  }

  /// KeyPair.fromAnother creates a new keypair from a public key and secret key
  factory KeyPair.from(PublicKey pk, SecretKey sk) {
    return KeyPair._(PublicKey.from(pk), SecretKey.copy(sk));
  }

  /// Sign uses the schnorr signature algorithm to sign a message
  /// See the following for the transcript message
  /// https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/sign.rs#L158
  /// Schnorr w/ transcript, secret key x:
  /// 1. choose random r from group
  /// 2. R = gr
  /// 3. k = scalar(transcript.extract_bytes())
  /// 4. s = kx + r
  /// signature: (R, s)
  /// public key used for verification: y = g^x
  Signature sign(merlin.Transcript t) {
    return secretKey.sign(t);
  }

  /// Verify verifies a schnorr signature with format: (R, s) where y is the public key
  /// 1. k = scalar(transcript.extract_bytes())
  /// 2. R' = -ky + gs
  /// 3. return R' == R
  (bool, Exception?) verify(Signature s, merlin.Transcript t) {
    return publicKey.verify(s, t);
  }

  /// VrfSign returns a vrf output and proof given a secret key and transcript.
  (VrfInOut, VrfProof) vrfSign(merlin.Transcript t) {
    return secretKey.vrfSign(t);
  }

  /// VrfVerify verifies that the proof and output created are valid given the public key and transcript.
  bool vrfVerify(merlin.Transcript t, VrfOutput out, VrfProof proof) {
    return publicKey.vrfVerify(t, out, proof);
  }
}
