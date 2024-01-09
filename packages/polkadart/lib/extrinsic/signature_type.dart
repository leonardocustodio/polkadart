import 'dart:typed_data';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

enum SignatureType {
  ed25519('00'),
  sr25519('01');

  final String type;
  const SignatureType(this.type);
}

extension SignExtrinsicExtension on Uint8List {
  Uint8List sign(keyring.KeyPair keyPair) {
    return keyPair.sign(this);
  }
}
