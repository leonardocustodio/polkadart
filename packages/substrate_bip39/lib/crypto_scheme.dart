import 'dart:convert' show utf8;
import 'dart:typed_data' show Uint8List;
import 'package:bip39_mnemonic/bip39_mnemonic.dart' show Mnemonic, Language;
import 'package:convert/convert.dart' show hex;
import 'package:cryptography/cryptography.dart' show Pbkdf2, Hmac, SecretKey;
import './secret_uri.dart' show SecretUri, DeriveJunction;
import './schemes/ed25519.dart' show Ed25519;
import './exceptions.dart' show SecretStringException;

export './schemes/ed25519.dart' show Ed25519;

abstract class CryptoScheme {
  static const ed25519 = Ed25519();

  /// Size of the seed in bytes
  final int seedSize;

  const CryptoScheme(this.seedSize);

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
      throw SecretStringException.invalidEntropy('Invalid number of words given for phrase, must be 12/15/18/21/24');
    }
    return Mnemonic.generate(Language.english, entropyLength: entropy);
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
      throw SecretStringException.invalidEntropy(
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

  /// Derive a child key from a series of given junctions.
  Future<Uint8List> derive(List<int> seed, Iterable<DeriveJunction> path, {Uint8List? output});

  /// Returns the 32 bytes seed from the English BIP39 seed `phrase`
  ///
  /// Reference
  /// https://github.com/paritytech/substrate/blob/polkadot-v0.9.43/client/cli/src/commands/utils.rs#L57-L154
  Future<List<int>> seedFromUri(String uri, {String? password}) async {
    try {
      final entropy = Mnemonic.fromSentence(uri, Language.english).entropy;
      final seed = await CryptoScheme.seedFromEntropy(entropy, password: password);
      return seed.sublist(0, 32);
      // ignore: empty_catches
    } catch (e) {}

    SecretUri secretUri = SecretUri.fromStr(uri);

    // The phrase is hex encoded secret seed
    if (secretUri.phrase.startsWith('0x')) {
      try {
        return hex.decode(secretUri.phrase.substring(2));
      } catch (e) {
        throw SecretStringException.invalidSeed();
      }
    }

    String? passwordOverride = password ?? secretUri.password;
    final entropy;
    try {
      entropy = Mnemonic.fromSentence(secretUri.phrase, Language.english).entropy;
    } on Exception catch(e) {
      throw SecretStringException.fromException(e);
    }
        
    List<int> seed = await CryptoScheme.seedFromEntropy(entropy, password: passwordOverride);
    seed = seed.sublist(0, 32);

    return await derive(seed, secretUri.junctions);
  }
}
