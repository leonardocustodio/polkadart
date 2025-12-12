import 'dart:convert' show utf8;
import 'dart:typed_data' show Uint8List;
import 'package:bip39_mnemonic/bip39_mnemonic.dart' show Mnemonic, Language, MnemonicLength;
import 'package:convert/convert.dart' show hex;
import 'package:cryptography/cryptography.dart' show Pbkdf2, Hmac, SecretKey;
import 'package:substrate_bip39/schemes/secp256k1.dart';
import './secret_uri.dart' show SecretUri, DeriveJunction;
import './schemes/ed25519.dart' show Ed25519;
import './exceptions.dart' show SubstrateBip39Exception;

export './schemes/ed25519.dart' show Ed25519;

abstract class CryptoScheme {
  static const ed25519 = Ed25519();
  static const ecdsa = Secp256k1();

  /// Size of the seed in bytes
  final int seedSize;

  const CryptoScheme(this.seedSize);

  /// BIP39: Since the vast majority of BIP39 wallets supports only the English wordlist,
  /// it is strongly discouraged to use non-English wordlists.
  ///
  /// Substrate-BIP39 also only supports english wordlist.
  static Mnemonic generate({int words = 12}) {
    final wordsToEntropy = {
      12: MnemonicLength.words12,
      15: MnemonicLength.words15,
      18: MnemonicLength.words18,
      21: MnemonicLength.words21,
      24: MnemonicLength.words24,
    };
    final entropy = wordsToEntropy[words];
    if (entropy == null) {
      throw SubstrateBip39Exception.invalidEntropy(
        'Invalid number of words given for phrase, must be 12/15/18/21/24',
      );
    }
    return Mnemonic.generate(Language.english, length: entropy);
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
  static Future<List<int>> miniSecretFromEntropy(List<int> entropy, {String password = ''}) async {
    final seed = await seedFromEntropy(entropy, password: password);
    return seed.sublist(0, 32);
  }

  /// Similar to `miniSecretFromEntropy`, except that it provides the 64-byte seed directly.
  static Future<List<int>> seedFromEntropy(List<int> entropy, {String? password}) async {
    if (entropy.length < 16 || entropy.length > 32 || entropy.length % 4 != 0) {
      throw SubstrateBip39Exception.invalidEntropy(
        'InvalidEntropy: byte length must be between 16 and 32 and multiple of 4',
      );
    }

    final salt = 'mnemonic${password ?? ''}';
    final pbkdf2 = Pbkdf2(macAlgorithm: Hmac.sha512(), iterations: 2048, bits: 512);

    final secret = await pbkdf2.deriveKey(secretKey: SecretKey(entropy), nonce: utf8.encode(salt));

    return secret.extractBytes();
  }

  /// Derive a child key from a series of given junctions.
  Future<Uint8List> derive(List<int> seed, Iterable<DeriveJunction> path, {Uint8List? output}) {
    throw UnimplementedError('Implement derive in child class.');
  }

  /// Parses secret uri (`URI`) into a 32 bytes that can be used to generate a key pair.
  ///
  /// The `URI` is parsed from a string. The string is interpreted in the following way:
  ///
  /// - If `string` is a possibly `0x` prefixed 64-digit hex string, then it will be interpreted
  /// directly as a `MiniSecretKey` (aka "seed" in `subkey`).
  /// - If `string` is a valid BIP-39 key phrase of 12, 15, 18, 21 or 24 words, then the key will
  /// be derived from it. In this case:
  ///   - the phrase may be followed by one or more items delimited by `/` characters.
  ///   - the path may be followed by `///`, in which case everything after the `///` is treated
  /// as a password.
  /// - If `string` begins with a `/` character it is prefixed with the Substrate public `DEV_PHRASE`
  ///   and interpreted as above.
  ///
  /// In this case they are interpreted as HDKD junctions; purely numeric items are interpreted as
  /// integers, non-numeric items as strings. Junctions prefixed with `/` are interpreted as soft
  /// junctions, and with `//` as hard junctions.
  ///
  /// There is no correspondence mapping between `SURI` strings and the keys they represent.
  /// Two different non-identical strings can actually lead to the same secret being derived.
  /// Notably, integer junction indices may be legally prefixed with arbitrary number of zeros.
  /// Similarly an empty password (ending the `SURI` with `///`) is perfectly valid and will
  /// generally be equivalent to no password at all.
  ///
  /// Reference:
  /// https://github.com/paritytech/substrate/blob/polkadot-v0.9.43/client/cli/src/commands/utils.rs#L57-L154
  Future<List<int>> seedFromUri(String uri, {String? password}) async {
    try {
      final entropy = Mnemonic.fromSentence(uri, Language.english).entropy;
      final seed = await CryptoScheme.seedFromEntropy(entropy, password: password);
      return seed.sublist(0, 32);
      // ignore: empty_catches
    } catch (e) {}

    final secretUri = SecretUri.fromStr(uri);

    // The phrase is hex encoded secret seed
    if (secretUri.phrase.startsWith('0x')) {
      try {
        return hex.decode(secretUri.phrase.substring(2));
      } catch (e) {
        throw SubstrateBip39Exception.invalidSeed();
      }
    }

    final passwordOverride = password ?? secretUri.password;
    final List<int> entropy;
    try {
      entropy = Mnemonic.fromSentence(secretUri.phrase, Language.english).entropy;
    } on Exception catch (e) {
      throw SubstrateBip39Exception.fromException(e);
    }

    List<int> seed = await CryptoScheme.seedFromEntropy(entropy, password: passwordOverride);
    seed = seed.sublist(0, 32);

    return await derive(seed, secretUri.junctions);
  }
}
