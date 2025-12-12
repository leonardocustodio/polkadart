import 'dart:typed_data';

import 'package:secp256k1_ecdsa/secp256k1.dart';
import 'package:test/test.dart';

import 'helpers/ecdsa_model.dart';
import 'helpers/models.dart';
import 'helpers/utils.dart';

void main() {
  final Ecdsa ecdsa = getJsonFor('test/test_resources/ecdsa.json', ModelsType.ecdsa) as Ecdsa;

  group('verify()', () {
    test('verify signature', () {
      final MSG = Utilities.hexToBytes('01' * 32);
      final PRIV_KEY = PrivateKey(BigInt.from(2));
      final signature = PRIV_KEY.sign(MSG);
      final publicKey = PRIV_KEY.getPublicKey();
      expect(publicKey.bytes.length, 33);
      expect(publicKey.verify(signature, MSG), true);
    });

    test(' not verify signature with wrong public key', () {
      final MSG = Utilities.hexToBytes('01' * 32);
      final PRIV_KEY = PrivateKey.fromHex('01' * 32);
      final WRONG_PRIV_KEY = PrivateKey.fromHex('02' * 32);
      final signature = PRIV_KEY.sign(MSG);
      final publicKey = WRONG_PRIV_KEY.getPublicKey();
      expect(publicKey.toBytes(false).length, 65);
      expect(publicKey.verify(signature, MSG), false);
    });

    test('not verify signature with wrong hash', () {
      final MSG = Utilities.hexToBytes('01' * 32);
      final PRIV_KEY = PrivateKey(BigInt.from(2));
      final WRONG_MSG = Utilities.hexToBytes('11' * 32);
      final signature = PRIV_KEY.sign(MSG);
      final publicKey = PRIV_KEY.getPublicKey();
      expect(publicKey.bytes.length, 33);
      expect(publicKey.verify(signature, WRONG_MSG), false);
    });

    test('verify random signatures', () {
      final randomMessage = Utilities.hexToBytes(
        getRandomBigInt().toRadixString(16).padLeft(64, '0'),
      );
      final privateKey = PrivateKey(getRandomBigInt());
      final publicKey = privateKey.getPublicKey();
      final signature = privateKey.sign(randomMessage);
      expect(publicKey.verify(signature, randomMessage), true);
    });
    test('not verify signature with invalid r/s', () {
      final msg = Uint8List.fromList([
        0xbb,
        0x5a,
        0x52,
        0xf4,
        0x2f,
        0x9c,
        0x92,
        0x61,
        0xed,
        0x43,
        0x61,
        0xf5,
        0x94,
        0x22,
        0xa1,
        0xe3,
        0x00,
        0x36,
        0xe7,
        0xc3,
        0x2b,
        0x27,
        0x0c,
        0x88,
        0x07,
        0xa4,
        0x19,
        0xfe,
        0xca,
        0x60,
        0x50,
        0x23,
      ]);
      final x = BigInt.parse(
        '100260381870027870612475458630405506840396644859280795015145920502443964769584',
      );
      final y = BigInt.parse(
        '41096923727651821103518389640356553930186852801619204169823347832429067794568',
      );
      final r = BigInt.one;
      final s = BigInt.parse(
        '115792089237316195423570985008687907852837564279074904382605163141518162728904',
      );

      final pub = PublicKey.fromPoint(Point(x, y, BigInt.one));
      final signature = Signature(r: BigInt.two, s: BigInt.two);
      signature.r = r;
      signature.s = s;

      final verified = pub.verify(signature, msg);
      // Verifies, but it testn't, because signature S > curve order
      expect(verified, false);
    });
    test('not verify msg = curve order', () {
      final msg = Utilities.hexToBytes(
        'fffffffffffffffffffffffffffffffebaaedce6af48a03bbfd25e8cd0364141',
      );
      final x = BigInt.parse(
        '55066263022277343669578718895168534326250603453777594175500187360389116729240',
      );
      final y = BigInt.parse(
        '32670510020758816978083085130507043184471273380659243275938904335757337482424',
      );
      final r = BigInt.parse(
        '104546003225722045112039007203142344920046999340768276760147352389092131869133',
      );
      final s = BigInt.parse(
        '96900796730960181123786672629079577025401317267213807243199432755332205217369',
      );
      final pub = PublicKey.fromPoint(Point(x, y, BigInt.one));
      final sig = Signature(r: r, s: s);
      expect(pub.verify(sig, msg), false);
    });
    test('verify non-strict msg bb5a...', () {
      final msg = Utilities.hexToBytes(
        'bb5a52f42f9c9261ed4361f59422a1e30036e7c32b270c8807a419feca605023',
      );
      final x = BigInt.parse(
        '3252872872578928810725465493269682203671229454553002637820453004368632726370',
      );
      final y = BigInt.parse(
        '17482644437196207387910659778872952193236850502325156318830589868678978890912',
      );
      final r = BigInt.parse('432420386565659656852420866390673177323');
      final s = BigInt.parse(
        '115792089237316195423570985008687907852837564279074904382605163141518161494334',
      );
      final pub = PublicKey.fromPoint(Point(x, y, BigInt.one));
      final sig = Signature(r: r, s: s);
      expect(pub.verify(sig, msg, lowS: false), true);
    });
    test('not verify invalid deterministic signatures with RFC 6979', () {
      for (final vector in ecdsa.invalid.verify) {
        late Signature signature;
        late PublicKey publicKey;
        try {
          signature = Signature.fromCompactHex(vector.signature);
          publicKey = PublicKey(Utilities.hexToBytes(vector.q));
        } catch (e) {
          continue;
        }
        expect(publicKey.verify(signature, Utilities.hexToBytes(vector.m)), false);
      }
    });
  });
}
