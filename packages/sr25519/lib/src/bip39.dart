part of sr25519;

class Bip39 {
  /// WARNING:  Non-standard BIP39 Implementation
  /// Designed for compatibility with the Rust substrate-bip39 library
  ///
  /// GenerateMnemonic returns mnemonic for func MiniSecretKeyFromMnemonic
  static Mnemonic generateMnemonic() {
    // As per in Substrate_bip39 package
    // final wordsToEntropy = {
    // 12: 128,
    // 15: 160,
    // 18: 192,
    // 21: 224,
    // 24: 256,
    // };
    //
    // We want to use 256 as the entropy size

    return SubstrateBip39.generate(words: 24);
  }

  /// SeedFromMnemonic returns seed for func MiniSecretKeyFromMnemonic
  static Future<List<int>> seedFromMnemonic(String mnemonic,
      [String? password]) async {
    final pbkdf2 = DartPbkdf2(
      macAlgorithm: Hmac(Sha512()),
      iterations: 2048,
      bits: 512,
    ).toSync();
    final entropy = mnemonicToEntropy(mnemonic);
    final seed = await pbkdf2.toSync().deriveKey(
          secretKey: cryptography.SecretKey(entropy),
          nonce: utf8.encode('mnemonic${password ?? ''}'),
        );
    return seed.extractBytes();
  }

  /// MiniSecretKeyFromMnemonic returns a go-schnorrkel MiniSecretKey from a bip39 mnemonic
  static Future<List<int>> miniSecretKeyFromMnemonic(String mnemonic,
      [String? password]) async {
    final seed = await seedFromMnemonic(mnemonic, password);
    return seed.sublist(0, 32);
  }

  /// MnemonicToEntropy takes a mnemonic string and reverses it to the entropy
  /// An error is returned if the mnemonic is invalid.
  static List<int> mnemonicToEntropy(String mnemonic) {
    return Mnemonic.fromSentence(mnemonic, Language.english).entropy;
  }
}
