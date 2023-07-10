import 'dart:convert' show utf8;
import 'package:bip39_mnemonic/bip39_mnemonic.dart' show Mnemonic, Language;
import 'package:convert/convert.dart' show hex;
import 'package:cryptography/cryptography.dart' show Pbkdf2, Hmac, SecretKey;
import './secret_uri.dart' show SecretUri;
import './ed25519.dart' show Ed25519Pair;

export 'package:bip39_mnemonic/bip39_mnemonic.dart' show Mnemonic, Language;

/// The crypto scheme to use.
enum CryptoScheme {
  /// Use ed25519.
  ed25519,

  /// Use sr25519.
  sr25519,

  /// Use secp256k1
  ecdsa,
}

class SubstrateBip39 {
  /// BIP39: Since the vast majority of BIP39 wallets supports only the English wordlist,
  /// it is strongly discouraged to use non-English wordlists.
  ///
  /// Substrate-BIP39 also only supports english wordlist.
  static Mnemonic generate({int words = 12}) {
    final wordsToEntropy = {
      12: 128,
      15: 160,
      18: 192,
      21: 224,
      24: 256,
    };
    final entropy = wordsToEntropy[words];
    if (entropy == null) {
      throw InvalidNumberOfWordsException(
          "Invalid number of words given for phrase: must be 12/15/18/21/24");
    }
    return Mnemonic.generate(Language.english, entropyLength: entropy);
  }

  /// Returns the 32 bytes seed from the English BIP39 seed `phrase`
  ///
  /// Reference
  /// https://github.com/paritytech/substrate/blob/polkadot-v0.9.43/client/cli/src/commands/utils.rs#L57-L154
  static Future<List<int>> seedFromUri(String uri, CryptoScheme type,
      {String? password}) async {
    try {
      final entropy = Mnemonic.fromSentence(uri, Language.english).entropy;
      final seed = await seedFromEntropy(entropy, password: password);
      return seed.sublist(0, 32);
      // ignore: empty_catches
    } catch (e) {}

    SecretUri secretUri = SecretUri.fromStr(uri);

    if (secretUri.phrase.startsWith('0x')) {
      // The phrase is hex encoded secret seed
      return hex.decode(secretUri.phrase.substring(2));
    }

    String? passwordOverride = password ?? secretUri.password;
    final entropy =
        Mnemonic.fromSentence(secretUri.phrase, Language.english).entropy;
    List<int> seed = await seedFromEntropy(entropy, password: passwordOverride);
    seed = seed.sublist(0, 32);

    // Ed25519 derivation
    switch (type) {
      case CryptoScheme.ed25519:
        {
          return Ed25519Pair.derive(seed, secretUri.junctions);
        }
      case CryptoScheme.sr25519:
        {
          throw UnimplementedError('sr25519 is not implemented yet');
        }
      case CryptoScheme.ecdsa:
        {
          throw UnimplementedError('ecdsa is not implemented yet');
        }
      default:
        {
          return seed;
        }
    }
  }

  /// `entropy` should be a byte array from a correctly recovered and checksumed BIP39.
  ///
  /// This function accepts slices of different length for different word lengths:
  ///
  /// + 16 bytes for 12 words.
  /// + 20 bytes for 15 words.
  /// + 24 bytes for 18 words.
  /// + 28 bytes for 21 words.
  /// + 32 bytes for 24 words.
  ///
  /// Any other length will return an error.
  ///
  /// `password` is analog to BIP39 seed generation itself, with an empty string being defalt.
  static Future<List<int>> miniSecretFromEntropy(List<int> entropy,
      {String password = ''}) async {
    final seed = await seedFromEntropy(entropy, password: password);
    return seed.sublist(0, 32);
  }

  /// Similar to `miniSecretFromEntropy`, except that it provides the 64-byte seed directly.
  static Future<List<int>> seedFromEntropy(List<int> entropy,
      {String? password}) async {
    if (entropy.length < 16 || entropy.length > 32 || entropy.length % 4 != 0) {
      throw InvalidEntropyException(
          'InvalidEntropy: byte length must be between 16 and 32 and multiple of 4');
    }

    final salt = 'mnemonic${password ?? ''}';
    final pbkdf2 =
        Pbkdf2(macAlgorithm: Hmac.sha512(), iterations: 2048, bits: 512);

    final secret = await pbkdf2.deriveKey(
      secretKey: SecretKey(entropy),
      nonce: utf8.encode(salt),
    );

    return secret.extractBytes();
  }
}

class InvalidEntropyException implements Exception {
  String cause;
  InvalidEntropyException(this.cause);
}

class InvalidNumberOfWordsException implements Exception {
  String cause;
  InvalidNumberOfWordsException(this.cause);
}
