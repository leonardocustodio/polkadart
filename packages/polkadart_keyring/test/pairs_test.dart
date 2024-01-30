import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('Pairs Class', () {
    late Pairs pairs;
    late KeyPair keyPair1, keyPair2;
    late Uint8List seedOne, seedTwo;

    setUp(() {
      pairs = Pairs();
      seedOne =
          Uint8List.fromList('12345678901234567890123456789012'.codeUnits);
      seedTwo = Uint8List.fromList(hex.decode(
          '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));

      keyPair1 = KeyPair.ed25519.fromSeed(seedOne);
      keyPair2 = KeyPair.ed25519.fromSeed(seedTwo);
    });

    test('Adding and Retrieving KeyPairs', () {
      final address1 = keyPair1.address;
      final address2 = keyPair2.address;

      // Add keyPair1 to pairs
      pairs.add(keyPair1);

      // Check if keyPair1 is retrievable by address
      expect(pairs.getByAddress(address1), equals(keyPair1));

      // Add keyPair2 to pairs
      pairs.add(keyPair2);

      // Check if keyPair2 is retrievable by address
      expect(pairs.getByAddress(address2), equals(keyPair2));

      // Check that an exception is thrown when retrieving a non-existing key pair
      expect(() => pairs.getByAddress('non_existent_address'),
          throwsArgumentError);
    });

    test('Retrieving KeyPairs by PublicKey', () {
      final publicKey1 = keyPair1.bytes();

      // Add keyPair1 to pairs
      pairs.add(keyPair1);

      // Check if keyPair1 is retrievable by its public key
      expect(pairs.getByPublicKey(publicKey1), equals(keyPair1));

      // Check that getByPublicKey handles a non-existing key pair
      expect(() => pairs.getByPublicKey([1, 2, 3]), throwsArgumentError);
    });

    test('Removing KeyPairs', () {
      final address1 = keyPair1.address;

      // Add keyPair1 and keyPair2 to pairs
      pairs.add(keyPair1);
      pairs.add(keyPair2);

      // Remove keyPair1 by address
      pairs.remove(address1);

      // Check that keyPair1 is removed
      expect(() => pairs.getByAddress(address1), throwsArgumentError);

      // Remove keyPair2 by public key
      pairs.removeByPublicKey(keyPair2.bytes());

      // Check that keyPair2 is removed
      expect(() => pairs.getByPublicKey(keyPair2.bytes()), throwsArgumentError);
    });

    test('Removing All KeyPairs', () {
      // Add keyPair1 and keyPair2 to pairs
      pairs.add(keyPair1);
      pairs.add(keyPair2);

      // Remove all key pairs
      pairs.clear();

      // Check that the pairs collection is empty
      expect(pairs.all, isEmpty);
    });

    test('Getting Public Keys and Addresses', () {
      // Add keyPair1 and keyPair2 to pairs
      pairs.add(keyPair1);
      pairs.add(keyPair2);

      expect(pairs.publicKeys.length, 2);

      expect(
          const ListEquality().equals(
              pairs.publicKeys[0], keyPair1.bytes().toList(growable: false)),
          true);

      expect(
          const ListEquality().equals(
              pairs.publicKeys[1], keyPair2.bytes().toList(growable: false)),
          true);
      // Check that addresses are retrieved correctly
      expect(pairs.addresses, contains(keyPair1.address));
      expect(pairs.addresses, contains(keyPair2.address));
    });

    test('Getting All KeyPairs', () {
      // Add keyPair1 and keyPair2 to pairs
      pairs.add(keyPair1);
      pairs.add(keyPair2);

      // Check that all key pairs are retrieved correctly
      expect(pairs.all, contains(keyPair1));
      expect(pairs.all, contains(keyPair2));
    });
  });
}
