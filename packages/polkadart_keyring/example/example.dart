import 'dart:typed_data';

import 'package:polkadart_keyring/polkadart_keyring.dart';

void main() {
  KeyPair.ed25519.fromSeed(
    Uint8List.fromList('12345678901234567890123456789012'.codeUnits),
  );
}
