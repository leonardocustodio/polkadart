# Ecdsa/Secp256k1

```dart
import 'package:secp256k1_ecdsa/secp256k1_ecdsa.dart';

final message = Utilities.hexToBytes('some message here to sign it');

final privateKey = PrivateKey.fromHex('your private key hex');

final signature = privateKey.sign(message);

final publicKey = privateKey.getPublicKey();
final verified = publicKey.verify(signature, message);

```
