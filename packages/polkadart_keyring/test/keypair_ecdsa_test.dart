import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() async {
  late Keyring keyring;
  late String seedOne;
  late List<int> seedTwo;
  late List<int> publicKeyOne;
  late List<int> publicKeyTwo;
  setUp(() async {
    keyring = Keyring.ecdsa;
    publicKeyOne = hex.decode(
      '0x02c6b6c664db5ef505477bba1cf2f1789c98796b9bb5fa21abd0ac4589bed980e7'
          .substring(2),
    );
    publicKeyTwo = hex.decode(
      '0x021da683b913fb28c979ba3e5f1881415cef4b1f58a5d05ed3610a2995e7b4943c'
          .substring(2),
    );
    seedOne =
        'potato act energy ahead stone taxi receive fame gossip equip chest round';
    seedTwo = hex.decode(
      '0x3c74be003bd9a876be439949ccf2b292bd966c94959a689173b295b326cd6da7'
          .substring(2),
    );

    await keyring.fromMnemonic(seedOne, addToPairs: true);
  });

  group('Ecdsa test cases', () {
    test('test //Alice', () async {
      expect(
        (await keyring.fromUri('//Alice')).address,
        '5C7C2Z5sWbytvHpuLTvzKunnnRwQxft1jiqrLD5rhucQ5S9X',
      );
    });

    test('adds the pair', () {
      expect(
        const ListEquality().equals(
          keyring
              .fromSeed(Uint8List.fromList(seedTwo))
              .bytes()
              .toList(growable: false),
          publicKeyTwo,
        ),
        true,
      );
    });

    test('test adds from a mnemonic', () async {
      final keyPair = await keyring.fromMnemonic(
        'moral movie very draw assault whisper awful rebuild speed purity repeat card',
        addToPairs: true,
      );
      keyPair.ss58Format = 2;

      expect(
        keyPair.address,
        'DrRE1KAcs4pCicX8yJPh7YxkLPQ2vXnCFSVRPQfx38KjEFe',
      );
    });

    test('allows publicKeys retrieval', () {
      keyring.fromSeed(Uint8List.fromList(seedTwo), addToPairs: true);

      expect(keyring.publicKeys, [publicKeyOne, publicKeyTwo.toList()]);

      final fetchedKeyPair = keyring.getByPublicKey(publicKeyTwo);
      expect(fetchedKeyPair.bytes().toList(growable: false), publicKeyTwo);
    });

    test('signs and verifies', () {
      final Uint8List message = utf8.encode('this is a message');
      final pair = keyring.getByPublicKey(publicKeyOne);
      final signature = pair.sign(message);
      expect(pair.verify(message, signature), true);
      {
        keyring.fromSeed(Uint8List.fromList(seedTwo), addToPairs: true);
        final randomUnexpectedPairHacker = keyring.getByPublicKey(publicKeyTwo);
        // should not verify because we didn't signed with this pair but used the other signature
        // pretending to be a different pair
        expect(randomUnexpectedPairHacker.verify(message, signature), false);
      }

      expect(pair.verify(Uint8List(0), signature), false);
    });

    group('secp256k1PairFromSeed', () {
      test('generates a valid publicKey/secretKey pair (u8a)', () {
        final test = hex.decode(
          '4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae',
        );
        final result = <String, dynamic>{
          'publicKey':
              '0x03fd8c74f795ced92064b86191cb2772b1e3a0947740aa0a5a6e379592471fd85b',
          'secretKey':
              '0x4380de832af797688026ce24f85204d508243f201650c1a134929e5458b7fbae',
        };
        final keypair = KeyPair.ecdsa.fromSeed(Uint8List.fromList(test));
        expect('0x${(keypair as EcdsaKeyPair).seedHex()}', result['secretKey']);

        expect('0x${keypair.publicKeyHex()}', result['publicKey']);
      });

      test('generates a valid publicKey/secretKey pair (u8a)', () async {
        final tests = <List<String>>[
          [
            'life fee table ahead modify maximum dumb such tobacco boss dry nurse',
            '0xf2360e871c830d397fe221382b503f07ddd8763df81a94bb2504390a2fb91f59',
            '0x036b0aa6beab469dd2b748a0ff5ddbe3d13df1e15c9d28a2aa057212994e127bea',
            '0xae8e8fcacbaeb607bcdf0bbd7e615f2b4ef484ee54f19d68a7393fb6db2dd9cd',
          ],
          [
            'tide survey cradle cover column ugly author wait eye state elder blame',
            '0x5385355a5118ec732b9dbcf1668ba21db38b07cf79082dafa9a7cc4b52e4abb0',
            '0x03929e4f93cdad265751ad8f6365185d8e937610d19b510400f5867d542d60a313',
            '0xf80ea815da66c42f870b687e1530770d5a7936ae81a147b009506d85bd6d621c',
          ],
          [
            'laugh fish flee cake approve butter april dynamic myth license ticket lobster',
            '0x83ec65cf9a8a7442d808aef6f8987599f1ba3be880769bb3a20621b13adbd476',
            '0x0388299e4cfaa33d180a026bd54a46ad98df129a131320a9d2fd6f80e64bc3db39',
            '0x35036238dd195f4c2169379354bda6cba5746f67bde03ef59a77a4cea80729bc',
          ],
          [
            'animal thing fork recipe exotic pilot inquiry pledge obey slab obtain reveal',
            '0x0fd50580eb5a58b0eee60c77656dffa50094b539262366f1227d3babfd7343e5',
            '0x036edc954685ad89f0a23b0fb1eb2b9c3a8600eee9091c758426dfb2bc7889a7c3',
            '0x2a94b10d1f28810dc4628e7e424b2d08bd3d17fb08f9416d112f17e86c8fa77c',
          ],
        ];

        await Future.forEach(tests, (test) async {
          final (mnemonic, secretKey, publicKey) = (test[0], test[1], test[2]);
          final pair = await KeyPair.ecdsa.fromMnemonic(mnemonic);

          expect('0x${(pair as EcdsaKeyPair).seedHex()}', secretKey);
          expect('0x${pair.publicKeyHex()}', publicKey);
        });
      });
    });
  });
}
