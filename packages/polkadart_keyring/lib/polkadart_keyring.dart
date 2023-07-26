import 'dart:typed_data';
import 'package:substrate_bip39/substrate_bip39.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed;

class Keyring {
  final Uint8List seed;
  late final ed.PublicKey publicKey;
  late final ed.PrivateKey privateKey;

  Keyring({required this.seed}) {
    privateKey = ed.newKeyFromSeed(seed);
    publicKey = ed.public(privateKey);
  }

  static Future<Keyring> fromMnemonic(String mnemonic) async {
    final seed = await SubstrateBip39.ed25519.seedFromUri(mnemonic);
    return Keyring(seed: Uint8List.fromList(seed));
  }

  Uint8List sign(Uint8List message) {
    return ed.sign(privateKey, message);
  }

  bool verify(Uint8List message, Uint8List signature) {
    return ed.verify(publicKey, message, signature);
  }
}
