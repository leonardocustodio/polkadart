import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Keyring Class:', () {
    late Keyring keyring;
    late KeyPair keyPair1, keyPair2, keyPairMnemonic;
    late Uint8List seedOne, seedTwo, message;
    late String mnemonic;

    setUp(() async {
      keyring = Keyring();
      message = Uint8List.fromList('this is a message'.codeUnits);
      seedOne =
          Uint8List.fromList('12345678901234567890123456789012'.codeUnits);
      seedTwo = Uint8List.fromList(hex.decode(
          '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));
      mnemonic =
          'moral movie very draw assault whisper awful rebuild speed purity repeat card';

      keyPairMnemonic = await KeyPair.ed25519.fromUri(mnemonic);
      keyPair1 = KeyPair.ed25519.fromSeed(seedOne);
      keyPair2 = KeyPair.ed25519.fromSeed(seedTwo);
    });

    test('Creating KeyPairs from Mnemonic', () async {
      final keyPair = await keyring.fromMnemonic(mnemonic,
          keyPairType: KeyPairType.ed25519);
      expect(keyPair.address, equals(keyPairMnemonic.address));
    });

    test('Adding and Retrieving KeyPairs', () {
      final address1 = keyPair1.address;
      final address2 = keyPair2.address;

      // Add keyPair1 to keyring
      keyring.add(keyPair1);

      // Check if keyPair1 is retrievable by address
      expect(keyring.getByAddress(address1), equals(keyPair1));

      // Add keyPair2 to keyring
      keyring.add(keyPair2);

      // Check if keyPair2 is retrievable by address
      expect(keyring.getByAddress(address2), equals(keyPair2));

      // Check that an exception is thrown when retrieving a non-existing key pair
      expect(() => keyring.getByAddress('non_existent_address'),
          throwsArgumentError);
    });

    test('Retrieving KeyPairs by PublicKey', () {
      final publicKey1 = keyPair1.bytes();

      // Add keyPair1 to key
      keyring.add(keyPair1);

      // Check if keyPair1 is retrievable by its public key
      expect(keyring.getByPublicKey(publicKey1), equals(keyPair1));

      // Check that getByPublicKey handles a non-existing key pair
      expect(() => keyring.getByPublicKey([1, 2, 3]), throwsArgumentError);
    });

    test('Removing KeyPairs', () {
      final address1 = keyPair1.address;

      // Add keyPair1 and keyPair2 to keyring
      keyring.add(keyPair1);
      keyring.add(keyPair2);

      // Remove keyPair1 by address
      keyring.remove(address1);

      // Check that keyPair1 is no longer retrievable by address
      expect(() => keyring.getByAddress(address1), throwsArgumentError);
    });

    test('Encoding and Decoding Addresses', () {
      final address = keyPair1.address;
      final publicKey = keyPair1.bytes();

      // Encode the public key to an address
      final encodedAddress = keyring.encodeAddress(publicKey);

      // Check that the encoded address is correct
      expect(encodedAddress, equals(address));

      // Decode the address to a public key
      final decodedPublicKey = keyring.decodeAddress(address);

      // Check that the decoded public key is correct
      expect(decodedPublicKey, equals(publicKey));
    });

    test('Getting All Public Keys', () {
      expect(keyring.publicKeys, isEmpty);

      keyring
        ..add(keyPair1)
        ..add(keyPair2);

      // Check that the public keys are correct
      expect(
          keyring.publicKeys,
          equals([
            keyPair1.bytes().toList(growable: false),
            keyPair2.bytes().toList(growable: false)
          ]));
    });

    test('Getting All Addresses', () {
      // Add keyPair1 and keyPair2 to keyring
      keyring
        ..add(keyPair1)
        ..add(keyPair2);
      final addresses = keyring.addresses;

      // Check that the addresses are correct
      expect(addresses, equals([keyPair1.address, keyPair2.address]));
    });

    test('Getting All KeyPairs', () {
      keyring
        ..add(keyPair1)
        ..add(keyPair2);

      final allKeyPairs = keyring.all;

      // Check that the key pairs are correct
      expect(allKeyPairs, equals([keyPair1, keyPair2]));
    });

    test('Removing All KeyPairs', () {
      // Add keyPair1 and keyPair2 to keyring
      keyring.add(keyPair1);
      keyring.add(keyPair2);

      // Remove all key pairs
      keyring.clear();

      // Check that the keyring is empty
      expect(keyring.all, isEmpty);
    });

    test('Signing and Verifying', () {
      keyring.add(keyPair2);

      final kp = keyring.getByPublicKey(keyPair2.bytes());

      final signature = kp.sign(message);

      final isVerified = kp.verify(message, signature);

      final expectedSignature = [
        222,
        108,
        44,
        76,
        37,
        145,
        14,
        75,
        12,
        32,
        223,
        60,
        91,
        73,
        179,
        38,
        143,
        16,
        67,
        223,
        154,
        43,
        178,
        110,
        223,
        129,
        62,
        19,
        169,
        102,
        181,
        254,
        155,
        8,
        252,
        109,
        85,
        95,
        97,
        205,
        132,
        93,
        156,
        155,
        119,
        116,
        205,
        103,
        86,
        247,
        41,
        250,
        8,
        169,
        26,
        135,
        73,
        115,
        108,
        36,
        149,
        40,
        74,
        12
      ];

      expect(signature, equals(expectedSignature));
      expect(isVerified, equals(true));
    });
  });
}
