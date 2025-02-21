part of sr25519;

class Sr25519 {
  /// Sr25519.newSigningContext returns a new transcript initialized with the context for the signature
  /// see: https://github.com/w3f/schnorrkel/blob/db61369a6e77f8074eb3247f9040ccde55697f20/src/context.rs#L183
  static merlin.Transcript newSigningContext(List<int> context, List<int> msg) {
    final transcript = merlin.Transcript('SigningContext');
    transcript
      ..appendMessage(utf8.encode(''), context)
      ..appendMessage(utf8.encode('sign-bytes'), msg);
    return transcript;
  }

  /// sign returns a signature of the message msg using the secret key sk.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = Sr25519.generateKeyPair();
  /// final secretKey = keyPair.secretKey;
  /// final msg = utf8.encode('hello');
  /// final sig = Sr25519.sign(secretKey, msg);
  /// ```
  static Signature sign(SecretKey secretKey, List<int> msg) {
    final transcript = newSigningContext(utf8.encode('substrate'), msg);
    return secretKey.sign(transcript);
  }

  /// verify returns true if the signature sig on message msg was created by the public key pk.
  ///
  /// Example:
  /// ```dart
  /// final keyPair = Sr25519.generateKeyPair();
  /// final publicKey = keyPair.publicKey;
  /// final Uint8List message = // your message in Uint8List
  /// final signature = // your signature from signing / signer
  ///
  /// final (verified, exception) = Sr25519.verify(publicKey, signature, message);
  ///
  /// or
  ///
  /// final (verified, exception) = publicKey.verify(signature, transcript);
  ///
  /// ```
  static (bool, Exception?) verify(PublicKey publicKey, Signature sig, Uint8List msg) {
    final transcript = newSigningContext(utf8.encode('substrate'), msg);
    return publicKey.verify(sig, transcript);
  }

  /// generateKeyPair returns a new random keypair
  ///
  /// Example:
  /// ```dart
  /// final keyPair = Sr25519.generateKeyPair();
  /// ```
  static KeyPair generateKeyPair([Random? random]) {
    return KeyPair.generateKeypair();
  }
}
