import 'dart:typed_data';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;

enum SignatureType {
  ed25519(0),
  ecdsa(2),
  ethereum(2),
  sr25519(1);

  final int type;
  const SignatureType(this.type);
}

extension SignExtrinsicExtension on Uint8List {
  Uint8List sign(keyring.KeyPair keyPair) {
    return keyPair.sign(this);
  }
}
