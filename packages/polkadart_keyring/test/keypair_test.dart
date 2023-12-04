import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart';
import 'package:test/test.dart';

void main() {
  group('KeyPair Class', () {
    late KeyPair keyPair, keyPairMemonic;
    late Uint8List seed;
    late String mnemonic;
    late Uint8List message;

    setUp(() async {
      message = Uint8List.fromList('this is a message'.codeUnits);
      seed = Uint8List.fromList(hex.decode(
          '9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60'));
      mnemonic =
          'moral movie very draw assault whisper awful rebuild speed purity repeat card';

      keyPairMemonic = await KeyPair.ed25519.fromMnemonic(mnemonic);
      keyPair = KeyPair.ed25519.fromSeed(seed);
    });

    test('fromSeed', () {
      final bytes = keyPair.bytes;
      final expectedBytes = [
        215,
        90,
        152,
        1,
        130,
        177,
        10,
        183,
        213,
        75,
        254,
        211,
        201,
        100,
        7,
        58,
        14,
        225,
        114,
        243,
        218,
        166,
        35,
        37,
        175,
        2,
        26,
        104,
        247,
        7,
        81,
        26
      ];
      expect(bytes, expectedBytes);
    });

    test('fromMnemonic', () {
      expect(keyPairMemonic.address,
          '5GvjEiJk5fFGurvyx4vgjWAKef9yXP31ThQDdeEEhvsdsWx1');
    });

    test('sign and verify', () {
      final signature = keyPair.sign(Uint8List.fromList(message));
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
      expect(signature, expectedSignature);
      final isVerified = keyPair.verify(message, signature);
      expect(isVerified, true);
    });

    test('lock', () {
      keyPair.lock();
      expect(keyPair.isLocked, true);
    });

    test('unlockFromMnemonic', () async {
      keyPairMemonic.lock();

      expect(keyPairMemonic.isLocked, true);
      expect(() => keyPairMemonic.sign(message), throwsException);

      await keyPairMemonic.unlockFromMemonic(mnemonic);

      expect(() => keyPairMemonic.sign(message), returnsNormally);
      expect(keyPairMemonic.isLocked, false);
    });

    test('unlockFromSeed', () {
      keyPair.lock();

      expect(keyPair.isLocked, true);
      expect(() => keyPair.sign(message), throwsException);

      keyPair.unlockFromSeed(seed);

      expect(() => keyPair.sign(message), returnsNormally);
      expect(keyPair.isLocked, false);
    });
  });
}
