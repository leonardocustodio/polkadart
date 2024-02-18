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

extension KeyPairExtension on keyring.KeyPair {
  SignatureType get signatureType {
    switch (keyPairType) {
      case keyring.KeyPairType.sr25519:
        return SignatureType.sr25519;
      case keyring.KeyPairType.ecdsa:
        return SignatureType.ecdsa;
      case keyring.KeyPairType.ed25519:
        return SignatureType.ed25519;
      default:
        throw UnsupportedError('Unsupported KeyPair type');
    }
  }
}
