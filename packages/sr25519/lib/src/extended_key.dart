part of sr25519;

///
/// ExtendedKey consists of a DerivableKey which can be a schnorrkel public or private key as well as chain code
class ExtendedKey {
  late final DerivableKey key;
  final List<int> chaincode = List<int>.filled(32, 0, growable: false);

  ExtendedKey(DerivableKey k, List<int> cc) {
    key = k;
    chaincode.setAll(0, cc);
  }

  ///
  /// secret returns the SecretKey underlying the ExtendedKey if it's not a secret key, it returns an error
  SecretKey secret() {
    try {
      return key as SecretKey;
    } catch (_) {
      throw Exception('extended key is not a secret key');
    }
  }

  ///
  /// public returns the PublicKey underlying the ExtendedKey
  PublicKey public() {
    try {
      return key as PublicKey;
    } catch (_) {
      try {
        return (key as SecretKey).public();
      } catch (_) {
        throw Exception('extended key is not a valid public or private key');
      }
    }
  }

  ///
  /// deriveKey derives an extended key from an extended key
  ExtendedKey deriveKey(merlin.Transcript t) {
    return key.deriveKey(t, chaincode);
  }

  ///
  /// hardDeriveMiniSecretKey implements BIP-32 like 'hard' derivation of a mini secret from an extended key's secret key
  ExtendedKey hardDeriveMiniSecretKey(List<int> i) {
    final sk = secret();

    final (msk, chainCode) = sk.hardDeriveMiniSecretKey(i, chaincode);
    return ExtendedKey(msk, chainCode);
  }

  ///
  /// deriveKeyHard derives a Hard subkey identified by the byte array i and chain code
  factory ExtendedKey.deriveKeyHard(
      DerivableKey key, List<int> i, List<int> cc) {
    if (key is SecretKey) {
      final (msk, resCC) = key.hardDeriveMiniSecretKey(i, cc);
      return ExtendedKey(msk.expandEd25519(), resCC);
    }
    throw Exception(
        'cannot derive hard key type, DerivableKey must be of type SecretKey');
  }

  ///
  /// derviveKeySoft is an alias for DervieKeySimple() used to derive a Soft subkey identified by the byte array i and chain code
  factory ExtendedKey.deriveKeySoft(
      DerivableKey key, List<int> i, List<int> cc) {
    return ExtendedKey.deriveKeySimple(key, i, cc);
  }

  ///
  /// deriveKeySimple derives a Soft subkey identified by byte array i and chain code.
  factory ExtendedKey.deriveKeySimple(
      DerivableKey key, List<int> i, List<int> cc) {
    final t = merlin.Transcript('SchnorrRistrettoHDKD');
    t.appendMessage(utf8.encode('sign-bytes'), i);
    return key.deriveKey(t, cc);
  }
}
