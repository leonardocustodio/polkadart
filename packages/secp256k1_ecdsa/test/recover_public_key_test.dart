import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';

import 'helpers/ecdsa_model.dart';
import 'helpers/models.dart';
import 'helpers/utils.dart';

void main() {
  final Ecdsa ecdsa =
      getJsonFor('test/test_resources/ecdsa.json', ModelsType.ecdsa) as Ecdsa;

  group('recoverPublicKey()', () {
    test('recover public key from recovery bit', () {
      final message = Utilities.hexToBytes(
          '00000000000000000000000000000000000000000000000000000000deadbeef');
      final privateKey = PrivateKey(BigInt.from(123456789));
      final publicKey = privateKey.getPublicKey();
      final sig = privateKey.sign(message);
      final recoveredPubkey = sig.recoverPublicKey(message);
      expect(recoveredPubkey.toHex(false), publicKey.toHex(false));
      expect(recoveredPubkey.toHex(true), publicKey.toHex(true));
      expect(recoveredPubkey.verify(sig, message), true);
    });

    test('handle all-zeros msghash', () {
      final privKey = PrivateKey(getRandomBigInt());
      final pub = privKey.getPublicKey();
      final zeros = Utilities.hexToBytes(
          '0000000000000000000000000000000000000000000000000000000000000000');
      final sig = privKey.sign(zeros);
      final recoveredKey = sig.recoverPublicKey(zeros);
      expect(recoveredKey.toBytes(false), pub.toBytes(false));
      expect(recoveredKey.toBytes(true), pub.toBytes(true));
    });

    test('handle RFC 6979 vectors', () {
      for (final vector in ecdsa.valid) {
        final privateKey = PrivateKey.fromHex(vector.d);
        final message = Utilities.hexToBytes(vector.m);
        final usig = privateKey.sign(message);
        final _ = DER.hexFromSig(usig);
        final vpub = privateKey.getPublicKey();
        final recovered = usig.recoverPublicKey(message);
        expect(recovered.toHex(), vpub.toHex());
        expect(recovered.toHex(false), vpub.toHex(false));
      }
    });
  });
}
