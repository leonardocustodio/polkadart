import 'dart:typed_data';

import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';

import 'helpers/ecdsa_model.dart';
import 'helpers/models.dart';
import 'helpers/utils.dart';

void main() {
  final Ecdsa ecdsa =
      getJsonFor('test/test_resources/ecdsa.json', ModelsType.ecdsa) as Ecdsa;
  group('Sign Test', () {
    test('fromCompactHex() roundtrip', () {
      final (r, s) = (getRandomBigInt(), getRandomBigInt());
      final sig = Signature(r: r, s: s);
      expect(Signature.fromCompactHex(sig.toCompactHex()).toString(),
          sig.toString());
    });

    test('.fromDERHex() roundtrip', () {
      final (r, s) = (getRandomBigInt(), getRandomBigInt());
      final sig = Signature(r: r, s: s);
      expect(DER.toSigFromHex(DER.hexFromSig(sig)).toString(), sig.toString());
    });
  });

  group('sign()', () {
    test('create deterministic signatures with RFC 6979', () {
      for (final vector in ecdsa.valid) {
        final PrivateKey privateKey = PrivateKey.fromHex(vector.d);
        final Signature usig = privateKey.sign(Utilities.hexToBytes(vector.m));
        final sig = usig.toCompactHex();
        final vsig = vector.singature;
        expect(sig.substring(0, 64), vsig.substring(0, 64));
        expect(sig.substring(64, 128), vsig.substring(64, 128));
      }
    });

    test('not create invalid deterministic signatures with RFC 6979', () {
      for (final vector in ecdsa.invalid.sign) {
        expect(() {
          final _ = PrivateKey(BigInt.parse(vector.d));
          // No point in running below because the upper will throw exception firstly.
          /* privateKey.sign(Utilities.hexToBytes(vector.m)); */
        }, throwsA(isA<Exception>()));
      }
    });

    test('create correct DER encoding against libsecp256k1', () {
      const CASES = [
        [
          'd1a9dc8ed4e46a6a3e5e594615ca351d7d7ef44df1e4c94c1802f3592183794b',
          '304402203de2559fccb00c148574997f660e4d6f40605acc71267ee38101abf15ff467af02200950abdf40628fd13f547792ba2fc544681a485f2fdafb5c3b909a4df7350e6b',
        ],
        [
          '5f97983254982546d3976d905c6165033976ee449d300d0e382099fa74deaf82',
          '3045022100c046d9ff0bd2845b9aa9dff9f997ecebb31e52349f80fe5a5a869747d31dcb88022011f72be2a6d48fe716b825e4117747b397783df26914a58139c3f4c5cbb0e66c',
        ],
        [
          '0d7017a96b97cd9be21cf28aada639827b2814a654a478c81945857196187808',
          '3045022100d18990bba7832bb283e3ecf8700b67beb39acc73f4200ed1c331247c46edccc602202e5c8bbfe47ae159512c583b30a3fa86575cddc62527a03de7756517ae4c6c73',
        ],
      ];

      final privateKey = PrivateKey.fromHex(
          '0101010101010101010101010101010101010101010101010101010101010101');

      for (final value in CASES) {
        final (msg, exp) = (value[0], value[1]);
        final res = privateKey.sign(Utilities.hexToBytes(msg));
        expect(DER.hexFromSig(res), exp);
        final rs = DER.toSigFromHex(DER.hexFromSig(res)).toCompactHex();
        expect(DER.hexFromSig(Signature.fromCompactHex(rs)), exp);
      }
    });

    test('handle {extraData} option', () {
      const ent1 =
          '0000000000000000000000000000000000000000000000000000000000000000';
      const ent2 =
          '0000000000000000000000000000000000000000000000000000000000000001';
      const ent3 =
          '6e723d3fd94ed5d2b6bdd4f123364b0f3ca52af829988a63f8afe91d29db1c33';
      const ent4 =
          'fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141';
      const ent5 =
          'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff';

      for (final e in ecdsa.extraEntropy) {
        String signature([Uint8List? extraEntropy]) {
          final privateKey = PrivateKey.fromHex(e.d);
          return privateKey
              .sign(Utilities.hexToBytes(e.m), extraEntropy: extraEntropy)
              .toCompactHex();
        }

        expect(signature(), e.signature);
        expect(signature(Utilities.hexToBytes(ent1)), e.extraEntropy0);
        expect(signature(Utilities.hexToBytes(ent2)), e.extraEntropy1);
        expect(signature(Utilities.hexToBytes(ent3)), e.extraEntropyRand);
        expect(signature(Utilities.hexToBytes(ent4)), e.extraEntropyN);
        expect(signature(Utilities.hexToBytes(ent5)), e.extraEntropyMax);
      }
    });
  });
}
