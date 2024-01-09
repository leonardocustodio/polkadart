import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Sr25519 test cases', () {
    late Keyring keyring;
    late List<int> seedOne;
    late List<int> seedTwo;
    late List<int> publicKeyOne;
    late List<int> publicKeyTwo;

    setUp(() {
      keyring = Keyring.sr25519;
      publicKeyOne = <int>[
        116,
        28,
        8,
        160,
        111,
        65,
        197,
        150,
        96,
        143,
        103,
        116,
        37,
        155,
        217,
        4,
        51,
        4,
        173,
        250,
        93,
        62,
        234,
        98,
        118,
        11,
        217,
        190,
        151,
        99,
        77,
        99
      ];
      publicKeyTwo = hex.decode(
          '0x44a996beb1eef7bdcab976ab6d2ca26104834164ecf28fb375600576fcc6eb0f'
              .substring(2));
      seedOne = utf8.encode('12345678901234567890123456789012');
      seedTwo = hex.decode(
          '0x9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'
              .substring(2));

      keyring.fromSeed(Uint8List.fromList(seedOne), addToPairs: true);
    });

    test('test //Alice', () async {
      expect((await keyring.fromUri('//Alice')).address,
          '5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY');
    });
    test('test //9007199254740991', () async {
      expect((await keyring.fromUri('//9007199254740991')).address,
          '5CDsyNZyqxLpHnTvknr68anUcYoBFjZbFKiEJJf4prB75Uog');
    });
    test('test //900719925474099999', () async {
      expect((await keyring.fromUri('//900719925474099999')).address,
          '5GHj2D7RG2m2DXYwGSDpXwuuxn53G987i7p2EQVDqP4NYu4q');
    });
    test('test //Alice via dev seed (2-byte encoding)', () async {
      final KeyPair keyPair = await keyring.fromUri('//Alice');
      keyPair.ss58Format = 252;
      expect(
          keyPair.address, 'xw8P6urbSAronL3zZFB7dg8p7LLSgKCUFDUgjohnf1iP434ic');
    });

    test('test adds the pair: seedTwo', () async {
      expect(
          const ListEquality().equals(
              (await keyring.fromSeed(
                Uint8List.fromList(seedTwo),
              ))
                  .bytes
                  .toList(growable: false),
              publicKeyTwo),
          true);
    });

    test('test adds from a mnemonic', () async {
      final keyPair = await keyring.fromMnemonic(
          'moral movie very draw assault whisper awful rebuild speed purity repeat card',
          addToPairs: true);
      keyPair.ss58Format = 2;

      expect(
          keyPair.address, 'FSjXNRT2K1R5caeHLPD6WMrqYUpfGZB7ua8W89JFctZ1YqV');
    });

    test('allows publicKeys retrieval', () {
      keyring.fromSeed(Uint8List.fromList(seedTwo), addToPairs: true);

      expect(keyring.publicKeys, [publicKeyOne, publicKeyTwo.toList()]);

      final fetchedKeyPair = keyring.getByPublicKey(publicKeyTwo);
      expect(fetchedKeyPair.bytes.toList(growable: false), publicKeyTwo);
    });

    test('signs and verifies', () {
      final Uint8List message =
          Uint8List.fromList(utf8.encode('this is a message'));
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
  });
}
